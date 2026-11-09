package com.android.settings.mod;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class BugOSModActivity extends Activity {
    private static final int REQ_PICK_BANNER = 1001;

    private ImageView ivBanner;
    private TextView tvDeviceName;
    private View btnEditBanner;
    private Button btnActionSukiSU;
    private TextView tvStep2Status;
    private Button btnFlash;

    private final ExecutorService executor = Executors.newSingleThreadExecutor();
    private final Handler mainHandler = new Handler(Looper.getMainLooper());

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        int layoutId = getResources().getIdentifier("activity_bugos_mod", "layout", getPackageName());
        if (layoutId != 0) {
            setContentView(layoutId);
        }

        ActionBar actionBar = getActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true);
            actionBar.setTitle("Mod");
        }

        int idBanner = getResources().getIdentifier("iv_mod_banner", "id", getPackageName());
        int idDevName = getResources().getIdentifier("tv_device_name", "id", getPackageName());
        int idEditBanner = getResources().getIdentifier("btn_edit_banner", "id", getPackageName());
        int idBannerCard = getResources().getIdentifier("card_banner", "id", getPackageName());
        int idActionSukiSU = getResources().getIdentifier("btn_action_sukisu", "id", getPackageName());
        int idStatus = getResources().getIdentifier("tv_step2_status", "id", getPackageName());
        int idFlash = getResources().getIdentifier("btn_flash", "id", getPackageName());

        if (idBanner != 0) ivBanner = findViewById(idBanner);
        if (idDevName != 0) tvDeviceName = findViewById(idDevName);
        if (idEditBanner != 0) btnEditBanner = findViewById(idEditBanner);
        if (idActionSukiSU != 0) btnActionSukiSU = findViewById(idActionSukiSU);
        if (idStatus != 0) tvStep2Status = findViewById(idStatus);
        if (idFlash != 0) btnFlash = findViewById(idFlash);

        if (tvDeviceName != null) {
            tvDeviceName.setText(getDeviceNameString());
        }

        loadCustomBanner();

        if (btnEditBanner != null) {
            btnEditBanner.setOnClickListener(v -> openImagePicker());
            btnEditBanner.setOnLongClickListener(v -> {
                resetDefaultBanner();
                return true;
            });
        }

        if (idBannerCard != 0) {
            View bannerCard = findViewById(idBannerCard);
            if (bannerCard != null) {
                bannerCard.setOnLongClickListener(v -> {
                    openImagePicker();
                    return true;
                });
            }
        }

        if (btnFlash != null) {
            btnFlash.setOnClickListener(v -> handleFlashModule());
        }
    }

    private String getDeviceNameString() {
        String name = getSystemProperty("ro.product.marketname");
        if (name != null && !name.trim().isEmpty()) {
            return name.trim();
        }
        try {
            String dev = Settings.Global.getString(getContentResolver(), "device_name");
            if (dev != null && !dev.trim().isEmpty()) {
                return dev.trim();
            }
        } catch (Exception ignored) {}

        if (Build.MODEL != null && !Build.MODEL.trim().isEmpty()) {
            return Build.MODEL.trim();
        }
        return "Xiaomi HyperOS Device";
    }

    private String getSystemProperty(String key) {
        try {
            Class<?> c = Class.forName("android.os.SystemProperties");
            Method get = c.getMethod("get", String.class);
            return (String) get.invoke(null, key);
        } catch (Exception e) {
            return null;
        }
    }

    private void openImagePicker() {
        try {
            Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
            intent.setType("image/*");
            intent.addCategory(Intent.CATEGORY_OPENABLE);
            startActivityForResult(Intent.createChooser(intent, "Chọn ảnh bìa"), REQ_PICK_BANNER);
        } catch (Exception e) {
            Toast.makeText(this, "Không thể mở bộ chọn ảnh: " + e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQ_PICK_BANNER && resultCode == RESULT_OK && data != null && data.getData() != null) {
            Uri imageUri = data.getData();
            saveBannerFromUri(imageUri);
        }
    }

    private void saveBannerFromUri(Uri uri) {
        executor.execute(() -> {
            try {
                File dest = new File(getFilesDir(), "mod_banner_custom.png");
                try (InputStream in = getContentResolver().openInputStream(uri);
                     OutputStream out = new FileOutputStream(dest)) {
                    byte[] buf = new byte[8192];
                    int len;
                    while ((len = in.read(buf)) > 0) {
                        out.write(buf, 0, len);
                    }
                }
                mainHandler.post(() -> {
                    loadCustomBanner();
                    Toast.makeText(this, "Đã cập nhật ảnh bìa!", Toast.LENGTH_SHORT).show();
                });
            } catch (Exception e) {
                mainHandler.post(() -> Toast.makeText(this, "Lỗi lưu ảnh: " + e.getMessage(), Toast.LENGTH_SHORT).show());
            }
        });
    }

    private void loadCustomBanner() {
        if (ivBanner == null) return;
        File custom = new File(getFilesDir(), "mod_banner_custom.png");
        if (custom.exists() && custom.length() > 0) {
            try {
                Bitmap bmp = BitmapFactory.decodeFile(custom.getAbsolutePath());
                if (bmp != null) {
                    ivBanner.setImageBitmap(bmp);
                    return;
                }
            } catch (Exception ignored) {}
        }
        int defRes = getResources().getIdentifier("bg_mod_banner_default", "drawable", getPackageName());
        if (defRes != 0) {
            ivBanner.setImageResource(defRes);
        }
    }

    private void resetDefaultBanner() {
        File custom = new File(getFilesDir(), "mod_banner_custom.png");
        if (custom.exists()) custom.delete();
        loadCustomBanner();
        Toast.makeText(this, "Đã đặt lại ảnh bìa mặc định!", Toast.LENGTH_SHORT).show();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            finish();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onResume() {
        super.onResume();
        updateUIState();
    }

    private boolean isPackageInstalled(String pkg) {
        try {
            getPackageManager().getPackageInfo(pkg, 0);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    private void updateUIState() {
        boolean installed = isPackageInstalled("com.sukisu.ultra");

        if (btnActionSukiSU != null) {
            btnActionSukiSU.setEnabled(true);
            if (installed) {
                btnActionSukiSU.setText("Mở");
                int bgId = getResources().getIdentifier("bg_mod_btn_pill_outline", "drawable", getPackageName());
                if (bgId != 0) btnActionSukiSU.setBackgroundResource(bgId);
                btnActionSukiSU.setTextColor(Color.parseColor("#1BA784"));
                btnActionSukiSU.setOnClickListener(v -> handleOpenSukiSU());
            } else {
                btnActionSukiSU.setText("Cài đặt");
                int bgId = getResources().getIdentifier("bg_mod_btn_pill_primary", "drawable", getPackageName());
                if (bgId != 0) btnActionSukiSU.setBackgroundResource(bgId);
                btnActionSukiSU.setTextColor(Color.WHITE);
                btnActionSukiSU.setOnClickListener(v -> handleInstallSukiSU());
            }
        }

        if (tvStep2Status != null) {
            if (installed) {
                tvStep2Status.setText("✓ Sẵn sàng");
                tvStep2Status.setTextColor(Color.parseColor("#1BA784"));
            } else {
                tvStep2Status.setText("Cần SukiSU Ultra trước");
                tvStep2Status.setTextColor(Color.parseColor("#FF5252"));
            }
        }

        if (btnFlash != null) {
            btnFlash.setEnabled(installed);
            btnFlash.setText("Flash");
            int bgId = getResources().getIdentifier(installed ? "bg_mod_btn_pill_primary" : "bg_mod_btn_pill_disabled", "drawable", getPackageName());
            if (bgId != 0) btnFlash.setBackgroundResource(bgId);
            btnFlash.setTextColor(installed ? Color.WHITE : Color.parseColor("#888888"));
        }
    }

    private void handleInstallSukiSU() {
        if (btnActionSukiSU != null) {
            btnActionSukiSU.setEnabled(false);
            btnActionSukiSU.setText("Đang cài...");
        }

        executor.execute(() -> {
            File apk = new File(getCacheDir(), "sukisu_ultra.apk");
            boolean ok = false;
            try {
                copyAssetToFile("sukisu_ultra.apk", apk);
                ok = trySilentInstall(apk);
            } catch (Exception e) {
                e.printStackTrace();
            }

            final boolean silentOk = ok;
            mainHandler.post(() -> {
                if (silentOk) {
                    Toast.makeText(this, "Cài đặt SukiSU Ultra thành công!", Toast.LENGTH_SHORT).show();
                    updateUIState();
                } else {
                    launchSystemInstaller(apk);
                    updateUIState();
                }
            });
        });
    }

    private boolean trySilentInstall(File apk) {
        try {
            String cmd = "cp " + apk.getAbsolutePath() + " /data/local/tmp/sukisu.apk && pm install -r -d /data/local/tmp/sukisu.apk && rm -f /data/local/tmp/sukisu.apk";
            Process p = Runtime.getRuntime().exec(new String[]{"su", "-c", cmd});
            return p.waitFor() == 0;
        } catch (Exception e) {
            return false;
        }
    }

    private void launchSystemInstaller(File apk) {
        try {
            Uri uri = ToolboxFileProvider.getUriForFile(this, apk);
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setDataAndType(uri, "application/vnd.android.package-archive");
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_GRANT_READ_URI_PERMISSION);
            startActivity(intent);
        } catch (Exception e) {
            Toast.makeText(this, "Lỗi mở trình cài đặt: " + e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    private void handleOpenSukiSU() {
        if (!isPackageInstalled("com.sukisu.ultra")) {
            Toast.makeText(this, "Vui lòng bấm 'Cài đặt' SukiSU Ultra trước!", Toast.LENGTH_SHORT).show();
            return;
        }
        try {
            Intent intent = getPackageManager().getLaunchIntentForPackage("com.sukisu.ultra");
            if (intent != null) {
                startActivity(intent);
            }
        } catch (Exception e) {
            Toast.makeText(this, "Không thể mở SukiSU Ultra: " + e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    private void handleFlashModule() {
        if (!isPackageInstalled("com.sukisu.ultra")) {
            Toast.makeText(this, "Vui lòng cài đặt SukiSU Ultra trước!", Toast.LENGTH_SHORT).show();
            return;
        }

        if (btnFlash != null) {
            btnFlash.setEnabled(false);
            btnFlash.setText("Đang chuẩn bị...");
        }

        executor.execute(() -> {
            File modulesDir = new File(getCacheDir(), "modules");
            if (!modulesDir.exists()) modulesDir.mkdirs();
            File zip = new File(modulesDir, "ZygiskNext+AlwaysStrongInject.zip");

            try {
                copyAssetToFile("ZygiskNext+AlwaysStrongInject.zip", zip);
            } catch (Exception e) {
                e.printStackTrace();
            }

            mainHandler.post(() -> {
                openSukiSUFlashScreen(zip);
                if (btnFlash != null) {
                    btnFlash.setEnabled(true);
                    btnFlash.setText("Flash");
                }
            });
        });
    }

    private void openSukiSUFlashScreen(File zip) {
        try {
            Uri uri = ToolboxFileProvider.getUriForFile(this, zip);
            grantUriPermission("com.sukisu.ultra", uri, Intent.FLAG_GRANT_READ_URI_PERMISSION);

            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setDataAndType(uri, "application/zip");
            intent.setPackage("com.sukisu.ultra");
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_GRANT_READ_URI_PERMISSION);
            startActivity(intent);
        } catch (Exception e) {
            Toast.makeText(this, "Lỗi mở SukiSU Flash: " + e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    private void copyAssetToFile(String assetName, File outFile) throws Exception {
        if (outFile.exists() && outFile.length() > 0) return;
        try (InputStream in = getAssets().open(assetName);
             OutputStream out = new FileOutputStream(outFile)) {
            byte[] buf = new byte[8192];
            int len;
            while ((len = in.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
        }
    }
}
