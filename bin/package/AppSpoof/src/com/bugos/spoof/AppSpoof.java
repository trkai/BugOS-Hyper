package com.bugos.spoof;

import android.content.Context;
import android.os.Build;
import android.provider.Settings;
import android.util.Base64;

import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

/**
 * Spoof Build props theo TỪNG app (không phải toàn hệ thống).
 *
 * Được gọi từ Instrumentation.newApplication() sau Application.attach(Context):
 * lúc đó tiến trình đã có package name và Context, nhưng chưa chạy onCreate của
 * app, nên mọi lần đọc Build.* sau đó đều thấy giá trị giả.
 *
 * Nguồn cấu hình, theo thứ tự ưu tiên:
 *   1. Settings.Global "bugos_app_spoof" = base64(JSON)  -> đổi được runtime
 *   2. /system/etc/bugos/app-spoof.json                  -> mặc định đóng vào ROM
 *
 * JSON: { "<package>": { "BRAND": "...", "MODEL": "...", "FINGERPRINT": "..." }, ... }
 */
public final class AppSpoof {

    private static final String GLOBAL_KEY = "bugos_app_spoof";
    private static final String FALLBACK = "/system/etc/bugos/app-spoof.json";

    private static volatile Map<String, String> sProps;
    private static volatile String sPkg;

    private static final String[] FIELDS = {
            "BRAND", "DEVICE", "MANUFACTURER", "MODEL", "PRODUCT", "FINGERPRINT",
            "BRAND_FOR_ATTESTATION", "DEVICE_FOR_ATTESTATION",
            "MANUFACTURER_FOR_ATTESTATION", "MODEL_FOR_ATTESTATION",
            "PRODUCT_FOR_ATTESTATION"
    };

    private AppSpoof() {
    }

    /** Gọi từ smali: Instrumentation.newApplication -> sau Application.attach(). */
    public static void apply(Context ctx) {
        try {
            if (ctx == null) {
                return;
            }
            String pkg = ctx.getPackageName();
            if (pkg == null || pkg.length() == 0 || pkg.equals(sPkg)) {
                return;
            }

            JSONObject profile = loadProfile(ctx, pkg);
            if (profile == null || !profile.optBoolean("enabled", true)) {
                return;
            }

            HashMap<String, String> map = new HashMap<String, String>();
            for (int i = 0; i < FIELDS.length; i++) {
                String field = FIELDS[i];
                String value = profile.optString(field, "");
                if (value.length() == 0) {
                    continue;
                }
                setField(field, value);
                String prop = propKey(field);
                if (prop != null) {
                    map.put(prop, value);
                }
            }

            sProps = map;
            sPkg = pkg;
        } catch (Throwable ignored) {
            // Không bao giờ được làm chết tiến trình đang khởi tạo.
        }
    }

    /**
     * Gọi từ smali: SystemProperties.get(String[, String]).
     * Trả null nghĩa là "không spoof key này" -> rơi xuống giá trị thật.
     */
    public static String prop(String key) {
        Map<String, String> map = sProps;
        if (map == null || key == null) {
            return null;
        }
        return map.get(key);
    }

    private static JSONObject loadProfile(Context ctx, String pkg) {
        String raw = null;

        try {
            String b64 = Settings.Global.getString(ctx.getContentResolver(), GLOBAL_KEY);
            if (b64 != null && b64.length() > 0) {
                raw = new String(Base64.decode(b64, Base64.DEFAULT), "UTF-8");
            }
        } catch (Throwable ignored) {
        }

        if (raw == null || raw.length() == 0) {
            raw = readFile(FALLBACK);
        }
        if (raw == null || raw.length() == 0) {
            return null;
        }

        try {
            JSONObject root = new JSONObject(raw);
            return root.optJSONObject(pkg);
        } catch (Throwable t) {
            return null;
        }
    }

    private static String readFile(String path) {
        FileInputStream in = null;
        try {
            File f = new File(path);
            if (!f.exists()) {
                return null;
            }
            in = new FileInputStream(f);
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            byte[] buf = new byte[4096];
            int n;
            while ((n = in.read(buf)) != -1) {
                out.write(buf, 0, n);
            }
            return new String(out.toByteArray(), "UTF-8");
        } catch (Throwable t) {
            return null;
        } finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Throwable ignored) {
            }
        }
    }

    private static void setField(String name, String value) {
        try {
            Field f = Build.class.getField(name);
            f.setAccessible(true);
            f.set(null, value);
        } catch (Throwable ignored) {
            // Field còn final (chưa patch Build.smali) hoặc không tồn tại.
        }
    }

    private static String propKey(String field) {
        if ("BRAND".equals(field)) {
            return "ro.product.brand";
        }
        if ("DEVICE".equals(field)) {
            return "ro.product.device";
        }
        if ("MANUFACTURER".equals(field)) {
            return "ro.product.manufacturer";
        }
        if ("MODEL".equals(field)) {
            return "ro.product.model";
        }
        if ("PRODUCT".equals(field)) {
            return "ro.product.name";
        }
        if ("FINGERPRINT".equals(field)) {
            return "ro.build.fingerprint";
        }
        return null;
    }
}
