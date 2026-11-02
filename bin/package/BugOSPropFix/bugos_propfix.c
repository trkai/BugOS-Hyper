/*
 * bugos_propfix - ghi de prop trang thai bootloader o tang vung property.
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
 * CACH LAM (giong resetprop cua Magisk, khong can Magisk)
 *   1. __system_property_find() lay con tro toi prop_info trong vung property
 *   2. doc /proc/self/maps de biet prop_info nam trong FILE nao, offset bao nhieu
 *   3. mmap lai chinh file do voi PROT_WRITE
 *      -> khong dung duoc __system_property_update: bionic map vung property chi
 *         PROT_READ cho moi process khong phai init, ghi vao se SIGSEGV
 *   4. ghi value + bump serial (bit 0 = dirty) de moi reader thay gia tri moi
 *
 * AN TOAN
 *   - chi ghi khi ten nam ngay sau struct prop_info khop dung key (chong ghi nham)
 *   - chi ghi khi duong dan mapping bat dau bang /dev/__properties__/
 *   - gia tri deu ngan hon PROP_VALUE_MAX (92)
 *   - chay tu init service oneshot: loi thi chi in log roi thoat, khong anh
 *     huong boot, khong boot loop
 *
 * Build: NDK, aarch64, static. Xem .github/workflows/build.yml buoc
 * "Build prop-fix helper".
 */

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/system_properties.h>

/* bionic: PROP_VALUE_MAX = 92, prop_info = { u32 serial; char value[92]; char name[]; } */
#define BUGOS_PROP_VALUE_MAX 92

struct bugos_prop_info {
    uint32_t serial;
    char value[BUGOS_PROP_VALUE_MAX];
    char name[];
};

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
 * Tim dong trong /proc/self/maps chua dia chi addr.
 * Tra ve 1 neu thay va doc duoc duong dan file, 0 neu khong.
 */
static int find_mapping(const void *addr, char *path, size_t path_sz,
                        uintptr_t *start, size_t *len)
{
    FILE *f;
    char line[1024];
    int found = 0;

    f = fopen("/proc/self/maps", "r");
    if (f == NULL) {
        return 0;
    }

    while (fgets(line, (int)sizeof(line), f) != NULL) {
        unsigned long s = 0;
        unsigned long e = 0;
        char perms[8];
        char file[768];
        int n;

        memset(perms, 0, sizeof(perms));
        memset(file, 0, sizeof(file));

        n = sscanf(line, "%lx-%lx %7s %*s %*s %*s %767[^\n]", &s, &e, perms, file);
        if (n < 3) {
            continue;
        }
        if ((uintptr_t)addr < (uintptr_t)s) {
            continue;
        }
        if ((uintptr_t)addr >= (uintptr_t)e) {
            continue;
        }
        if (n < 4) {
            /* mapping an danh, khong co file */
            break;
        }

        {
            char *q = file;
            while (*q == ' ' || *q == '\t') {
                q++;
            }
            if (*q == '\0') {
                break;
            }
            snprintf(path, path_sz, "%s", q);
            *start = (uintptr_t)s;
            *len = (size_t)(e - s);
            found = 1;
        }
        break;
    }

    fclose(f);
    return found;
}

/*
 * Ghi de mot prop. Tra ve 0 neu da ghi, khac 0 neu bo qua / loi.
 */
static int write_one(const char *key, const char *val)
{
    const void *found;
    char path[768];
    uintptr_t start = 0;
    size_t len = 0;
    size_t off;
    size_t vlen;
    size_t nlen;
    int fd;
    void *base;
    struct bugos_prop_info *pi;
    uint32_t serial;

    found = (const void *)__system_property_find(key);
    if (found == NULL) {
        printf("bugos_propfix: %s: khong co prop\n", key);
        return 1;
    }

    if (!find_mapping(found, path, sizeof(path), &start, &len)) {
        printf("bugos_propfix: %s: khong xac dinh duoc mapping\n", key);
        return 2;
    }

    if (strncmp(path, "/dev/__properties__/", 20) != 0) {
        printf("bugos_propfix: %s: mapping la (%s) - bo qua\n", key, path);
        return 3;
    }

    off = (size_t)((uintptr_t)found - start);

    fd = open(path, O_RDWR | O_CLOEXEC);
    if (fd < 0) {
        printf("bugos_propfix: %s: open(%s) loi\n", key, path);
        return 4;
    }

    base = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    close(fd);
    if (base == MAP_FAILED) {
        printf("bugos_propfix: %s: mmap RW loi\n", key);
        return 5;
    }

    pi = (struct bugos_prop_info *)((char *)base + off);

    /* Chan ghi nham o: ten ngay sau struct phai khop dung key */
    nlen = strnlen(pi->name, 64);
    if (nlen != strlen(key) || memcmp(pi->name, key, nlen) != 0) {
        printf("bugos_propfix: %s: ten khong khop (%s) - bo qua\n", key, pi->name);
        munmap(base, len);
        return 6;
    }

    vlen = strlen(val);
    if (vlen >= BUGOS_PROP_VALUE_MAX) {
        munmap(base, len);
        return 7;
    }

    serial = __atomic_load_n(&pi->serial, __ATOMIC_RELAXED);
    __atomic_store_n(&pi->serial, serial | 1u, __ATOMIC_RELAXED);
    memcpy(pi->value, val, vlen);
    pi->value[vlen] = '\0';
    __atomic_thread_fence(__ATOMIC_RELEASE);
    __atomic_store_n(&pi->serial, (serial | 1u) + 1u, __ATOMIC_RELAXED);

    munmap(base, len);
    return 0;
}

int main(int argc, char **argv)
{
    int i;
    int ok = 0;
    int bad = 0;

    /* Cho phep go tay: bugos_propfix <key> <value> */
    if (argc == 3) {
        int rc = write_one(argv[1], argv[2]);
        printf("bugos_propfix: %s=%s -> %s\n", argv[1], argv[2], rc == 0 ? "ok" : "loi");
        return rc == 0 ? 0 : 1;
    }

    printf("bugos_propfix: bat dau (uid=%d)\n", (int)getuid());

    for (i = 0; i < TARGET_COUNT; i++) {
        if (write_one(TARGETS[i].key, TARGETS[i].val) == 0) {
            printf("bugos_propfix: %s=%s\n", TARGETS[i].key, TARGETS[i].val);
            ok++;
        } else {
            bad++;
        }
    }

    printf("bugos_propfix: xong - %d doi, %d loi\n", ok, bad);
    return bad == 0 ? 0 : 1;
}
