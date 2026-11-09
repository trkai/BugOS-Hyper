package com.android.settings.mod;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.net.Uri;
import android.os.Environment;
import android.os.ParcelFileDescriptor;
import java.io.File;
import java.io.FileNotFoundException;

public class ToolboxFileProvider extends ContentProvider {
    public static final String AUTHORITY = "com.android.settings.mod.fileprovider";

    public static Uri getUriForFile(Context context, File file) {
        return Uri.parse("content://" + AUTHORITY + "/" + file.getName());
    }

    @Override
    public boolean onCreate() {
        return true;
    }

    private File resolveFile(Uri uri) throws FileNotFoundException {
        String name = uri.getLastPathSegment();
        if (name == null || name.isEmpty()) {
            throw new FileNotFoundException("Invalid URI: " + uri);
        }
        Context ctx = getContext();
        if (ctx != null) {
            File f = new File(ctx.getCacheDir(), name);
            if (f.exists()) return f;
            f = new File(new File(ctx.getCacheDir(), "modules"), name);
            if (f.exists()) return f;
            f = new File(ctx.getExternalCacheDir(), name);
            if (f.exists()) return f;
            f = new File(ctx.getFilesDir(), name);
            if (f.exists()) return f;
        }
        File dl = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS), name);
        if (dl.exists()) return dl;
        throw new FileNotFoundException("File not found on device: " + name);
    }

    @Override
    public ParcelFileDescriptor openFile(Uri uri, String mode) throws FileNotFoundException {
        File file = resolveFile(uri);
        return ParcelFileDescriptor.open(file, ParcelFileDescriptor.MODE_READ_ONLY);
    }

    @Override
    public String getType(Uri uri) {
        String path = uri.getPath();
        if (path != null) {
            if (path.endsWith(".apk")) return "application/vnd.android.package-archive";
            if (path.endsWith(".zip")) return "application/zip";
        }
        return "application/octet-stream";
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
        if (projection == null) {
            projection = new String[]{"_display_name", "_size"};
        }
        try {
            File file = resolveFile(uri);
            MatrixCursor cursor = new MatrixCursor(projection, 1);
            MatrixCursor.RowBuilder row = cursor.newRow();
            for (String col : projection) {
                if ("_display_name".equals(col)) {
                    row.add(file.getName());
                } else if ("_size".equals(col)) {
                    row.add(file.length());
                } else {
                    row.add(null);
                }
            }
            return cursor;
        } catch (FileNotFoundException e) {
            return null;
        }
    }

    @Override
    public Uri insert(Uri uri, ContentValues values) { return null; }
    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) { return 0; }
    @Override
    public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) { return 0; }
}
