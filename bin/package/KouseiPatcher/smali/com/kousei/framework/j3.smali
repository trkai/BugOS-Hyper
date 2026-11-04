.class public abstract Lcom/kousei/framework/j3;
.super Ljava/lang/Object;
.source "r8-map-id-ab9d9a36b7cfe29bbfb78ee9a77c1feaf549e881397fc2be336a306d7a6faedf"


# static fields
.field public static final a:Lcom/kousei/framework/v;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 1
    const-wide v0, -0x5479df5b40d7L

    .line 2
    .line 3
    .line 4
    .line 5
    .line 6
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 7
    .line 8
    .line 9
    new-instance v0, Lcom/kousei/framework/v;

    .line 10
    .line 11
    const-wide v1, -0x545ddf5b40d7L

    .line 12
    .line 13
    .line 14
    .line 15
    .line 16
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 17
    .line 18
    .line 19
    move-result-object v1

    .line 20
    invoke-direct {v0, v1}, Lcom/kousei/framework/v;-><init>(Ljava/lang/String;)V

    .line 21
    .line 22
    .line 23
    sput-object v0, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 24
    .line 25
    return-void
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

.method public static a(Lcom/kousei/framework/i3;II)Lcom/kousei/framework/a8;
    .registers 21

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move/from16 v1, p1

    .line 4
    .line 5
    :try_start_4
    sget-object v2, Lcom/kousei/framework/o0;->a:[B

    .line 6
    .line 7
    if-nez v2, :cond_16

    .line 8
    .line 9
    const/16 v2, 0x20

    .line 10
    .line 11
    new-array v2, v2, [B

    .line 12
    .line 13
    new-instance v3, Ljava/security/SecureRandom;

    .line 14
    .line 15
    invoke-direct {v3}, Ljava/security/SecureRandom;-><init>()V

    .line 16
    .line 17
    .line 18
    invoke-virtual {v3, v2}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 19
    .line 20
    .line 21
    sput-object v2, Lcom/kousei/framework/o0;->a:[B

    .line 22
    .line 23
    :cond_16
    sget-object v2, Lcom/kousei/framework/o0;->a:[B

    .line 24
    .line 25
    invoke-static {}, Lcom/kousei/framework/o0;->d()[B

    .line 26
    .line 27
    .line 28
    move-result-object v3

    .line 29
    new-instance v4, Lcom/kousei/framework/o4;

    .line 30
    .line 31
    invoke-direct {v4, v2}, Lcom/kousei/framework/w;-><init>([B)V

    .line 32
    .line 33
    .line 34
    new-instance v2, Lcom/kousei/framework/m;

    .line 35
    .line 36
    const/4 v5, 0x0

    .line 37
    invoke-direct {v2, v5}, Lcom/kousei/framework/m;-><init>(I)V

    .line 38
    .line 39
    .line 40
    new-instance v6, Lcom/kousei/framework/o4;

    .line 41
    .line 42
    invoke-direct {v6, v3}, Lcom/kousei/framework/w;-><init>([B)V

    .line 43
    .line 44
    .line 45
    const/4 v3, 0x4

    .line 46
    new-array v7, v3, [Lcom/kousei/framework/k;

    .line 47
    .line 48
    aput-object v4, v7, v5

    .line 49
    .line 50
    sget-object v4, Lcom/kousei/framework/i;->M:Lcom/kousei/framework/i;

    .line 51
    .line 52
    const/4 v8, 0x1

    .line 53
    aput-object v4, v7, v8

    .line 54
    .line 55
    const/4 v4, 0x2

    .line 56
    aput-object v2, v7, v4

    .line 57
    .line 58
    const/4 v2, 0x3

    .line 59
    aput-object v6, v7, v2

    .line 60
    .line 61
    new-instance v6, Lcom/kousei/framework/r4;

    .line 62
    .line 63
    invoke-direct {v6, v7, v5}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 64
    .line 65
    .line 66
    new-instance v7, Lcom/kousei/framework/l;

    .line 67
    .line 68
    invoke-direct {v7}, Lcom/kousei/framework/l;-><init>()V

    .line 69
    .line 70
    .line 71
    iget-object v9, v0, Lcom/kousei/framework/i3;->j:Ljava/util/ArrayList;

    .line 72
    .line 73
    iget-object v10, v0, Lcom/kousei/framework/i3;->k:Ljava/util/ArrayList;

    .line 74
    .line 75
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    .line 76
    .line 77
    .line 78
    move-result v11

    .line 79
    new-array v11, v11, [Lcom/kousei/framework/q;

    .line 80
    .line 81
    move v12, v5

    .line 82
    :goto_51
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    .line 83
    .line 84
    .line 85
    move-result v13

    .line 86
    if-ge v12, v13, :cond_6b

    .line 87
    .line 88
    new-instance v13, Lcom/kousei/framework/q;

    .line 89
    .line 90
    invoke-virtual {v9, v12}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 91
    .line 92
    .line 93
    move-result-object v14

    .line 94
    check-cast v14, Ljava/lang/Integer;

    .line 95
    .line 96
    invoke-virtual {v14}, Ljava/lang/Integer;->intValue()I

    .line 97
    .line 98
    .line 99
    move-result v14

    .line 100
    invoke-direct {v13, v14}, Lcom/kousei/framework/q;-><init>(I)V

    .line 101
    .line 102
    .line 103
    aput-object v13, v11, v12

    .line 104
    .line 105
    add-int/lit8 v12, v12, 0x1

    .line 106
    .line 107
    goto :goto_51

    .line 108
    :cond_6b
    new-instance v9, Lcom/kousei/framework/k2;

    .line 109
    .line 110
    new-instance v12, Lcom/kousei/framework/s4;

    .line 111
    .line 112
    invoke-direct {v12, v11, v5}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 113
    .line 114
    .line 115
    invoke-direct {v9, v8, v8, v12, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 116
    .line 117
    .line 118
    invoke-virtual {v7, v9}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 119
    .line 120
    .line 121
    new-instance v9, Lcom/kousei/framework/k2;

    .line 122
    .line 123
    new-instance v11, Lcom/kousei/framework/q;

    .line 124
    .line 125
    iget v12, v0, Lcom/kousei/framework/i3;->b:I

    .line 126
    .line 127
    invoke-direct {v11, v12}, Lcom/kousei/framework/q;-><init>(I)V

    .line 128
    .line 129
    .line 130
    invoke-direct {v9, v8, v4, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 131
    .line 132
    .line 133
    invoke-virtual {v7, v9}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 134
    .line 135
    .line 136
    new-instance v9, Lcom/kousei/framework/k2;

    .line 137
    .line 138
    new-instance v11, Lcom/kousei/framework/q;

    .line 139
    .line 140
    iget v12, v0, Lcom/kousei/framework/i3;->a:I

    .line 141
    .line 142
    invoke-direct {v11, v12}, Lcom/kousei/framework/q;-><init>(I)V

    .line 143
    .line 144
    .line 145
    invoke-direct {v9, v8, v2, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 146
    .line 147
    .line 148
    invoke-virtual {v7, v9}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 149
    .line 150
    .line 151
    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    .line 152
    .line 153
    .line 154
    move-result v9

    .line 155
    new-array v9, v9, [Lcom/kousei/framework/q;

    .line 156
    .line 157
    move v11, v5

    .line 158
    :goto_9d
    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    .line 159
    .line 160
    .line 161
    move-result v12

    .line 162
    if-ge v11, v12, :cond_b7

    .line 163
    .line 164
    new-instance v12, Lcom/kousei/framework/q;

    .line 165
    .line 166
    invoke-virtual {v10, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 167
    .line 168
    .line 169
    move-result-object v13

    .line 170
    check-cast v13, Ljava/lang/Integer;

    .line 171
    .line 172
    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    .line 173
    .line 174
    .line 175
    move-result v13

    .line 176
    invoke-direct {v12, v13}, Lcom/kousei/framework/q;-><init>(I)V

    .line 177
    .line 178
    .line 179
    aput-object v12, v9, v11

    .line 180
    .line 181
    add-int/lit8 v11, v11, 0x1

    .line 182
    .line 183
    goto :goto_9d

    .line 184
    :cond_b7
    new-instance v10, Lcom/kousei/framework/k2;

    .line 185
    .line 186
    new-instance v11, Lcom/kousei/framework/s4;

    .line 187
    .line 188
    invoke-direct {v11, v9, v5}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 189
    .line 190
    .line 191
    const/4 v9, 0x5

    .line 192
    invoke-direct {v10, v8, v9, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 193
    .line 194
    .line 195
    invoke-virtual {v7, v10}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 196
    .line 197
    .line 198
    iget v10, v0, Lcom/kousei/framework/i3;->b:I

    .line 199
    .line 200
    if-ne v10, v2, :cond_da

    .line 201
    .line 202
    new-instance v10, Lcom/kousei/framework/k2;

    .line 203
    .line 204
    new-instance v11, Lcom/kousei/framework/q;

    .line 205
    .line 206
    iget v12, v0, Lcom/kousei/framework/i3;->h:I

    .line 207
    .line 208
    invoke-direct {v11, v12}, Lcom/kousei/framework/q;-><init>(I)V

    .line 209
    .line 210
    .line 211
    const/16 v12, 0xa

    .line 212
    .line 213
    invoke-direct {v10, v8, v12, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 214
    .line 215
    .line 216
    invoke-virtual {v7, v10}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 217
    .line 218
    .line 219
    :cond_da
    new-instance v10, Lcom/kousei/framework/k2;

    .line 220
    .line 221
    sget-object v11, Lcom/kousei/framework/m4;->K:Lcom/kousei/framework/m4;

    .line 222
    .line 223
    const/16 v12, 0x1f7

    .line 224
    .line 225
    invoke-direct {v10, v8, v12, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 226
    .line 227
    .line 228
    invoke-virtual {v7, v10}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 229
    .line 230
    .line 231
    new-instance v10, Lcom/kousei/framework/k2;

    .line 232
    .line 233
    new-instance v11, Lcom/kousei/framework/q;

    .line 234
    .line 235
    invoke-direct {v11, v5}, Lcom/kousei/framework/q;-><init>(I)V

    .line 236
    .line 237
    .line 238
    const/16 v12, 0x2be

    .line 239
    .line 240
    invoke-direct {v10, v8, v12, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 241
    .line 242
    .line 243
    invoke-virtual {v7, v10}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 244
    .line 245
    .line 246
    new-instance v10, Lcom/kousei/framework/k2;

    .line 247
    .line 248
    const/16 v11, 0x2c0

    .line 249
    .line 250
    invoke-direct {v10, v8, v11, v6, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 251
    .line 252
    .line 253
    invoke-virtual {v7, v10}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 254
    .line 255
    .line 256
    new-instance v6, Lcom/kousei/framework/k2;

    .line 257
    .line 258
    new-instance v10, Lcom/kousei/framework/q;

    .line 259
    .line 260
    sget v11, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 261
    .line 262
    packed-switch v11, :pswitch_data_302

    .line 263
    .line 264
    .line 265
    const v11, 0x27100

    .line 266
    .line 267
    .line 268
    goto :goto_11b

    .line 269
    :pswitch_10c
    const v11, 0x249f0

    .line 270
    .line 271
    .line 272
    goto :goto_11b

    .line 273
    :pswitch_110
    const v11, 0x222e0

    .line 274
    .line 275
    .line 276
    goto :goto_11b

    .line 277
    :pswitch_114
    const v11, 0x1fbd0

    .line 278
    .line 279
    .line 280
    goto :goto_11b

    .line 281
    :pswitch_118
    const v11, 0x1d524

    .line 282
    .line 283
    .line 284
    :goto_11b
    invoke-direct {v10, v11}, Lcom/kousei/framework/q;-><init>(I)V

    .line 285
    .line 286
    .line 287
    const/16 v11, 0x2c1

    .line 288
    .line 289
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 290
    .line 291
    .line 292
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 293
    .line 294
    .line 295
    new-instance v6, Lcom/kousei/framework/k2;

    .line 296
    .line 297
    new-instance v10, Lcom/kousei/framework/q;

    .line 298
    .line 299
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 300
    .line 301
    .line 302
    move-result-object v11

    .line 303
    iget-object v11, v11, Lcom/kousei/framework/gi;->f:Lcom/kousei/framework/k3;

    .line 304
    .line 305
    if-eqz v11, :cond_143

    .line 306
    .line 307
    iget-object v11, v11, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 308
    .line 309
    check-cast v11, Ljava/lang/String;

    .line 310
    .line 311
    if-eqz v11, :cond_143

    .line 312
    .line 313
    invoke-static {v11, v5}, Lcom/kousei/framework/o0;->g(Ljava/lang/String;Z)Ljava/lang/Integer;

    .line 314
    .line 315
    .line 316
    move-result-object v11

    .line 317
    if-eqz v11, :cond_143

    .line 318
    .line 319
    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    .line 320
    .line 321
    .line 322
    move-result v11

    .line 323
    goto :goto_149

    .line 324
    :cond_143
    sget-object v11, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    .line 325
    .line 326
    invoke-static {v5}, Lcom/kousei/framework/o0;->b(Z)I

    .line 327
    .line 328
    .line 329
    move-result v11

    .line 330
    :goto_149
    invoke-direct {v10, v11}, Lcom/kousei/framework/q;-><init>(I)V

    .line 331
    .line 332
    .line 333
    const/16 v11, 0x2c2

    .line 334
    .line 335
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 336
    .line 337
    .line 338
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 339
    .line 340
    .line 341
    new-instance v6, Lcom/kousei/framework/k2;

    .line 342
    .line 343
    new-instance v10, Lcom/kousei/framework/q;

    .line 344
    .line 345
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 346
    .line 347
    .line 348
    move-result-object v11

    .line 349
    iget-object v11, v11, Lcom/kousei/framework/gi;->f:Lcom/kousei/framework/k3;

    .line 350
    .line 351
    if-eqz v11, :cond_171

    .line 352
    .line 353
    iget-object v11, v11, Lcom/kousei/framework/k3;->i:Ljava/lang/Object;

    .line 354
    .line 355
    check-cast v11, Ljava/lang/String;

    .line 356
    .line 357
    if-eqz v11, :cond_171

    .line 358
    .line 359
    invoke-static {v11, v8}, Lcom/kousei/framework/o0;->g(Ljava/lang/String;Z)Ljava/lang/Integer;

    .line 360
    .line 361
    .line 362
    move-result-object v11

    .line 363
    if-eqz v11, :cond_171

    .line 364
    .line 365
    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    .line 366
    .line 367
    .line 368
    move-result v11

    .line 369
    goto :goto_177

    .line 370
    :cond_171
    sget-object v11, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    .line 371
    .line 372
    invoke-static {v8}, Lcom/kousei/framework/o0;->b(Z)I

    .line 373
    .line 374
    .line 375
    move-result v11

    .line 376
    :goto_177
    invoke-direct {v10, v11}, Lcom/kousei/framework/q;-><init>(I)V

    .line 377
    .line 378
    .line 379
    const/16 v11, 0x2ce

    .line 380
    .line 381
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 382
    .line 383
    .line 384
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 385
    .line 386
    .line 387
    new-instance v6, Lcom/kousei/framework/k2;

    .line 388
    .line 389
    new-instance v10, Lcom/kousei/framework/q;

    .line 390
    .line 391
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 392
    .line 393
    .line 394
    move-result-object v11

    .line 395
    iget-object v11, v11, Lcom/kousei/framework/gi;->f:Lcom/kousei/framework/k3;

    .line 396
    .line 397
    if-eqz v11, :cond_19f

    .line 398
    .line 399
    iget-object v11, v11, Lcom/kousei/framework/k3;->h:Ljava/lang/Object;

    .line 400
    .line 401
    check-cast v11, Ljava/lang/String;

    .line 402
    .line 403
    if-eqz v11, :cond_19f

    .line 404
    .line 405
    invoke-static {v11, v8}, Lcom/kousei/framework/o0;->g(Ljava/lang/String;Z)Ljava/lang/Integer;

    .line 406
    .line 407
    .line 408
    move-result-object v11

    .line 409
    if-eqz v11, :cond_19f

    .line 410
    .line 411
    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    .line 412
    .line 413
    .line 414
    move-result v11

    .line 415
    goto :goto_1a5

    .line 416
    :cond_19f
    sget-object v11, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    .line 417
    .line 418
    invoke-static {v8}, Lcom/kousei/framework/o0;->b(Z)I

    .line 419
    .line 420
    .line 421
    move-result v11

    .line 422
    :goto_1a5
    invoke-direct {v10, v11}, Lcom/kousei/framework/q;-><init>(I)V

    .line 423
    .line 424
    .line 425
    const/16 v11, 0x2cf

    .line 426
    .line 427
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 428
    .line 429
    .line 430
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 431
    .line 432
    .line 433
    iget-object v6, v0, Lcom/kousei/framework/i3;->m:[B

    .line 434
    .line 435
    if-eqz v6, :cond_1c5

    .line 436
    .line 437
    new-instance v6, Lcom/kousei/framework/k2;

    .line 438
    .line 439
    new-instance v10, Lcom/kousei/framework/o4;

    .line 440
    .line 441
    iget-object v11, v0, Lcom/kousei/framework/i3;->m:[B

    .line 442
    .line 443
    invoke-direct {v10, v11}, Lcom/kousei/framework/w;-><init>([B)V

    .line 444
    .line 445
    .line 446
    const/16 v11, 0x2c6

    .line 447
    .line 448
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 449
    .line 450
    .line 451
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 452
    .line 453
    .line 454
    :cond_1c5
    iget-object v6, v0, Lcom/kousei/framework/i3;->n:[B

    .line 455
    .line 456
    if-eqz v6, :cond_1da

    .line 457
    .line 458
    new-instance v6, Lcom/kousei/framework/k2;

    .line 459
    .line 460
    new-instance v10, Lcom/kousei/framework/o4;

    .line 461
    .line 462
    iget-object v11, v0, Lcom/kousei/framework/i3;->n:[B

    .line 463
    .line 464
    invoke-direct {v10, v11}, Lcom/kousei/framework/w;-><init>([B)V

    .line 465
    .line 466
    .line 467
    const/16 v11, 0x2c7

    .line 468
    .line 469
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 470
    .line 471
    .line 472
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 473
    .line 474
    .line 475
    :cond_1da
    iget-object v6, v0, Lcom/kousei/framework/i3;->o:[B

    .line 476
    .line 477
    if-eqz v6, :cond_1ef

    .line 478
    .line 479
    new-instance v6, Lcom/kousei/framework/k2;

    .line 480
    .line 481
    new-instance v10, Lcom/kousei/framework/o4;

    .line 482
    .line 483
    iget-object v11, v0, Lcom/kousei/framework/i3;->o:[B

    .line 484
    .line 485
    invoke-direct {v10, v11}, Lcom/kousei/framework/w;-><init>([B)V

    .line 486
    .line 487
    .line 488
    const/16 v11, 0x2c8

    .line 489
    .line 490
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 491
    .line 492
    .line 493
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 494
    .line 495
    .line 496
    :cond_1ef
    iget-object v6, v0, Lcom/kousei/framework/i3;->p:[B

    .line 497
    .line 498
    if-eqz v6, :cond_204

    .line 499
    .line 500
    new-instance v6, Lcom/kousei/framework/k2;

    .line 501
    .line 502
    new-instance v10, Lcom/kousei/framework/o4;

    .line 503
    .line 504
    iget-object v11, v0, Lcom/kousei/framework/i3;->p:[B

    .line 505
    .line 506
    invoke-direct {v10, v11}, Lcom/kousei/framework/w;-><init>([B)V

    .line 507
    .line 508
    .line 509
    const/16 v11, 0x2cc

    .line 510
    .line 511
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 512
    .line 513
    .line 514
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 515
    .line 516
    .line 517
    :cond_204
    iget-object v6, v0, Lcom/kousei/framework/i3;->q:[B

    .line 518
    .line 519
    if-eqz v6, :cond_219

    .line 520
    .line 521
    new-instance v6, Lcom/kousei/framework/k2;

    .line 522
    .line 523
    new-instance v10, Lcom/kousei/framework/o4;

    .line 524
    .line 525
    iget-object v11, v0, Lcom/kousei/framework/i3;->q:[B

    .line 526
    .line 527
    invoke-direct {v10, v11}, Lcom/kousei/framework/w;-><init>([B)V

    .line 528
    .line 529
    .line 530
    const/16 v11, 0x2cd

    .line 531
    .line 532
    invoke-direct {v6, v8, v11, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 533
    .line 534
    .line 535
    invoke-virtual {v7, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 536
    .line 537
    .line 538
    :cond_219
    new-instance v6, Lcom/kousei/framework/l;

    .line 539
    .line 540
    invoke-direct {v6}, Lcom/kousei/framework/l;-><init>()V
    :try_end_21e
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_21e} :catch_2ea

    .line 541
    .line 542
    .line 543
    :try_start_21e
    invoke-static/range {p2 .. p2}, Lcom/kousei/framework/j3;->d(I)Lcom/kousei/framework/o4;

    .line 544
    .line 545
    .line 546
    move-result-object v10

    .line 547
    if-eqz v10, :cond_23f

    .line 548
    .line 549
    new-instance v11, Lcom/kousei/framework/k2;

    .line 550
    .line 551
    const/16 v12, 0x2c5

    .line 552
    .line 553
    invoke-direct {v11, v8, v12, v10, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 554
    .line 555
    .line 556
    invoke-virtual {v6, v11}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V
    :try_end_22e
    .catchall {:try_start_21e .. :try_end_22e} :catchall_22f

    .line 557
    .line 558
    .line 559
    goto :goto_23f

    .line 560
    :catchall_22f
    const-wide v10, -0x57cbdf5b40d7L

    .line 561
    .line 562
    .line 563
    .line 564
    .line 565
    :try_start_234
    invoke-static {v10, v11}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 566
    .line 567
    .line 568
    const-wide v10, -0x57afdf5b40d7L

    .line 569
    .line 570
    .line 571
    .line 572
    .line 573
    invoke-static {v10, v11}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 574
    .line 575
    .line 576
    :cond_23f
    :goto_23f
    new-instance v10, Lcom/kousei/framework/k2;

    .line 577
    .line 578
    new-instance v11, Lcom/kousei/framework/q;

    .line 579
    .line 580
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 581
    .line 582
    .line 583
    move-result-wide v12

    .line 584
    invoke-direct {v11, v12, v13}, Lcom/kousei/framework/q;-><init>(J)V

    .line 585
    .line 586
    .line 587
    const/16 v12, 0x2bd

    .line 588
    .line 589
    invoke-direct {v10, v8, v12, v11, v8}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 590
    .line 591
    .line 592
    invoke-virtual {v6, v10}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 593
    .line 594
    .line 595
    new-instance v10, Lcom/kousei/framework/q;

    .line 596
    .line 597
    sget v11, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 598
    .line 599
    const/16 v12, 0x64

    .line 600
    .line 601
    const/16 v13, 0xc8

    .line 602
    .line 603
    const/16 v14, 0x12c

    .line 604
    .line 605
    const/16 v15, 0x190

    .line 606
    .line 607
    packed-switch v11, :pswitch_data_30e

    .line 608
    .line 609
    .line 610
    move/from16 v16, v2

    .line 611
    .line 612
    move v2, v15

    .line 613
    goto :goto_270

    .line 614
    :pswitch_265
    move/from16 v16, v2

    .line 615
    .line 616
    move v2, v14

    .line 617
    goto :goto_270

    .line 618
    :pswitch_269
    move/from16 v16, v2

    .line 619
    .line 620
    move v2, v13

    .line 621
    goto :goto_270

    .line 622
    :pswitch_26d
    move/from16 v16, v2

    .line 623
    .line 624
    move v2, v12

    .line 625
    :goto_270
    invoke-direct {v10, v2}, Lcom/kousei/framework/q;-><init>(I)V

    .line 626
    .line 627
    .line 628
    new-instance v2, Lcom/kousei/framework/m;

    .line 629
    .line 630
    invoke-direct {v2, v1}, Lcom/kousei/framework/m;-><init>(I)V

    .line 631
    .line 632
    .line 633
    move/from16 v17, v3

    .line 634
    .line 635
    new-instance v3, Lcom/kousei/framework/q;

    .line 636
    .line 637
    packed-switch v11, :pswitch_data_31a

    .line 638
    .line 639
    .line 640
    move v12, v15

    .line 641
    goto :goto_284

    .line 642
    :pswitch_281
    move v12, v14

    .line 643
    goto :goto_284

    .line 644
    :pswitch_283
    move v12, v13

    .line 645
    :goto_284
    :pswitch_284
    invoke-direct {v3, v12}, Lcom/kousei/framework/q;-><init>(I)V

    .line 646
    .line 647
    .line 648
    new-instance v11, Lcom/kousei/framework/m;

    .line 649
    .line 650
    invoke-direct {v11, v1}, Lcom/kousei/framework/m;-><init>(I)V

    .line 651
    .line 652
    .line 653
    new-instance v1, Lcom/kousei/framework/o4;

    .line 654
    .line 655
    iget-object v0, v0, Lcom/kousei/framework/i3;->l:[B

    .line 656
    .line 657
    if-eqz v0, :cond_293

    .line 658
    .line 659
    goto :goto_295

    .line 660
    :cond_293
    new-array v0, v5, [B

    .line 661
    .line 662
    :goto_295
    invoke-direct {v1, v0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 663
    .line 664
    .line 665
    new-instance v0, Lcom/kousei/framework/o4;

    .line 666
    .line 667
    new-array v12, v5, [B

    .line 668
    .line 669
    invoke-direct {v0, v12}, Lcom/kousei/framework/w;-><init>([B)V

    .line 670
    .line 671
    .line 672
    new-instance v12, Lcom/kousei/framework/r4;

    .line 673
    .line 674
    invoke-direct {v12, v6, v5}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 675
    .line 676
    .line 677
    const/4 v6, -0x1

    .line 678
    iput v6, v12, Lcom/kousei/framework/r4;->N:I

    .line 679
    .line 680
    new-instance v13, Lcom/kousei/framework/r4;

    .line 681
    .line 682
    invoke-direct {v13, v7, v5}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 683
    .line 684
    .line 685
    iput v6, v13, Lcom/kousei/framework/r4;->N:I

    .line 686
    .line 687
    const/16 v6, 0x8

    .line 688
    .line 689
    new-array v6, v6, [Lcom/kousei/framework/k;

    .line 690
    .line 691
    aput-object v10, v6, v5

    .line 692
    .line 693
    aput-object v2, v6, v8

    .line 694
    .line 695
    aput-object v3, v6, v4

    .line 696
    .line 697
    aput-object v11, v6, v16

    .line 698
    .line 699
    aput-object v1, v6, v17

    .line 700
    .line 701
    aput-object v0, v6, v9

    .line 702
    .line 703
    const/4 v0, 0x6

    .line 704
    aput-object v12, v6, v0

    .line 705
    .line 706
    const/4 v0, 0x7

    .line 707
    aput-object v13, v6, v0

    .line 708
    .line 709
    new-instance v0, Lcom/kousei/framework/r4;

    .line 710
    .line 711
    invoke-direct {v0, v6, v5}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 712
    .line 713
    .line 714
    new-instance v1, Lcom/kousei/framework/o4;

    .line 715
    .line 716
    invoke-virtual {v0}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 717
    .line 718
    .line 719
    move-result-object v0

    .line 720
    invoke-direct {v1, v0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 721
    .line 722
    .line 723
    const-wide v2, -0x578fdf5b40d7L

    .line 724
    .line 725
    .line 726
    .line 727
    .line 728
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 729
    .line 730
    .line 731
    const-wide v2, -0x5763df5b40d7L

    .line 732
    .line 733
    .line 734
    .line 735
    .line 736
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 737
    .line 738
    .line 739
    new-instance v0, Lcom/kousei/framework/a8;

    .line 740
    .line 741
    sget-object v2, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 742
    .line 743
    invoke-direct {v0, v2, v5, v1}, Lcom/kousei/framework/a8;-><init>(Lcom/kousei/framework/v;ZLcom/kousei/framework/o4;)V
    :try_end_2e9
    .catch Ljava/lang/Exception; {:try_start_234 .. :try_end_2e9} :catch_2ea

    .line 744
    .line 745
    .line 746
    return-object v0

    .line 747
    :catch_2ea
    move-exception v0

    .line 748
    const-wide v1, -0x574adf5b40d7L

    .line 749
    .line 750
    .line 751
    .line 752
    .line 753
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 754
    .line 755
    .line 756
    move-result-object v1

    .line 757
    const-wide v2, -0x572edf5b40d7L

    .line 758
    .line 759
    .line 760
    .line 761
    .line 762
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 763
    .line 764
    .line 765
    move-result-object v2

    .line 766
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 767
    .line 768
    .line 769
    const/4 v0, 0x0

    .line 770
    return-object v0

    .line 771
    :pswitch_data_302
    .packed-switch 0x20
        :pswitch_118
        :pswitch_114
        :pswitch_110
        :pswitch_10c
    .end packed-switch

    .line 772
    .line 773
    .line 774
    .line 775
    .line 776
    .line 777
    .line 778
    .line 779
    .line 780
    .line 781
    .line 782
    .line 783
    :pswitch_data_30e
    .packed-switch 0x20
        :pswitch_26d
        :pswitch_269
        :pswitch_265
        :pswitch_265
    .end packed-switch

    .line 784
    .line 785
    .line 786
    .line 787
    .line 788
    .line 789
    .line 790
    .line 791
    .line 792
    .line 793
    .line 794
    .line 795
    :pswitch_data_31a
    .packed-switch 0x20
        :pswitch_284
        :pswitch_283
        :pswitch_281
        :pswitch_281
    .end packed-switch
    .line 796
    .line 797
    .line 798
    .line 799
    .line 800
    .line 801
    .line 802
    .line 803
    .line 804
    .line 805
    .line 806
    .line 807
    .line 808
    .line 809
    .line 810
    .line 811
    .line 812
    .line 813
    .line 814
    .line 815
    .line 816
    .line 817
    .line 818
    .line 819
    .line 820
    .line 821
    .line 822
    .line 823
    .line 824
    .line 825
    .line 826
    .line 827
    .line 828
    .line 829
    .line 830
    .line 831
    .line 832
    .line 833
    .line 834
    .line 835
    .line 836
    .line 837
    .line 838
    .line 839
    .line 840
    .line 841
    .line 842
    .line 843
    .line 844
    .line 845
    .line 846
    .line 847
    .line 848
    .line 849
    .line 850
    .line 851
    .line 852
    .line 853
    .line 854
    .line 855
    .line 856
    .line 857
    .line 858
    .line 859
    .line 860
    .line 861
    .line 862
    .line 863
    .line 864
    .line 865
    .line 866
    .line 867
    .line 868
    .line 869
    .line 870
    .line 871
    .line 872
    .line 873
    .line 874
    .line 875
    .line 876
    .line 877
    .line 878
    .line 879
    .line 880
    .line 881
    .line 882
    .line 883
    .line 884
    .line 885
    .line 886
    .line 887
    .line 888
    .line 889
    .line 890
    .line 891
    .line 892
    .line 893
    .line 894
    .line 895
    .line 896
    .line 897
    .line 898
    .line 899
    .line 900
    .line 901
    .line 902
    .line 903
    .line 904
    .line 905
    .line 906
    .line 907
    .line 908
    .line 909
    .line 910
    .line 911
    .line 912
    .line 913
    .line 914
    .line 915
    .line 916
    .line 917
    .line 918
    .line 919
    .line 920
    .line 921
    .line 922
    .line 923
    .line 924
    .line 925
    .line 926
    .line 927
    .line 928
    .line 929
    .line 930
    .line 931
    .line 932
    .line 933
    .line 934
    .line 935
    .line 936
    .line 937
    .line 938
    .line 939
    .line 940
    .line 941
    .line 942
    .line 943
    .line 944
    .line 945
    .line 946
    .line 947
    .line 948
    .line 949
    .line 950
    .line 951
    .line 952
    .line 953
    .line 954
    .line 955
    .line 956
    .line 957
    .line 958
    .line 959
    .line 960
    .line 961
    .line 962
    .line 963
    .line 964
    .line 965
    .line 966
    .line 967
    .line 968
    .line 969
    .line 970
    .line 971
    .line 972
    .line 973
    .line 974
    .line 975
    .line 976
    .line 977
    .line 978
    .line 979
    .line 980
    .line 981
    .line 982
    .line 983
    .line 984
    .line 985
    .line 986
    .line 987
    .line 988
    .line 989
    .line 990
    .line 991
    .line 992
    .line 993
    .line 994
    .line 995
    .line 996
    .line 997
    .line 998
    .line 999
    .line 1000
    .line 1001
    .line 1002
    .line 1003
    .line 1004
    .line 1005
    .line 1006
    .line 1007
    .line 1008
    .line 1009
    .line 1010
    .line 1011
    .line 1012
    .line 1013
    .line 1014
    .line 1015
    .line 1016
    .line 1017
    .line 1018
    .line 1019
    .line 1020
    .line 1021
    .line 1022
    .line 1023
    .line 1024
    .line 1025
    .line 1026
    .line 1027
    .line 1028
    .line 1029
    .line 1030
    .line 1031
    .line 1032
    .line 1033
    .line 1034
    .line 1035
    .line 1036
    .line 1037
    .line 1038
    .line 1039
    .line 1040
    .line 1041
    .line 1042
    .line 1043
    .line 1044
    .line 1045
    .line 1046
    .line 1047
    .line 1048
    .line 1049
    .line 1050
    .line 1051
    .line 1052
    .line 1053
    .line 1054
    .line 1055
    .line 1056
    .line 1057
    .line 1058
    .line 1059
    .line 1060
    .line 1061
    .line 1062
    .line 1063
    .line 1064
    .line 1065
    .line 1066
    .line 1067
    .line 1068
    .line 1069
    .line 1070
    .line 1071
    .line 1072
    .line 1073
    .line 1074
    .line 1075
    .line 1076
    .line 1077
    .line 1078
    .line 1079
    .line 1080
    .line 1081
    .line 1082
    .line 1083
    .line 1084
    .line 1085
    .line 1086
    .line 1087
    .line 1088
    .line 1089
    .line 1090
    .line 1091
    .line 1092
    .line 1093
    .line 1094
    .line 1095
    .line 1096
    .line 1097
    .line 1098
    .line 1099
    .line 1100
    .line 1101
    .line 1102
    .line 1103
    .line 1104
    .line 1105
    .line 1106
    .line 1107
    .line 1108
    .line 1109
    .line 1110
    .line 1111
    .line 1112
    .line 1113
    .line 1114
    .line 1115
    .line 1116
    .line 1117
    .line 1118
    .line 1119
    .line 1120
    .line 1121
    .line 1122
    .line 1123
    .line 1124
    .line 1125
    .line 1126
    .line 1127
    .line 1128
    .line 1129
    .line 1130
    .line 1131
    .line 1132
    .line 1133
    .line 1134
    .line 1135
    .line 1136
    .line 1137
    .line 1138
    .line 1139
    .line 1140
    .line 1141
    .line 1142
    .line 1143
    .line 1144
    .line 1145
    .line 1146
    .line 1147
    .line 1148
    .line 1149
    .line 1150
    .line 1151
    .line 1152
    .line 1153
    .line 1154
    .line 1155
    .line 1156
    .line 1157
    .line 1158
    .line 1159
    .line 1160
    .line 1161
    .line 1162
    .line 1163
    .line 1164
    .line 1165
    .line 1166
    .line 1167
    .line 1168
    .line 1169
    .line 1170
    .line 1171
    .line 1172
    .line 1173
    .line 1174
    .line 1175
    .line 1176
    .line 1177
    .line 1178
    .line 1179
    .line 1180
    .line 1181
    .line 1182
    .line 1183
    .line 1184
    .line 1185
    .line 1186
    .line 1187
    .line 1188
    .line 1189
    .line 1190
    .line 1191
    .line 1192
    .line 1193
    .line 1194
    .line 1195
    .line 1196
    .line 1197
    .line 1198
    .line 1199
    .line 1200
    .line 1201
    .line 1202
    .line 1203
    .line 1204
    .line 1205
    .line 1206
    .line 1207
    .line 1208
    .line 1209
    .line 1210
    .line 1211
    .line 1212
    .line 1213
    .line 1214
    .line 1215
    .line 1216
    .line 1217
    .line 1218
    .line 1219
    .line 1220
    .line 1221
    .line 1222
    .line 1223
    .line 1224
    .line 1225
    .line 1226
    .line 1227
    .line 1228
    .line 1229
    .line 1230
    .line 1231
    .line 1232
    .line 1233
    .line 1234
    .line 1235
    .line 1236
    .line 1237
    .line 1238
    .line 1239
    .line 1240
    .line 1241
    .line 1242
    .line 1243
    .line 1244
    .line 1245
    .line 1246
    .line 1247
    .line 1248
    .line 1249
    .line 1250
    .line 1251
    .line 1252
    .line 1253
    .line 1254
    .line 1255
    .line 1256
    .line 1257
    .line 1258
    .line 1259
    .line 1260
    .line 1261
    .line 1262
    .line 1263
    .line 1264
    .line 1265
    .line 1266
    .line 1267
    .line 1268
    .line 1269
    .line 1270
    .line 1271
    .line 1272
    .line 1273
    .line 1274
    .line 1275
    .line 1276
    .line 1277
    .line 1278
    .line 1279
    .line 1280
    .line 1281
    .line 1282
    .line 1283
    .line 1284
    .line 1285
    .line 1286
    .line 1287
    .line 1288
    .line 1289
    .line 1290
    .line 1291
    .line 1292
    .line 1293
    .line 1294
    .line 1295
    .line 1296
    .line 1297
    .line 1298
    .line 1299
    .line 1300
    .line 1301
    .line 1302
    .line 1303
    .line 1304
    .line 1305
    .line 1306
    .line 1307
    .line 1308
    .line 1309
    .line 1310
    .line 1311
    .line 1312
    .line 1313
    .line 1314
    .line 1315
    .line 1316
    .line 1317
    .line 1318
    .line 1319
    .line 1320
    .line 1321
    .line 1322
    .line 1323
    .line 1324
    .line 1325
    .line 1326
    .line 1327
    .line 1328
    .line 1329
    .line 1330
    .line 1331
    .line 1332
    .line 1333
    .line 1334
    .line 1335
    .line 1336
    .line 1337
    .line 1338
    .line 1339
    .line 1340
    .line 1341
    .line 1342
    .line 1343
    .line 1344
    .line 1345
    .line 1346
    .line 1347
    .line 1348
    .line 1349
    .line 1350
    .line 1351
    .line 1352
    .line 1353
    .line 1354
    .line 1355
    .line 1356
    .line 1357
    .line 1358
    .line 1359
    .line 1360
    .line 1361
    .line 1362
    .line 1363
    .line 1364
    .line 1365
    .line 1366
    .line 1367
    .line 1368
    .line 1369
    .line 1370
    .line 1371
    .line 1372
    .line 1373
    .line 1374
    .line 1375
    .line 1376
    .line 1377
    .line 1378
    .line 1379
    .line 1380
.end method

.method public static b(Ljava/security/KeyPair;Lcom/kousei/framework/ca;Lcom/kousei/framework/i3;Lcom/kousei/framework/wi;II)Ljava/security/cert/X509Certificate;
    .registers 14

    .line 1
    iget-object v0, p2, Lcom/kousei/framework/i3;->c:Ljava/math/BigInteger;

    if-eqz v0, :cond_6

    :goto_4
    move-object v3, v0

    goto :goto_9

    .line 2
    :cond_6
    sget-object v0, Ljava/math/BigInteger;->ONE:Ljava/math/BigInteger;

    goto :goto_4

    .line 3
    :goto_9
    iget-object v0, p2, Lcom/kousei/framework/i3;->d:Ljava/util/Date;

    if-eqz v0, :cond_f

    :goto_d
    move-object v4, v0

    goto :goto_15

    .line 4
    :cond_f
    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    goto :goto_d

    .line 5
    :goto_15
    iget-object v0, p2, Lcom/kousei/framework/i3;->e:Ljava/util/Date;

    if-eqz v0, :cond_1b

    :goto_19
    move-object v5, v0

    goto :goto_29

    .line 6
    :cond_1b
    iget-object v0, p1, Lcom/kousei/framework/ca;->b:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/security/cert/X509Certificate;

    invoke-virtual {v0}, Ljava/security/cert/X509Certificate;->getNotAfter()Ljava/util/Date;

    move-result-object v0

    goto :goto_19

    .line 7
    :goto_29
    iget-object v0, p2, Lcom/kousei/framework/i3;->f:Ljavax/security/auth/x500/X500Principal;

    if-eqz v0, :cond_37

    .line 8
    invoke-virtual {v0}, Ljavax/security/auth/x500/X500Principal;->getEncoded()[B

    move-result-object v0

    invoke-static {v0}, Lcom/kousei/framework/wi;->h(Ljava/lang/Object;)Lcom/kousei/framework/wi;

    move-result-object v0

    :goto_35
    move-object v6, v0

    goto :goto_46

    :cond_37
    new-instance v0, Lcom/kousei/framework/wi;

    const-wide v1, -0x4bb9df5b40d7L

    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/kousei/framework/wi;-><init>(Ljava/lang/String;)V

    goto :goto_35

    .line 9
    :goto_46
    invoke-virtual {p0}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    move-result-object p0

    invoke-interface {p0}, Ljava/security/Key;->getEncoded()[B

    move-result-object p0

    .line 10
    invoke-static {p0}, Lcom/kousei/framework/xh;->h(Ljava/lang/Object;)Lcom/kousei/framework/xh;

    move-result-object v7

    const-wide v0, -0x4b91df5b40d7L

    .line 11
    :try_start_57
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide v0, -0x4b75df5b40d7L

    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 12
    new-instance v1, Lcom/kousei/framework/m8;

    move-object v2, p3

    invoke-direct/range {v1 .. v7}, Lcom/kousei/framework/m8;-><init>(Lcom/kousei/framework/wi;Ljava/math/BigInteger;Ljava/util/Date;Ljava/util/Date;Lcom/kousei/framework/wi;Lcom/kousei/framework/xh;)V

    const-wide v2, -0x4b50df5b40d7L

    .line 13
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide v2, -0x4b34df5b40d7L

    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 14
    sget-object p0, Lcom/kousei/framework/a8;->O:Lcom/kousei/framework/v;

    new-instance p3, Lcom/kousei/framework/ha;

    invoke-direct {p3}, Lcom/kousei/framework/ha;-><init>()V

    invoke-virtual {v1, p0, p3}, Lcom/kousei/framework/m8;->b(Lcom/kousei/framework/v;Lcom/kousei/framework/ha;)V

    const-wide v2, -0x4b17df5b40d7L

    .line 15
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide v2, -0x48ebdf5b40d7L

    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 16
    invoke-static {p2, p4, p5}, Lcom/kousei/framework/j3;->a(Lcom/kousei/framework/i3;II)Lcom/kousei/framework/a8;

    move-result-object p0

    if-eqz p0, :cond_b0

    .line 17
    iget-object p2, v1, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    check-cast p2, Lcom/kousei/framework/c8;

    invoke-virtual {p2, p0}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    const-wide p2, -0x48cedf5b40d7L

    .line 18
    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p2, -0x48a2df5b40d7L

    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    goto :goto_c0

    :cond_b0
    const-wide p2, -0x488edf5b40d7L

    .line 19
    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p2, -0x4862df5b40d7L

    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 20
    :goto_c0
    iget-object p0, p1, Lcom/kousei/framework/ca;->a:Ljava/security/KeyPair;

    invoke-virtual {p0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object p0

    .line 21
    invoke-static {p0}, Lcom/kousei/framework/j3;->h(Ljava/security/PrivateKey;)Ljava/lang/String;

    move-result-object p1

    const-wide p2, -0x4829df5b40d7L

    .line 22
    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p2, -0x480ddf5b40d7L

    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p2, -0x49ecdf5b40d7L

    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p2, -0x49c3df5b40d7L

    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 23
    new-instance p2, Lcom/kousei/framework/u9;

    invoke-direct {p2, p1}, Lcom/kousei/framework/u9;-><init>(Ljava/lang/String;)V
    :try_end_ef
    .catch Ljava/lang/Exception; {:try_start_57 .. :try_end_ef} :catch_16c

    .line 24
    :try_start_ef
    invoke-static {p0}, Lcom/kousei/framework/j3;->g(Ljava/security/PrivateKey;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object p1

    .line 25
    new-instance p3, Ljava/security/spec/PKCS8EncodedKeySpec;

    invoke-interface {p0}, Ljava/security/Key;->getEncoded()[B

    move-result-object p4

    invoke-direct {p3, p4}, Ljava/security/spec/PKCS8EncodedKeySpec;-><init>([B)V

    invoke-virtual {p1, p3}, Ljava/security/KeyFactory;->generatePrivate(Ljava/security/spec/KeySpec;)Ljava/security/PrivateKey;

    move-result-object p0

    const-wide p3, -0x49c1df5b40d7L

    .line 26
    invoke-static {p3, p4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p3, -0x49a5df5b40d7L

    invoke-static {p3, p4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;
    :try_end_114
    .catch Ljava/lang/Exception; {:try_start_ef .. :try_end_114} :catch_115

    goto :goto_125

    :catch_115
    const-wide p3, -0x499cdf5b40d7L

    .line 27
    :try_start_11a
    invoke-static {p3, p4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p3, -0x4970df5b40d7L

    invoke-static {p3, p4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 28
    :goto_125
    invoke-virtual {p2, p0}, Lcom/kousei/framework/u9;->a(Ljava/security/PrivateKey;)Lcom/kousei/framework/k3;

    move-result-object p0

    const-wide p1, -0x4922df5b40d7L

    .line 29
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p1, -0x4906df5b40d7L

    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 30
    invoke-virtual {v1, p0}, Lcom/kousei/framework/m8;->c(Lcom/kousei/framework/k3;)Lcom/kousei/framework/yi;

    move-result-object p0

    const-wide p1, -0x491fdf5b40d7L

    .line 31
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object p1

    .line 32
    new-instance p2, Ljava/io/ByteArrayInputStream;

    .line 33
    iget-object p0, p0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    invoke-virtual {p0}, Lcom/kousei/framework/s;->getEncoded()[B

    move-result-object p0

    .line 34
    invoke-direct {p2, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 35
    invoke-virtual {p1, p2}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object p0

    check-cast p0, Ljava/security/cert/X509Certificate;

    const-wide p1, -0x4919df5b40d7L

    .line 36
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    const-wide p1, -0x56fddf5b40d7L

    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;
    :try_end_16b
    .catch Ljava/lang/Exception; {:try_start_11a .. :try_end_16b} :catch_16c

    return-object p0

    :catch_16c
    move-exception v0

    move-object p0, v0

    const-wide p1, -0x56dedf5b40d7L

    .line 37
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    move-result-object p1

    const-wide p2, -0x56b2df5b40d7L

    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 p0, 0x0

    return-object p0
.end method

.method public static c(Ljava/security/KeyPair;Lcom/kousei/framework/i3;IILcom/kousei/framework/wi;Ljava/security/PrivateKey;)Ljava/security/cert/X509Certificate;
    .registers 15

    .line 1
    const/4 v1, 0x0

    .line 2
    if-eqz p4, :cond_e7

    .line 3
    .line 4
    if-nez p5, :cond_7

    .line 5
    .line 6
    goto/16 :goto_e7

    .line 7
    .line 8
    :cond_7
    :try_start_7
    iget-object v0, p1, Lcom/kousei/framework/i3;->c:Ljava/math/BigInteger;

    .line 9
    .line 10
    if-eqz v0, :cond_d

    .line 11
    .line 12
    :goto_b
    move-object v4, v0

    .line 13
    goto :goto_10

    .line 14
    :cond_d
    sget-object v0, Ljava/math/BigInteger;->ONE:Ljava/math/BigInteger;

    .line 15
    .line 16
    goto :goto_b

    .line 17
    :goto_10
    iget-object v0, p1, Lcom/kousei/framework/i3;->d:Ljava/util/Date;

    .line 18
    .line 19
    if-eqz v0, :cond_16

    .line 20
    .line 21
    :goto_14
    move-object v5, v0

    .line 22
    goto :goto_1c

    .line 23
    :cond_16
    new-instance v0, Ljava/util/Date;

    .line 24
    .line 25
    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    .line 26
    .line 27
    .line 28
    goto :goto_14

    .line 29
    :goto_1c
    iget-object v0, p1, Lcom/kousei/framework/i3;->e:Ljava/util/Date;

    .line 30
    .line 31
    if-eqz v0, :cond_22

    .line 32
    .line 33
    :goto_20
    move-object v6, v0

    .line 34
    goto :goto_32

    .line 35
    :cond_22
    new-instance v0, Ljava/util/Date;

    .line 36
    .line 37
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 38
    .line 39
    .line 40
    move-result-wide v2

    .line 41
    const-wide v6, 0x496cebb800L

    .line 42
    .line 43
    .line 44
    .line 45
    .line 46
    add-long/2addr v2, v6

    .line 47
    invoke-direct {v0, v2, v3}, Ljava/util/Date;-><init>(J)V

    .line 48
    .line 49
    .line 50
    goto :goto_20

    .line 51
    :goto_32
    iget-object v0, p1, Lcom/kousei/framework/i3;->f:Ljavax/security/auth/x500/X500Principal;

    .line 52
    .line 53
    if-eqz v0, :cond_44

    .line 54
    .line 55
    invoke-virtual {v0}, Ljavax/security/auth/x500/X500Principal;->getEncoded()[B

    .line 56
    .line 57
    .line 58
    move-result-object v0

    .line 59
    invoke-static {v0}, Lcom/kousei/framework/wi;->h(Ljava/lang/Object;)Lcom/kousei/framework/wi;

    .line 60
    .line 61
    .line 62
    move-result-object v0

    .line 63
    :goto_3e
    move-object v7, v0

    .line 64
    goto :goto_53

    .line 65
    :catchall_40
    move-exception v0

    .line 66
    move-object p0, v0

    .line 67
    goto/16 :goto_d2

    .line 68
    .line 69
    :cond_44
    new-instance v0, Lcom/kousei/framework/wi;

    .line 70
    .line 71
    const-wide v2, -0x5694df5b40d7L

    .line 72
    .line 73
    .line 74
    .line 75
    .line 76
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 77
    .line 78
    .line 79
    move-result-object v2

    .line 80
    invoke-direct {v0, v2}, Lcom/kousei/framework/wi;-><init>(Ljava/lang/String;)V

    .line 81
    .line 82
    .line 83
    goto :goto_3e

    .line 84
    :goto_53
    invoke-virtual {p0}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    .line 85
    .line 86
    .line 87
    move-result-object p0

    .line 88
    invoke-interface {p0}, Ljava/security/Key;->getEncoded()[B

    .line 89
    .line 90
    .line 91
    move-result-object p0

    .line 92
    invoke-static {p0}, Lcom/kousei/framework/xh;->h(Ljava/lang/Object;)Lcom/kousei/framework/xh;

    .line 93
    .line 94
    .line 95
    move-result-object v8

    .line 96
    new-instance v2, Lcom/kousei/framework/m8;

    .line 97
    .line 98
    move-object v3, p4

    .line 99
    invoke-direct/range {v2 .. v8}, Lcom/kousei/framework/m8;-><init>(Lcom/kousei/framework/wi;Ljava/math/BigInteger;Ljava/util/Date;Ljava/util/Date;Lcom/kousei/framework/wi;Lcom/kousei/framework/xh;)V

    .line 100
    .line 101
    .line 102
    sget-object p0, Lcom/kousei/framework/a8;->O:Lcom/kousei/framework/v;

    .line 103
    .line 104
    new-instance p4, Lcom/kousei/framework/ha;

    .line 105
    .line 106
    invoke-direct {p4}, Lcom/kousei/framework/ha;-><init>()V

    .line 107
    .line 108
    .line 109
    invoke-virtual {v2, p0, p4}, Lcom/kousei/framework/m8;->b(Lcom/kousei/framework/v;Lcom/kousei/framework/ha;)V

    .line 110
    .line 111
    .line 112
    invoke-static {p1, p2, p3}, Lcom/kousei/framework/j3;->a(Lcom/kousei/framework/i3;II)Lcom/kousei/framework/a8;

    .line 113
    .line 114
    .line 115
    move-result-object p0

    .line 116
    if-eqz p0, :cond_7d

    .line 117
    .line 118
    iget-object p1, v2, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 119
    .line 120
    check-cast p1, Lcom/kousei/framework/c8;

    .line 121
    .line 122
    invoke-virtual {p1, p0}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 123
    .line 124
    .line 125
    goto :goto_8d

    .line 126
    :cond_7d
    const-wide p0, -0x566cdf5b40d7L

    .line 127
    .line 128
    .line 129
    .line 130
    .line 131
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 132
    .line 133
    .line 134
    const-wide p0, -0x5640df5b40d7L

    .line 135
    .line 136
    .line 137
    .line 138
    .line 139
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 140
    .line 141
    .line 142
    :goto_8d
    invoke-static {p5}, Lcom/kousei/framework/j3;->h(Ljava/security/PrivateKey;)Ljava/lang/String;

    .line 143
    .line 144
    .line 145
    move-result-object p0

    .line 146
    new-instance p1, Lcom/kousei/framework/u9;

    .line 147
    .line 148
    invoke-direct {p1, p0}, Lcom/kousei/framework/u9;-><init>(Ljava/lang/String;)V
    :try_end_96
    .catchall {:try_start_7 .. :try_end_96} :catchall_40

    .line 149
    .line 150
    .line 151
    :try_start_96
    invoke-static {p5}, Lcom/kousei/framework/j3;->g(Ljava/security/PrivateKey;)Ljava/lang/String;

    .line 152
    .line 153
    .line 154
    move-result-object p0

    .line 155
    invoke-static {p0}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    .line 156
    .line 157
    .line 158
    move-result-object p0

    .line 159
    new-instance p2, Ljava/security/spec/PKCS8EncodedKeySpec;

    .line 160
    .line 161
    invoke-interface {p5}, Ljava/security/Key;->getEncoded()[B

    .line 162
    .line 163
    .line 164
    move-result-object p3

    .line 165
    invoke-direct {p2, p3}, Ljava/security/spec/PKCS8EncodedKeySpec;-><init>([B)V

    .line 166
    .line 167
    .line 168
    invoke-virtual {p0, p2}, Ljava/security/KeyFactory;->generatePrivate(Ljava/security/spec/KeySpec;)Ljava/security/PrivateKey;

    .line 169
    .line 170
    .line 171
    move-result-object p5
    :try_end_ab
    .catch Ljava/lang/Exception; {:try_start_96 .. :try_end_ab} :catch_ab
    .catchall {:try_start_96 .. :try_end_ab} :catchall_40

    .line 172
    :catch_ab
    :try_start_ab
    invoke-virtual {p1, p5}, Lcom/kousei/framework/u9;->a(Ljava/security/PrivateKey;)Lcom/kousei/framework/k3;

    .line 173
    .line 174
    .line 175
    move-result-object p0

    .line 176
    invoke-virtual {v2, p0}, Lcom/kousei/framework/m8;->c(Lcom/kousei/framework/k3;)Lcom/kousei/framework/yi;

    .line 177
    .line 178
    .line 179
    move-result-object p0

    .line 180
    const-wide p1, -0x5605df5b40d7L

    .line 181
    .line 182
    .line 183
    .line 184
    .line 185
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 186
    .line 187
    .line 188
    move-result-object p1

    .line 189
    invoke-static {p1}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    .line 190
    .line 191
    .line 192
    move-result-object p1

    .line 193
    new-instance p2, Ljava/io/ByteArrayInputStream;

    .line 194
    .line 195
    iget-object p0, p0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 196
    .line 197
    invoke-virtual {p0}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 198
    .line 199
    .line 200
    move-result-object p0

    .line 201
    invoke-direct {p2, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 202
    .line 203
    .line 204
    invoke-virtual {p1, p2}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 205
    .line 206
    .line 207
    move-result-object p0

    .line 208
    check-cast p0, Ljava/security/cert/X509Certificate;
    :try_end_d1
    .catchall {:try_start_ab .. :try_end_d1} :catchall_40

    .line 209
    .line 210
    return-object p0

    .line 211
    :goto_d2
    const-wide p1, -0x560fdf5b40d7L

    .line 212
    .line 213
    .line 214
    .line 215
    .line 216
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 217
    .line 218
    .line 219
    move-result-object p1

    .line 220
    const-wide p2, -0x57e3df5b40d7L

    .line 221
    .line 222
    .line 223
    .line 224
    .line 225
    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 226
    .line 227
    .line 228
    move-result-object p2

    .line 229
    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 230
    .line 231
    .line 232
    :cond_e7
    :goto_e7
    return-object v1
.end method

.method public static d(I)Lcom/kousei/framework/o4;
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
    if-eqz v0, :cond_de

    .line 7
    .line 8
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    if-eqz v0, :cond_d1

    .line 13
    .line 14
    invoke-virtual {v0, p0}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    .line 15
    .line 16
    .line 17
    move-result-object p0

    .line 18
    if-eqz p0, :cond_c0

    .line 19
    .line 20
    array-length v2, p0

    .line 21
    if-nez v2, :cond_18

    .line 22
    .line 23
    goto/16 :goto_c0

    .line 24
    .line 25
    :cond_18
    array-length v1, p0

    .line 26
    new-array v2, v1, [Lcom/kousei/framework/k;

    .line 27
    .line 28
    new-instance v3, Ljava/util/HashSet;

    .line 29
    .line 30
    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    .line 31
    .line 32
    .line 33
    const-wide v4, -0x5471df5b40d7L

    .line 34
    .line 35
    .line 36
    .line 37
    .line 38
    invoke-static {v4, v5}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 39
    .line 40
    .line 41
    move-result-object v4

    .line 42
    invoke-static {v4}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    .line 43
    .line 44
    .line 45
    move-result-object v4

    .line 46
    const/4 v5, 0x0

    .line 47
    move v6, v5

    .line 48
    :goto_2f
    const/4 v7, 0x2

    .line 49
    const/4 v8, 0x1

    .line 50
    if-ge v6, v1, :cond_7b

    .line 51
    .line 52
    aget-object v9, p0, v6

    .line 53
    .line 54
    const/16 v10, 0x40

    .line 55
    .line 56
    invoke-virtual {v0, v9, v10}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    .line 57
    .line 58
    .line 59
    move-result-object v10

    .line 60
    new-instance v11, Lcom/kousei/framework/o4;

    .line 61
    .line 62
    sget-object v12, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 63
    .line 64
    invoke-virtual {v9, v12}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    .line 65
    .line 66
    .line 67
    move-result-object v9

    .line 68
    invoke-direct {v11, v9}, Lcom/kousei/framework/w;-><init>([B)V

    .line 69
    .line 70
    .line 71
    new-instance v9, Lcom/kousei/framework/q;

    .line 72
    .line 73
    invoke-virtual {v10}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    .line 74
    .line 75
    .line 76
    move-result-wide v12

    .line 77
    invoke-direct {v9, v12, v13}, Lcom/kousei/framework/q;-><init>(J)V

    .line 78
    .line 79
    .line 80
    new-array v7, v7, [Lcom/kousei/framework/k;

    .line 81
    .line 82
    aput-object v11, v7, v5

    .line 83
    .line 84
    aput-object v9, v7, v8

    .line 85
    .line 86
    new-instance v8, Lcom/kousei/framework/r4;

    .line 87
    .line 88
    invoke-direct {v8, v7, v5}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 89
    .line 90
    .line 91
    aput-object v8, v2, v6

    .line 92
    .line 93
    iget-object v7, v10, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 94
    .line 95
    if-eqz v7, :cond_78

    .line 96
    .line 97
    array-length v8, v7

    .line 98
    move v9, v5

    .line 99
    :goto_62
    if-ge v9, v8, :cond_78

    .line 100
    .line 101
    aget-object v10, v7, v9

    .line 102
    .line 103
    invoke-virtual {v10}, Landroid/content/pm/Signature;->toByteArray()[B

    .line 104
    .line 105
    .line 106
    move-result-object v10

    .line 107
    invoke-virtual {v4, v10}, Ljava/security/MessageDigest;->digest([B)[B

    .line 108
    .line 109
    .line 110
    move-result-object v10

    .line 111
    invoke-static {v10}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    .line 112
    .line 113
    .line 114
    move-result-object v10

    .line 115
    invoke-virtual {v3, v10}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 116
    .line 117
    .line 118
    add-int/lit8 v9, v9, 0x1

    .line 119
    .line 120
    goto :goto_62

    .line 121
    :cond_78
    add-int/lit8 v6, v6, 0x1

    .line 122
    .line 123
    goto :goto_2f

    .line 124
    :cond_7b
    invoke-virtual {v3}, Ljava/util/HashSet;->size()I

    .line 125
    .line 126
    .line 127
    move-result p0

    .line 128
    new-array p0, p0, [Lcom/kousei/framework/k;

    .line 129
    .line 130
    invoke-virtual {v3}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    .line 131
    .line 132
    .line 133
    move-result-object v0

    .line 134
    move v1, v5

    .line 135
    :goto_86
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 136
    .line 137
    .line 138
    move-result v3

    .line 139
    if-eqz v3, :cond_a1

    .line 140
    .line 141
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 142
    .line 143
    .line 144
    move-result-object v3

    .line 145
    check-cast v3, Ljava/nio/ByteBuffer;

    .line 146
    .line 147
    add-int/lit8 v4, v1, 0x1

    .line 148
    .line 149
    new-instance v6, Lcom/kousei/framework/o4;

    .line 150
    .line 151
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->array()[B

    .line 152
    .line 153
    .line 154
    move-result-object v3

    .line 155
    invoke-direct {v6, v3}, Lcom/kousei/framework/w;-><init>([B)V

    .line 156
    .line 157
    .line 158
    aput-object v6, p0, v1

    .line 159
    .line 160
    move v1, v4

    .line 161
    goto :goto_86

    .line 162
    :cond_a1
    new-instance v0, Lcom/kousei/framework/s4;

    .line 163
    .line 164
    invoke-direct {v0, v2, v5}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 165
    .line 166
    .line 167
    new-instance v1, Lcom/kousei/framework/s4;

    .line 168
    .line 169
    invoke-direct {v1, p0, v5}, Lcom/kousei/framework/s4;-><init>([Lcom/kousei/framework/k;I)V

    .line 170
    .line 171
    .line 172
    new-array p0, v7, [Lcom/kousei/framework/k;

    .line 173
    .line 174
    aput-object v0, p0, v5

    .line 175
    .line 176
    aput-object v1, p0, v8

    .line 177
    .line 178
    new-instance v0, Lcom/kousei/framework/o4;

    .line 179
    .line 180
    new-instance v1, Lcom/kousei/framework/r4;

    .line 181
    .line 182
    invoke-direct {v1, p0, v5}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 183
    .line 184
    .line 185
    invoke-virtual {v1}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 186
    .line 187
    .line 188
    move-result-object p0

    .line 189
    invoke-direct {v0, p0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 190
    .line 191
    .line 192
    return-object v0

    .line 193
    :cond_c0
    :goto_c0
    const-wide v2, -0x54b9df5b40d7L

    .line 194
    .line 195
    .line 196
    .line 197
    .line 198
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 199
    .line 200
    .line 201
    const-wide v2, -0x549ddf5b40d7L

    .line 202
    .line 203
    .line 204
    .line 205
    .line 206
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 207
    .line 208
    .line 209
    return-object v1

    .line 210
    :cond_d1
    const-wide v2, -0x54c8df5b40d7L

    .line 211
    .line 212
    .line 213
    .line 214
    .line 215
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 216
    .line 217
    .line 218
    move-result-object p0

    .line 219
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 220
    .line 221
    .line 222
    return-object v1

    .line 223
    :cond_de
    const-wide v2, -0x5708df5b40d7L

    .line 224
    .line 225
    .line 226
    .line 227
    .line 228
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 229
    .line 230
    .line 231
    move-result-object p0

    .line 232
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 233
    .line 234
    .line 235
    return-object v1
    .line 236
    .line 237
    .line 238
    .line 239
    .line 240
    .line 241
    .line 242
.end method

.method public static e(Ljava/security/KeyPair;Lcom/kousei/framework/i3;II)Ljava/util/ArrayList;
    .registers 13

    .line 1
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    iget-object v0, v0, Lcom/kousei/framework/gi;->i:Lcom/kousei/framework/da;

    .line 6
    .line 7
    iget v1, p1, Lcom/kousei/framework/i3;->b:I

    .line 8
    .line 9
    const/4 v2, 0x3

    .line 10
    if-ne v1, v2, :cond_15

    .line 11
    .line 12
    const-wide v1, -0x4d04df5b40d7L

    .line 13
    .line 14
    .line 15
    .line 16
    .line 17
    :goto_10
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 18
    .line 19
    .line 20
    move-result-object v1

    .line 21
    goto :goto_1b

    .line 22
    :cond_15
    const-wide v1, -0x4d01df5b40d7L

    .line 23
    .line 24
    .line 25
    .line 26
    .line 27
    goto :goto_10

    .line 28
    :goto_1b
    invoke-virtual {v0, v1}, Lcom/kousei/framework/da;->b(Ljava/lang/String;)Lcom/kousei/framework/ca;

    .line 29
    .line 30
    .line 31
    move-result-object v3

    .line 32
    const/4 v8, 0x0

    .line 33
    if-nez v3, :cond_53

    .line 34
    .line 35
    new-instance p0, Ljava/lang/StringBuilder;

    .line 36
    .line 37
    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    .line 38
    .line 39
    .line 40
    const-wide p1, -0x4d0ddf5b40d7L

    .line 41
    .line 42
    .line 43
    .line 44
    .line 45
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 46
    .line 47
    .line 48
    move-result-object p1

    .line 49
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 50
    .line 51
    .line 52
    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 53
    .line 54
    .line 55
    const-wide p1, -0x4ae9df5b40d7L

    .line 56
    .line 57
    .line 58
    .line 59
    .line 60
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 61
    .line 62
    .line 63
    move-result-object p1

    .line 64
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 65
    .line 66
    .line 67
    const-wide p1, -0x4acfdf5b40d7L

    .line 68
    .line 69
    .line 70
    .line 71
    .line 72
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 73
    .line 74
    .line 75
    move-result-object p1

    .line 76
    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 77
    .line 78
    .line 79
    move-result-object p0

    .line 80
    invoke-static {p1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 81
    .line 82
    .line 83
    return-object v8

    .line 84
    :cond_53
    :try_start_53
    iget-object v0, v3, Lcom/kousei/framework/ca;->b:Ljava/util/ArrayList;

    .line 85
    .line 86
    const-wide v1, -0x4aa3df5b40d7L

    .line 87
    .line 88
    .line 89
    .line 90
    .line 91
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 92
    .line 93
    .line 94
    const-wide v1, -0x4a87df5b40d7L

    .line 95
    .line 96
    .line 97
    .line 98
    .line 99
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 100
    .line 101
    .line 102
    const-wide v1, -0x4a99df5b40d7L

    .line 103
    .line 104
    .line 105
    .line 106
    .line 107
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 108
    .line 109
    .line 110
    const-wide v1, -0x4a61df5b40d7L

    .line 111
    .line 112
    .line 113
    .line 114
    .line 115
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 116
    .line 117
    .line 118
    iget-object v1, v3, Lcom/kousei/framework/ca;->a:Ljava/security/KeyPair;

    .line 119
    .line 120
    invoke-virtual {v1}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    .line 121
    .line 122
    .line 123
    move-result-object v1

    .line 124
    invoke-interface {v1}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 125
    .line 126
    .line 127
    new-instance v1, Lcom/kousei/framework/yi;

    .line 128
    .line 129
    const/4 v2, 0x0

    .line 130
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 131
    .line 132
    .line 133
    move-result-object v2

    .line 134
    check-cast v2, Ljava/security/cert/Certificate;

    .line 135
    .line 136
    invoke-virtual {v2}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 137
    .line 138
    .line 139
    move-result-object v2

    .line 140
    invoke-direct {v1, v2}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 141
    .line 142
    .line 143
    invoke-virtual {v1}, Lcom/kousei/framework/yi;->b()Lcom/kousei/framework/wi;

    .line 144
    .line 145
    .line 146
    move-result-object v5

    .line 147
    move-object v2, p0

    .line 148
    move-object v4, p1

    .line 149
    move v6, p2

    .line 150
    move v7, p3

    .line 151
    invoke-static/range {v2 .. v7}, Lcom/kousei/framework/j3;->b(Ljava/security/KeyPair;Lcom/kousei/framework/ca;Lcom/kousei/framework/i3;Lcom/kousei/framework/wi;II)Ljava/security/cert/X509Certificate;

    .line 152
    .line 153
    .line 154
    move-result-object p0

    .line 155
    if-nez p0, :cond_b5

    .line 156
    .line 157
    const-wide p0, -0x4a73df5b40d7L

    .line 158
    .line 159
    .line 160
    .line 161
    .line 162
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 163
    .line 164
    .line 165
    move-result-object p0

    .line 166
    const-wide p1, -0x4a57df5b40d7L

    .line 167
    .line 168
    .line 169
    .line 170
    .line 171
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 172
    .line 173
    .line 174
    move-result-object p1

    .line 175
    invoke-static {p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    .line 177
    .line 178
    return-object v8

    .line 179
    :catch_b2
    move-exception v0

    .line 180
    move-object p0, v0

    .line 181
    goto :goto_d4

    .line 182
    :cond_b5
    new-instance p1, Ljava/util/ArrayList;

    .line 183
    .line 184
    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 185
    .line 186
    .line 187
    invoke-virtual {p1, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 188
    .line 189
    .line 190
    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 191
    .line 192
    .line 193
    const-wide p2, -0x4a28df5b40d7L

    .line 194
    .line 195
    .line 196
    .line 197
    .line 198
    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 199
    .line 200
    .line 201
    const-wide p2, -0x4a0cdf5b40d7L

    .line 202
    .line 203
    .line 204
    .line 205
    .line 206
    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 207
    .line 208
    .line 209
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I
    :try_end_d3
    .catch Ljava/lang/Exception; {:try_start_53 .. :try_end_d3} :catch_b2

    .line 210
    .line 211
    .line 212
    return-object p1

    .line 213
    :goto_d4
    const-wide p1, -0x4bfadf5b40d7L

    .line 214
    .line 215
    .line 216
    .line 217
    .line 218
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 219
    .line 220
    .line 221
    move-result-object p1

    .line 222
    const-wide p2, -0x4bdedf5b40d7L

    .line 223
    .line 224
    .line 225
    .line 226
    .line 227
    invoke-static {p2, p3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 228
    .line 229
    .line 230
    move-result-object p2

    .line 231
    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 232
    .line 233
    .line 234
    return-object v8
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
.end method

.method public static f(Lcom/kousei/framework/i3;)Ljava/security/KeyPair;
    .registers 6

    .line 1
    const/4 v0, 0x0

    .line 2
    :try_start_1
    iget v1, p0, Lcom/kousei/framework/i3;->b:I

    .line 3
    .line 4
    const/4 v2, 0x3

    .line 5
    if-ne v1, v2, :cond_66

    .line 6
    .line 7
    const-wide v1, -0x4d97df5b40d7L

    .line 8
    .line 9
    .line 10
    .line 11
    .line 12
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 13
    .line 14
    .line 15
    move-result-object v1

    .line 16
    invoke-static {v1}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;)Ljava/security/KeyPairGenerator;

    .line 17
    .line 18
    .line 19
    move-result-object v1

    .line 20
    new-instance v2, Ljava/security/spec/ECGenParameterSpec;

    .line 21
    .line 22
    iget-object v3, p0, Lcom/kousei/framework/i3;->i:Ljava/lang/String;

    .line 23
    .line 24
    if-eqz v3, :cond_1a

    .line 25
    .line 26
    goto :goto_5d

    .line 27
    :cond_1a
    iget p0, p0, Lcom/kousei/framework/i3;->a:I

    .line 28
    .line 29
    const/16 v3, 0xe0

    .line 30
    .line 31
    if-eq p0, v3, :cond_54

    .line 32
    .line 33
    const/16 v3, 0x100

    .line 34
    .line 35
    if-eq p0, v3, :cond_4a

    .line 36
    .line 37
    const/16 v3, 0x180

    .line 38
    .line 39
    if-eq p0, v3, :cond_40

    .line 40
    .line 41
    const/16 v3, 0x209

    .line 42
    .line 43
    if-eq p0, v3, :cond_36

    .line 44
    .line 45
    const-wide v3, -0x4c1fdf5b40d7L

    .line 46
    .line 47
    .line 48
    .line 49
    .line 50
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 51
    .line 52
    .line 53
    move-result-object v3

    .line 54
    goto :goto_5d

    .line 55
    :cond_36
    const-wide v3, -0x4c09df5b40d7L

    .line 56
    .line 57
    .line 58
    .line 59
    .line 60
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 61
    .line 62
    .line 63
    move-result-object v3

    .line 64
    goto :goto_5d

    .line 65
    :cond_40
    const-wide v3, -0x4c03df5b40d7L

    .line 66
    .line 67
    .line 68
    .line 69
    .line 70
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 71
    .line 72
    .line 73
    move-result-object v3

    .line 74
    goto :goto_5d

    .line 75
    :cond_4a
    const-wide v3, -0x4c3ddf5b40d7L

    .line 76
    .line 77
    .line 78
    .line 79
    .line 80
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 81
    .line 82
    .line 83
    move-result-object v3

    .line 84
    goto :goto_5d

    .line 85
    :cond_54
    const-wide v3, -0x4c37df5b40d7L

    .line 86
    .line 87
    .line 88
    .line 89
    .line 90
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 91
    .line 92
    .line 93
    move-result-object v3

    .line 94
    :goto_5d
    invoke-direct {v2, v3}, Ljava/security/spec/ECGenParameterSpec;-><init>(Ljava/lang/String;)V

    .line 95
    .line 96
    .line 97
    invoke-virtual {v1, v2}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 98
    .line 99
    .line 100
    goto :goto_87

    .line 101
    :catch_64
    move-exception p0

    .line 102
    goto :goto_b3

    .line 103
    :cond_66
    const/4 v2, 0x1

    .line 104
    if-ne v1, v2, :cond_8c

    .line 105
    .line 106
    const-wide v1, -0x4d94df5b40d7L

    .line 107
    .line 108
    .line 109
    .line 110
    .line 111
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 112
    .line 113
    .line 114
    move-result-object v1

    .line 115
    invoke-static {v1}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;)Ljava/security/KeyPairGenerator;

    .line 116
    .line 117
    .line 118
    move-result-object v1

    .line 119
    new-instance v2, Ljava/security/spec/RSAKeyGenParameterSpec;

    .line 120
    .line 121
    iget v3, p0, Lcom/kousei/framework/i3;->a:I

    .line 122
    .line 123
    iget-object p0, p0, Lcom/kousei/framework/i3;->g:Ljava/math/BigInteger;

    .line 124
    .line 125
    if-eqz p0, :cond_7f

    .line 126
    .line 127
    goto :goto_81

    .line 128
    :cond_7f
    sget-object p0, Ljava/security/spec/RSAKeyGenParameterSpec;->F4:Ljava/math/BigInteger;

    .line 129
    .line 130
    :goto_81
    invoke-direct {v2, v3, p0}, Ljava/security/spec/RSAKeyGenParameterSpec;-><init>(ILjava/math/BigInteger;)V

    .line 131
    .line 132
    .line 133
    invoke-virtual {v1, v2}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 134
    .line 135
    .line 136
    :goto_87
    invoke-virtual {v1}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;

    .line 137
    .line 138
    .line 139
    move-result-object p0

    .line 140
    return-object p0

    .line 141
    :cond_8c
    new-instance v1, Ljava/lang/StringBuilder;

    .line 142
    .line 143
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 144
    .line 145
    .line 146
    const-wide v2, -0x4d90df5b40d7L

    .line 147
    .line 148
    .line 149
    .line 150
    .line 151
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 152
    .line 153
    .line 154
    move-result-object v2

    .line 155
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 156
    .line 157
    .line 158
    iget p0, p0, Lcom/kousei/framework/i3;->b:I

    .line 159
    .line 160
    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 161
    .line 162
    .line 163
    const-wide v2, -0x4d68df5b40d7L

    .line 164
    .line 165
    .line 166
    .line 167
    .line 168
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 169
    .line 170
    .line 171
    move-result-object p0

    .line 172
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 173
    .line 174
    .line 175
    move-result-object v1

    .line 176
    invoke-static {p0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_b2
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_b2} :catch_64

    .line 177
    .line 178
    .line 179
    return-object v0

    .line 180
    :goto_b3
    const-wide v1, -0x4d4cdf5b40d7L

    .line 181
    .line 182
    .line 183
    .line 184
    .line 185
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 186
    .line 187
    .line 188
    move-result-object v1

    .line 189
    const-wide v2, -0x4d20df5b40d7L

    .line 190
    .line 191
    .line 192
    .line 193
    .line 194
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 195
    .line 196
    .line 197
    move-result-object v2

    .line 198
    invoke-static {v1, v2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 199
    .line 200
    .line 201
    return-object v0
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

.method public static g(Ljava/security/PrivateKey;)Ljava/lang/String;
    .registers 3

    .line 1
    if-nez p0, :cond_c

    .line 2
    .line 3
    const-wide v0, -0x4d86df5b40d7L

    .line 4
    .line 5
    .line 6
    .line 7
    .line 8
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 9
    .line 10
    .line 11
    move-result-object p0

    .line 12
    return-object p0

    .line 13
    :cond_c
    instance-of v0, p0, Ljava/security/interfaces/RSAPrivateKey;

    .line 14
    .line 15
    if-nez v0, :cond_2e

    .line 16
    .line 17
    const-wide v0, -0x4d82df5b40d7L

    .line 18
    .line 19
    .line 20
    .line 21
    .line 22
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 23
    .line 24
    .line 25
    move-result-object v0

    .line 26
    invoke-interface {p0}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 27
    .line 28
    .line 29
    move-result-object p0

    .line 30
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    .line 31
    .line 32
    .line 33
    move-result p0

    .line 34
    if-eqz p0, :cond_24

    .line 35
    .line 36
    goto :goto_2e

    .line 37
    :cond_24
    const-wide v0, -0x4d8adf5b40d7L

    .line 38
    .line 39
    .line 40
    .line 41
    .line 42
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 43
    .line 44
    .line 45
    move-result-object p0

    .line 46
    return-object p0

    .line 47
    :cond_2e
    :goto_2e
    const-wide v0, -0x4d8edf5b40d7L

    .line 48
    .line 49
    .line 50
    .line 51
    .line 52
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 53
    .line 54
    .line 55
    move-result-object p0

    .line 56
    return-object p0
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

.method public static h(Ljava/security/PrivateKey;)Ljava/lang/String;
    .registers 3

    .line 1
    if-nez p0, :cond_c

    .line 2
    .line 3
    const-wide v0, -0x4de5df5b40d7L

    .line 4
    .line 5
    .line 6
    .line 7
    .line 8
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 9
    .line 10
    .line 11
    move-result-object p0

    .line 12
    return-object p0

    .line 13
    :cond_c
    instance-of v0, p0, Ljava/security/interfaces/RSAPrivateKey;

    .line 14
    .line 15
    if-eqz v0, :cond_1a

    .line 16
    .line 17
    const-wide v0, -0x4df7df5b40d7L

    .line 18
    .line 19
    .line 20
    .line 21
    .line 22
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 23
    .line 24
    .line 25
    move-result-object p0

    .line 26
    return-object p0

    .line 27
    :cond_1a
    instance-of v0, p0, Ljava/security/interfaces/ECPrivateKey;

    .line 28
    .line 29
    if-eqz v0, :cond_28

    .line 30
    .line 31
    const-wide v0, -0x4df9df5b40d7L

    .line 32
    .line 33
    .line 34
    .line 35
    .line 36
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 37
    .line 38
    .line 39
    move-result-object p0

    .line 40
    return-object p0

    .line 41
    :cond_28
    invoke-interface {p0}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 42
    .line 43
    .line 44
    move-result-object p0

    .line 45
    const-wide v0, -0x4dc9df5b40d7L

    .line 46
    .line 47
    .line 48
    .line 49
    .line 50
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 51
    .line 52
    .line 53
    move-result-object v0

    .line 54
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    .line 55
    .line 56
    .line 57
    move-result v0

    .line 58
    if-eqz v0, :cond_45

    .line 59
    .line 60
    const-wide v0, -0x4dd5df5b40d7L

    .line 61
    .line 62
    .line 63
    .line 64
    .line 65
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 66
    .line 67
    .line 68
    move-result-object p0

    .line 69
    return-object p0

    .line 70
    :cond_45
    const-wide v0, -0x4da7df5b40d7L

    .line 71
    .line 72
    .line 73
    .line 74
    .line 75
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 76
    .line 77
    .line 78
    move-result-object v0

    .line 79
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    .line 80
    .line 81
    .line 82
    move-result p0

    .line 83
    if-eqz p0, :cond_5e

    .line 84
    .line 85
    const-wide v0, -0x4da4df5b40d7L

    .line 86
    .line 87
    .line 88
    .line 89
    .line 90
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 91
    .line 92
    .line 93
    move-result-object p0

    .line 94
    return-object p0

    .line 95
    :cond_5e
    const-wide v0, -0x4db4df5b40d7L

    .line 96
    .line 97
    .line 98
    .line 99
    .line 100
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 101
    .line 102
    .line 103
    move-result-object p0

    .line 104
    return-object p0
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
