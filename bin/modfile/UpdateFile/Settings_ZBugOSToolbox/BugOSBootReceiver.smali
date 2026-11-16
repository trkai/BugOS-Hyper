.class public Lcom/bugos/settings/BugOSBootReceiver;
.super Landroid/content/BroadcastReceiver;
.source "BugOSBootReceiver.java"

# Preference file name used by Settings.apk for BugOS preferences
.field public static final BUGOS_PREFS_NAME:Ljava/lang/String; = "bugos_prefs"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 8

    # --- Lấy SharedPreferences "bugos_prefs" ---
    const-string v0, "bugos_prefs"
    const/4 v1, 0x0
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0

    # --- Đọc bugos_performance_level, ghi prop bugos.perf.level ---
    const-string v1, "bugos_performance_level"
    const-string v2, "balanced"
    invoke-virtual {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

    const-string v2, "bugos.perf.level"
    invoke-static {v2, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    # --- Đọc bugos_app_spoof_enabled, ghi prop bugos.app.spoof.enabled ---
    const-string v1, "bugos_app_spoof_enabled"
    const-string v2, "false"
    invoke-virtual {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

    const-string v2, "bugos.app.spoof.enabled"
    invoke-static {v2, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    # --- Đọc bugos_language, ghi prop bugos.language ---
    const-string v1, "bugos_language"
    const-string v2, "vi-VN"
    invoke-virtual {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

    const-string v2, "bugos.language"
    invoke-static {v2, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    # --- Đọc bugos_theme, ghi prop bugos.theme ---
    const-string v1, "bugos_theme"
    const-string v2, "light"
    invoke-virtual {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

    const-string v2, "bugos.theme"
    invoke-static {v2, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    # --- Áp dụng mức hiệu năng: chạy apply_perf.sh ---
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;
    move-result-object v2

    const-string v0, "/system/etc/bugos/apply_perf.sh"
    invoke-virtual {v2, v0}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    return-void
.end method