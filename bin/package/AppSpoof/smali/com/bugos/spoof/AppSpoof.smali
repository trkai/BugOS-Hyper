.class public final Lcom/bugos/spoof/AppSpoof;
.super Ljava/lang/Object;
.source "AppSpoof.java"


# static fields
.field private static final FALLBACK:Ljava/lang/String; = "/system/etc/bugos/app-spoof.json"

.field private static final FIELDS:[Ljava/lang/String;

.field private static final GLOBAL_KEY:Ljava/lang/String; = "bugos_app_spoof"

.field private static volatile sPkg:Ljava/lang/String;

.field private static volatile sProps:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .registers 11

    .line 38
    const-string v9, "MODEL_FOR_ATTESTATION"

    const-string v10, "PRODUCT_FOR_ATTESTATION"

    const-string v0, "BRAND"

    const-string v1, "DEVICE"

    const-string v2, "MANUFACTURER"

    const-string v3, "MODEL"

    const-string v4, "PRODUCT"

    const-string v5, "FINGERPRINT"

    const-string v6, "BRAND_FOR_ATTESTATION"

    const-string v7, "DEVICE_FOR_ATTESTATION"

    const-string v8, "MANUFACTURER_FOR_ATTESTATION"

    filled-new-array/range {v0 .. v10}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/bugos/spoof/AppSpoof;->FIELDS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    return-void
.end method

.method public static apply(Landroid/content/Context;)V
    .registers 7

    .line 51
    if-nez p0, :cond_3

    .line 52
    return-void

    .line 54
    :cond_3
    :try_start_3
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 55
    if-eqz v0, :cond_59

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_59

    sget-object v1, Lcom/bugos/spoof/AppSpoof;->sPkg:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_18

    goto :goto_59

    .line 59
    :cond_18
    invoke-static {p0, v0}, Lcom/bugos/spoof/AppSpoof;->loadProfile(Landroid/content/Context;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p0

    .line 60
    if-eqz p0, :cond_58

    const-string v1, "enabled"

    const/4 v2, 0x1

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_28

    goto :goto_58

    .line 64
    :cond_28
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 65
    const/4 v2, 0x0

    :goto_2e
    sget-object v3, Lcom/bugos/spoof/AppSpoof;->FIELDS:[Ljava/lang/String;

    array-length v3, v3

    if-ge v2, v3, :cond_53

    .line 66
    sget-object v3, Lcom/bugos/spoof/AppSpoof;->FIELDS:[Ljava/lang/String;

    aget-object v3, v3, v2

    .line 67
    const-string v4, ""

    invoke-virtual {p0, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 68
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-nez v5, :cond_44

    .line 69
    goto :goto_50

    .line 71
    :cond_44
    invoke-static {v3, v4}, Lcom/bugos/spoof/AppSpoof;->setField(Ljava/lang/String;Ljava/lang/String;)V

    .line 72
    invoke-static {v3}, Lcom/bugos/spoof/AppSpoof;->propKey(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 73
    if-eqz v3, :cond_50

    .line 74
    invoke-virtual {v1, v3, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 65
    :cond_50
    :goto_50
    add-int/lit8 v2, v2, 0x1

    goto :goto_2e

    .line 78
    :cond_53
    sput-object v1, Lcom/bugos/spoof/AppSpoof;->sProps:Ljava/util/Map;

    .line 79
    sput-object v0, Lcom/bugos/spoof/AppSpoof;->sPkg:Ljava/lang/String;
    :try_end_57
    .catchall {:try_start_3 .. :try_end_57} :catchall_5a

    .line 82
    goto :goto_5b

    .line 61
    :cond_58
    :goto_58
    return-void

    .line 56
    :cond_59
    :goto_59
    return-void

    .line 80
    :catchall_5a
    move-exception p0

    .line 83
    :goto_5b
    return-void
.end method

.method private static loadProfile(Landroid/content/Context;Ljava/lang/String;)Lorg/json/JSONObject;
    .registers 5

    .line 98
    nop

    .line 101
    const/4 v0, 0x0

    :try_start_2
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "bugos_app_spoof"

    invoke-static {p0, v1}, Landroid/provider/Settings$Global;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 102
    if-eqz p0, :cond_21

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_21

    .line 103
    new-instance v1, Ljava/lang/String;

    const/4 v2, 0x0

    invoke-static {p0, v2}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object p0

    const-string v2, "UTF-8"

    invoke-direct {v1, p0, v2}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_20
    .catchall {:try_start_2 .. :try_end_20} :catchall_23

    goto :goto_22

    .line 106
    :cond_21
    move-object v1, v0

    :goto_22
    goto :goto_25

    .line 105
    :catchall_23
    move-exception p0

    move-object v1, v0

    .line 108
    :goto_25
    if-eqz v1, :cond_2d

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result p0

    if-nez p0, :cond_33

    .line 109
    :cond_2d
    const-string p0, "/system/etc/bugos/app-spoof.json"

    invoke-static {p0}, Lcom/bugos/spoof/AppSpoof;->readFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 111
    :cond_33
    if-eqz v1, :cond_48

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result p0

    if-nez p0, :cond_3c

    goto :goto_48

    .line 116
    :cond_3c
    :try_start_3c
    new-instance p0, Lorg/json/JSONObject;

    invoke-direct {p0, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 117
    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p0
    :try_end_45
    .catchall {:try_start_3c .. :try_end_45} :catchall_46

    return-object p0

    .line 118
    :catchall_46
    move-exception p0

    .line 119
    return-object v0

    .line 112
    :cond_48
    :goto_48
    return-object v0
.end method

.method public static prop(Ljava/lang/String;)Ljava/lang/String;
    .registers 2

    .line 90
    sget-object v0, Lcom/bugos/spoof/AppSpoof;->sProps:Ljava/util/Map;

    .line 91
    if-eqz v0, :cond_e

    if-nez p0, :cond_7

    goto :goto_e

    .line 94
    :cond_7
    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    return-object p0

    .line 92
    :cond_e
    :goto_e
    const/4 p0, 0x0

    return-object p0
.end method

.method private static propKey(Ljava/lang/String;)Ljava/lang/String;
    .registers 2

    .line 161
    const-string v0, "BRAND"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 162
    const-string p0, "ro.product.brand"

    return-object p0

    .line 164
    :cond_b
    const-string v0, "DEVICE"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_16

    .line 165
    const-string p0, "ro.product.device"

    return-object p0

    .line 167
    :cond_16
    const-string v0, "MANUFACTURER"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_21

    .line 168
    const-string p0, "ro.product.manufacturer"

    return-object p0

    .line 170
    :cond_21
    const-string v0, "MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2c

    .line 171
    const-string p0, "ro.product.model"

    return-object p0

    .line 173
    :cond_2c
    const-string v0, "PRODUCT"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_37

    .line 174
    const-string p0, "ro.product.name"

    return-object p0

    .line 176
    :cond_37
    const-string v0, "FINGERPRINT"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_42

    .line 177
    const-string p0, "ro.build.fingerprint"

    return-object p0

    .line 179
    :cond_42
    const/4 p0, 0x0

    return-object p0
.end method

.method private static readFile(Ljava/lang/String;)Ljava/lang/String;
    .registers 6

    .line 124
    nop

    .line 126
    const/4 v0, 0x0

    :try_start_2
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 127
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_11

    .line 128
    nop

    .line 142
    nop

    .line 146
    nop

    .line 128
    return-object v0

    .line 130
    :cond_11
    new-instance p0, Ljava/io/FileInputStream;

    invoke-direct {p0, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_16
    .catchall {:try_start_2 .. :try_end_16} :catchall_3f

    .line 131
    :try_start_16
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 132
    const/16 v2, 0x1000

    new-array v2, v2, [B

    .line 134
    :goto_1f
    invoke-virtual {p0, v2}, Ljava/io/FileInputStream;->read([B)I

    move-result v3

    const/4 v4, -0x1

    if-eq v3, v4, :cond_2b

    .line 135
    const/4 v4, 0x0

    invoke-virtual {v1, v2, v4, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_1f

    .line 137
    :cond_2b
    new-instance v2, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    const-string v3, "UTF-8"

    invoke-direct {v2, v1, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_36
    .catchall {:try_start_16 .. :try_end_36} :catchall_3d

    .line 142
    nop

    .line 143
    :try_start_37
    invoke-virtual {p0}, Ljava/io/FileInputStream;->close()V
    :try_end_3a
    .catchall {:try_start_37 .. :try_end_3a} :catchall_3b

    .line 146
    goto :goto_3c

    .line 145
    :catchall_3b
    move-exception p0

    .line 137
    :goto_3c
    return-object v2

    .line 138
    :catchall_3d
    move-exception v1

    goto :goto_41

    :catchall_3f
    move-exception p0

    move-object p0, v0

    .line 139
    :goto_41
    nop

    .line 142
    if-eqz p0, :cond_4a

    .line 143
    :try_start_44
    invoke-virtual {p0}, Ljava/io/FileInputStream;->close()V
    :try_end_47
    .catchall {:try_start_44 .. :try_end_47} :catchall_48

    goto :goto_4a

    .line 145
    :catchall_48
    move-exception p0

    goto :goto_4b

    .line 146
    :cond_4a
    :goto_4a
    nop

    .line 139
    :goto_4b
    return-object v0
.end method

.method private static setField(Ljava/lang/String;Ljava/lang/String;)V
    .registers 3

    .line 152
    :try_start_0
    const-class v0, Landroid/os/Build;

    invoke-virtual {v0, p0}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    .line 153
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 154
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_e
    .catchall {:try_start_0 .. :try_end_e} :catchall_f

    .line 157
    goto :goto_10

    .line 155
    :catchall_f
    move-exception p0

    .line 158
    :goto_10
    return-void
.end method
