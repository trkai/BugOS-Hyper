package com.bugos.toolbox;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInstaller;

/**
 * Nhận kết quả từ PackageInstaller.
 *
 * Vì app giữ INSTALL_PACKAGES nên phiên cài chạy thẳng, không có hộp thoại xác
 * nhận; kết quả vẫn phải đọc ở đây để biết thành công hay không thay vì đoán.
 */
public class InstallReceiver extends BroadcastReceiver {

    static final String EXTRA_SESSION = "session";

    @Override
    public void onReceive(Context context, Intent intent) {
        int status = intent.getIntExtra(PackageInstaller.EXTRA_STATUS,
                PackageInstaller.STATUS_FAILURE);
        String message = intent.getStringExtra(PackageInstaller.EXTRA_STATUS_MESSAGE);

        MainActivity.onInstallResult(status, message);
    }
}
