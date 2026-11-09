.class public Lcom/android/settings/mod/BugOSModActivity;
.super Landroid/app/Activity;
.source "BugOSModActivity.java"


# static fields
.field private static final REQ_PICK_BANNER:I = 0x3e9


# instance fields
.field private btnActionSukiSU:Landroid/widget/Button;

.field private btnEditBanner:Landroid/view/View;

.field private btnFlash:Landroid/widget/Button;

.field private final executor:Ljava/util/concurrent/ExecutorService;

.field private ivBanner:Landroid/widget/ImageView;

.field private final mainHandler:Landroid/os/Handler;

.field private tvDeviceName:Landroid/widget/TextView;

.field private tvStep2Status:Landroid/widget/TextView;


# direct methods
.method public static synthetic $r8$lambda$AWEMXkwElnxBlL0lewP-bpXi-BM(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$0(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$CA5hfe9D1FwRv6-639DXFoa___g(Lcom/android/settings/mod/BugOSModActivity;Ljava/lang/Exception;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$saveBannerFromUri$5(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$DhNb84EKncmWE4tF1dq86N9N0WU(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)Z
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$1(Landroid/view/View;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$JRldZq1_w4NhmOSeKmA0UrfZetI(Lcom/android/settings/mod/BugOSModActivity;ZLjava/io/File;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleInstallSukiSU$9(ZLjava/io/File;)V

    return-void
.end method

.method public static synthetic $r8$lambda$JTrXRBc8q6V49U0nfrqgaNxbexk(Lcom/android/settings/mod/BugOSModActivity;Landroid/net/Uri;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$saveBannerFromUri$6(Landroid/net/Uri;)V

    return-void
.end method

.method public static synthetic $r8$lambda$PrNxV1v1M9Dj4jIj1r0OzJxw2gs(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$updateUIState$8(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Uspbjo5pLwvHgiuY95t7daeHO2c(Lcom/android/settings/mod/BugOSModActivity;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleInstallSukiSU$10()V

    return-void
.end method

.method public static synthetic $r8$lambda$_1LiW5iQTFjKq34io4yRQ_knWZM(Lcom/android/settings/mod/BugOSModActivity;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleFlashModule$12()V

    return-void
.end method

.method public static synthetic $r8$lambda$_O6jR4tOAUSVUys-TodoY42UWTw(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$updateUIState$7(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$afwmFU41iZbzMwd1GBVUfWwevr0(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)Z
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$2(Landroid/view/View;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$lu4usyVolAbRz7JJ2SNAdrNyv1M(Lcom/android/settings/mod/BugOSModActivity;Ljava/io/File;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$handleFlashModule$11(Ljava/io/File;)V

    return-void
.end method

.method public static synthetic $r8$lambda$mK9kEawxClQzn9-SH-s-9pFMhNw(Lcom/android/settings/mod/BugOSModActivity;Landroid/view/View;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->lambda$onCreate$3(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$qikz_Qg4I0yJevI1Rf6Dz_vk45A(Lcom/android/settings/mod/BugOSModActivity;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->lambda$saveBannerFromUri$4()V

    return-void
.end method

.method public constructor <init>()V
    .registers 3

    .line 31
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 41
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    .line 42
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

    .line 375
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_11

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_11

    return-void

    .line 376
    :cond_11
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    .line 377
    :try_start_19
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1e
    .catchall {:try_start_19 .. :try_end_1e} :catchall_40

    .line 378
    const/16 p2, 0x2000

    :try_start_20
    new-array p2, p2, [B

    .line 380
    :goto_22
    invoke-virtual {p1, p2}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-lez v1, :cond_2d

    .line 381
    const/4 v2, 0x0

    invoke-virtual {v0, p2, v2, v1}, Ljava/io/OutputStream;->write([BII)V
    :try_end_2c
    .catchall {:try_start_20 .. :try_end_2c} :catchall_36

    goto :goto_22

    .line 383
    :cond_2d
    :try_start_2d
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_30
    .catchall {:try_start_2d .. :try_end_30} :catchall_40

    if-eqz p1, :cond_35

    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 384
    :cond_35
    return-void

    .line 376
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

.method private getDeviceNameString()Ljava/lang/String;
    .registers 3

    .line 104
    const-string v0, "ro.product.marketname"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 105
    if-eqz v0, :cond_17

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_17

    .line 106
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 109
    :cond_17
    :try_start_17
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "device_name"

    invoke-static {v0, v1}, Landroid/provider/Settings$Global;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 110
    if-eqz v0, :cond_33

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_33

    .line 111
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0
    :try_end_31
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_31} :catch_32

    return-object v0

    .line 113
    :catch_32
    move-exception v0

    :cond_33
    nop

    .line 115
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    if-eqz v0, :cond_4b

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4b

    .line 116
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 118
    :cond_4b
    const-string v0, "Xiaomi HyperOS Device"

    return-object v0
.end method

.method private getSystemProperty(Ljava/lang/String;)Ljava/lang/String;
    .registers 6

    .line 123
    const/4 v0, 0x0

    :try_start_1
    const-string v1, "android.os.SystemProperties"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 124
    const-string v2, "get"

    const-class v3, Ljava/lang/String;

    filled-new-array {v3}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 125
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v1, v0, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_1d
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1d} :catch_1e

    return-object p1

    .line 126
    :catch_1e
    move-exception p1

    .line 127
    return-object v0
.end method

.method private handleFlashModule()V
    .registers 3

    .line 328
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_13

    .line 329
    const-string v0, "Vui l\u00f2ng c\u00e0i \u0111\u1eb7t SukiSU Ultra tr\u01b0\u1edbc!"

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 330
    return-void

    .line 333
    :cond_13
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz v0, :cond_23

    .line 334
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 335
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v1, "\u0110ang chu\u1ea9n b\u1ecb..."

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 338
    :cond_23
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda2;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 357
    return-void
.end method

.method private handleInstallSukiSU()V
    .registers 3

    .line 262
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    if-eqz v0, :cond_11

    .line 263
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 264
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const-string v1, "\u0110ang c\u00e0i..."

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 267
    :cond_11
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda11;

    invoke-direct {v1, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda11;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 288
    return-void
.end method

.method private handleOpenSukiSU()V
    .registers 5

    .line 313
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_13

    .line 314
    const-string v0, "Vui l\u00f2ng b\u1ea5m \'C\u00e0i \u0111\u1eb7t\' SukiSU Ultra tr\u01b0\u1edbc!"

    invoke-static {p0, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 315
    return-void

    .line 318
    :cond_13
    :try_start_13
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 319
    if-eqz v0, :cond_20

    .line 320
    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_20} :catch_21

    .line 324
    :cond_20
    goto :goto_40

    .line 322
    :catch_21
    move-exception v0

    .line 323
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

    .line 325
    :goto_40
    return-void
.end method

.method private isPackageInstalled(Ljava/lang/String;)Z
    .registers 4

    .line 215
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_8
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_8} :catch_a

    .line 216
    const/4 p1, 0x1

    return p1

    .line 217
    :catch_a
    move-exception p1

    .line 218
    return v0
.end method

.method private synthetic lambda$handleFlashModule$11(Ljava/io/File;)V
    .registers 3

    .line 350
    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->openSukiSUFlashScreen(Ljava/io/File;)V

    .line 351
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz p1, :cond_14

    .line 352
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 353
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v0, "Flash"

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 355
    :cond_14
    return-void
.end method

.method private synthetic lambda$handleFlashModule$12()V
    .registers 4

    .line 339
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "modules"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 340
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_14

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 341
    :cond_14
    new-instance v1, Ljava/io/File;

    const-string v2, "ZygiskNext+AlwaysStrongInject.zip"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 344
    :try_start_1b
    invoke-direct {p0, v2, v1}, Lcom/android/settings/mod/BugOSModActivity;->copyAssetToFile(Ljava/lang/String;Ljava/io/File;)V
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1e} :catch_1f

    .line 347
    goto :goto_23

    .line 345
    :catch_1f
    move-exception v0

    .line 346
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 349
    :goto_23
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v2, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda10;

    invoke-direct {v2, p0, v1}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda10;-><init>(Lcom/android/settings/mod/BugOSModActivity;Ljava/io/File;)V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 356
    return-void
.end method

.method private synthetic lambda$handleInstallSukiSU$10()V
    .registers 5

    .line 268
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "sukisu_ultra.apk"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 269
    nop

    .line 271
    :try_start_c
    invoke-direct {p0, v2, v0}, Lcom/android/settings/mod/BugOSModActivity;->copyAssetToFile(Ljava/lang/String;Ljava/io/File;)V

    .line 272
    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->trySilentInstall(Ljava/io/File;)Z

    move-result v1
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_13} :catch_14

    .line 275
    goto :goto_19

    .line 273
    :catch_14
    move-exception v1

    .line 274
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 v1, 0x0

    .line 277
    :goto_19
    nop

    .line 278
    iget-object v2, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v3, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda12;

    invoke-direct {v3, p0, v1, v0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda12;-><init>(Lcom/android/settings/mod/BugOSModActivity;ZLjava/io/File;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 287
    return-void
.end method

.method private synthetic lambda$handleInstallSukiSU$9(ZLjava/io/File;)V
    .registers 3

    .line 279
    if-eqz p1, :cond_10

    .line 280
    const-string p1, "C\u00e0i \u0111\u1eb7t SukiSU Ultra th\u00e0nh c\u00f4ng!"

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 281
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    goto :goto_16

    .line 283
    :cond_10
    invoke-direct {p0, p2}, Lcom/android/settings/mod/BugOSModActivity;->launchSystemInstaller(Ljava/io/File;)V

    .line 284
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    .line 286
    :goto_16
    return-void
.end method

.method private synthetic lambda$onCreate$0(Landroid/view/View;)V
    .registers 2

    .line 81
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->openImagePicker()V

    return-void
.end method

.method private synthetic lambda$onCreate$1(Landroid/view/View;)Z
    .registers 2

    .line 83
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->resetDefaultBanner()V

    .line 84
    const/4 p1, 0x1

    return p1
.end method

.method private synthetic lambda$onCreate$2(Landroid/view/View;)Z
    .registers 2

    .line 92
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->openImagePicker()V

    .line 93
    const/4 p1, 0x1

    return p1
.end method

.method private synthetic lambda$onCreate$3(Landroid/view/View;)V
    .registers 2

    .line 99
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleFlashModule()V

    return-void
.end method

.method private synthetic lambda$saveBannerFromUri$4()V
    .registers 3

    .line 164
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->loadCustomBanner()V

    .line 165
    const-string v0, "\u0110\u00e3 c\u1eadp nh\u1eadt \u1ea3nh b\u00eca!"

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 166
    return-void
.end method

.method private synthetic lambda$saveBannerFromUri$5(Ljava/lang/Exception;)V
    .registers 4

    .line 168
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "L\u1ed7i l\u01b0u \u1ea3nh: "

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

    return-void
.end method

.method private synthetic lambda$saveBannerFromUri$6(Landroid/net/Uri;)V
    .registers 6

    .line 154
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "mod_banner_custom.png"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 155
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object p1
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_13} :catch_50

    .line 156
    :try_start_13
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_18
    .catchall {:try_start_13 .. :try_end_18} :catchall_44

    .line 157
    const/16 v0, 0x2000

    :try_start_1a
    new-array v0, v0, [B

    .line 159
    :goto_1c
    invoke-virtual {p1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_27

    .line 160
    const/4 v3, 0x0

    invoke-virtual {v1, v0, v3, v2}, Ljava/io/OutputStream;->write([BII)V
    :try_end_26
    .catchall {:try_start_1a .. :try_end_26} :catchall_3a

    goto :goto_1c

    .line 162
    :cond_27
    :try_start_27
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_2a
    .catchall {:try_start_27 .. :try_end_2a} :catchall_44

    if-eqz p1, :cond_2f

    :try_start_2c
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 163
    :cond_2f
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_39
    .catch Ljava/lang/Exception; {:try_start_2c .. :try_end_39} :catch_50

    .line 169
    goto :goto_5b

    .line 155
    :catchall_3a
    move-exception v0

    :try_start_3b
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_3e
    .catchall {:try_start_3b .. :try_end_3e} :catchall_3f

    goto :goto_43

    :catchall_3f
    move-exception v1

    :try_start_40
    invoke-virtual {v0, v1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_43
    throw v0
    :try_end_44
    .catchall {:try_start_40 .. :try_end_44} :catchall_44

    :catchall_44
    move-exception v0

    if-eqz p1, :cond_4f

    :try_start_47
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_4a
    .catchall {:try_start_47 .. :try_end_4a} :catchall_4b

    goto :goto_4f

    :catchall_4b
    move-exception p1

    :try_start_4c
    invoke-virtual {v0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_4f
    :goto_4f
    throw v0
    :try_end_50
    .catch Ljava/lang/Exception; {:try_start_4c .. :try_end_50} :catch_50

    .line 167
    :catch_50
    move-exception p1

    .line 168
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->mainHandler:Landroid/os/Handler;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda1;-><init>(Lcom/android/settings/mod/BugOSModActivity;Ljava/lang/Exception;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 170
    :goto_5b
    return-void
.end method

.method private synthetic lambda$updateUIState$7(Landroid/view/View;)V
    .registers 2

    .line 232
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleOpenSukiSU()V

    return-void
.end method

.method private synthetic lambda$updateUIState$8(Landroid/view/View;)V
    .registers 2

    .line 238
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->handleInstallSukiSU()V

    return-void
.end method

.method private launchSystemInstaller(Ljava/io/File;)V
    .registers 4

    .line 302
    :try_start_0
    invoke-static {p0, p1}, Lcom/android/settings/mod/ToolboxFileProvider;->getUriForFile(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    .line 303
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 304
    const-string v1, "application/vnd.android.package-archive"

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 305
    const p1, 0x10000001

    invoke-virtual {v0, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 306
    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_19} :catch_1a

    .line 309
    goto :goto_3a

    .line 307
    :catch_1a
    move-exception p1

    .line 308
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

    .line 310
    :goto_3a
    return-void
.end method

.method private loadCustomBanner()V
    .registers 6

    .line 174
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->ivBanner:Landroid/widget/ImageView;

    if-nez v0, :cond_5

    return-void

    .line 175
    :cond_5
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "mod_banner_custom.png"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 176
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_32

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-lez v1, :cond_32

    .line 178
    :try_start_20
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 179
    if-eqz v0, :cond_31

    .line 180
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->ivBanner:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V
    :try_end_2f
    .catch Ljava/lang/Exception; {:try_start_20 .. :try_end_2f} :catch_30

    .line 181
    return-void

    .line 183
    :catch_30
    move-exception v0

    :cond_31
    nop

    .line 185
    :cond_32
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "drawable"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "bg_mod_banner_default"

    invoke-virtual {v0, v3, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 186
    if-eqz v0, :cond_49

    .line 187
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->ivBanner:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 189
    :cond_49
    return-void
.end method

.method private openImagePicker()V
    .registers 4

    .line 133
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 134
    const-string v1, "image/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 135
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 136
    const-string v1, "Ch\u1ecdn \u1ea3nh b\u00eca"

    invoke-static {v0, v1}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v0

    const/16 v1, 0x3e9

    invoke-virtual {p0, v0, v1}, Lcom/android/settings/mod/BugOSModActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_1c
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_1c} :catch_1d

    .line 139
    goto :goto_3d

    .line 137
    :catch_1d
    move-exception v0

    .line 138
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Kh\u00f4ng th\u1ec3 m\u1edf b\u1ed9 ch\u1ecdn \u1ea3nh: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 140
    :goto_3d
    return-void
.end method

.method private openSukiSUFlashScreen(Ljava/io/File;)V
    .registers 5

    .line 361
    const-string v0, "com.sukisu.ultra"

    :try_start_2
    invoke-static {p0, p1}, Lcom/android/settings/mod/ToolboxFileProvider;->getUriForFile(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    .line 362
    const/4 v1, 0x1

    invoke-virtual {p0, v0, p1, v1}, Lcom/android/settings/mod/BugOSModActivity;->grantUriPermission(Ljava/lang/String;Landroid/net/Uri;I)V

    .line 364
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 365
    const-string v2, "application/zip"

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 366
    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 367
    const p1, 0x10000001

    invoke-virtual {v1, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 368
    invoke-virtual {p0, v1}, Lcom/android/settings/mod/BugOSModActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_22
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_22} :catch_23

    .line 371
    goto :goto_43

    .line 369
    :catch_23
    move-exception p1

    .line 370
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

    .line 372
    :goto_43
    return-void
.end method

.method private resetDefaultBanner()V
    .registers 4

    .line 192
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "mod_banner_custom.png"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 193
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_14

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 194
    :cond_14
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->loadCustomBanner()V

    .line 195
    const-string v0, "\u0110\u00e3 \u0111\u1eb7t l\u1ea1i \u1ea3nh b\u00eca m\u1eb7c \u0111\u1ecbnh!"

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 196
    return-void
.end method

.method private saveBannerFromUri(Landroid/net/Uri;)V
    .registers 4

    .line 152
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0, p1}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda3;-><init>(Lcom/android/settings/mod/BugOSModActivity;Landroid/net/Uri;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 171
    return-void
.end method

.method private trySilentInstall(Ljava/io/File;)Z
    .registers 6

    .line 292
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

    .line 293
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    const-string v2, "su"

    const-string v3, "-c"

    filled-new-array {v2, v3, p1}, [Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object p1

    .line 294
    invoke-virtual {p1}, Ljava/lang/Process;->waitFor()I

    move-result p1
    :try_end_32
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_32} :catch_36

    if-nez p1, :cond_35

    const/4 v0, 0x1

    :cond_35
    return v0

    .line 295
    :catch_36
    move-exception p1

    .line 296
    return v0
.end method

.method private updateUIState()V
    .registers 9

    .line 223
    const-string v0, "com.sukisu.ultra"

    invoke-direct {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->isPackageInstalled(Ljava/lang/String;)Z

    move-result v0

    .line 225
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const/4 v2, -0x1

    const-string v3, "#1BA784"

    const-string v4, "bg_mod_btn_pill_primary"

    const-string v5, "drawable"

    if-eqz v1, :cond_72

    .line 226
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const/4 v6, 0x1

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setEnabled(Z)V

    .line 227
    if-eqz v0, :cond_49

    .line 228
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const-string v6, "M\u1edf"

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 229
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v6, "bg_mod_btn_pill_outline"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v6, v5, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 230
    if-eqz v1, :cond_35

    iget-object v6, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-virtual {v6, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    .line 231
    :cond_35
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setTextColor(I)V

    .line 232
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    new-instance v6, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda4;

    invoke-direct {v6, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda4;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 233
    goto :goto_72

    .line 234
    :cond_49
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    const-string v6, "C\u00e0i \u0111\u1eb7t"

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 235
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v4, v5, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 236
    if-eqz v1, :cond_63

    iget-object v6, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-virtual {v6, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    .line 237
    :cond_63
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setTextColor(I)V

    .line 238
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    new-instance v6, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;

    invoke-direct {v6, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {v1, v6}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 242
    :cond_72
    :goto_72
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    if-eqz v1, :cond_9b

    .line 243
    if-eqz v0, :cond_89

    .line 244
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v6, "\u2713 S\u1eb5n s\u00e0ng"

    invoke-virtual {v1, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 245
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_9b

    .line 247
    :cond_89
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v3, "C\u1ea7n SukiSU Ultra tr\u01b0\u1edbc"

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 248
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    const-string v3, "#FF5252"

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 252
    :cond_9b
    :goto_9b
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz v1, :cond_d1

    .line 253
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 254
    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    const-string v3, "Flash"

    invoke-virtual {v1, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 255
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

    .line 256
    if-eqz v1, :cond_c3

    iget-object v3, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    invoke-virtual {v3, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    .line 257
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

    .line 259
    :cond_d1
    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .registers 5

    .line 144
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 145
    const/16 v0, 0x3e9

    if-ne p1, v0, :cond_19

    const/4 p1, -0x1

    if-ne p2, p1, :cond_19

    if-eqz p3, :cond_19

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    if-eqz p1, :cond_19

    .line 146
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    .line 147
    invoke-direct {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->saveBannerFromUri(Landroid/net/Uri;)V

    .line 149
    :cond_19
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 11

    .line 46
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 48
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const-string v0, "layout"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "activity_bugos_mod"

    invoke-virtual {p1, v2, v0, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    .line 49
    if-eqz p1, :cond_18

    .line 50
    invoke-virtual {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->setContentView(I)V

    .line 53
    :cond_18
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getActionBar()Landroid/app/ActionBar;

    move-result-object p1

    .line 54
    if-eqz p1, :cond_27

    .line 55
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/app/ActionBar;->setDisplayHomeAsUpEnabled(Z)V

    .line 56
    const-string v0, "Toolbox"

    invoke-virtual {p1, v0}, Landroid/app/ActionBar;->setTitle(Ljava/lang/CharSequence;)V

    .line 59
    :cond_27
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const-string v0, "iv_mod_banner"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "id"

    invoke-virtual {p1, v0, v2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    .line 60
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "tv_device_name"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 61
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v3, "btn_edit_banner"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v2, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 62
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const-string v4, "card_banner"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 63
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const-string v5, "btn_action_sukisu"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 64
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const-string v6, "tv_step2_status"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v6, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 65
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    const-string v7, "btn_flash"

    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v7, v2, v8}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 67
    if-eqz p1, :cond_95

    invoke-virtual {p0, p1}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->ivBanner:Landroid/widget/ImageView;

    .line 68
    :cond_95
    if-eqz v0, :cond_9f

    invoke-virtual {p0, v0}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvDeviceName:Landroid/widget/TextView;

    .line 69
    :cond_9f
    if-eqz v1, :cond_a7

    invoke-virtual {p0, v1}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnEditBanner:Landroid/view/View;

    .line 70
    :cond_a7
    if-eqz v4, :cond_b1

    invoke-virtual {p0, v4}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnActionSukiSU:Landroid/widget/Button;

    .line 71
    :cond_b1
    if-eqz v5, :cond_bb

    invoke-virtual {p0, v5}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvStep2Status:Landroid/widget/TextView;

    .line 72
    :cond_bb
    if-eqz v2, :cond_c5

    invoke-virtual {p0, v2}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    .line 74
    :cond_c5
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvDeviceName:Landroid/widget/TextView;

    if-eqz p1, :cond_d2

    .line 75
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->tvDeviceName:Landroid/widget/TextView;

    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->getDeviceNameString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 78
    :cond_d2
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->loadCustomBanner()V

    .line 80
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnEditBanner:Landroid/view/View;

    if-eqz p1, :cond_ed

    .line 81
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnEditBanner:Landroid/view/View;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda6;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda6;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 82
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnEditBanner:Landroid/view/View;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda7;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda7;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 88
    :cond_ed
    if-eqz v3, :cond_fd

    .line 89
    invoke-virtual {p0, v3}, Lcom/android/settings/mod/BugOSModActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    .line 90
    if-eqz p1, :cond_fd

    .line 91
    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda8;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda8;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 98
    :cond_fd
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    if-eqz p1, :cond_10b

    .line 99
    iget-object p1, p0, Lcom/android/settings/mod/BugOSModActivity;->btnFlash:Landroid/widget/Button;

    new-instance v0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda9;

    invoke-direct {v0, p0}, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda9;-><init>(Lcom/android/settings/mod/BugOSModActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 101
    :cond_10b
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .registers 4

    .line 200
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-ne v0, v1, :cond_e

    .line 201
    invoke-virtual {p0}, Lcom/android/settings/mod/BugOSModActivity;->finish()V

    .line 202
    const/4 p1, 0x1

    return p1

    .line 204
    :cond_e
    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1
.end method

.method protected onResume()V
    .registers 1

    .line 209
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 210
    invoke-direct {p0}, Lcom/android/settings/mod/BugOSModActivity;->updateUIState()V

    .line 211
    return-void
.end method
