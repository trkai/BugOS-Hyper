.class public abstract Lcom/kousei/framework/ka;
.super Ljava/lang/Object;
.source "r8-map-id-ab9d9a36b7cfe29bbfb78ee9a77c1feaf549e881397fc2be336a306d7a6faedf"


# static fields
.field public static final a:Lcom/kousei/framework/y2;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 1
    new-instance v0, Lcom/kousei/framework/y2;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/kousei/framework/y2;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/kousei/framework/ka;->a:Lcom/kousei/framework/y2;

    .line 7
    .line 8
    return-void
    .line 9
    .line 10
    .line 11
    .line 12
    .line 13
    .line 14
    .line 15
    .line 16
    .line 17
    .line 18
    .line 19
    .line 20
    .line 21
    .line 22
    .line 23
    .line 24
    .line 25
    .line 26
    .line 27
    .line 28
    .line 29
    .line 30
    .line 31
    .line 32
    .line 33
    .line 34
    .line 35
    .line 36
    .line 37
    .line 38
    .line 39
    .line 40
    .line 41
    .line 42
    .line 43
    .line 44
    .line 45
    .line 46
    .line 47
    .line 48
    .line 49
    .line 50
    .line 51
    .line 52
    .line 53
    .line 54
    .line 55
    .line 56
    .line 57
    .line 58
    .line 59
    .line 60
    .line 61
    .line 62
    .line 63
    .line 64
    .line 65
    .line 66
    .line 67
    .line 68
    .line 69
    .line 70
    .line 71
    .line 72
    .line 73
    .line 74
    .line 75
    .line 76
    .line 77
    .line 78
    .line 79
    .line 80
    .line 81
    .line 82
    .line 83
    .line 84
    .line 85
    .line 86
    .line 87
    .line 88
    .line 89
    .line 90
    .line 91
    .line 92
    .line 93
    .line 94
    .line 95
    .line 96
    .line 97
    .line 98
    .line 99
    .line 100
    .line 101
    .line 102
    .line 103
    .line 104
    .line 105
    .line 106
    .line 107
    .line 108
    .line 109
    .line 110
    .line 111
    .line 112
    .line 113
    .line 114
    .line 115
    .line 116
    .line 117
    .line 118
    .line 119
    .line 120
    .line 121
    .line 122
    .line 123
    .line 124
    .line 125
    .line 126
    .line 127
    .line 128
    .line 129
    .line 130
    .line 131
    .line 132
    .line 133
    .line 134
    .line 135
    .line 136
    .line 137
    .line 138
    .line 139
    .line 140
    .line 141
    .line 142
    .line 143
    .line 144
    .line 145
    .line 146
    .line 147
    .line 148
    .line 149
    .line 150
    .line 151
    .line 152
    .line 153
    .line 154
    .line 155
    .line 156
    .line 157
    .line 158
    .line 159
    .line 160
    .line 161
    .line 162
    .line 163
    .line 164
    .line 165
    .line 166
    .line 167
    .line 168
    .line 169
    .line 170
    .line 171
    .line 172
.end method

.method public static a(Z)I
    .registers 4

    .line 1
    sget-object v0, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    .line 2
    .line 3
    :try_start_2
    const-string v1, "-"

    .line 4
    .line 5
    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    const/4 v1, 0x0

    .line 10
    aget-object v1, v0, v1

    .line 11
    .line 12
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 13
    .line 14
    .line 15
    move-result v1

    .line 16
    const/4 v2, 0x1

    .line 17
    aget-object v2, v0, v2

    .line 18
    .line 19
    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 20
    .line 21
    .line 22
    move-result v2

    .line 23
    if-eqz p0, :cond_26

    .line 24
    .line 25
    const/4 p0, 0x2

    .line 26
    aget-object p0, v0, p0

    .line 27
    .line 28
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 29
    .line 30
    .line 31
    move-result p0
    :try_end_1f
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_1f} :catch_2a

    .line 32
    mul-int/lit16 v1, v1, 0x2710

    .line 33
    .line 34
    mul-int/lit8 v2, v2, 0x64

    .line 35
    .line 36
    add-int/2addr v2, v1

    .line 37
    add-int/2addr v2, p0

    .line 38
    return v2

    .line 39
    :cond_26
    mul-int/lit8 v1, v1, 0x64

    .line 40
    .line 41
    add-int/2addr v1, v2

    .line 42
    return v1

    .line 43
    :catch_2a
    const p0, 0x316a4

    .line 44
    .line 45
    .line 46
    return p0
    .line 47
    .line 48
    .line 49
    .line 50
    .line 51
    .line 52
    .line 53
    .line 54
    .line 55
    .line 56
    .line 57
    .line 58
    .line 59
    .line 60
    .line 61
    .line 62
    .line 63
    .line 64
    .line 65
    .line 66
    .line 67
    .line 68
    .line 69
    .line 70
    .line 71
    .line 72
    .line 73
    .line 74
    .line 75
    .line 76
    .line 77
    .line 78
    .line 79
    .line 80
    .line 81
    .line 82
    .line 83
    .line 84
    .line 85
    .line 86
    .line 87
    .line 88
    .line 89
    .line 90
    .line 91
    .line 92
    .line 93
    .line 94
    .line 95
    .line 96
    .line 97
    .line 98
    .line 99
    .line 100
    .line 101
    .line 102
    .line 103
    .line 104
    .line 105
    .line 106
    .line 107
    .line 108
    .line 109
    .line 110
    .line 111
    .line 112
    .line 113
    .line 114
    .line 115
    .line 116
    .line 117
    .line 118
    .line 119
    .line 120
    .line 121
    .line 122
    .line 123
    .line 124
    .line 125
    .line 126
    .line 127
    .line 128
    .line 129
    .line 130
    .line 131
    .line 132
    .line 133
    .line 134
    .line 135
    .line 136
    .line 137
    .line 138
    .line 139
    .line 140
    .line 141
    .line 142
    .line 143
    .line 144
    .line 145
    .line 146
    .line 147
    .line 148
    .line 149
    .line 150
    .line 151
    .line 152
    .line 153
    .line 154
    .line 155
    .line 156
    .line 157
    .line 158
    .line 159
    .line 160
    .line 161
    .line 162
    .line 163
    .line 164
    .line 165
    .line 166
    .line 167
    .line 168
    .line 169
    .line 170
    .line 171
    .line 172
    .line 173
    .line 174
    .line 175
    .line 176
    .line 177
    .line 178
    .line 179
    .line 180
    .line 181
    .line 182
    .line 183
    .line 184
    .line 185
    .line 186
    .line 187
    .line 188
    .line 189
    .line 190
    .line 191
    .line 192
    .line 193
    .line 194
    .line 195
    .line 196
    .line 197
    .line 198
    .line 199
    .line 200
    .line 201
    .line 202
    .line 203
    .line 204
    .line 205
    .line 206
    .line 207
    .line 208
    .line 209
    .line 210
    .line 211
    .line 212
    .line 213
    .line 214
    .line 215
    .line 216
    .line 217
    .line 218
    .line 219
    .line 220
    .line 221
    .line 222
    .line 223
    .line 224
    .line 225
    .line 226
    .line 227
    .line 228
    .line 229
    .line 230
    .line 231
    .line 232
    .line 233
    .line 234
    .line 235
    .line 236
    .line 237
    .line 238
    .line 239
    .line 240
    .line 241
    .line 242
.end method

.method public static b(I)Lcom/kousei/framework/o4;
    .registers 15

    .line 1
    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    const/4 v1, 0x0

    .line 6
    if-eqz v0, :cond_d2

    .line 7
    .line 8
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    if-eqz v0, :cond_cc

    .line 13
    .line 14
    invoke-virtual {v0, p0}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    .line 15
    .line 16
    .line 17
    move-result-object v1

    .line 18
    if-eqz v1, :cond_b8

    .line 19
    .line 20
    array-length v2, v1

    .line 21
    if-eqz v2, :cond_b8

    .line 22
    .line 23
    array-length p0, v1

    .line 24
    new-array v2, p0, [Lcom/kousei/framework/k;

    .line 25
    .line 26
    new-instance v3, Ljava/util/HashSet;

    .line 27
    .line 28
    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    .line 29
    .line 30
    .line 31
    const-string v4, "SHA-256"

    .line 32
    .line 33
    invoke-static {v4}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    .line 34
    .line 35
    .line 36
    move-result-object v4

    .line 37
    const/4 v5, 0x0

    .line 38
    move v6, v5

    .line 39
    :goto_26
    const/4 v7, 0x2

    .line 40
    const/4 v8, 0x1

    .line 41
    if-ge v6, p0, :cond_75

    .line 42
    .line 43
    aget-object v9, v1, v6

    .line 44
    .line 45
    const/16 v10, 0x40

    .line 46
    .line 47
    invoke-virtual {v0, v9, v10}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    .line 48
    .line 49
    .line 50
    move-result-object v10

    .line 51
    new-instance v11, Lcom/kousei/framework/o4;

    .line 52
    .line 53
    sget-object v12, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 54
    .line 55
    invoke-virtual {v9, v12}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    .line 56
    .line 57
    .line 58
    move-result-object v9

    .line 59
    invoke-direct {v11, v9}, Lcom/kousei/framework/w;-><init>([B)V

    .line 60
    .line 61
    .line 62
    new-instance v9, Lcom/kousei/framework/q;

    .line 63
    .line 64
    invoke-virtual {v10}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    .line 65
    .line 66
    .line 67
    move-result-wide v12

    .line 68
    invoke-direct {v9, v12, v13}, Lcom/kousei/framework/q;-><init>(J)V

    .line 69
    .line 70
    .line 71
    new-array v7, v7, [Lcom/kousei/framework/k;

    .line 72
    .line 73
    aput-object v11, v7, v5

    .line 74
    .line 75
    aput-object v9, v7, v8

    .line 76
    .line 77
    new-instance v8, Lcom/kousei/framework/r4;

    .line 78
    .line 79
    invoke-direct {v8, v7, v5}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 80
    .line 81
    .line 82
    aput-object v8, v2, v6

    .line 83
    .line 84
    iget-object v7, v10, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 85
    .line 86
    if-eqz v7, :cond_72

    .line 87
    .line 88
    array-length v8, v7

    .line 89
    move v9, v5

    .line 90
    :goto_59
    if-ge v9, v8, :cond_72

    .line 91
    .line 92
    aget-object v10, v7, v9

    .line 93
    .line 94
    if-eqz v10, :cond_6f

    .line 95
    .line 96
    new-instance v11, Lcom/kousei/framework/ia;

    .line 97
    .line 98
    invoke-virtual {v10}, Landroid/content/pm/Signature;->toByteArray()[B

    .line 99
    .line 100
    .line 101
    move-result-object v10

    .line 102
    invoke-virtual {v4, v10}, Ljava/security/MessageDigest;->digest([B)[B

    .line 103
    .line 104
    .line 105
    move-result-object v10

    .line 106
    invoke-direct {v11, v10}, Lcom/kousei/framework/ia;-><init>([B)V

    .line 107
    .line 108
    .line 109
    invoke-virtual {v3, v11}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 110
    .line 111
    .line 112
    :cond_6f
    add-int/lit8 v9, v9, 0x1

    .line 113
    .line 114
    goto :goto_59

    .line 115
    :cond_72
    add-int/lit8 v6, v6, 0x1

    .line 116
    .line 117
    goto :goto_26

    .line 118
    :cond_75
    invoke-virtual {v3}, Ljava/util/HashSet;->size()I

    .line 119
    .line 120
    .line 121
    move-result p0

    .line 122
    new-array p0, p0, [Lcom/kousei/framework/k;

    .line 123
    .line 124
    invoke-virtual {v3}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    .line 125
    .line 126
    .line 127
    move-result-object v0

    .line 128
    move v1, v5

    .line 129
    :goto_80
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 130
    .line 131
    .line 132
    move-result v3

    .line 133
    if-eqz v3, :cond_99

    .line 134
    .line 135
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 136
    .line 137
    .line 138
    move-result-object v3

    .line 139
    check-cast v3, Lcom/kousei/framework/ia;

    .line 140
    .line 141
    add-int/lit8 v4, v1, 0x1

    .line 142
    .line 143
    new-instance v6, Lcom/kousei/framework/o4;

    .line 144
    .line 145
    iget-object v3, v3, Lcom/kousei/framework/ia;->a:[B

    .line 146
    .line 147
    invoke-direct {v6, v3}, Lcom/kousei/framework/w;-><init>([B)V

    .line 148
    .line 149
    .line 150
    aput-object v6, p0, v1

    .line 151
    .line 152
    move v1, v4

    .line 153
    goto :goto_80

    .line 154
    :cond_99
    new-instance v0, Lcom/kousei/framework/s4;

    .line 155
    .line 156
    invoke-direct {v0, v2, v5}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 157
    .line 158
    .line 159
    new-instance v1, Lcom/kousei/framework/s4;

    .line 160
    .line 161
    invoke-direct {v1, p0, v5}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 162
    .line 163
    .line 164
    new-array p0, v7, [Lcom/kousei/framework/k;

    .line 165
    .line 166
    aput-object v0, p0, v5

    .line 167
    .line 168
    aput-object v1, p0, v8

    .line 169
    .line 170
    new-instance v0, Lcom/kousei/framework/o4;

    .line 171
    .line 172
    new-instance v1, Lcom/kousei/framework/r4;

    .line 173
    .line 174
    invoke-direct {v1, p0, v5}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 175
    .line 176
    .line 177
    invoke-virtual {v1}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 178
    .line 179
    .line 180
    move-result-object p0

    .line 181
    invoke-direct {v0, p0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 182
    .line 183
    .line 184
    return-object v0

    .line 185
    :cond_b8
    new-instance v0, Ljava/lang/IllegalStateException;

    .line 186
    .line 187
    new-instance v1, Ljava/lang/StringBuilder;

    .line 188
    .line 189
    const-string v2, "No packages found for UID: "

    .line 190
    .line 191
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 192
    .line 193
    .line 194
    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 195
    .line 196
    .line 197
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 198
    .line 199
    .line 200
    move-result-object p0

    .line 201
    invoke-direct {v0, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 202
    .line 203
    .line 204
    throw v0

    .line 205
    :cond_cc
    const-string p0, "createApplicationId: PackageManager not found!"

    .line 206
    .line 207
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 208
    .line 209
    .line 210
    return-object v1

    .line 211
    :cond_d2
    const-string p0, "createApplicationId: context not available from ActivityThread!"

    .line 212
    .line 213
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 214
    .line 215
    .line 216
    return-object v1
    .line 217
    .line 218
    .line 219
    .line 220
    .line 221
    .line 222
    .line 223
    .line 224
    .line 225
    .line 226
    .line 227
    .line 228
    .line 229
    .line 230
    .line 231
    .line 232
    .line 233
    .line 234
    .line 235
    .line 236
    .line 237
    .line 238
    .line 239
    .line 240
    .line 241
    .line 242
.end method

.method public static c(Lcom/kousei/framework/ja;I)Lcom/kousei/framework/a8;
    .registers 37

    move-object/from16 v0, p0

    .line 1
    :try_start_2
    new-instance v1, Ljava/security/SecureRandom;

    invoke-direct {v1}, Ljava/security/SecureRandom;-><init>()V

    const/16 v2, 0x20

    .line 2
    new-array v3, v2, [B

    .line 3
    invoke-virtual {v1, v3}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 4
    const-string v4, "ro.boot.vbmeta.digest"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const/16 v5, 0x10

    const/4 v6, 0x0

    if-eqz v4, :cond_58

    .line 5
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v7

    const/16 v8, 0x40

    if-ne v7, v8, :cond_58

    .line 6
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v1

    .line 7
    div-int/lit8 v2, v1, 0x2

    new-array v2, v2, [B

    move v7, v6

    :goto_2c
    if-ge v7, v1, :cond_5d

    .line 8
    invoke-virtual {v4, v7}, Ljava/lang/String;->charAt(I)C

    move-result v8

    invoke-static {v8, v5}, Ljava/lang/Character;->digit(CI)I

    move-result v8

    add-int/lit8 v9, v7, 0x1

    .line 9
    invoke-virtual {v4, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-static {v9, v5}, Ljava/lang/Character;->digit(CI)I

    move-result v9

    const/4 v10, -0x1

    if-eq v8, v10, :cond_50

    if-eq v9, v10, :cond_50

    .line 10
    div-int/lit8 v10, v7, 0x2

    shl-int/lit8 v8, v8, 0x4

    add-int/2addr v8, v9

    int-to-byte v8, v8

    aput-byte v8, v2, v10

    add-int/lit8 v7, v7, 0x2

    goto :goto_2c

    .line 11
    :cond_50
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid hex"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 12
    :cond_58
    new-array v2, v2, [B

    .line 13
    invoke-virtual {v1, v2}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 14
    :cond_5d
    new-instance v1, Lcom/kousei/framework/o4;

    .line 15
    invoke-direct {v1, v3}, Lcom/kousei/framework/w;-><init>([B)V

    .line 16
    new-instance v3, Lcom/kousei/framework/m;

    invoke-direct {v3, v6}, Lcom/kousei/framework/m;-><init>(I)V

    new-instance v4, Lcom/kousei/framework/o4;

    .line 17
    invoke-direct {v4, v2}, Lcom/kousei/framework/w;-><init>([B)V

    const/4 v2, 0x4

    .line 18
    new-array v7, v2, [Lcom/kousei/framework/k;

    aput-object v1, v7, v6

    sget-object v1, Lcom/kousei/framework/i;->M:Lcom/kousei/framework/i;

    const/4 v8, 0x1

    aput-object v1, v7, v8

    const/4 v1, 0x2

    aput-object v3, v7, v1

    const/4 v3, 0x3

    aput-object v4, v7, v3

    .line 19
    new-instance v4, Lcom/kousei/framework/r4;

    invoke-direct {v4, v7, v6}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 20
    new-instance v7, Lcom/kousei/framework/s4;

    iget-object v9, v0, Lcom/kousei/framework/ja;->j:Ljava/util/ArrayList;

    iget-object v10, v0, Lcom/kousei/framework/ja;->m:[B

    invoke-static {v9}, Lcom/kousei/framework/ka;->d(Ljava/util/ArrayList;)[Lcom/kousei/framework/k;

    move-result-object v9

    invoke-direct {v7, v9, v6}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 21
    new-instance v9, Lcom/kousei/framework/q;

    iget v11, v0, Lcom/kousei/framework/ja;->b:I

    invoke-direct {v9, v11}, Lcom/kousei/framework/q;-><init>(I)V

    .line 22
    new-instance v11, Lcom/kousei/framework/q;

    iget v12, v0, Lcom/kousei/framework/ja;->a:I

    invoke-direct {v11, v12}, Lcom/kousei/framework/q;-><init>(I)V

    .line 23
    new-instance v12, Lcom/kousei/framework/s4;

    iget-object v13, v0, Lcom/kousei/framework/ja;->k:Ljava/util/ArrayList;

    invoke-static {v13}, Lcom/kousei/framework/ka;->d(Ljava/util/ArrayList;)[Lcom/kousei/framework/k;

    move-result-object v13

    invoke-direct {v12, v13, v6}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 24
    new-instance v13, Lcom/kousei/framework/q;

    iget v14, v0, Lcom/kousei/framework/ja;->h:I

    invoke-direct {v13, v14}, Lcom/kousei/framework/q;-><init>(I)V

    .line 25
    sget-object v14, Lcom/kousei/framework/m4;->K:Lcom/kousei/framework/m4;

    .line 26
    new-instance v15, Lcom/kousei/framework/q;

    invoke-direct {v15, v6}, Lcom/kousei/framework/q;-><init>(I)V

    move/from16 v16, v2

    .line 27
    new-instance v2, Lcom/kousei/framework/q;

    move/from16 v17, v5

    invoke-static {}, Lcom/kousei/framework/ka;->g()I

    move-result v5

    invoke-direct {v2, v5}, Lcom/kousei/framework/q;-><init>(I)V

    .line 28
    new-instance v5, Lcom/kousei/framework/q;

    .line 29
    sget-object v18, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    move/from16 v18, v6

    invoke-static/range {v18 .. v18}, Lcom/kousei/framework/ka;->a(Z)I

    move-result v6

    .line 30
    invoke-direct {v5, v6}, Lcom/kousei/framework/q;-><init>(I)V

    .line 31
    new-instance v6, Lcom/kousei/framework/q;

    .line 32
    invoke-static {v8}, Lcom/kousei/framework/ka;->a(Z)I

    move-result v3

    .line 33
    invoke-direct {v6, v3}, Lcom/kousei/framework/q;-><init>(I)V

    .line 34
    new-instance v3, Lcom/kousei/framework/q;

    .line 35
    invoke-static {v8}, Lcom/kousei/framework/ka;->a(Z)I

    move-result v1

    .line 36
    invoke-direct {v3, v1}, Lcom/kousei/framework/q;-><init>(I)V

    .line 37
    new-instance v1, Lcom/kousei/framework/k2;

    .line 38
    invoke-direct {v1, v8, v8, v7, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 39
    new-instance v7, Lcom/kousei/framework/k2;

    move-object/from16 v21, v1

    const/4 v1, 0x2

    .line 40
    invoke-direct {v7, v8, v1, v9, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 41
    new-instance v1, Lcom/kousei/framework/k2;

    const/4 v9, 0x3

    .line 42
    invoke-direct {v1, v8, v9, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 43
    new-instance v9, Lcom/kousei/framework/k2;

    const/4 v11, 0x5

    .line 44
    invoke-direct {v9, v8, v11, v12, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 45
    new-instance v12, Lcom/kousei/framework/k2;

    move/from16 v22, v11

    const/16 v11, 0xa

    .line 46
    invoke-direct {v12, v8, v11, v13, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 47
    new-instance v13, Lcom/kousei/framework/k2;

    move/from16 v23, v11

    const/16 v11, 0x1f7

    .line 48
    invoke-direct {v13, v8, v11, v14, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 49
    new-instance v11, Lcom/kousei/framework/k2;

    const/16 v14, 0x2be

    .line 50
    invoke-direct {v11, v8, v14, v15, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 51
    new-instance v14, Lcom/kousei/framework/k2;

    const/16 v15, 0x2c0

    .line 52
    invoke-direct {v14, v8, v15, v4, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 53
    new-instance v4, Lcom/kousei/framework/k2;

    const/16 v15, 0x2c1

    .line 54
    invoke-direct {v4, v8, v15, v2, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 55
    new-instance v2, Lcom/kousei/framework/k2;

    const/16 v15, 0x2c2

    .line 56
    invoke-direct {v2, v8, v15, v5, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 57
    new-instance v5, Lcom/kousei/framework/k2;

    const/16 v15, 0x2ce

    .line 58
    invoke-direct {v5, v8, v15, v3, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 59
    new-instance v3, Lcom/kousei/framework/k2;

    const/16 v15, 0x2cf

    .line 60
    invoke-direct {v3, v8, v15, v6, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    const/16 v24, 0x9

    const/16 v25, 0x8

    const/16 v26, 0x7

    const/16 v27, 0x6

    if-eqz v10, :cond_1c2

    const/16 v28, 0xb

    .line 61
    new-instance v15, Lcom/kousei/framework/o4;

    .line 62
    invoke-direct {v15, v10}, Lcom/kousei/framework/w;-><init>([B)V

    .line 63
    new-instance v10, Lcom/kousei/framework/o4;

    const/16 v29, 0xc

    iget-object v6, v0, Lcom/kousei/framework/ja;->n:[B

    .line 64
    invoke-direct {v10, v6}, Lcom/kousei/framework/w;-><init>([B)V

    .line 65
    new-instance v6, Lcom/kousei/framework/o4;

    iget-object v8, v0, Lcom/kousei/framework/ja;->o:[B

    .line 66
    invoke-direct {v6, v8}, Lcom/kousei/framework/w;-><init>([B)V

    .line 67
    new-instance v8, Lcom/kousei/framework/o4;

    move-object/from16 v31, v1

    iget-object v1, v0, Lcom/kousei/framework/ja;->p:[B

    .line 68
    invoke-direct {v8, v1}, Lcom/kousei/framework/w;-><init>([B)V

    .line 69
    new-instance v1, Lcom/kousei/framework/o4;

    move-object/from16 v32, v2

    iget-object v2, v0, Lcom/kousei/framework/ja;->q:[B

    .line 70
    invoke-direct {v1, v2}, Lcom/kousei/framework/w;-><init>([B)V

    .line 71
    new-instance v2, Lcom/kousei/framework/k2;

    move-object/from16 v33, v3

    const/16 v3, 0x2c6

    move-object/from16 v34, v4

    const/4 v4, 0x1

    .line 72
    invoke-direct {v2, v4, v3, v15, v4}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 73
    new-instance v3, Lcom/kousei/framework/k2;

    const/16 v15, 0x2c7

    .line 74
    invoke-direct {v3, v4, v15, v10, v4}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 75
    new-instance v10, Lcom/kousei/framework/k2;

    const/16 v15, 0x2c8

    .line 76
    invoke-direct {v10, v4, v15, v6, v4}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 77
    new-instance v6, Lcom/kousei/framework/k2;

    const/16 v15, 0x2cc

    .line 78
    invoke-direct {v6, v4, v15, v8, v4}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 79
    new-instance v8, Lcom/kousei/framework/k2;

    const/16 v15, 0x2cd

    .line 80
    invoke-direct {v8, v4, v15, v1, v4}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    const/16 v1, 0x11

    .line 81
    new-array v1, v1, [Lcom/kousei/framework/k;

    aput-object v21, v1, v18

    aput-object v7, v1, v4

    const/16 v20, 0x2

    aput-object v31, v1, v20

    const/16 v19, 0x3

    aput-object v9, v1, v19

    aput-object v12, v1, v16

    aput-object v13, v1, v22

    aput-object v11, v1, v27

    aput-object v14, v1, v26

    aput-object v34, v1, v25

    aput-object v32, v1, v24

    aput-object v5, v1, v23

    aput-object v33, v1, v28

    aput-object v2, v1, v29

    const/16 v2, 0xd

    aput-object v3, v1, v2

    const/16 v2, 0xe

    aput-object v10, v1, v2

    const/16 v2, 0xf

    aput-object v6, v1, v2

    aput-object v8, v1, v17

    goto :goto_1ee

    :cond_1c2
    move-object/from16 v31, v1

    move-object/from16 v32, v2

    move-object/from16 v33, v3

    move-object/from16 v34, v4

    const/16 v1, 0xc

    const/16 v28, 0xb

    .line 82
    new-array v1, v1, [Lcom/kousei/framework/k;

    aput-object v21, v1, v18

    const/16 v30, 0x1

    aput-object v7, v1, v30

    const/16 v20, 0x2

    aput-object v31, v1, v20

    const/16 v19, 0x3

    aput-object v9, v1, v19

    aput-object v12, v1, v16

    aput-object v13, v1, v22

    aput-object v11, v1, v27

    aput-object v14, v1, v26

    aput-object v34, v1, v25

    aput-object v32, v1, v24

    aput-object v5, v1, v23

    aput-object v33, v1, v28

    .line 83
    :goto_1ee
    new-instance v2, Lcom/kousei/framework/q;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-direct {v2, v3, v4}, Lcom/kousei/framework/q;-><init>(J)V

    .line 84
    invoke-static/range {p1 .. p1}, Lcom/kousei/framework/ka;->b(I)Lcom/kousei/framework/o4;

    move-result-object v3

    .line 85
    new-instance v4, Lcom/kousei/framework/k2;

    const/16 v5, 0x2bd

    const/4 v6, 0x1

    .line 86
    invoke-direct {v4, v6, v5, v2, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 87
    new-instance v2, Lcom/kousei/framework/k2;

    const/16 v5, 0x2c5

    .line 88
    invoke-direct {v2, v6, v5, v3, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    const/4 v3, 0x2

    .line 89
    new-array v3, v3, [Lcom/kousei/framework/k;

    aput-object v4, v3, v18

    aput-object v2, v3, v6

    .line 90
    invoke-static {v1, v3, v0}, Lcom/kousei/framework/ka;->f([Lcom/kousei/framework/k;[Lcom/kousei/framework/k;Lcom/kousei/framework/ja;)Lcom/kousei/framework/o4;

    move-result-object v0

    .line 91
    new-instance v1, Lcom/kousei/framework/a8;

    new-instance v2, Lcom/kousei/framework/v;

    const-string v3, "1.3.6.1.4.1.11129.2.1.17"

    invoke-direct {v2, v3}, Lcom/kousei/framework/v;-><init>(Ljava/lang/String;)V

    move/from16 v3, v18

    invoke-direct {v1, v2, v3, v0}, Lcom/kousei/framework/a8;-><init>(Lcom/kousei/framework/v;ZLcom/kousei/framework/o4;)V
    :try_end_223
    .catchall {:try_start_2 .. :try_end_223} :catchall_224

    return-object v1

    :catchall_224
    const/4 v0, 0x0

    return-object v0
.end method

.method public static d(Ljava/util/ArrayList;)[Lcom/kousei/framework/k;
    .registers 5

    .line 1
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    new-array v0, v0, [Lcom/kousei/framework/k;

    .line 6
    .line 7
    const/4 v1, 0x0

    .line 8
    :goto_7
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    .line 9
    .line 10
    .line 11
    move-result v2

    .line 12
    if-ge v1, v2, :cond_21

    .line 13
    .line 14
    new-instance v2, Lcom/kousei/framework/q;

    .line 15
    .line 16
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 17
    .line 18
    .line 19
    move-result-object v3

    .line 20
    check-cast v3, Ljava/lang/Integer;

    .line 21
    .line 22
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    .line 23
    .line 24
    .line 25
    move-result v3

    .line 26
    invoke-direct {v2, v3}, Lcom/kousei/framework/q;-><init>(I)V

    .line 27
    .line 28
    .line 29
    aput-object v2, v0, v1

    .line 30
    .line 31
    add-int/lit8 v1, v1, 0x1

    .line 32
    .line 33
    goto :goto_7

    .line 34
    :cond_21
    return-object v0
    .line 35
    .line 36
    .line 37
    .line 38
    .line 39
    .line 40
    .line 41
    .line 42
    .line 43
    .line 44
    .line 45
    .line 46
    .line 47
    .line 48
    .line 49
    .line 50
    .line 51
    .line 52
    .line 53
    .line 54
    .line 55
    .line 56
    .line 57
    .line 58
    .line 59
    .line 60
    .line 61
    .line 62
    .line 63
    .line 64
    .line 65
    .line 66
    .line 67
    .line 68
    .line 69
    .line 70
    .line 71
    .line 72
    .line 73
    .line 74
    .line 75
    .line 76
    .line 77
    .line 78
    .line 79
    .line 80
    .line 81
    .line 82
    .line 83
    .line 84
    .line 85
    .line 86
    .line 87
    .line 88
    .line 89
    .line 90
    .line 91
    .line 92
    .line 93
    .line 94
    .line 95
    .line 96
    .line 97
    .line 98
    .line 99
    .line 100
    .line 101
    .line 102
    .line 103
    .line 104
    .line 105
    .line 106
    .line 107
    .line 108
    .line 109
    .line 110
    .line 111
    .line 112
    .line 113
    .line 114
    .line 115
    .line 116
    .line 117
    .line 118
    .line 119
    .line 120
    .line 121
    .line 122
    .line 123
    .line 124
    .line 125
    .line 126
    .line 127
    .line 128
    .line 129
    .line 130
    .line 131
    .line 132
    .line 133
    .line 134
    .line 135
    .line 136
    .line 137
    .line 138
    .line 139
    .line 140
    .line 141
    .line 142
    .line 143
    .line 144
    .line 145
    .line 146
    .line 147
    .line 148
    .line 149
    .line 150
    .line 151
    .line 152
    .line 153
    .line 154
    .line 155
    .line 156
    .line 157
    .line 158
    .line 159
    .line 160
    .line 161
    .line 162
    .line 163
    .line 164
    .line 165
    .line 166
    .line 167
    .line 168
    .line 169
    .line 170
    .line 171
    .line 172
    .line 173
    .line 174
    .line 175
    .line 176
    .line 177
    .line 178
    .line 179
    .line 180
    .line 181
    .line 182
    .line 183
    .line 184
    .line 185
    .line 186
    .line 187
    .line 188
    .line 189
    .line 190
    .line 191
    .line 192
    .line 193
    .line 194
    .line 195
    .line 196
    .line 197
    .line 198
    .line 199
    .line 200
    .line 201
    .line 202
    .line 203
    .line 204
    .line 205
    .line 206
    .line 207
    .line 208
    .line 209
    .line 210
    .line 211
    .line 212
    .line 213
    .line 214
    .line 215
    .line 216
    .line 217
    .line 218
    .line 219
    .line 220
    .line 221
    .line 222
    .line 223
    .line 224
    .line 225
    .line 226
    .line 227
    .line 228
    .line 229
    .line 230
    .line 231
    .line 232
    .line 233
    .line 234
    .line 235
    .line 236
    .line 237
    .line 238
    .line 239
    .line 240
    .line 241
    .line 242
.end method

.method public static e(ILandroid/system/keystore2/KeyDescriptor;Lcom/kousei/framework/ja;)Ljava/util/ArrayList;
    .registers 23

    .line 1
    move-object/from16 v0, p2

    .line 2
    .line 3
    const-string v1, "\\s+"

    .line 4
    .line 5
    const-string v2, "-----END [^-]+-----"

    .line 6
    .line 7
    const-string v3, ""

    .line 8
    .line 9
    const-string v4, "-----BEGIN [^-]+-----"

    .line 10
    .line 11
    const-string v5, "X.509"

    .line 12
    .line 13
    const/4 v6, 0x3

    .line 14
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 15
    .line 16
    .line 17
    move-result-object v6

    .line 18
    move-object/from16 v7, p1

    .line 19
    .line 20
    iget-object v7, v7, Landroid/system/keystore2/KeyDescriptor;->alias:Ljava/lang/String;

    .line 21
    .line 22
    iget v7, v0, Lcom/kousei/framework/ja;->b:I

    .line 23
    .line 24
    :try_start_17
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 25
    .line 26
    .line 27
    move-result-object v8

    .line 28
    invoke-virtual {v8, v6}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    .line 29
    .line 30
    .line 31
    move-result v8
    :try_end_1f
    .catchall {:try_start_17 .. :try_end_1f} :catchall_185

    .line 32
    sget-object v9, Lcom/kousei/framework/ka;->a:Lcom/kousei/framework/y2;

    .line 33
    .line 34
    const-string v10, "RSA"

    .line 35
    .line 36
    const-string v11, "EC"

    .line 37
    .line 38
    if-eqz v8, :cond_3a

    .line 39
    .line 40
    :try_start_27
    new-instance v8, Ljava/security/spec/ECGenParameterSpec;

    .line 41
    .line 42
    iget-object v12, v0, Lcom/kousei/framework/ja;->i:Ljava/lang/String;

    .line 43
    .line 44
    invoke-direct {v8, v12}, Ljava/security/spec/ECGenParameterSpec;-><init>(Ljava/lang/String;)V

    .line 45
    .line 46
    .line 47
    invoke-static {v11, v9}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljava/security/KeyPairGenerator;

    .line 48
    .line 49
    .line 50
    move-result-object v9

    .line 51
    invoke-virtual {v9, v8}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 52
    .line 53
    .line 54
    invoke-virtual {v9}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;

    .line 55
    .line 56
    .line 57
    move-result-object v8

    .line 58
    goto :goto_5d

    .line 59
    :cond_3a
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 60
    .line 61
    .line 62
    move-result-object v8

    .line 63
    const/4 v12, 0x1

    .line 64
    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 65
    .line 66
    .line 67
    move-result-object v12

    .line 68
    invoke-virtual {v8, v12}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    .line 69
    .line 70
    .line 71
    move-result v8

    .line 72
    if-eqz v8, :cond_185

    .line 73
    .line 74
    new-instance v8, Ljava/security/spec/RSAKeyGenParameterSpec;

    .line 75
    .line 76
    iget v12, v0, Lcom/kousei/framework/ja;->a:I

    .line 77
    .line 78
    iget-object v13, v0, Lcom/kousei/framework/ja;->g:Ljava/math/BigInteger;

    .line 79
    .line 80
    invoke-direct {v8, v12, v13}, Ljava/security/spec/RSAKeyGenParameterSpec;-><init>(ILjava/math/BigInteger;)V

    .line 81
    .line 82
    .line 83
    invoke-static {v10, v9}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljava/security/KeyPairGenerator;

    .line 84
    .line 85
    .line 86
    move-result-object v9

    .line 87
    invoke-virtual {v9, v8}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 88
    .line 89
    .line 90
    invoke-virtual {v9}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;

    .line 91
    .line 92
    .line 93
    move-result-object v8

    .line 94
    :goto_5d
    new-instance v12, Lcom/kousei/framework/m8;

    .line 95
    .line 96
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 97
    .line 98
    .line 99
    move-result-object v9

    .line 100
    invoke-virtual {v9, v6}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    .line 101
    .line 102
    .line 103
    move-result v9

    .line 104
    if-eqz v9, :cond_6b

    .line 105
    .line 106
    move-object v9, v11

    .line 107
    goto :goto_6c

    .line 108
    :cond_6b
    move-object v9, v10

    .line 109
    :goto_6c
    sget-object v13, Lcom/kousei/framework/na;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 110
    .line 111
    new-instance v13, Lcom/kousei/framework/ga;

    .line 112
    .line 113
    invoke-direct {v13}, Lcom/kousei/framework/ga;-><init>()V

    .line 114
    .line 115
    .line 116
    invoke-static {v13, v9}, Lcom/kousei/framework/na;->e(Lcom/kousei/framework/ga;Ljava/lang/String;)[Ljava/lang/String;

    .line 117
    .line 118
    .line 119
    move-result-object v9

    .line 120
    const/4 v13, 0x0

    .line 121
    aget-object v9, v9, v13

    .line 122
    .line 123
    invoke-virtual {v9, v4, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 124
    .line 125
    .line 126
    move-result-object v9

    .line 127
    invoke-virtual {v9, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 128
    .line 129
    .line 130
    move-result-object v9

    .line 131
    invoke-virtual {v9, v1, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 132
    .line 133
    .line 134
    move-result-object v9

    .line 135
    invoke-static {}, Ljava/util/Base64;->getDecoder()Ljava/util/Base64$Decoder;

    .line 136
    .line 137
    .line 138
    move-result-object v14

    .line 139
    invoke-virtual {v14, v9}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    .line 140
    .line 141
    .line 142
    move-result-object v9

    .line 143
    invoke-static {v5}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    .line 144
    .line 145
    .line 146
    move-result-object v14

    .line 147
    new-instance v15, Ljava/io/ByteArrayInputStream;

    .line 148
    .line 149
    invoke-direct {v15, v9}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 150
    .line 151
    .line 152
    invoke-virtual {v14, v15}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 153
    .line 154
    .line 155
    move-result-object v9

    .line 156
    check-cast v9, Ljava/security/cert/X509Certificate;

    .line 157
    .line 158
    new-instance v14, Lcom/kousei/framework/yi;

    .line 159
    .line 160
    invoke-virtual {v9}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 161
    .line 162
    .line 163
    move-result-object v9

    .line 164
    invoke-direct {v14, v9}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 165
    .line 166
    .line 167
    invoke-virtual {v14}, Lcom/kousei/framework/yi;->b()Lcom/kousei/framework/wi;

    .line 168
    .line 169
    .line 170
    move-result-object v9

    .line 171
    iget-object v14, v0, Lcom/kousei/framework/ja;->c:Ljava/math/BigInteger;

    .line 172
    .line 173
    new-instance v15, Lcom/kousei/framework/ei;

    .line 174
    .line 175
    iget-object v13, v0, Lcom/kousei/framework/ja;->d:Ljava/util/Date;

    .line 176
    .line 177
    invoke-direct {v15, v13}, Lcom/kousei/framework/ei;-><init>(Ljava/util/Date;)V

    .line 178
    .line 179
    .line 180
    new-instance v13, Lcom/kousei/framework/ei;

    .line 181
    .line 182
    move-object/from16 v19, v5

    .line 183
    .line 184
    iget-object v5, v0, Lcom/kousei/framework/ja;->e:Ljava/util/Date;

    .line 185
    .line 186
    invoke-direct {v13, v5}, Lcom/kousei/framework/ei;-><init>(Ljava/util/Date;)V

    .line 187
    .line 188
    .line 189
    iget-object v5, v0, Lcom/kousei/framework/ja;->f:Lcom/kousei/framework/wi;

    .line 190
    .line 191
    invoke-virtual {v8}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    .line 192
    .line 193
    .line 194
    move-result-object v8

    .line 195
    invoke-interface {v8}, Ljava/security/Key;->getEncoded()[B

    .line 196
    .line 197
    .line 198
    move-result-object v8

    .line 199
    invoke-static {v8}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 200
    .line 201
    .line 202
    move-result-object v8

    .line 203
    invoke-static {v8}, Lcom/kousei/framework/xh;->h(Ljava/lang/Object;)Lcom/kousei/framework/xh;

    .line 204
    .line 205
    .line 206
    move-result-object v18

    .line 207
    move-object/from16 v17, v5

    .line 208
    .line 209
    move-object/from16 v16, v13

    .line 210
    .line 211
    const/4 v5, 0x0

    .line 212
    move-object v13, v9

    .line 213
    invoke-direct/range {v12 .. v18}, Lcom/kousei/framework/m8;-><init>(Lcom/kousei/framework/wi;Ljava/math/BigInteger;Lcom/kousei/framework/ei;Lcom/kousei/framework/ei;Lcom/kousei/framework/wi;Lcom/kousei/framework/xh;)V

    .line 214
    .line 215
    .line 216
    new-instance v8, Lcom/kousei/framework/ha;

    .line 217
    .line 218
    invoke-direct {v8}, Lcom/kousei/framework/ha;-><init>()V

    .line 219
    .line 220
    .line 221
    sget-object v9, Lcom/kousei/framework/a8;->O:Lcom/kousei/framework/v;

    .line 222
    .line 223
    invoke-virtual {v12, v9, v8}, Lcom/kousei/framework/m8;->b(Lcom/kousei/framework/v;Lcom/kousei/framework/ha;)V

    .line 224
    .line 225
    .line 226
    move/from16 v8, p0

    .line 227
    .line 228
    invoke-static {v0, v8}, Lcom/kousei/framework/ka;->c(Lcom/kousei/framework/ja;I)Lcom/kousei/framework/a8;

    .line 229
    .line 230
    .line 231
    move-result-object v0

    .line 232
    iget-object v8, v12, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 233
    .line 234
    check-cast v8, Lcom/kousei/framework/c8;

    .line 235
    .line 236
    invoke-virtual {v8, v0}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 237
    .line 238
    .line 239
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 240
    .line 241
    .line 242
    move-result-object v0

    .line 243
    invoke-virtual {v0, v6}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    .line 244
    .line 245
    .line 246
    move-result v0

    .line 247
    if-eqz v0, :cond_f9

    .line 248
    .line 249
    move-object v10, v11

    .line 250
    :cond_f9
    invoke-static {v10}, Lcom/kousei/framework/na;->b(Ljava/lang/String;)Ljava/security/PrivateKey;

    .line 251
    .line 252
    .line 253
    move-result-object v0

    .line 254
    invoke-interface {v0}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 255
    .line 256
    .line 257
    move-result-object v6

    .line 258
    if-eqz v6, :cond_112

    .line 259
    .line 260
    sget-object v7, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 261
    .line 262
    invoke-virtual {v6, v7}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    .line 263
    .line 264
    .line 265
    move-result-object v6

    .line 266
    invoke-virtual {v6, v11}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    .line 267
    .line 268
    .line 269
    move-result v6

    .line 270
    if-eqz v6, :cond_112

    .line 271
    .line 272
    const-string v6, "SHA256withECDSA"

    .line 273
    .line 274
    goto :goto_114

    .line 275
    :cond_112
    const-string v6, "SHA256withRSA"

    .line 276
    .line 277
    :goto_114
    new-instance v7, Lcom/kousei/framework/u9;

    .line 278
    .line 279
    invoke-direct {v7, v6}, Lcom/kousei/framework/u9;-><init>(Ljava/lang/String;)V

    .line 280
    .line 281
    .line 282
    invoke-virtual {v7, v0}, Lcom/kousei/framework/u9;->a(Ljava/security/PrivateKey;)Lcom/kousei/framework/k3;

    .line 283
    .line 284
    .line 285
    move-result-object v0

    .line 286
    invoke-virtual {v12, v0}, Lcom/kousei/framework/m8;->c(Lcom/kousei/framework/k3;)Lcom/kousei/framework/yi;

    .line 287
    .line 288
    .line 289
    move-result-object v0

    .line 290
    invoke-static/range {v19 .. v19}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    .line 291
    .line 292
    .line 293
    move-result-object v6

    .line 294
    new-instance v7, Ljava/io/ByteArrayInputStream;

    .line 295
    .line 296
    iget-object v0, v0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 297
    .line 298
    invoke-virtual {v0}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 299
    .line 300
    .line 301
    move-result-object v0

    .line 302
    invoke-direct {v7, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 303
    .line 304
    .line 305
    invoke-virtual {v6, v7}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 306
    .line 307
    .line 308
    move-result-object v0

    .line 309
    check-cast v0, Ljava/security/cert/X509Certificate;

    .line 310
    .line 311
    invoke-virtual {v0}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    .line 312
    .line 313
    .line 314
    move-result-object v6

    .line 315
    invoke-interface {v6}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 316
    .line 317
    .line 318
    move-result-object v6

    .line 319
    new-instance v7, Lcom/kousei/framework/ga;

    .line 320
    .line 321
    invoke-direct {v7}, Lcom/kousei/framework/ga;-><init>()V

    .line 322
    .line 323
    .line 324
    invoke-static {v7, v6}, Lcom/kousei/framework/na;->e(Lcom/kousei/framework/ga;Ljava/lang/String;)[Ljava/lang/String;

    .line 325
    .line 326
    .line 327
    move-result-object v6

    .line 328
    new-instance v7, Ljava/util/ArrayList;

    .line 329
    .line 330
    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    .line 331
    .line 332
    .line 333
    array-length v8, v6

    .line 334
    move v13, v5

    .line 335
    :goto_14e
    if-ge v13, v8, :cond_181

    .line 336
    .line 337
    aget-object v9, v6, v13

    .line 338
    .line 339
    invoke-static {v9}, Lcom/kousei/framework/na;->c(Ljava/lang/String;)Z

    .line 340
    .line 341
    .line 342
    move-result v10

    .line 343
    if-eqz v10, :cond_17e

    .line 344
    .line 345
    invoke-virtual {v9, v4, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 346
    .line 347
    .line 348
    move-result-object v9

    .line 349
    invoke-virtual {v9, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 350
    .line 351
    .line 352
    move-result-object v9

    .line 353
    invoke-virtual {v9, v1, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 354
    .line 355
    .line 356
    move-result-object v9

    .line 357
    invoke-static {}, Ljava/util/Base64;->getDecoder()Ljava/util/Base64$Decoder;

    .line 358
    .line 359
    .line 360
    move-result-object v10

    .line 361
    invoke-virtual {v10, v9}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    .line 362
    .line 363
    .line 364
    move-result-object v9

    .line 365
    invoke-static/range {v19 .. v19}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    .line 366
    .line 367
    .line 368
    move-result-object v10

    .line 369
    new-instance v11, Ljava/io/ByteArrayInputStream;

    .line 370
    .line 371
    invoke-direct {v11, v9}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 372
    .line 373
    .line 374
    invoke-virtual {v10, v11}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 375
    .line 376
    .line 377
    move-result-object v9

    .line 378
    check-cast v9, Ljava/security/cert/X509Certificate;

    .line 379
    .line 380
    invoke-virtual {v7, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 381
    .line 382
    .line 383
    :cond_17e
    add-int/lit8 v13, v13, 0x1

    .line 384
    .line 385
    goto :goto_14e

    .line 386
    :cond_181
    invoke-virtual {v7, v5, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V
    :try_end_184
    .catchall {:try_start_27 .. :try_end_184} :catchall_185

    .line 387
    .line 388
    .line 389
    return-object v7

    .line 390
    :catchall_185
    :cond_185
    const/4 v0, 0x0

    .line 391
    return-object v0
    .line 392
    .line 393
    .line 394
    .line 395
    .line 396
    .line 397
    .line 398
    .line 399
    .line 400
    .line 401
    .line 402
    .line 403
    .line 404
    .line 405
    .line 406
    .line 407
    .line 408
    .line 409
    .line 410
    .line 411
    .line 412
    .line 413
    .line 414
    .line 415
    .line 416
    .line 417
    .line 418
    .line 419
    .line 420
    .line 421
    .line 422
    .line 423
    .line 424
    .line 425
    .line 426
    .line 427
    .line 428
    .line 429
    .line 430
    .line 431
    .line 432
    .line 433
    .line 434
    .line 435
    .line 436
    .line 437
    .line 438
    .line 439
    .line 440
    .line 441
    .line 442
    .line 443
    .line 444
    .line 445
    .line 446
    .line 447
    .line 448
    .line 449
    .line 450
    .line 451
    .line 452
    .line 453
    .line 454
    .line 455
    .line 456
    .line 457
    .line 458
    .line 459
    .line 460
    .line 461
    .line 462
    .line 463
    .line 464
    .line 465
    .line 466
    .line 467
    .line 468
    .line 469
    .line 470
    .line 471
    .line 472
    .line 473
    .line 474
    .line 475
    .line 476
    .line 477
    .line 478
    .line 479
    .line 480
    .line 481
    .line 482
    .line 483
    .line 484
    .line 485
    .line 486
    .line 487
    .line 488
    .line 489
    .line 490
    .line 491
    .line 492
    .line 493
    .line 494
    .line 495
    .line 496
    .line 497
    .line 498
    .line 499
    .line 500
    .line 501
    .line 502
    .line 503
    .line 504
    .line 505
    .line 506
    .line 507
    .line 508
    .line 509
    .line 510
    .line 511
    .line 512
    .line 513
    .line 514
    .line 515
    .line 516
    .line 517
    .line 518
    .line 519
    .line 520
    .line 521
    .line 522
    .line 523
    .line 524
    .line 525
    .line 526
    .line 527
    .line 528
    .line 529
    .line 530
    .line 531
    .line 532
    .line 533
    .line 534
    .line 535
    .line 536
    .line 537
    .line 538
    .line 539
    .line 540
    .line 541
    .line 542
    .line 543
    .line 544
    .line 545
    .line 546
    .line 547
    .line 548
    .line 549
    .line 550
    .line 551
    .line 552
    .line 553
    .line 554
    .line 555
    .line 556
    .line 557
    .line 558
    .line 559
    .line 560
    .line 561
    .line 562
    .line 563
    .line 564
    .line 565
    .line 566
    .line 567
    .line 568
    .line 569
    .line 570
    .line 571
    .line 572
    .line 573
    .line 574
    .line 575
    .line 576
    .line 577
    .line 578
    .line 579
    .line 580
    .line 581
    .line 582
    .line 583
    .line 584
    .line 585
    .line 586
    .line 587
    .line 588
    .line 589
    .line 590
    .line 591
    .line 592
    .line 593
    .line 594
    .line 595
    .line 596
    .line 597
    .line 598
    .line 599
    .line 600
    .line 601
    .line 602
    .line 603
    .line 604
    .line 605
    .line 606
    .line 607
    .line 608
    .line 609
    .line 610
    .line 611
    .line 612
    .line 613
    .line 614
    .line 615
    .line 616
    .line 617
    .line 618
    .line 619
    .line 620
    .line 621
    .line 622
    .line 623
    .line 624
    .line 625
    .line 626
    .line 627
    .line 628
    .line 629
    .line 630
    .line 631
    .line 632
    .line 633
    .line 634
    .line 635
    .line 636
    .line 637
    .line 638
    .line 639
    .line 640
    .line 641
    .line 642
    .line 643
    .line 644
    .line 645
    .line 646
    .line 647
    .line 648
    .line 649
    .line 650
    .line 651
    .line 652
    .line 653
    .line 654
    .line 655
    .line 656
    .line 657
    .line 658
    .line 659
.end method

.method public static f([Lcom/kousei/framework/k;[Lcom/kousei/framework/k;Lcom/kousei/framework/ja;)Lcom/kousei/framework/o4;
    .registers 11

    .line 1
    new-instance v0, Lcom/kousei/framework/q;

    .line 2
    .line 3
    const/16 v1, 0x64

    .line 4
    .line 5
    invoke-direct {v0, v1}, Lcom/kousei/framework/q;-><init>(I)V

    .line 6
    .line 7
    .line 8
    new-instance v2, Lcom/kousei/framework/m;

    .line 9
    .line 10
    const/4 v3, 0x1

    .line 11
    invoke-direct {v2, v3}, Lcom/kousei/framework/m;-><init>(I)V

    .line 12
    .line 13
    .line 14
    new-instance v4, Lcom/kousei/framework/q;

    .line 15
    .line 16
    invoke-direct {v4, v1}, Lcom/kousei/framework/q;-><init>(I)V

    .line 17
    .line 18
    .line 19
    new-instance v1, Lcom/kousei/framework/m;

    .line 20
    .line 21
    invoke-direct {v1, v3}, Lcom/kousei/framework/m;-><init>(I)V

    .line 22
    .line 23
    .line 24
    new-instance v5, Lcom/kousei/framework/o4;

    .line 25
    .line 26
    iget-object p2, p2, Lcom/kousei/framework/ja;->l:[B

    .line 27
    .line 28
    invoke-direct {v5, p2}, Lcom/kousei/framework/w;-><init>([B)V

    .line 29
    .line 30
    .line 31
    new-instance p2, Lcom/kousei/framework/o4;

    .line 32
    .line 33
    const/4 v6, 0x0

    .line 34
    new-array v7, v6, [B

    .line 35
    .line 36
    invoke-direct {p2, v7}, Lcom/kousei/framework/w;-><init>([B)V

    .line 37
    .line 38
    .line 39
    new-instance v7, Lcom/kousei/framework/r4;

    .line 40
    .line 41
    invoke-direct {v7, p1, v6}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 42
    .line 43
    .line 44
    new-instance p1, Lcom/kousei/framework/r4;

    .line 45
    .line 46
    invoke-direct {p1, p0, v6}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 47
    .line 48
    .line 49
    const/16 p0, 0x8

    .line 50
    .line 51
    new-array p0, p0, [Lcom/kousei/framework/k;

    .line 52
    .line 53
    aput-object v0, p0, v6

    .line 54
    .line 55
    aput-object v2, p0, v3

    .line 56
    .line 57
    const/4 v0, 0x2

    .line 58
    aput-object v4, p0, v0

    .line 59
    .line 60
    const/4 v0, 0x3

    .line 61
    aput-object v1, p0, v0

    .line 62
    .line 63
    const/4 v0, 0x4

    .line 64
    aput-object v5, p0, v0

    .line 65
    .line 66
    const/4 v0, 0x5

    .line 67
    aput-object p2, p0, v0

    .line 68
    .line 69
    const/4 p2, 0x6

    .line 70
    aput-object v7, p0, p2

    .line 71
    .line 72
    const/4 p2, 0x7

    .line 73
    aput-object p1, p0, p2

    .line 74
    .line 75
    new-instance p1, Lcom/kousei/framework/r4;

    .line 76
    .line 77
    invoke-direct {p1, p0, v6}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 78
    .line 79
    .line 80
    new-instance p0, Lcom/kousei/framework/o4;

    .line 81
    .line 82
    invoke-direct {p0, p1}, Lcom/kousei/framework/o4;-><init>(Lcom/kousei/framework/s;)V

    .line 83
    .line 84
    .line 85
    return-object p0
    .line 86
    .line 87
    .line 88
    .line 89
    .line 90
    .line 91
    .line 92
    .line 93
    .line 94
    .line 95
    .line 96
    .line 97
    .line 98
    .line 99
    .line 100
    .line 101
    .line 102
    .line 103
    .line 104
    .line 105
    .line 106
    .line 107
    .line 108
    .line 109
    .line 110
    .line 111
    .line 112
    .line 113
    .line 114
    .line 115
    .line 116
    .line 117
    .line 118
    .line 119
    .line 120
    .line 121
    .line 122
    .line 123
    .line 124
    .line 125
    .line 126
    .line 127
    .line 128
    .line 129
    .line 130
    .line 131
    .line 132
    .line 133
    .line 134
    .line 135
    .line 136
    .line 137
    .line 138
    .line 139
    .line 140
    .line 141
    .line 142
    .line 143
    .line 144
    .line 145
    .line 146
    .line 147
    .line 148
    .line 149
    .line 150
    .line 151
    .line 152
    .line 153
    .line 154
    .line 155
    .line 156
    .line 157
    .line 158
    .line 159
    .line 160
    .line 161
    .line 162
    .line 163
    .line 164
    .line 165
    .line 166
    .line 167
    .line 168
    .line 169
    .line 170
    .line 171
    .line 172
    .line 173
    .line 174
    .line 175
    .line 176
    .line 177
    .line 178
    .line 179
    .line 180
    .line 181
    .line 182
    .line 183
    .line 184
    .line 185
    .line 186
    .line 187
    .line 188
    .line 189
    .line 190
    .line 191
    .line 192
    .line 193
    .line 194
    .line 195
    .line 196
    .line 197
    .line 198
    .line 199
    .line 200
    .line 201
    .line 202
    .line 203
    .line 204
    .line 205
    .line 206
    .line 207
    .line 208
    .line 209
    .line 210
    .line 211
    .line 212
    .line 213
    .line 214
    .line 215
    .line 216
    .line 217
    .line 218
    .line 219
    .line 220
    .line 221
    .line 222
    .line 223
    .line 224
    .line 225
    .line 226
    .line 227
    .line 228
    .line 229
    .line 230
    .line 231
    .line 232
    .line 233
    .line 234
    .line 235
    .line 236
    .line 237
    .line 238
    .line 239
    .line 240
    .line 241
    .line 242
    .line 243
    .line 244
    .line 245
    .line 246
    .line 247
    .line 248
    .line 249
    .line 250
    .line 251
    .line 252
    .line 253
    .line 254
    .line 255
    .line 256
    .line 257
    .line 258
    .line 259
    .line 260
    .line 261
    .line 262
    .line 263
    .line 264
    .line 265
    .line 266
    .line 267
    .line 268
    .line 269
    .line 270
    .line 271
    .line 272
    .line 273
    .line 274
    .line 275
    .line 276
    .line 277
    .line 278
    .line 279
    .line 280
    .line 281
    .line 282
    .line 283
    .line 284
    .line 285
    .line 286
    .line 287
    .line 288
    .line 289
    .line 290
    .line 291
    .line 292
    .line 293
    .line 294
    .line 295
    .line 296
    .line 297
    .line 298
    .line 299
    .line 300
    .line 301
    .line 302
    .line 303
    .line 304
    .line 305
    .line 306
    .line 307
    .line 308
    .line 309
    .line 310
    .line 311
    .line 312
    .line 313
    .line 314
    .line 315
    .line 316
    .line 317
    .line 318
    .line 319
    .line 320
    .line 321
    .line 322
    .line 323
    .line 324
    .line 325
    .line 326
    .line 327
    .line 328
    .line 329
    .line 330
    .line 331
    .line 332
    .line 333
    .line 334
    .line 335
    .line 336
    .line 337
    .line 338
    .line 339
    .line 340
    .line 341
    .line 342
    .line 343
    .line 344
    .line 345
    .line 346
    .line 347
    .line 348
    .line 349
    .line 350
    .line 351
    .line 352
    .line 353
    .line 354
    .line 355
    .line 356
    .line 357
    .line 358
    .line 359
    .line 360
    .line 361
    .line 362
    .line 363
    .line 364
    .line 365
    .line 366
    .line 367
    .line 368
    .line 369
    .line 370
    .line 371
    .line 372
    .line 373
    .line 374
    .line 375
    .line 376
    .line 377
    .line 378
    .line 379
    .line 380
    .line 381
    .line 382
    .line 383
    .line 384
    .line 385
    .line 386
    .line 387
    .line 388
    .line 389
    .line 390
    .line 391
    .line 392
    .line 393
    .line 394
    .line 395
    .line 396
    .line 397
    .line 398
    .line 399
    .line 400
    .line 401
    .line 402
    .line 403
    .line 404
    .line 405
    .line 406
    .line 407
    .line 408
    .line 409
    .line 410
    .line 411
    .line 412
    .line 413
    .line 414
    .line 415
    .line 416
    .line 417
    .line 418
    .line 419
    .line 420
    .line 421
    .line 422
    .line 423
    .line 424
    .line 425
    .line 426
    .line 427
    .line 428
    .line 429
    .line 430
    .line 431
    .line 432
    .line 433
    .line 434
    .line 435
    .line 436
    .line 437
    .line 438
    .line 439
    .line 440
    .line 441
    .line 442
    .line 443
    .line 444
    .line 445
    .line 446
    .line 447
    .line 448
    .line 449
    .line 450
    .line 451
    .line 452
    .line 453
    .line 454
    .line 455
    .line 456
    .line 457
    .line 458
    .line 459
    .line 460
    .line 461
    .line 462
    .line 463
    .line 464
    .line 465
    .line 466
    .line 467
    .line 468
    .line 469
    .line 470
    .line 471
    .line 472
    .line 473
    .line 474
    .line 475
    .line 476
    .line 477
    .line 478
    .line 479
    .line 480
    .line 481
    .line 482
    .line 483
    .line 484
    .line 485
    .line 486
    .line 487
    .line 488
    .line 489
    .line 490
    .line 491
    .line 492
    .line 493
    .line 494
    .line 495
    .line 496
    .line 497
    .line 498
    .line 499
    .line 500
    .line 501
    .line 502
    .line 503
    .line 504
    .line 505
    .line 506
    .line 507
    .line 508
    .line 509
    .line 510
    .line 511
    .line 512
    .line 513
    .line 514
    .line 515
    .line 516
    .line 517
    .line 518
    .line 519
    .line 520
    .line 521
    .line 522
    .line 523
    .line 524
    .line 525
    .line 526
    .line 527
    .line 528
    .line 529
    .line 530
    .line 531
    .line 532
    .line 533
    .line 534
    .line 535
    .line 536
    .line 537
    .line 538
    .line 539
    .line 540
    .line 541
    .line 542
    .line 543
    .line 544
    .line 545
    .line 546
    .line 547
    .line 548
    .line 549
    .line 550
    .line 551
    .line 552
    .line 553
    .line 554
    .line 555
    .line 556
    .line 557
    .line 558
    .line 559
    .line 560
    .line 561
    .line 562
    .line 563
    .line 564
    .line 565
    .line 566
    .line 567
    .line 568
    .line 569
    .line 570
    .line 571
    .line 572
    .line 573
    .line 574
    .line 575
    .line 576
    .line 577
    .line 578
    .line 579
    .line 580
    .line 581
    .line 582
    .line 583
    .line 584
    .line 585
    .line 586
    .line 587
    .line 588
    .line 589
    .line 590
    .line 591
    .line 592
    .line 593
    .line 594
    .line 595
    .line 596
    .line 597
    .line 598
    .line 599
    .line 600
    .line 601
    .line 602
    .line 603
    .line 604
    .line 605
    .line 606
    .line 607
    .line 608
    .line 609
    .line 610
    .line 611
    .line 612
    .line 613
    .line 614
    .line 615
    .line 616
    .line 617
    .line 618
    .line 619
    .line 620
    .line 621
    .line 622
    .line 623
    .line 624
    .line 625
    .line 626
    .line 627
    .line 628
    .line 629
    .line 630
    .line 631
    .line 632
    .line 633
    .line 634
    .line 635
    .line 636
    .line 637
    .line 638
    .line 639
    .line 640
    .line 641
    .line 642
    .line 643
    .line 644
    .line 645
    .line 646
    .line 647
    .line 648
    .line 649
    .line 650
    .line 651
    .line 652
    .line 653
    .line 654
    .line 655
    .line 656
    .line 657
    .line 658
    .line 659
.end method

.method public static g()I
    .registers 6

    .line 1
    sget-object v0, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    .line 2
    .line 3
    const-string v1, "/"

    .line 4
    .line 5
    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    const/4 v1, 0x0

    .line 10
    aget-object v0, v0, v1

    .line 11
    .line 12
    const-string v2, "\\."

    .line 13
    .line 14
    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    .line 15
    .line 16
    .line 17
    move-result-object v0

    .line 18
    const/16 v2, 0x10

    .line 19
    .line 20
    :try_start_13
    array-length v3, v0

    .line 21
    if-lez v3, :cond_1f

    .line 22
    .line 23
    aget-object v3, v0, v1

    .line 24
    .line 25
    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 26
    .line 27
    .line 28
    move-result v2

    .line 29
    goto :goto_1f

    .line 30
    :catch_1d
    move v3, v1

    .line 31
    goto :goto_35

    .line 32
    :cond_1f
    :goto_1f
    array-length v3, v0

    .line 33
    const/4 v4, 0x1

    .line 34
    if-le v3, v4, :cond_2a

    .line 35
    .line 36
    aget-object v3, v0, v4

    .line 37
    .line 38
    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 39
    .line 40
    .line 41
    move-result v3
    :try_end_29
    .catch Ljava/lang/NumberFormatException; {:try_start_13 .. :try_end_29} :catch_1d

    .line 42
    goto :goto_2b

    .line 43
    :cond_2a
    move v3, v1

    .line 44
    :goto_2b
    :try_start_2b
    array-length v4, v0

    .line 45
    const/4 v5, 0x2

    .line 46
    if-le v4, v5, :cond_35

    .line 47
    .line 48
    aget-object v0, v0, v5

    .line 49
    .line 50
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 51
    .line 52
    .line 53
    move-result v1
    :try_end_35
    .catch Ljava/lang/NumberFormatException; {:try_start_2b .. :try_end_35} :catch_35

    .line 54
    :catch_35
    :cond_35
    :goto_35
    mul-int/lit16 v2, v2, 0x2710

    .line 55
    .line 56
    mul-int/lit8 v3, v3, 0x64

    .line 57
    .line 58
    add-int/2addr v3, v2

    .line 59
    add-int/2addr v3, v1

    .line 60
    return v3
    .line 61
    .line 62
    .line 63
    .line 64
    .line 65
    .line 66
    .line 67
    .line 68
    .line 69
    .line 70
    .line 71
    .line 72
    .line 73
    .line 74
    .line 75
    .line 76
    .line 77
    .line 78
    .line 79
    .line 80
    .line 81
    .line 82
    .line 83
    .line 84
    .line 85
    .line 86
    .line 87
    .line 88
    .line 89
    .line 90
    .line 91
    .line 92
    .line 93
    .line 94
    .line 95
    .line 96
    .line 97
    .line 98
    .line 99
    .line 100
    .line 101
    .line 102
    .line 103
    .line 104
    .line 105
    .line 106
    .line 107
    .line 108
    .line 109
    .line 110
    .line 111
    .line 112
    .line 113
    .line 114
    .line 115
    .line 116
    .line 117
    .line 118
    .line 119
    .line 120
    .line 121
    .line 122
    .line 123
    .line 124
    .line 125
    .line 126
    .line 127
    .line 128
    .line 129
    .line 130
    .line 131
    .line 132
    .line 133
    .line 134
    .line 135
    .line 136
    .line 137
    .line 138
    .line 139
    .line 140
    .line 141
    .line 142
    .line 143
    .line 144
    .line 145
    .line 146
    .line 147
    .line 148
    .line 149
    .line 150
    .line 151
    .line 152
    .line 153
    .line 154
    .line 155
    .line 156
    .line 157
    .line 158
    .line 159
    .line 160
    .line 161
    .line 162
    .line 163
    .line 164
    .line 165
    .line 166
    .line 167
    .line 168
    .line 169
    .line 170
    .line 171
    .line 172
.end method
