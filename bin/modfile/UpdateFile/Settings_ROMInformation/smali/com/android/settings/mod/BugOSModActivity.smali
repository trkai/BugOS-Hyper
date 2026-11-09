.class public Lcom/android/settings/mod/BugOSModActivity;
.super Landroid/app/Activity;
.source "BugOSModActivity.java"


# instance fields
.field private btnActionSukiSU:Landroid/widget/Button;

.field private btnFlash:Landroid/widget/Button;

.field private final executor:Ljava/util/concurrent/ExecutorService;

.field private final mainHandler:Landroid/os/Handler;

.field private tvStep2Status:Landroid/widget/TextView;


# direct methods
.method public static synthetic $r8$lambda$AWEMXkwElnxBlL0lewP-bpXi-BM(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$0(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$EdoclXTvhBxmRy2p999wvb-UahM(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$updateUIState$1(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$H8vjFdRPStzaaQ0Wzx7rWMCFX1k(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$updateUIState$2(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$KTXU2SMtyPNoPsxDrbRP1JaaqLA(Lcom/android/settings/mod/BugOSModActivity;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleInstallSukiSU$4()V

    return-void
.end method

.method public static synthetic $r8$lambda$UIYBO4j0RUv8LDegv5KpsPvJbBo(Lcom/android/settings/mod/BugOSModActivity;ZLjava/io/File;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleInstallSukiSU$3(ZLjava/io/File;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ZZh3Ab1sFzC9DK1LVdzQC1yTy2I(Lcom/android/settings/mod/BugOSModActivity;Ljava/io/File;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleFlashModule$5(Ljava/io/File;)V

    return-void
.end method

.method public static synthetic $r8$lambda$hvzYBtgw8uexFKKZPjjc08lDnME(Lcom/android/settings/mod/BugOSModActivity;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleFlashModule$6()V

    return-void
.end method

.method public constructor <init>()V
    .registers 3

    .line 24
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 29
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    .line 30
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    return-void
.end method

.method private copyAssetToFile(Ljava/lang/String;Ljava/io/File;)V
    .registers 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 237
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_11

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_11

    return-void

    .line 238
    :cond_11
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    .line 239
    :try_start_19
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1e
    .catchall {:try_start_19 .. :try_end_1e} :catchall_40

    .line 240
    const/16 p2, 0x2000

    :try_start_20
    new-array p2, p2, [B

    .line 242
    :goto_22
    invoke-virtual {p1, p2}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-lez v1, :cond_2d

    .line 243
    const/4 v2, 0x0

    invoke-virtual {v0, p2, v2, v1}, Ljava/io/OutputStream;->write([BII)V
    :try_end_2c
    .catchall {:try_start_20 .. :try_end_2c} :catchall_36

    goto :goto_22

    .line 245
    :cond_2d
    :try_start_2d
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_30
    .catchall {:try_start_2d .. :try_end_30} :catchall_40

    if-eqz p1, :cond_35

    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 246
    :cond_35
    return-void

    .line 238
    :catchall_36
    move-exception p2

    :try_start_37
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_3a
    .catchall {:try_start_37 .. :try_end_3a} :catchall_3b

    goto :goto_3f

    :catchall_3b
    move-exception v0

    :try_start_3c
    invoke-virtual {p2, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_3f
    throw p2
    :try_end_40
    .catchall {:try_start_3c .. :try_end_40} :catchall_40

    :catchall_40
    move-exception p2

    if-eqz p1, :cond_4b

    :try_start_43
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_46
    .catchall {:try_start_43 .. :try_end_46} :catchall_47

    goto :goto_4b

    :catchall_47
    move-exception p1

    invoke-virtual {p2, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_4b
    :goto_4b
    throw p2
.end method

.method private handleFlashModule()V
    .registers 3

    .line 190
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_13

    .line 191
    const-string v0, "Vui l\u00f2ng c\u00e0i \u0111\u1eb7t SukiSU Ultra tr\u01b0\u1edbc!"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 192
    return-void

    .line 195
    :cond_13
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz v0, :cond_23

    .line 196
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 197
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v1, "\u0110ang chu\u1ea9n b\u1ecb..."

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 200
    :cond_23
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda1;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 219
    return-void
.end method

.method private handleInstallSukiSU()V
    .registers 3

    .line 124
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    if-eqz v0, :cond_11

    .line 125
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 126
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const-string v1, "\u0110ang c\u00e0i..."

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 129
    :cond_11
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda6;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 150
    return-void
.end method

.method private handleOpenSukiSU()V
    .registers 5

    .line 175
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_13

    .line 176
    const-string v0, "Vui l\u00f2ng b\u1ea5m \'C\u00e0i \u0111\u1eb7t\' SukiSU Ultra tr\u01b0\u1edbc!"

    invoke-static {p0, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 177
    return-void

    .line 180
    :cond_13
    :try_start_13
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 181
    if-eqz v0, :cond_20

    .line 182
    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_20} :catch_21

    .line 186
    :cond_20
    goto :goto_40

    .line 184
    :catch_21
    move-exception v0

    .line 185
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Kh\u00f4ng th\u1ec3 m\u1edf SukiSU Ultra: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 187
    :goto_40
    return-void
.end method

.method private isPackageInstalled(Ljava/lang/String;)Z
    .registers 4

    .line 77
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_8
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_8} :catch_a

    .line 78
    const/4 p1, 0x1

    return p1

    .line 79
    :catch_a
    move-exception p1

    .line 80
    return v0
.end method

.method private synthetic lambda$handleFlashModule$5(Ljava/io/File;)V
    .registers 3

    .line 212
    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->openSukiSUFlashScreen(Ljava/io/File;)V

    .line 213
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz p1, :cond_14

    .line 214
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 215
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v0, "Flash"

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 217
    :cond_14
    return-void
.end method

.method private synthetic lambda$handleFlashModule$6()V
    .registers 4

    .line 201
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "modules"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 202
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_14

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 203
    :cond_14
    new-instance v1, Ljava/io/File;

    const-string v2, "ZygiskNext+AlwaysStrongInject.zip"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 206
    :try_start_1b
    invoke-direct {p0, v2, v1}, Lcom/android/settings/mod/BugOSModActivity;->copyAssetToFile(Ljava/lang/String;Ljava/io/File;)V
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1e} :catch_1f

    .line 209
    goto :goto_23

    .line 207
    :catch_1f
    move-exception v0

    .line 208
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 211
    :goto_23
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v2, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;

    invoke-direct {v2, p0, v1}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;-><init>(Lcom/android/settings/mod/BugOSModActivity;Ljava/io/File;)V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 218
    return-void
.end method

.method private synthetic lambda$handleInstallSukiSU$3(ZLjava/io/File;)V
    .registers 3

    .line 141
    if-eqz p1, :cond_10

    .line 142
    const-string p1, "C\u00e0i \u0111\u1eb7t SukiSU Ultra th\u00e0nh c\u00f4ng!"

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 143
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    goto :goto_16

    .line 145
    :cond_10
    invoke-direct {p0, p2}, Lcom/android/settings/mod/BugOSModActivity;->launchSystemInstaller(Ljava/io/File;)V

    .line 146
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    .line 148
    :goto_16
    return-void
.end method

.method private synthetic lambda$handleInstallSukiSU$4()V
    .registers 5

    .line 130
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "sukisu_ultra.apk"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 131
    nop

    .line 133
    :try_start_c
    invoke-direct {p0, v2, v0}, Lcom/android/settings/mod/BugOSModActivity;->copyAssetToFile(Ljava/lang/String;Ljava/io/File;)V

    .line 134
    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->trySilentInstall(Ljava/io/File;)Z

    move-result v1
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_13} :catch_14

    .line 137
    goto :goto_19

    .line 135
    :catch_14
    move-exception v1

    .line 136
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 v1, 0x0

    .line 139
    :goto_19
    nop

    .line 140
    iget-object v2, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v3, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0, v1, v0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;-><init>(Lcom/android/settings/mod/BugOSModActivity;ZLjava/io/File;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 149
    return-void
.end method

.method private synthetic lambda$onCreate$0(Landroid/view/View;)V
    .registers 2

    .line 56
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleFlashModule()V

    return-void
.end method

.method private synthetic lambda$updateUIState$1(Landroid/view/View;)V
    .registers 2

    .line 94
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleOpenSukiSU()V

    return-void
.end method

.method private synthetic lambda$updateUIState$2(Landroid/view/View;)V
    .registers 2

    .line 100
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleInstallSukiSU()V

    return-void
.end method

.method private launchSystemInstaller(Ljava/io/File;)V
    .registers 4

    .line 164
    :try_start_0
    invoke-static {p0, p1}, Lcom/android/settings/mod/ToolboxFileProvider;->getUriForFile(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    .line 165
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 166
    const-string v1, "application/vnd.android.package-archive"

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 167
    const p1, 0x10000001

    invoke-virtual {v0, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 168
    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_19} :catch_1a

    .line 171
    goto :goto_3a

    .line 169
    :catch_1a
    move-exception p1

    .line 170
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "L\u1ed7i m\u1edf tr\u00ecnh c\u00e0i \u0111\u1eb7t: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 172
    :goto_3a
    return-void
.end method

.method private openSukiSUFlashScreen(Ljava/io/File;)V
    .registers 5

    .line 223
    const-string v0, "com.sukisu.ultra"

    :try_start_2
    invoke-static {p0, p1}, Lcom/android/settings/mod/ToolboxFileProvider;->getUriForFile(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    .line 224
    const/4 v1, 0x1

    invoke-virtual {p0, v0, p1, v1}, Lcom/android/settings/mod/BugOSModActivity;->grantUriPermission(Ljava/lang/String;Landroid/net/Uri;I)V

    .line 226
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 227
    const-string v2, "application/zip"

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 228
    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 229
    const p1, 0x10000001

    invoke-virtual {v1, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 230
    invoke-virtual {p0, v1}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_22
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_22} :catch_23

    .line 233
    goto :goto_43

    .line 231
    :catch_23
    move-exception p1

    .line 232
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "L\u1ed7i m\u1edf SukiSU Flash: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 234
    :goto_43
    return-void
.end method

.method private trySilentInstall(Ljava/io/File;)Z
    .registers 6

    .line 154
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "cp "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " /data/local/tmp/sukisu.apk && pm install -r -d /data/local/tmp/sukisu.apk && rm -f /data/local/tmp/sukisu.apk"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 155
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    const-string v2, "su"

    const-string v3, "-c"

    filled-new-array {v2, v3, p1}, [Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object p1

    .line 156
    invoke-virtual {p1}, Ljava/lang/Process;->waitFor()I

    move-result p1
    :try_end_32
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_32} :catch_36

    if-nez p1, :cond_35

    const/4 v0, 0x1

    :cond_35
    return v0

    .line 157
    :catch_36
    move-exception p1

    .line 158
    return v0
.end method

.method private updateUIState()V
    .registers 9

    .line 85
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v0

    .line 87
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const/4 v2, -0x1

    const-string v3, "#1BA784"

    const-string v4, "bg_mod_btn_pill_primary"

    const-string v5, "drawable"

    if-eqz v1, :cond_72

    .line 88
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const/4 v6, 0x1

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setEnabled(Z)V

    .line 89
    if-eqz v0, :cond_49

    .line 90
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const-string v6, "M\u1edf"

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 91
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v6, "bg_mod_btn_pill_outline"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v6, v5, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 92
    if-eqz v1, :cond_35

    iget-object v6, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-virtual {v6, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    .line 93
    :cond_35
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setTextColor(I)V

    .line 94
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    new-instance v6, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda2;

    invoke-direct {v6, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda2;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 95
    goto :goto_72

    .line 96
    :cond_49
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const-string v6, "C\u00e0i \u0111\u1eb7t"

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 97
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v4, v5, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 98
    if-eqz v1, :cond_63

    iget-object v6, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-virtual {v6, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    .line 99
    :cond_63
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setTextColor(I)V

    .line 100
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    new-instance v6, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda3;

    invoke-direct {v6, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda3;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 104
    :cond_72
    :goto_72
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    if-eqz v1, :cond_9b

    .line 105
    if-eqz v0, :cond_89

    .line 106
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v6, "\u2713 S\u1eb5n s\u00e0ng"

    invoke-virtual {v1, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 107
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_9b

    .line 109
    :cond_89
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v3, "C\u1ea7n SukiSU Ultra tr\u01b0\u1edbc"

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 110
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v3, "#FF5252"

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 114
    :cond_9b
    :goto_9b
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz v1, :cond_d1

    .line 115
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 116
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v3, "Flash"

    invoke-virtual {v1, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 117
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    if-eqz v0, :cond_b2

    goto :goto_b4

    :cond_b2
    const-string v4, "bg_mod_btn_pill_disabled"

    :goto_b4
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v4, v5, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 118
    if-eqz v1, :cond_c3

    iget-object v3, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v3, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    .line 119
    :cond_c3
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz v0, :cond_c8

    goto :goto_ce

    :cond_c8
    const-string v0, "#888888"

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    :goto_ce
    invoke-virtual {v1, v2}, Landroid/widget/Button;->setTextColor(I)V

    .line 121
    :cond_d1
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .registers 7

    .line 34
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 36
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const-string v0, "layout"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "activity_bugos_mod"

    invoke-virtual {p1, v2, v0, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    .line 37
    if-eqz p1, :cond_18

    .line 38
    invoke-virtual {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->setContentView(I)V

    .line 41
    :cond_18
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getActionBar()Landroid/app/ActionBar;

    move-result-object p1

    .line 42
    if-eqz p1, :cond_27

    .line 43
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/app/ActionBar;->setDisplayHomeAsUpEnabled(Z)V

    .line 44
    const-string v0, "Mod"

    invoke-virtual {p1, v0}, Landroid/app/ActionBar;->setTitle(Ljava/lang/CharSequence;)V

    .line 47
    :cond_27
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const-string v0, "btn_action_sukisu"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "id"

    invoke-virtual {p1, v0, v2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    .line 48
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "tv_step2_status"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 49
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v3, "btn_flash"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v2, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 51
    if-eqz p1, :cond_5d

    invoke-virtual {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    .line 52
    :cond_5d
    if-eqz v0, :cond_67

    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    .line 53
    :cond_67
    if-eqz v1, :cond_71

    invoke-virtual {p0, v1}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    .line 55
    :cond_71
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz p1, :cond_7f

    .line 56
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda4;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda4;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 58
    :cond_7f
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .registers 4

    .line 62
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-ne v0, v1, :cond_e

    .line 63
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->finish()V

    .line 64
    const/4 p1, 0x1

    return p1

    .line 66
    :cond_e
    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1
.end method

.method protected onResume()V
    .registers 1

    .line 71
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 72
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    .line 73
    return-void
.end method
