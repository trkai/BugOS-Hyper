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
 *   serial = (do dai << 24) | ((cook + 1) & 0xffffff) -> futex wake. Moi process
 *   dang map cung file se thay gia tri moi ngay, khong can restart.
 *
 *   Byte cao cua serial la DO DAI value (SERIAL_VALUE_LEN trong bionic). Phai
 *   ghi lai no moi lan doi value: ghi "green" (5) de len "orange" (6) ma giu
 *   byte cu thi bionic doc lai 6 byte -> sai gia tri.
 *
 *   Co y KHONG dung __system_property_find(): phai co NDK ~5GB de build (runner
 *   het dia, build fail) va khoa binary vao mot minh bionic. Doc thang dinh dang
 *   thi chi can mot compiler C cross bat ky.
 *
 *   Co y KHONG dung opendir/readdir tren /dev/__properties__/: policy khong cho
 *   init `read` tren thu muc (chi getattr + search), nen readdir() tra rong.
 *   Thay bang danh sach 3 file da do that tren may - xem CANDIDATES.
 *
 * AN TOAN
 *   - chi ghi khi ten khop TUYET DOI: byte ngay sau key phai la '\0', va 92 byte
 *     truoc do phai la value sach (NUL-terminated, toan ky tu in duoc) -> khong
 *     ghi nham vao giua value cua prop khac
 *   - prop co kLongFlag (value > 92 byte) bi bo qua, layout khac han
 *   - gia tri deu ngan hon PROP_VALUE_MAX (92)
 *   - chay tu init: loi thi chi ghi log roi thoat, khong anh huong boot, khong
 *     boot loop. Chay lai nhieu lan vo hai (idempotent).
 *   - moi ket qua ghi ra /dev/kmsg voi tien to BUGOS_PROP, doc lai bang
 *     `adb shell dmesg | grep BUGOS_PROP` (shell doc duoc dmesg tren ROM nay).
 *
 * Build: aarch64-linux-gnu-gcc -Os -static -no-pie (xem .github/workflows/build.yml
 *        buoc "Build prop-fix helper").
 * Test:  gcc -DBUGOS_SELFTEST -o /tmp/pf bugos_propfix.c && /tmp/pf --selftest
 *        (workflow chay buoc nay truoc khi dong binary vao ROM)
 */

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdarg.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/syscall.h>

#define PROP_VALUE_MAX 92
#define PROP_DIR "/dev/__properties__"
#define KMSG "/dev/kmsg"
#define TAG "BUGOS_PROP: "
/* Ban sao log doc duoc khong can root - /dev/kmsg chi root doc duoc. */
#define LOGFILE "/data/local/tmp/bugos_propfix.log"

/* serial: bit0 = dirty, bit16 = kLongFlag, byte cao = do dai value. */
#define SERIAL_DIRTY(s)       ((s) & 1u)
#define SERIAL_IS_LONG(s)     ((s) & (1u << 16))
#define SERIAL_LEN(s)         ((s) >> 24)
#define SERIAL_COOK(s)        ((s) & 0x00ffffffu)
#define SERIAL_MAKE(l, cook)  (((uint32_t)(l) << 24) | SERIAL_COOK(cook))

/*
 * Danh sach file vung property CAN quet.
 *
 * KHONG doc thu muc bang opendir/readdir: policy chi cho init
 *   (allow domain properties_device (dir (getattr search)))
 *   (allow init   properties_device (dir (relabelto)))
 * -> khong co `read` tren thu muc, readdir() bi EACCES va tra ve rong.
 * Mo truc tiep tung file thi duoc:
 *   (allow init property_type (file (read write ... map ... open)))
 *
 * 3 ten duoi day la ket qua do THAT tren may (annibale, OS4.0.5.0):
 *   for k in <6 prop>; do strings /dev/__properties__/u:* | grep -qx $k; done
 * -> bootloader_prop (verifiedbootstate, vbmeta.device_state, flash.locked)
 * -> default_prop          (ro.secureboot.lockstate)
 * -> vendor_default_prop   (vendor.boot.*)
 *
 * ponytail: danh sach cung, du cho annibale. Neu sau nay prop doi context thi
 * them ten vao day - hoac mo lai opendir khi policy co `read` tren thu muc.
 */
static const char *CANDIDATES[] = {
    PROP_DIR "/u:object_r:bootloader_prop:s0",
    PROP_DIR "/u:object_r:default_prop:s0",
    PROP_DIR "/u:object_r:vendor_default_prop:s0",
};

#define CANDIDATE_COUNT ((int)(sizeof(CANDIDATES) / sizeof(CANDIDATES[0])))

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
    static int lfd = -2;
    char buf[256];
    va_list ap;
    size_t used;
    int n;
    int m;

    if (fd == -2) {
        fd = open(KMSG, O_WRONLY | O_CLOEXEC);
    }
    if (lfd == -2) {
        lfd = open(LOGFILE, O_WRONLY | O_CREAT | O_APPEND | O_CLOEXEC, 0644);
    }

    if (fd < 0 && lfd < 0) {
        return;
    }

    n = snprintf(buf, sizeof(buf), "<6>" TAG);
    if (n < 0 || (size_t)n >= sizeof(buf)) {
        return;
    }
    used = (size_t)n;

    va_start(ap, fmt);
    m = vsnprintf(buf + used, sizeof(buf) - used, fmt, ap);
    va_end(ap);
    if (m < 0) {
        return;
    }

    /* vsnprintf tra ve so byte NEU du cho, co the > phan con lai -> phai cat */
    used += (size_t)m;
    if (used >= sizeof(buf)) {
        used = sizeof(buf) - 1;
    }

    if (fd >= 0 && write(fd, buf, used) < 0) {
        /* bo qua */
    }
    /*
     * Ban sao ra file de doc duoc bang adb shell khi khong co root: /dev/kmsg
     * chi root doc duoc, nen truoc day khong co cach nao biet binary co chay
     * hay khong. Dong nay la thu duy nhat tra loi duoc cau hoi do.
     */
    if (lfd >= 0 && write(lfd, buf + 3, used - 3) < 0) {
        /* bo qua */
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

/*
 * Danh thuc thread dang futex-wait tren serial.
 *
 * Bionic doc prop kieu: doc serial -> neu dirty thi __futex_wait(&serial, serial).
 * Thread da kip ngu voi gia tri CU se ngu mai neu khong ai wake, du ta da doi
 * serial. resetprop cung wake vi ly do nay. FUTEX_WAKE = 1, INT_MAX waiter.
 */
static void futex_wake_serial(uint32_t *addr)
{
#ifdef SYS_futex
    if (syscall(SYS_futex, addr, 1, 2147483647, NULL, NULL, 0) < 0) {
        /* khong wake duoc cung khong sao: reader co vong lap kiem tra lai */
    }
#else
    (void)addr;
#endif
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

        /* prop dai (value > 92 byte) dung layout khac - khong dung vao */
        if (SERIAL_IS_LONG(serial)) {
            continue;
        }

        /*
         * Thu tu y nhu bionic SystemProperties::Update():
         *   serial |= dirty -> copy value + NUL -> serial = (len<<24)|((serial|1)+1)
         *
         * Ba cho deu phai dung:
         *  1. Ghi lai byte do dai (bit 24..31). Ban cu giu byte cu -> ghi
         *     "green"(5) de len "orange"(6) thi bionic doc lai 6 byte.
         *  2. Cookie tinh tu serial DA bat dirty, khong phai serial goc. Dirty
         *     bit nam trong cookie (bit 0 cua &0xffffff), nen:
         *        serial   = 0x06000000
         *        serial|1 = 0x06000001
         *        +1       = 0x06000002  -> cook = 2, bit0 = 0 (sach)
         *     Tinh tu serial goc: 0x06000000+1 = 1 -> bit0 = 1, dirty con bat,
         *     reader coi prop luon "dang ghi do" va khong bao gio doc.
         *  3. Wake futex ca hai lan nhu AOSP.
         */
        next = serial | 1u;
        memcpy(serialp, &next, sizeof(next));
        futex_wake_serial((uint32_t *)serialp);

        memcpy(value_start, g_val[t], g_vlen[t]);
        value_start[g_vlen[t]] = '\0';
        __sync_synchronize();

        next = SERIAL_MAKE(g_vlen[t], next + 1u);
        memcpy(serialp, &next, sizeof(next));
        futex_wake_serial((uint32_t *)serialp);

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

/* Quet cac file vung property da biet cho g_n target dang hoat dong. */
static void patch_all(void)
{
    int files = 0;
    int failed = 0;
    int first_err = 0;
    int i;
    int t;

    for (i = 0; i < CANDIDATE_COUNT; i++) {
        int err = 0;

        patch_file(CANDIDATES[i], &err);
        if (err != 0) {
            failed++;
            if (first_err == 0) {
                first_err = err;
            }
            klog("mo that bai %s errno=%d", CANDIDATES[i], err);
        } else {
            files++;
        }
    }

    for (t = 0; t < g_n; t++) {
        klog("%s=%s -> hits=%d", g_key[t], g_val[t], g_hits[t]);
    }
    klog("quet: files=%d open_fail=%d first_errno=%d uid=%d",
         files, failed, first_err, (int)getuid());
}

/* Nap TARGETS vao mang dang hoat dong. */
static void load_targets(void)
{
    int i;

    g_n = TARGET_COUNT;
    for (i = 0; i < TARGET_COUNT; i++) {
        g_key[i] = TARGETS[i].key;
        g_val[i] = TARGETS[i].val;
        g_klen[i] = strlen(TARGETS[i].key);
        g_vlen[i] = strlen(TARGETS[i].val);
    }
}

/*
 * Tu kiem tra phan ghi serial - phan duy nhat tung sai ma KHONG bao loi.
 * Dung file gia lap theo dung layout prop_info, chay patch_file() that, doc lai.
 *
 *   gcc -DBUGOS_SELFTEST -o /tmp/pf bugos_propfix.c && /tmp/pf --selftest
 *
 * (chi build khi test tren may build; binary trong ROM khong co nhanh nay)
 */
#ifdef BUGOS_SELFTEST

#define ST_SERIAL_OFF 128        /* prop_area header 124 -> can 4 byte align */
#define ST_VALUE_OFF  (ST_SERIAL_OFF + 4)
#define ST_NAME_OFF   (ST_VALUE_OFF + PROP_VALUE_MAX)
#define ST_SIZE       4096

static int selftest(void)
{
    char path[] = "/tmp/bugos_propfix_XXXXXX";
    unsigned char *b;
    uint32_t serial;
    int fd;
    int err = 0;
    int fails = 0;

    fd = mkstemp(path);
    if (fd < 0) {
        printf("selftest: mkstemp loi errno=%d\n", errno);
        return 1;
    }
    b = calloc(1, ST_SIZE);
    if (b == NULL) {
        close(fd);
        unlink(path);
        return 1;
    }

    /* header prop_area toi thieu + 1 prop_info: "orange" dai 6, cook 0 */
    ((uint32_t *)b)[1] = 0x504f5250u;      /* magic "PROP" */
    ((uint32_t *)b)[2] = 0xfc6ed0abu;      /* version */
    serial = SERIAL_MAKE(6, 0);
    memcpy(b + ST_SERIAL_OFF, &serial, 4);
    memcpy(b + ST_VALUE_OFF, "orange", 7);
    memcpy(b + ST_NAME_OFF, "ro.boot.verifiedbootstate", 26);

    if (write(fd, b, ST_SIZE) != ST_SIZE) {
        printf("selftest: ghi file gia lap loi\n");
        close(fd);
        unlink(path);
        free(b);
        return 1;
    }
    close(fd);
    free(b);

    g_n = 1;
    g_key[0] = "ro.boot.verifiedbootstate";
    g_val[0] = "green";
    g_klen[0] = strlen(g_key[0]);
    g_vlen[0] = strlen(g_val[0]);
    g_hits[0] = 0;

    patch_file(path, &err);

    b = calloc(1, ST_SIZE);
    fd = open(path, O_RDONLY);
    if (fd < 0 || read(fd, b, ST_SIZE) != ST_SIZE) {
        printf("selftest: doc lai loi errno=%d\n", errno);
        if (fd >= 0) close(fd);
        unlink(path);
        free(b);
        return 1;
    }
    close(fd);

    memcpy(&serial, b + ST_SERIAL_OFF, 4);

    /* 1. phai ghi dung 1 lan */
    if (g_hits[0] != 1) {
        printf("selftest FAIL hits=%d (mong 1)\n", g_hits[0]);
        fails++;
    }
    /* 2. serial moi phai mang do dai MOI (5), stale length la loi cu */
    if (SERIAL_LEN(serial) != 5) {
        printf("selftest FAIL len=%u (mong 5) serial=0x%08x\n",
               SERIAL_LEN(serial), serial);
        fails++;
    }
    /* 3. phai sach dirty bit */
    if (SERIAL_DIRTY(serial)) {
        printf("selftest FAIL dirty bit con, serial=0x%08x\n", serial);
        fails++;
    }
    /* 4. value doc lai phai dung */
    if (strcmp((char *)b + ST_VALUE_OFF, "green") != 0) {
        printf("selftest FAIL value='%s' (mong 'green')\n",
               (char *)b + ST_VALUE_OFF);
        fails++;
    }
    /* 5. khong duoc cham vao ten */
    if (strcmp((char *)b + ST_NAME_OFF, "ro.boot.verifiedbootstate") != 0) {
        printf("selftest FAIL ten bi ghi de: '%s'\n", (char *)b + ST_NAME_OFF);
        fails++;
    }

    /*
     * 5b. ghi LAN HAI (init chay binary 2 lan: post-fs-data + boot_completed).
     * Cookie da khac 0 nen day la duong de tinh sai: neu cookie chi cong tu
     * serial goc thi sau lan 2 dirty bit van con bat.
     */
    free(b);
    g_hits[0] = 0;
    patch_file(path, &err);

    b = calloc(1, ST_SIZE);
    fd = open(path, O_RDONLY);
    if (fd < 0 || read(fd, b, ST_SIZE) != ST_SIZE) {
        printf("selftest: doc lai lan 2 loi errno=%d\n", errno);
        if (fd >= 0) close(fd);
        unlink(path);
        free(b);
        return 1;
    }
    close(fd);

    memcpy(&serial, b + ST_SERIAL_OFF, 4);

    if (g_hits[0] != 1) {
        printf("selftest FAIL lan 2 hits=%d (mong 1)\n", g_hits[0]);
        fails++;
    }
    if (SERIAL_DIRTY(serial)) {
        printf("selftest FAIL lan 2 dirty con bat, serial=0x%08x\n", serial);
        fails++;
    }
    if (SERIAL_LEN(serial) != 5) {
        printf("selftest FAIL lan 2 len=%u (mong 5)\n", SERIAL_LEN(serial));
        fails++;
    }
    if (strcmp((char *)b + ST_VALUE_OFF, "green") != 0) {
        printf("selftest FAIL lan 2 value='%s'\n", (char *)b + ST_VALUE_OFF);
        fails++;
    }

    /* 6. file gia lap khong ton tai thi patch_file phai bao loi, khong crash */
    g_hits[0] = 0;
    patch_file("/tmp/bugos_propfix_khong_ton_tai", &err);
    if (err == 0 || g_hits[0] != 0) {
        printf("selftest FAIL file thieu ma khong bao loi\n");
        fails++;
    }

    unlink(path);
    free(b);

    if (fails == 0) {
        printf("selftest OK: orange(6) -> green(5), serial=0x%08x\n", serial);
        return 0;
    }
    printf("selftest: %d loi\n", fails);
    return 1;
}
#endif /* BUGOS_SELFTEST */

int main(int argc, char **argv)
{
    int i;
    int ok = 0;
    int bad = 0;

#ifdef BUGOS_SELFTEST
    if (argc == 2 && strcmp(argv[1], "--selftest") == 0) {
        return selftest();
    }
#endif

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

    load_targets();

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
