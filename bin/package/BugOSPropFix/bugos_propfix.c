/*
 * bugos_propfix - ghi de prop trang thai bootloader o tang VUNG PROPERTY.
 *
 * VI SAO CAN
 *   Tren base OS4, bootloader cong bo androidboot.verifiedbootstate=orange TRUOC
 *   khi userspace chay. `ro.*` la prop ghi-mot-lan, nen moi thu den sau deu bi
 *   bo: cmdline trong vendor_boot, prop/build.prop, hook SystemProperties (Java),
 *   va ca wrapper /system/bin/getprop. Da kiem chung tren may (annibale):
 *
 *     getprop (native)   -> orange
 *     Settings (Java)    -> "da khoa"      (hook Java chay dung)
 *     VNeID              -> van CA-E006
 *     resetprop 6 prop   -> VNeID het CA-E006, Play Store sach hop thoai
 *
 *   Tuc la chi co ghi thang vao kho prop moi thang duoc, va viec do can uid 0.
 *   Ban OS3 pass duoc vi bootloader base do KHONG cong bo prop nay, nen
 *   build.prop cua mod dien vao -> green. Base OS4 thi da biet truoc.
 *
 * VI SAO PHAI CHAY TRONG DOMAIN init
 *   Khong phai root la du. Doc policy tren may (plat_sepolicy.cil):
 *
 *     (allow init property_data_file (file (... write ... map ...)))   <- CO
 *     (allow su   property_data_file ...)                             <- KHONG CO
 *
 *   Nghia la domain su (root shell) VAN KHONG ghi duoc vung property. Chi init
 *   ghi duoc, vi init la chu cua vung do. Nen binary phai duoc init exec truc
 *   tiep (khong transition domain) - va vi vay update.sh patch them mot rule
 *   cho init exec file system_file, xem System_PropFixBootState/update.sh.
 *
 * CACH LAM
 *   Doc/ghi thang dinh dang vung property trong /dev/__properties__/, khong qua
 *   bionic. Moi prop nam trong mot file (mmap MAP_SHARED) theo layout:
 *
 *     struct prop_info { uint32_t serial; char value[92]; char name[]; };
 *
 *   Nen: thay ten prop o offset X  ->  value o X-92, serial o X-96.
 *
 *   Ghi theo dung thu tu cua bionic: bat dirty bit (serial|1) -> copy value ->
 *   tang serial (serial+1). Moi process dang map cung file se thay gia tri moi
 *   ngay lap tuc, khong can restart, khong can reboot.
 *
 *   Co y KHONG dung __system_property_find(): phai co NDK ~5GB de build (runner
 *   het dia, build fail) va khoa binary vao mot minh bionic. Doc thang dinh dang
 *   thi chi can mot compiler C cross bat ky.
 *
 * AN TOAN
 *   - chi ghi khi ten khop TUYET DOI: byte ngay sau key phai la '\0', va 92 byte
 *     truoc do phai la value sach (NUL-terminated, toan ky tu in duoc) -> khong
 *     ghi nham vao giua value cua prop khac
 *   - gia tri deu ngan hon PROP_VALUE_MAX (92)
 *   - chay tu init: loi thi chi ghi log roi thoat, khong anh huong boot, khong
 *     boot loop. Chay lai nhieu lan vo hai (idempotent).
 *   - moi ket qua ghi ra /dev/kmsg voi tien to BUGOS_PROP, doc lai bang
 *     `adb shell dmesg | grep BUGOS_PROP` (shell doc duoc dmesg tren ROM nay).
 *
 * Build: aarch64-linux-gnu-gcc -Os -static -no-pie (xem .github/workflows/build.yml
 *        buoc "Build prop-fix helper").
 */

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdarg.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/mman.h>
#include <sys/stat.h>

#define PROP_VALUE_MAX 92
#define PROP_DIR "/dev/__properties__"
#define KMSG "/dev/kmsg"
#define TAG "BUGOS_PROP: "

static const struct {
    const char *key;
    const char *val;
} TARGETS[] = {
    { "ro.boot.verifiedbootstate",       "green"  },
    { "ro.boot.vbmeta.device_state",     "locked" },
    { "ro.secureboot.lockstate",         "locked" },
    { "vendor.boot.verifiedbootstate",   "green"  },
    { "vendor.boot.vbmeta.device_state", "locked" },
    { "ro.boot.flash.locked",            "1"      },
};

#define TARGET_COUNT ((int)(sizeof(TARGETS) / sizeof(TARGETS[0])))

/* Danh sach dang hoat dong: mac dinh la TARGETS, hoac mot cap tu argv. */
static const char *g_key[TARGET_COUNT];
static const char *g_val[TARGET_COUNT];
static size_t g_klen[TARGET_COUNT];
static size_t g_vlen[TARGET_COUNT];
static int g_hits[TARGET_COUNT];
static int g_n;

/* Log ra /dev/kmsg. Loi thi im lang, khong duoc lam chet binary. */
static void klog(const char *fmt, ...)
{
    static int fd = -2;
    char buf[256];
    va_list ap;
    int n;

    if (fd == -2) {
        fd = open(KMSG, O_WRONLY | O_CLOEXEC);
    }
    if (fd < 0) {
        return;
    }

    n = snprintf(buf, sizeof(buf), "<6>" TAG);
    if (n < 0 || (size_t)n >= sizeof(buf)) {
        return;
    }
    va_start(ap, fmt);
    n += vsnprintf(buf + n, sizeof(buf) - (size_t)n, fmt, ap);
    va_end(ap);
    if (n > 0) {
        if (write(fd, buf, (size_t)n) < 0) {
            /* bo qua */
        }
    }
}

/*
 * Value cu co hop le khong: phai co NUL trong 92 byte va truoc NUL toan ky tu
 * in duoc. Dung de loai truong hop key xuat hien trong value cua prop khac.
 */
static int value_sane(const char *v)
{
    int i;

    for (i = 0; i < PROP_VALUE_MAX; i++) {
        unsigned char c = (unsigned char)v[i];

        if (c == '\0') {
            return 1;
        }
        if (c < 0x20 || c > 0x7e) {
            return 0;
        }
    }
    return 0;
}

/* Ghi de mot prop tai vi tri ten da tim thay. */
static void poke(char *name_at)
{
    char *value_start = name_at - PROP_VALUE_MAX;
    char *serialp = name_at - PROP_VALUE_MAX - 4;
    uint32_t serial;
    uint32_t next;
    int t;

    for (t = 0; t < g_n; t++) {
        if (strncmp(name_at, g_key[t], g_klen[t]) != 0) {
            continue;
        }
        if (name_at[g_klen[t]] != '\0') {
            continue;
        }
        if (!value_sane(value_start)) {
            continue;
        }

        memcpy(&serial, serialp, sizeof(serial));

        /* dirty -> value -> clean, y nhu bionic */
        next = serial | 1u;
        memcpy(serialp, &next, sizeof(next));
        memcpy(value_start, g_val[t], g_vlen[t]);
        value_start[g_vlen[t]] = '\0';
        __sync_synchronize();
        next = (serial | 1u) + 1u;
        memcpy(serialp, &next, sizeof(next));

        g_hits[t]++;
    }
}

/*
 * Quet mot file vung property mot lan, ghi de moi target tim thay.
 * *err duoc dat khi khong mo duoc file.
 */
static void patch_file(const char *path, int *err)
{
    struct stat st;
    char *base;
    char *p;
    size_t size;
    int fd;

    *err = 0;

    fd = open(path, O_RDWR | O_CLOEXEC);
    if (fd < 0) {
        *err = errno;
        return;
    }
    if (fstat(fd, &st) != 0 || !S_ISREG(st.st_mode) || st.st_size < 128) {
        close(fd);
        return;
    }

    size = (size_t)st.st_size;
    base = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    close(fd);
    if (base == MAP_FAILED) {
        *err = errno;
        return;
    }

    for (p = base; (size_t)(base + size - p) > 96; p++) {
        /* Moi key deu bat dau bang 'r' hoac 'v' - loc nhanh */
        if (*p != 'r' && *p != 'v') {
            continue;
        }
        /* Phai con du phia truoc: serial(4) + value(92) */
        if ((size_t)(p - base) < (size_t)(4 + PROP_VALUE_MAX)) {
            continue;
        }
        poke(p);
    }

    munmap(base, size);
}

/* Quet toan bo vung property mot lan cho g_n target dang hoat dong. */
static void patch_all(void)
{
    DIR *d;
    struct dirent *de;
    char path[512];
    int files = 0;
    int failed = 0;
    int first_err = 0;
    int t;

    d = opendir(PROP_DIR);
    if (d == NULL) {
        klog("khong mo duoc " PROP_DIR " errno=%d", errno);
        printf("bugos_propfix: khong mo duoc " PROP_DIR " (errno=%d)\n", errno);
        return;
    }

    while ((de = readdir(d)) != NULL) {
        int err = 0;

        if (de->d_name[0] == '.') {
            continue;
        }
        snprintf(path, sizeof(path), "%s/%s", PROP_DIR, de->d_name);
        patch_file(path, &err);
        if (err != 0) {
            failed++;
            if (first_err == 0) {
                first_err = err;
            }
        } else {
            files++;
        }
    }
    closedir(d);

    for (t = 0; t < g_n; t++) {
        klog("%s=%s -> hits=%d", g_key[t], g_val[t], g_hits[t]);
    }
    klog("quét: files=%d open_fail=%d first_errno=%d uids=%d",
         files, failed, first_err, (int)getuid());
}

int main(int argc, char **argv)
{
    int i;
    int ok = 0;
    int bad = 0;

    /* Cho phep go tay: bugos_propfix <key> <value> */
    if (argc == 3) {
        g_n = 1;
        g_key[0] = argv[1];
        g_val[0] = argv[2];
        g_klen[0] = strlen(argv[1]);
        g_vlen[0] = strlen(argv[2]);

        if (g_vlen[0] >= PROP_VALUE_MAX) {
            printf("bugos_propfix: value qua dai\n");
            return 1;
        }

        patch_all();
        printf("bugos_propfix: %s=%s -> %d lan ghi\n",
               argv[1], argv[2], g_hits[0]);
        return g_hits[0] > 0 ? 0 : 1;
    }

    g_n = TARGET_COUNT;
    for (i = 0; i < TARGET_COUNT; i++) {
        g_key[i] = TARGETS[i].key;
        g_val[i] = TARGETS[i].val;
        g_klen[i] = strlen(TARGETS[i].key);
        g_vlen[i] = strlen(TARGETS[i].val);
    }

    klog("bat dau uid=%d pid=%d", (int)getuid(), (int)getpid());
    printf("bugos_propfix: bat dau (uid=%d)\n", (int)getuid());

    patch_all();

    for (i = 0; i < TARGET_COUNT; i++) {
        if (g_hits[i] > 0) {
            printf("bugos_propfix: %s=%s (%d)\n",
                   g_key[i], g_val[i], g_hits[i]);
            ok++;
        } else {
            printf("bugos_propfix: %s: khong ghi duoc\n", g_key[i]);
            bad++;
        }
    }

    printf("bugos_propfix: xong - %d doi, %d loi\n", ok, bad);
    return bad == 0 ? 0 : 1;
}
