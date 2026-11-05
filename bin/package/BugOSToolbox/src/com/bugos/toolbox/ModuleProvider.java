package com.bugos.toolbox;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.database.Cursor;
import android.net.Uri;
import android.os.ParcelFileDescriptor;

import java.io.File;
import java.io.FileNotFoundException;

/**
 * Cấp module.zip cho SukiSU đọc.
 *
 * SukiSU khai báo ACTION_VIEW với mimeType application/zip + scheme content,
 * nên chỉ cần trả về một content:// hợp lệ là nó mở thẳng màn hình flash module.
 * Không dùng androidx FileProvider để khỏi kéo cả AndroidX vào một app 3 màn hình.
 */
public class ModuleProvider extends ContentProvider {

    @Override
    public boolean onCreate() {
        return true;
    }

    @Override
    public ParcelFileDescriptor openFile(Uri uri, String mode) throws FileNotFoundException {
        File zip = new File(MainActivity.MODULE_ZIP);
        if (!zip.isFile()) {
            throw new FileNotFoundException("Không có " + MainActivity.MODULE_ZIP);
        }
        return ParcelFileDescriptor.open(zip, ParcelFileDescriptor.MODE_READ_ONLY);
    }

    @Override
    public String getType(Uri uri) {
        return "application/zip";
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection,
                        String[] selectionArgs, String sortOrder) {
        return null;
    }

    @Override
    public Uri insert(Uri uri, ContentValues values) {
        return null;
    }

    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) {
        return 0;
    }

    @Override
    public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
        return 0;
    }
}
