package com.bugos.toolbox;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageInstaller;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * BugOS Toolbox.
 *
 * Hai chức năng, đúng thứ tự bắt buộc:
 *   1. Cài SukiSU Ultra manager thành app dữ liệu (/data/app).
 *      Kernel chỉ "crowning" manager khi thấy base.apk trong /data/app; app hệ
 *      thống ở /product/app không bao giờ được quét tới, nên phải cài lại.
 *   2. Mở màn hình flash module của SukiSU với module đóng sẵn trong ROM.
 *      Chỉ bật khi bước 1 xong - SukiSU chưa cài thì không có gì để mở.
 *
 * App này nằm trong /product/priv-app nên giữ được INSTALL_PACKAGES: cài ngầm,
 * không hiện hộp thoại xác nhận của PackageInstaller.
 */
public class MainActivity extends Activity {

    static final String SUKISU_PKG = "com.sukisu.ultra";
    static final String SUKISU_APK = "/product/app/SukiSUUltra/SukiSUUltra.apk";
    static final String MODULE_ZIP = "/product/etc/bugos/toolbox/module.zip";
    static final String MODULE_AUTHORITY = "com.bugos.toolbox.module";

    private TextView statusView;
    private TextView moduleView;
    private Button installBtn;
    private Button moduleBtn;

    /** Activity đang hiện, để InstallReceiver báo kết quả về đúng chỗ. */
    private static MainActivity sForeground;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(buildUi());
    }

    @Override
    protected void onResume() {
        super.onResume();
        sForeground = this;
        refresh();
    }

    @Override
    protected void onPause() {
        if (sForeground == this) {
            sForeground = null;
        }
        super.onPause();
    }

    /** InstallReceiver gọi vào đây sau khi phiên cài kết thúc. */
    static void onInstallResult(final int status, final String message) {
        final MainActivity activity = sForeground;
        if (activity == null) {
            return;
        }
        activity.runOnUiThread(() -> {
            activity.installBtn.setEnabled(true);
            if (status == PackageInstaller.STATUS_SUCCESS) {
                activity.toast("Đã cài SukiSU Ultra");
            } else if (status == PackageInstaller.STATUS_PENDING_USER_ACTION) {
                activity.toast("Hệ thống yêu cầu xác nhận - thiếu quyền INSTALL_PACKAGES?");
            } else {
                activity.toast("Cài thất bại (status " + status + "): " + message);
            }
            activity.refresh();
        });
    }

    // ------------------------------------------------------------------
    // UI dựng bằng code: không cần layout XML, giữ build chỉ có aapt2 link.
    // ------------------------------------------------------------------
    private View buildUi() {
        int pad = dp(24);

        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setPadding(pad, pad, pad, pad);

        TextView title = new TextView(this);
        title.setText("BugOS Toolbox");
        title.setTextSize(TypedValue.COMPLEX_UNIT_SP, 26);
        title.setGravity(Gravity.START);
        root.addView(title);

        TextView sub = new TextView(this);
        sub.setText("Cài root manager rồi flash module có sẵn.");
        sub.setTextSize(TypedValue.COMPLEX_UNIT_SP, 14);
        sub.setPadding(0, dp(6), 0, dp(24));
        root.addView(sub);

        statusView = new TextView(this);
        statusView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 15);
        statusView.setPadding(0, 0, 0, dp(20));
        root.addView(statusView);

        installBtn = new Button(this);
        installBtn.setText("1. Cài SukiSU Ultra manager");
        installBtn.setAllCaps(false);
        installBtn.setOnClickListener(v -> installManager());
        root.addView(installBtn, buttonParams());

        TextView hint1 = new TextView(this);
        hint1.setText("Cài ngầm vào /data/app. Kernel chỉ nhận manager khi nó nằm ở đó.");
        hint1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
        hint1.setPadding(dp(4), dp(6), 0, dp(24));
        root.addView(hint1);

        moduleBtn = new Button(this);
        moduleBtn.setText("2. Flash module có sẵn");
        moduleBtn.setAllCaps(false);
        moduleBtn.setOnClickListener(v -> openModuleInstaller());
        root.addView(moduleBtn, buttonParams());

        moduleView = new TextView(this);
        moduleView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
        moduleView.setPadding(dp(4), dp(6), 0, 0);
        root.addView(moduleView);

        ScrollView scroll = new ScrollView(this);
        scroll.addView(root, new ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        return scroll;
    }

    private LinearLayout.LayoutParams buttonParams() {
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, dp(56));
        lp.topMargin = dp(4);
        return lp;
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }

    // ------------------------------------------------------------------
    // Trạng thái
    // ------------------------------------------------------------------
    /** Manager đã nằm trong /data/app chưa (đó mới là bản kernel nhận). */
    private boolean isManagerInstalled() {
        try {
            ApplicationInfo ai = getPackageManager().getApplicationInfo(SUKISU_PKG, 0);
            return ai.sourceDir != null && ai.sourceDir.startsWith("/data/app/");
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    private void refresh() {
        boolean installed = isManagerInstalled();
        if (installed) {
            statusView.setText("SukiSU Ultra: đã cài trong /data/app");
            statusView.setTextColor(Color.parseColor("#1B8A3A"));
            installBtn.setText("1. Cài lại SukiSU Ultra manager");
        } else {
            statusView.setText("SukiSU Ultra: chưa cài trong /data/app");
            statusView.setTextColor(Color.parseColor("#C0392B"));
            installBtn.setText("1. Cài SukiSU Ultra manager");
        }
        installBtn.setEnabled(true);

        // Chức năng 2 phụ thuộc chức năng 1.
        moduleBtn.setEnabled(installed);
        moduleBtn.setAlpha(installed ? 1f : 0.4f);

        File zip = new File(MODULE_ZIP);
        if (!zip.exists()) {
            moduleView.setText("Module: chưa có file tại " + MODULE_ZIP);
        } else {
            moduleView.setText("Module: " + zip.getName() + " (" + (zip.length() / 1024) + " KB)");
        }
    }

    // ------------------------------------------------------------------
    // Chức năng 1: cài manager
    // ------------------------------------------------------------------
    private void installManager() {
        File apk = new File(SUKISU_APK);
        if (!apk.isFile()) {
            // Dự phòng: lấy đường dẫn thật từ PackageManager (trường hợp ROM đổi chỗ).
            try {
                ApplicationInfo ai = getPackageManager().getApplicationInfo(SUKISU_PKG, 0);
                apk = new File(ai.sourceDir);
            } catch (PackageManager.NameNotFoundException e) {
                toast("Không thấy APK SukiSU trong ROM");
                return;
            }
        }
        if (!apk.isFile()) {
            toast("Không thấy " + SUKISU_APK);
            return;
        }

        installBtn.setEnabled(false);
        try {
            PackageInstaller installer = getPackageManager().getPackageInstaller();
            PackageInstaller.SessionParams params =
                    new PackageInstaller.SessionParams(PackageInstaller.SessionParams.MODE_FULL_INSTALL);
            int sessionId = installer.createSession(params);

            Intent result = new Intent(this, InstallReceiver.class);
            result.putExtra(InstallReceiver.EXTRA_SESSION, sessionId);
            PendingIntent pending = PendingIntent.getBroadcast(
                    this, sessionId, result,
                    PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_MUTABLE);

            // commit() phải gọi trên session đang mở (không có getSession(id)).
            try (PackageInstaller.Session session = installer.openSession(sessionId)) {
                long total;
                try (InputStream in = new FileInputStream(apk);
                     OutputStream out = session.openWrite("base.apk", 0, apk.length())) {
                    byte[] buf = new byte[256 * 1024];
                    int n;
                    total = 0;
                    while ((n = in.read(buf)) > 0) {
                        out.write(buf, 0, n);
                        total += n;
                    }
                    session.fsync(out);
                }
                toast("Đang cài " + (total / 1024 / 1024) + " MB…");
                session.commit(pending.getIntentSender());
            }
        } catch (Exception e) {
            installBtn.setEnabled(true);
            toast("Cài thất bại: " + e);
        }
    }

    // ------------------------------------------------------------------
    // Chức năng 2: mở màn hình flash module của SukiSU
    // ------------------------------------------------------------------
    private void openModuleInstaller() {
        if (!isManagerInstalled()) {
            toast("Cài manager trước đã");
            return;
        }
        File zip = new File(MODULE_ZIP);
        if (!zip.isFile()) {
            toast("Chưa có module tại " + MODULE_ZIP);
            return;
        }

        Uri uri = Uri.parse("content://" + MODULE_AUTHORITY + "/module.zip");
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(uri, "application/zip");
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        try {
            startActivity(intent);
        } catch (Exception e) {
            toast("SukiSU không nhận file module: " + e);
        }
    }

    private void toast(String message) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show();
    }
}
