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
 * CACH LAM
 *   Doc/ghi thang dinh dang vung property trong /dev/__properties__/*, khong qua
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
 *   - chay tu init: loi thi chi in log roi thoat, khong anh huong boot, khong
 *     boot loop. Chay lai nhieu lan vo hai (idempotent).
 *
 * Build: aarch64-linux-gnu-gcc -Os -static -no-pie (xem .github/workflows/build.yml
 *        buoc "Build prop-fix helper").
 */

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/mman.h>
#include <sys/stat.h>

#define PROP_VALUE_MAX 92
#define PROP_DIR "/dev/__properties__"

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
 * Quet mot file vung property, ghi de moi lan xuat hien cua key.
 * Tra ve so lan da ghi.
 */
static int patch_file(const char *path, const char *key, const char *val)
{
    struct stat st;
    const char *base;
    const char *end;
    const char *p;
    char *serialp;
    size_t size;
    size_t klen = strlen(key);
    size_t vlen = strlen(val);
    uint32_t serial;
    uint32_t next;
    int hits = 0;
    int fd;

    if (vlen >= PROP_VALUE_MAX) {
        return 0;
    }

    fd = open(path, O_RDWR | O_CLOEXEC);
    if (fd < 0) {
        return 0;
    }
    if (fstat(fd, &st) != 0 || !S_ISREG(st.st_mode) || st.st_size < 128) {
        close(fd);
        return 0;
    }

    size = (size_t)st.st_size;
    base = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    close(fd);
    if (base == MAP_FAILED) {
        return 0;
    }

    end = base + size;
    for (p = base; (size_t)(end - p) > klen; p++) {
        char *value_start;

        if (memcmp(p, key, klen) != 0) {
            continue;
        }
        /* Ten phai ket thuc ngay tai day */
        if (p[klen] != '\0') {
            continue;
        }
        /* Phai con du cho phia truoc: serial(4) + value(92) */
        if ((size_t)(p - base) < (size_t)(4 + PROP_VALUE_MAX)) {
            continue;
        }

        value_start = (char *)p - PROP_VALUE_MAX;
        if (!value_sane(value_start)) {
            continue;
        }

        serialp = (char *)p - PROP_VALUE_MAX - 4;
        memcpy(&serial, serialp, sizeof(serial));

        /* dirty -> value -> clean, y nhu bionic */
        next = serial | 1u;
        memcpy(serialp, &next, sizeof(next));
        memcpy(value_start, val, vlen);
        value_start[vlen] = '\0';
        __sync_synchronize();
        next = (serial | 1u) + 1u;
        memcpy(serialp, &next, sizeof(next));

        hits++;
        p += klen;
    }

    munmap((void *)base, size);
    return hits;
}

/* Ghi mot cap key/value tren toan bo vung property. Tra ve so lan ghi duoc. */
static int write_one(const char *key, const char *val)
{
    DIR *d;
    struct dirent *de;
    char path[512];
    int hits = 0;

    d = opendir(PROP_DIR);
    if (d == NULL) {
        printf("bugos_propfix: khong mo duoc %s\n", PROP_DIR);
        return 0;
    }

    while ((de = readdir(d)) != NULL) {
        if (de->d_name[0] == '.') {
            continue;
        }
        snprintf(path, sizeof(path), "%s/%s", PROP_DIR, de->d_name);
        hits += patch_file(path, key, val);
    }

    closedir(d);
    return hits;
}

int main(int argc, char **argv)
{
    int i;
    int ok = 0;
    int bad = 0;

    /* Cho phep go tay: bugos_propfix <key> <value> */
    if (argc == 3) {
        int n = write_one(argv[1], argv[2]);

        printf("bugos_propfix: %s=%s -> %d lan ghi\n", argv[1], argv[2], n);
        return n > 0 ? 0 : 1;
    }

    printf("bugos_propfix: bat dau (uid=%d)\n", (int)getuid());

    for (i = 0; i < TARGET_COUNT; i++) {
        int n = write_one(TARGETS[i].key, TARGETS[i].val);

        if (n > 0) {
            printf("bugos_propfix: %s=%s (%d)\n", TARGETS[i].key, TARGETS[i].val, n);
            ok++;
        } else {
            printf("bugos_propfix: %s: khong ghi duoc\n", TARGETS[i].key);
            bad++;
        }
    }

    printf("bugos_propfix: xong - %d doi, %d loi\n", ok, bad);
    return bad == 0 ? 0 : 1;
}
