.class public Lcom/android/settings/mod/BugOSModActivity;
.super Landroid/app/Activity;
.source "BugOSModActivity.java"


# instance fields
.field private btnFlash:Landroid/widget/Button;

.field private btnInstall:Landroid/widget/Button;

.field private btnOpenSukiSU:Landroid/widget/Button;

.field private final executor:Ljava/util/concurrent/ExecutorService;

.field private final mainHandler:Landroid/os/Handler;

.field private tvStep2Status:Landroid/widget/TextView;


# direct methods
.method public static synthetic $r8$lambda$AWEMXkwElnxBlL0lewP-bpXi-BM(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$0(Landroid/view/View;)V

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

.method public static synthetic $r8$lambda$kfnl26cM8LQzL813ZI3rYk9uYeE(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$1(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$oaGXdqQjUjJzHcgYu1CuprXKwpo(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$2(Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>()V
    .registers 3

    .line 25
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 31
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    .line 32
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

    .line 236
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_11

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_11

    return-void

    .line 237
    :cond_11
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    .line 238
    :try_start_19
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1e
    .catchall {:try_start_19 .. :try_end_1e} :catchall_40

    .line 239
    const/16 p2, 0x2000

    :try_start_20
    new-array p2, p2, [B

    .line 241
    :goto_22
    invoke-virtual {p1, p2}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-lez v1, :cond_2d

    .line 242
    const/4 v2, 0x0

    invoke-virtual {v0, p2, v2, v1}, Ljava/io/OutputStream;->write([BII)V
    :try_end_2c
    .catchall {:try_start_20 .. :try_end_2c} :catchall_36

    goto :goto_22

    .line 244
    :cond_2d
    :try_start_2d
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_30
    .catchall {:try_start_2d .. :try_end_30} :catchall_40

    if-eqz p1, :cond_35

    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 245
    :cond_35
    return-void

    .line 237
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

    .line 189
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_13

    .line 190
    const-string v0, "Vui l\u00f2ng c\u00e0i \u0111\u1eb7t SukiSU Ultra tr\u01b0\u1edbc!"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 191
    return-void

    .line 194
    :cond_13
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz v0, :cond_23

    .line 195
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 196
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v1, "\u0110ang chu\u1ea9n b\u1ecb..."

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 199
    :cond_23
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda1;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 218
    return-void
.end method

.method private handleInstallSukiSU()V
    .registers 3

    .line 123
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    if-eqz v0, :cond_11

    .line 124
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 125
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    const-string v1, "\u0110ang c\u00e0i \u0111\u1eb7t..."

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 128
    :cond_11
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda6;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 149
    return-void
.end method

.method private handleOpenSukiSU()V
    .registers 5

    .line 174
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_13

    .line 175
    const-string v0, "Vui l\u00f2ng b\u1ea5m \'C\u00e0i \u0111\u1eb7t\' SukiSU Ultra tr\u01b0\u1edbc!"

    invoke-static {p0, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 176
    return-void

    .line 179
    :cond_13
    :try_start_13
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 180
    if-eqz v0, :cond_20

    .line 181
    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_20} :catch_21

    .line 185
    :cond_20
    goto :goto_40

    .line 183
    :catch_21
    move-exception v0

    .line 184
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

    .line 186
    :goto_40
    return-void
.end method

.method private isPackageInstalled(Ljava/lang/String;)Z
    .registers 4

    .line 87
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_8
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_8} :catch_a

    .line 88
    const/4 p1, 0x1

    return p1

    .line 89
    :catch_a
    move-exception p1

    .line 90
    return v0
.end method

.method private synthetic lambda$handleFlashModule$5(Ljava/io/File;)V
    .registers 3

    .line 211
    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->openSukiSUFlashScreen(Ljava/io/File;)V

    .line 212
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz p1, :cond_14

    .line 213
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 214
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v0, "Flash module"

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 216
    :cond_14
    return-void
.end method

.method private synthetic lambda$handleFlashModule$6()V
    .registers 4

    .line 200
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "modules"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 201
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_14

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 202
    :cond_14
    new-instance v1, Ljava/io/File;

    const-string v2, "ZygiskNext+AlwaysStrongInject.zip"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 205
    :try_start_1b
    invoke-direct {p0, v2, v1}, Lcom/android/settings/mod/BugOSModActivity;->copyAssetToFile(Ljava/lang/String;Ljava/io/File;)V
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1e} :catch_1f

    .line 208
    goto :goto_23

    .line 206
    :catch_1f
    move-exception v0

    .line 207
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 210
    :goto_23
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v2, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;

    invoke-direct {v2, p0, v1}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;-><init>(Lcom/android/settings/mod/BugOSModActivity;Ljava/io/File;)V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 217
    return-void
.end method

.method private synthetic lambda$handleInstallSukiSU$3(ZLjava/io/File;)V
    .registers 3

    .line 140
    if-eqz p1, :cond_10

    .line 141
    const-string p1, "C\u00e0i \u0111\u1eb7t SukiSU Ultra th\u00e0nh c\u00f4ng!"

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 142
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    goto :goto_16

    .line 144
    :cond_10
    invoke-direct {p0, p2}, Lcom/android/settings/mod/BugOSModActivity;->launchSystemInstaller(Ljava/io/File;)V

    .line 145
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    .line 147
    :goto_16
    return-void
.end method

.method private synthetic lambda$handleInstallSukiSU$4()V
    .registers 5

    .line 129
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "sukisu_ultra.apk"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 130
    nop

    .line 132
    :try_start_c
    invoke-direct {p0, v2, v0}, Lcom/android/settings/mod/BugOSModActivity;->copyAssetToFile(Ljava/lang/String;Ljava/io/File;)V

    .line 133
    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->trySilentInstall(Ljava/io/File;)Z

    move-result v1
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_13} :catch_14

    .line 136
    goto :goto_19

    .line 134
    :catch_14
    move-exception v1

    .line 135
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 v1, 0x0

    .line 138
    :goto_19
    nop

    .line 139
    iget-object v2, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v3, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0, v1, v0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;-><init>(Lcom/android/settings/mod/BugOSModActivity;ZLjava/io/File;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 148
    return-void
.end method

.method private synthetic lambda$onCreate$0(Landroid/view/View;)V
    .registers 2

    .line 60
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleInstallSukiSU()V

    return-void
.end method

.method private synthetic lambda$onCreate$1(Landroid/view/View;)V
    .registers 2

    .line 63
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleOpenSukiSU()V

    return-void
.end method

.method private synthetic lambda$onCreate$2(Landroid/view/View;)V
    .registers 2

    .line 66
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleFlashModule()V

    return-void
.end method

.method private launchSystemInstaller(Ljava/io/File;)V
    .registers 4

    .line 163
    :try_start_0
    invoke-static {p0, p1}, Lcom/android/settings/mod/ToolboxFileProvider;->getUriForFile(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    .line 164
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 165
    const-string v1, "application/vnd.android.package-archive"

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 166
    const p1, 0x10000001

    invoke-virtual {v0, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 167
    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_19} :catch_1a

    .line 170
    goto :goto_3a

    .line 168
    :catch_1a
    move-exception p1

    .line 169
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

    .line 171
    :goto_3a
    return-void
.end method

.method private openSukiSUFlashScreen(Ljava/io/File;)V
    .registers 5

    .line 222
    const-string v0, "com.sukisu.ultra"

    :try_start_2
    invoke-static {p0, p1}, Lcom/android/settings/mod/ToolboxFileProvider;->getUriForFile(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    .line 223
    const/4 v1, 0x1

    invoke-virtual {p0, v0, p1, v1}, Lcom/android/settings/mod/BugOSModActivity;->grantUriPermission(Ljava/lang/String;Landroid/net/Uri;I)V

    .line 225
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 226
    const-string v2, "application/zip"

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 227
    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 228
    const p1, 0x10000001

    invoke-virtual {v1, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 229
    invoke-virtual {p0, v1}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_22
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_22} :catch_23

    .line 232
    goto :goto_43

    .line 230
    :catch_23
    move-exception p1

    .line 231
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

    .line 233
    :goto_43
    return-void
.end method

.method private trySilentInstall(Ljava/io/File;)Z
    .registers 6

    .line 153
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

    .line 154
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    const-string v2, "su"

    const-string v3, "-c"

    filled-new-array {v2, v3, p1}, [Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object p1

    .line 155
    invoke-virtual {p1}, Ljava/lang/Process;->waitFor()I

    move-result p1
    :try_end_32
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_32} :catch_36

    if-nez p1, :cond_35

    const/4 v0, 0x1

    :cond_35
    return v0

    .line 156
    :catch_36
    move-exception p1

    .line 157
    return v0
.end method

.method private updateUIState()V
    .registers 4

    .line 95
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v0

    .line 97
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    if-eqz v1, :cond_17

    .line 98
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    const-string v2, "C\u00e0i \u0111\u1eb7t"

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 99
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setEnabled(Z)V

    .line 102
    :cond_17
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnOpenSukiSU:Landroid/widget/Button;

    if-eqz v1, :cond_26

    .line 103
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnOpenSukiSU:Landroid/widget/Button;

    if-eqz v0, :cond_21

    const/4 v2, 0x0

    goto :goto_23

    :cond_21
    const/16 v2, 0x8

    :goto_23
    invoke-virtual {v1, v2}, Landroid/widget/Button;->setVisibility(I)V

    .line 106
    :cond_26
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    if-eqz v1, :cond_51

    .line 107
    if-eqz v0, :cond_3f

    .line 108
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v2, "\u2713 SukiSU Ultra \u0111\u00e3 s\u1eb5n s\u00e0ng"

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 109
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v2, "#1BA784"

    invoke-static {v2}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_51

    .line 111
    :cond_3f
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v2, "B\u1eadt ch\u1ee9c n\u0103ng 1 tr\u01b0\u1edbc \u0111\u00e3."

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 112
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v2, "#FF5252"

    invoke-static {v2}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 116
    :cond_51
    :goto_51
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz v1, :cond_61

    .line 117
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 118
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v1, "Flash module"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 120
    :cond_61
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .registers 8

    .line 36
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 38
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const-string v0, "layout"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "activity_bugos_mod"

    invoke-virtual {p1, v2, v0, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    .line 39
    if-eqz p1, :cond_18

    .line 40
    invoke-virtual {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->setContentView(I)V

    .line 43
    :cond_18
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getActionBar()Landroid/app/ActionBar;

    move-result-object p1

    .line 44
    if-eqz p1, :cond_27

    .line 45
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/app/ActionBar;->setDisplayHomeAsUpEnabled(Z)V

    .line 46
    const-string v0, "Mod"

    invoke-virtual {p1, v0}, Landroid/app/ActionBar;->setTitle(Ljava/lang/CharSequence;)V

    .line 49
    :cond_27
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const-string v0, "btn_install"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "id"

    invoke-virtual {p1, v0, v2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    .line 50
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "btn_open_sukisu"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 51
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v3, "tv_step2_status"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v2, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 52
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const-string v4, "btn_flash"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 54
    if-eqz p1, :cond_6b

    invoke-virtual {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    .line 55
    :cond_6b
    if-eqz v0, :cond_75

    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnOpenSukiSU:Landroid/widget/Button;

    .line 56
    :cond_75
    if-eqz v1, :cond_7f

    invoke-virtual {p0, v1}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    .line 57
    :cond_7f
    if-eqz v2, :cond_89

    invoke-virtual {p0, v2}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    .line 59
    :cond_89
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    if-eqz p1, :cond_97

    .line 60
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnInstall:Landroid/widget/Button;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda2;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 62
    :cond_97
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnOpenSukiSU:Landroid/widget/Button;

    if-eqz p1, :cond_a5

    .line 63
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnOpenSukiSU:Landroid/widget/Button;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda3;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 65
    :cond_a5
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz p1, :cond_b3

    .line 66
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda4;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda4;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 68
    :cond_b3
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .registers 4

    .line 72
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-ne v0, v1, :cond_e

    .line 73
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->finish()V

    .line 74
    const/4 p1, 0x1

    return p1

    .line 76
    :cond_e
    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1
.end method

.method protected onResume()V
    .registers 1

    .line 81
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 82
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    .line 83
    return-void
.end method
