.class public Lcom/kousei/framework/xd;
.super Lcom/kousei/framework/n0;


# static fields
.field public static final N:Lcom/kousei/framework/u2;

.field public static final O:Ljava/math/BigInteger;


# instance fields
.field public final L:Ljava/math/BigInteger;

.field public final M:Ljava/math/BigInteger;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 1
    new-instance v0, Lcom/kousei/framework/u2;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/kousei/framework/u2;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/kousei/framework/xd;->N:Lcom/kousei/framework/u2;

    .line 7
    .line 8
    new-instance v0, Ljava/math/BigInteger;

    .line 9
    .line 10
    const-string v1, "8138e8a0fcf3a4e84a771d40fd305d7f4aa59306d7251de54d98af8fe95729a1f73d893fa424cd2edc8636a6c3285e022b0e3866a565ae8108eed8591cd4fe8d2ce86165a978d719ebf647f362d33fca29cd179fb42401cbaf3df0c614056f9c8f3cfd51e474afb6bc6974f78db8aba8e9e517fded658591ab7502bd41849462f"

    .line 11
    .line 12
    const/16 v2, 0x10

    .line 13
    .line 14
    invoke-direct {v0, v1, v2}, Ljava/math/BigInteger;-><init>(Ljava/lang/String;I)V

    .line 15
    .line 16
    .line 17
    sput-object v0, Lcom/kousei/framework/xd;->O:Ljava/math/BigInteger;

    .line 18
    .line 19
    return-void
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

.method public constructor <init>(ZLjava/math/BigInteger;Ljava/math/BigInteger;I)V
    .registers 22

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p2

    .line 4
    .line 5
    invoke-direct/range {p0 .. p1}, Lcom/kousei/framework/n0;-><init>(Z)V

    .line 6
    .line 7
    .line 8
    const/4 v2, 0x0

    .line 9
    const/4 v3, 0x1

    .line 10
    if-nez p1, :cond_19

    .line 11
    .line 12
    invoke-virtual/range {p3 .. p3}, Ljava/math/BigInteger;->intValue()I

    .line 13
    .line 14
    .line 15
    move-result v4

    .line 16
    and-int/2addr v4, v3

    .line 17
    if-eqz v4, :cond_13

    .line 18
    .line 19
    goto :goto_19

    .line 20
    :cond_13
    const-string v0, "RSA publicExponent is even"

    .line 21
    .line 22
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 23
    .line 24
    .line 25
    throw v2

    .line 26
    :cond_19
    :goto_19
    sget-object v4, Lcom/kousei/framework/xd;->N:Lcom/kousei/framework/u2;

    .line 27
    .line 28
    monitor-enter v4

    .line 29
    :try_start_1c
    iget-object v5, v4, Lcom/kousei/framework/u2;->a:Ljava/util/WeakHashMap;

    .line 30
    .line 31
    invoke-virtual {v5, v1}, Ljava/util/WeakHashMap;->containsKey(Ljava/lang/Object;)Z

    .line 32
    .line 33
    .line 34
    move-result v5
    :try_end_22
    .catchall {:try_start_1c .. :try_end_22} :catchall_236

    .line 35
    monitor-exit v4

    .line 36
    if-eqz v5, :cond_27

    .line 37
    .line 38
    goto/16 :goto_209

    .line 39
    .line 40
    :cond_27
    invoke-virtual {v1}, Ljava/math/BigInteger;->intValue()I

    .line 41
    .line 42
    .line 43
    move-result v5

    .line 44
    and-int/2addr v5, v3

    .line 45
    if-eqz v5, :cond_22e

    .line 46
    .line 47
    const-string v5, "org.bouncycastle.rsa.allow_unsafe_mod"

    .line 48
    .line 49
    invoke-static {v5}, Lcom/kousei/framework/md;->c(Ljava/lang/String;)Z

    .line 50
    .line 51
    .line 52
    move-result v5

    .line 53
    if-eqz v5, :cond_38

    .line 54
    .line 55
    goto/16 :goto_209

    .line 56
    .line 57
    :cond_38
    const-string v5, "org.bouncycastle.rsa.max_size"

    .line 58
    .line 59
    const/16 v6, 0x4000

    .line 60
    .line 61
    invoke-static {v6, v5}, Lcom/kousei/framework/md;->a(ILjava/lang/String;)I

    .line 62
    .line 63
    .line 64
    move-result v5

    .line 65
    invoke-virtual {v1}, Ljava/math/BigInteger;->bitLength()I

    .line 66
    .line 67
    .line 68
    move-result v6

    .line 69
    if-lt v5, v6, :cond_226

    .line 70
    .line 71
    sget-object v5, Lcom/kousei/framework/xd;->O:Ljava/math/BigInteger;

    .line 72
    .line 73
    invoke-virtual {v1}, Ljava/math/BigInteger;->bitLength()I

    .line 74
    .line 75
    .line 76
    move-result v6

    .line 77
    invoke-virtual {v5}, Ljava/math/BigInteger;->bitLength()I

    .line 78
    .line 79
    .line 80
    move-result v7

    .line 81
    if-ge v6, v7, :cond_54

    .line 82
    .line 83
    move-object v6, v1

    .line 84
    goto :goto_56

    .line 85
    :cond_54
    move-object v6, v5

    .line 86
    move-object v5, v1

    .line 87
    :goto_56
    sget-object v7, Lcom/kousei/framework/v2;->a:Ljava/math/BigInteger;

    .line 88
    .line 89
    const/4 v7, 0x0

    .line 90
    invoke-virtual {v5, v7}, Ljava/math/BigInteger;->testBit(I)Z

    .line 91
    .line 92
    .line 93
    move-result v8

    .line 94
    if-eqz v8, :cond_21e

    .line 95
    .line 96
    invoke-virtual {v5}, Ljava/math/BigInteger;->signum()I

    .line 97
    .line 98
    .line 99
    move-result v8

    .line 100
    if-ne v8, v3, :cond_216

    .line 101
    .line 102
    invoke-virtual {v6}, Ljava/math/BigInteger;->signum()I

    .line 103
    .line 104
    .line 105
    move-result v8

    .line 106
    if-ltz v8, :cond_75

    .line 107
    .line 108
    invoke-virtual {v6}, Ljava/math/BigInteger;->bitLength()I

    .line 109
    .line 110
    .line 111
    move-result v8

    .line 112
    invoke-virtual {v5}, Ljava/math/BigInteger;->bitLength()I

    .line 113
    .line 114
    .line 115
    move-result v9

    .line 116
    if-le v8, v9, :cond_79

    .line 117
    .line 118
    :cond_75
    invoke-virtual {v6, v5}, Ljava/math/BigInteger;->mod(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 119
    .line 120
    .line 121
    move-result-object v6

    .line 122
    :cond_79
    sget-object v8, Lcom/kousei/framework/v2;->b:Ljava/math/BigInteger;

    .line 123
    .line 124
    invoke-virtual {v6, v8}, Ljava/math/BigInteger;->equals(Ljava/lang/Object;)Z

    .line 125
    .line 126
    .line 127
    move-result v8

    .line 128
    const/4 v9, 0x4

    .line 129
    if-eqz v8, :cond_87

    .line 130
    .line 131
    move-object/from16 p4, v2

    .line 132
    .line 133
    move v2, v3

    .line 134
    goto/16 :goto_10e

    .line 135
    .line 136
    :cond_87
    invoke-virtual {v5}, Ljava/math/BigInteger;->bitLength()I

    .line 137
    .line 138
    .line 139
    move-result v8

    .line 140
    invoke-static {v8, v5}, Lcom/kousei/framework/i0;->C0(ILjava/math/BigInteger;)[I

    .line 141
    .line 142
    .line 143
    move-result-object v5

    .line 144
    invoke-static {v8, v6}, Lcom/kousei/framework/i0;->C0(ILjava/math/BigInteger;)[I

    .line 145
    .line 146
    .line 147
    move-result-object v6

    .line 148
    array-length v8, v5

    .line 149
    mul-int/lit8 v10, v8, 0x20

    .line 150
    .line 151
    sub-int/2addr v8, v3

    .line 152
    aget v11, v5, v8

    .line 153
    .line 154
    invoke-static {v11}, Ljava/lang/Integer;->numberOfLeadingZeros(I)I

    .line 155
    .line 156
    .line 157
    move-result v11

    .line 158
    sub-int/2addr v10, v11

    .line 159
    add-int/lit8 v11, v10, 0x1d

    .line 160
    .line 161
    div-int/lit8 v11, v11, 0x1e

    .line 162
    .line 163
    :goto_a2
    if-ltz v8, :cond_b5

    .line 164
    .line 165
    aget v12, v6, v8

    .line 166
    .line 167
    if-eqz v12, :cond_b2

    .line 168
    .line 169
    mul-int/lit8 v8, v8, 0x20

    .line 170
    .line 171
    invoke-static {v12}, Ljava/lang/Integer;->numberOfLeadingZeros(I)I

    .line 172
    .line 173
    .line 174
    move-result v12

    .line 175
    rsub-int/lit8 v12, v12, 0x20

    .line 176
    .line 177
    add-int/2addr v12, v8

    .line 178
    goto :goto_b6

    .line 179
    :cond_b2
    add-int/lit8 v8, v8, -0x1

    .line 180
    .line 181
    goto :goto_a2

    .line 182
    :cond_b5
    move v12, v7

    .line 183
    :goto_b6
    sub-int v8, v10, v12

    .line 184
    .line 185
    new-array v12, v9, [I

    .line 186
    .line 187
    new-array v13, v11, [I

    .line 188
    .line 189
    new-array v14, v11, [I

    .line 190
    .line 191
    new-array v15, v11, [I

    .line 192
    .line 193
    invoke-static {v10, v6, v14}, Lcom/kousei/framework/i0;->p0(I[I[I)V

    .line 194
    .line 195
    .line 196
    invoke-static {v10, v5, v15}, Lcom/kousei/framework/i0;->p0(I[I[I)V

    .line 197
    .line 198
    .line 199
    invoke-static {v15, v7, v13, v7, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 200
    .line 201
    .line 202
    neg-int v5, v8

    .line 203
    const-wide/32 v15, 0x2e1e2

    .line 204
    .line 205
    .line 206
    move-object/from16 p4, v2

    .line 207
    .line 208
    int-to-long v2, v10

    .line 209
    mul-long/2addr v2, v15

    .line 210
    const/16 v15, 0x2e

    .line 211
    .line 212
    if-ge v10, v15, :cond_d9

    .line 213
    .line 214
    const v10, 0x4b4b5

    .line 215
    .line 216
    .line 217
    goto :goto_dc

    .line 218
    :cond_d9
    const v10, 0x2c3c4

    .line 219
    .line 220
    .line 221
    :goto_dc
    int-to-long v9, v10

    .line 222
    add-long/2addr v2, v9

    .line 223
    const/16 v9, 0x10

    .line 224
    .line 225
    ushr-long/2addr v2, v9

    .line 226
    long-to-int v2, v2

    .line 227
    :goto_e2
    invoke-static {v11, v7, v14}, Lcom/kousei/framework/i0;->x0(II[I)Z

    .line 228
    .line 229
    .line 230
    move-result v3

    .line 231
    if-nez v3, :cond_fe

    .line 232
    .line 233
    if-lt v8, v2, :cond_ec

    .line 234
    .line 235
    move v2, v7

    .line 236
    goto :goto_10e

    .line 237
    :cond_ec
    add-int/lit8 v8, v8, 0x1e

    .line 238
    .line 239
    aget v3, v13, v7

    .line 240
    .line 241
    aget v9, v14, v7

    .line 242
    .line 243
    invoke-static {v5, v3, v9, v12}, Lcom/kousei/framework/i0;->o0(III[I)I

    .line 244
    .line 245
    .line 246
    move-result v5

    .line 247
    invoke-static {v11, v13, v14, v12}, Lcom/kousei/framework/i0;->b3(I[I[I[I)V

    .line 248
    .line 249
    .line 250
    invoke-static {v11, v13, v14}, Lcom/kousei/framework/i0;->W2(I[I[I)I

    .line 251
    .line 252
    .line 253
    move-result v11

    .line 254
    goto :goto_e2

    .line 255
    :cond_fe
    add-int/lit8 v2, v11, -0x1

    .line 256
    .line 257
    aget v2, v13, v2

    .line 258
    .line 259
    shr-int/lit8 v2, v2, 0x1f

    .line 260
    .line 261
    if-gez v2, :cond_109

    .line 262
    .line 263
    invoke-static {v11, v13}, Lcom/kousei/framework/i0;->h2(I[I)I

    .line 264
    .line 265
    .line 266
    :cond_109
    const/4 v6, 0x1

    .line 267
    invoke-static {v11, v6, v13}, Lcom/kousei/framework/i0;->x0(II[I)Z

    .line 268
    .line 269
    .line 270
    move-result v2

    .line 271
    :goto_10e
    if-eqz v2, :cond_210

    .line 272
    .line 273
    invoke-virtual {v1}, Ljava/math/BigInteger;->bitLength()I

    .line 274
    .line 275
    .line 276
    move-result v2

    .line 277
    const/4 v3, 0x2

    .line 278
    div-int/2addr v2, v3

    .line 279
    const-string v5, "org.bouncycastle.rsa.max_mr_tests"

    .line 280
    .line 281
    const/16 v8, 0x600

    .line 282
    .line 283
    if-lt v2, v8, :cond_11e

    .line 284
    .line 285
    const/4 v9, 0x3

    .line 286
    goto :goto_12c

    .line 287
    :cond_11e
    const/16 v8, 0x400

    .line 288
    .line 289
    if-lt v2, v8, :cond_124

    .line 290
    .line 291
    const/4 v9, 0x4

    .line 292
    goto :goto_12c

    .line 293
    :cond_124
    const/16 v8, 0x200

    .line 294
    .line 295
    if-lt v2, v8, :cond_12a

    .line 296
    .line 297
    const/4 v9, 0x7

    .line 298
    goto :goto_12c

    .line 299
    :cond_12a
    const/16 v9, 0x32

    .line 300
    .line 301
    :goto_12c
    invoke-static {v9, v5}, Lcom/kousei/framework/md;->a(ILjava/lang/String;)I

    .line 302
    .line 303
    .line 304
    move-result v2

    .line 305
    if-lez v2, :cond_206

    .line 306
    .line 307
    invoke-static {}, Lcom/kousei/framework/y3;->b()Ljava/security/SecureRandom;

    .line 308
    .line 309
    .line 310
    move-result-object v5

    .line 311
    sget-object v8, Lcom/kousei/framework/jd;->a:Ljava/math/BigInteger;

    .line 312
    .line 313
    sget-object v9, Lcom/kousei/framework/jd;->b:Ljava/math/BigInteger;

    .line 314
    .line 315
    invoke-static {v1}, Lcom/kousei/framework/jd;->a(Ljava/math/BigInteger;)V

    .line 316
    .line 317
    .line 318
    if-eqz v5, :cond_200

    .line 319
    .line 320
    const/4 v6, 0x1

    .line 321
    if-lt v2, v6, :cond_1fa

    .line 322
    .line 323
    invoke-virtual {v1}, Ljava/math/BigInteger;->bitLength()I

    .line 324
    .line 325
    .line 326
    move-result v10

    .line 327
    if-ne v10, v3, :cond_14f

    .line 328
    .line 329
    new-instance v2, Lcom/kousei/framework/id;

    .line 330
    .line 331
    invoke-direct {v2, v7}, Lcom/kousei/framework/id;-><init>(Z)V

    .line 332
    .line 333
    .line 334
    goto/16 :goto_1ef

    .line 335
    .line 336
    :cond_14f
    invoke-virtual {v1, v7}, Ljava/math/BigInteger;->testBit(I)Z

    .line 337
    .line 338
    .line 339
    move-result v3

    .line 340
    if-nez v3, :cond_15c

    .line 341
    .line 342
    new-instance v2, Lcom/kousei/framework/id;

    .line 343
    .line 344
    invoke-direct {v2, v6}, Lcom/kousei/framework/id;-><init>(Z)V

    .line 345
    .line 346
    .line 347
    goto/16 :goto_1ef

    .line 348
    .line 349
    :cond_15c
    invoke-virtual {v1, v8}, Ljava/math/BigInteger;->subtract(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 350
    .line 351
    .line 352
    move-result-object v3

    .line 353
    invoke-virtual {v1, v9}, Ljava/math/BigInteger;->subtract(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 354
    .line 355
    .line 356
    move-result-object v10

    .line 357
    invoke-virtual {v3}, Ljava/math/BigInteger;->getLowestSetBit()I

    .line 358
    .line 359
    .line 360
    move-result v11

    .line 361
    invoke-virtual {v3, v11}, Ljava/math/BigInteger;->shiftRight(I)Ljava/math/BigInteger;

    .line 362
    .line 363
    .line 364
    move-result-object v12

    .line 365
    move v13, v7

    .line 366
    :goto_16d
    if-ge v13, v2, :cond_1ea

    .line 367
    .line 368
    invoke-static {v9, v10, v5}, Lcom/kousei/framework/v2;->c(Ljava/math/BigInteger;Ljava/math/BigInteger;Ljava/security/SecureRandom;)Ljava/math/BigInteger;

    .line 369
    .line 370
    .line 371
    move-result-object v14

    .line 372
    invoke-virtual {v14, v1}, Ljava/math/BigInteger;->gcd(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 373
    .line 374
    .line 375
    move-result-object v15

    .line 376
    invoke-virtual {v15, v8}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    .line 377
    .line 378
    .line 379
    move-result v15

    .line 380
    if-lez v15, :cond_185

    .line 381
    .line 382
    new-instance v2, Lcom/kousei/framework/id;

    .line 383
    .line 384
    const/4 v6, 0x1

    .line 385
    invoke-direct {v2, v6}, Lcom/kousei/framework/id;-><init>(Z)V

    .line 386
    .line 387
    .line 388
    goto/16 :goto_1ef

    .line 389
    .line 390
    :cond_185
    invoke-virtual {v14, v12, v1}, Ljava/math/BigInteger;->modPow(Ljava/math/BigInteger;Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 391
    .line 392
    .line 393
    move-result-object v14

    .line 394
    invoke-virtual {v14, v8}, Ljava/math/BigInteger;->equals(Ljava/lang/Object;)Z

    .line 395
    .line 396
    .line 397
    move-result v15

    .line 398
    if-nez v15, :cond_195

    .line 399
    .line 400
    invoke-virtual {v14, v3}, Ljava/math/BigInteger;->equals(Ljava/lang/Object;)Z

    .line 401
    .line 402
    .line 403
    move-result v15

    .line 404
    if-eqz v15, :cond_197

    .line 405
    .line 406
    :cond_195
    const/4 v6, 0x1

    .line 407
    goto :goto_1e7

    .line 408
    :cond_197
    move-object v15, v14

    .line 409
    const/4 v14, 0x1

    .line 410
    :goto_199
    if-ge v14, v11, :cond_1b5

    .line 411
    .line 412
    invoke-virtual {v15, v9, v1}, Ljava/math/BigInteger;->modPow(Ljava/math/BigInteger;Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 413
    .line 414
    .line 415
    move-result-object v6

    .line 416
    invoke-virtual {v6, v3}, Ljava/math/BigInteger;->equals(Ljava/lang/Object;)Z

    .line 417
    .line 418
    .line 419
    move-result v16

    .line 420
    if-eqz v16, :cond_1a8

    .line 421
    .line 422
    move-object v14, v6

    .line 423
    const/4 v6, 0x1

    .line 424
    goto :goto_1b7

    .line 425
    :cond_1a8
    invoke-virtual {v6, v8}, Ljava/math/BigInteger;->equals(Ljava/lang/Object;)Z

    .line 426
    .line 427
    .line 428
    move-result v16

    .line 429
    if-eqz v16, :cond_1b1

    .line 430
    .line 431
    move-object v14, v6

    .line 432
    move v6, v7

    .line 433
    goto :goto_1b7

    .line 434
    :cond_1b1
    add-int/lit8 v14, v14, 0x1

    .line 435
    .line 436
    move-object v15, v6

    .line 437
    goto :goto_199

    .line 438
    :cond_1b5
    move v6, v7

    .line 439
    move-object v14, v15

    .line 440
    :goto_1b7
    if-nez v6, :cond_195

    .line 441
    .line 442
    invoke-virtual {v14, v8}, Ljava/math/BigInteger;->equals(Ljava/lang/Object;)Z

    .line 443
    .line 444
    .line 445
    move-result v2

    .line 446
    if-nez v2, :cond_1cb

    .line 447
    .line 448
    invoke-virtual {v14, v9, v1}, Ljava/math/BigInteger;->modPow(Ljava/math/BigInteger;Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 449
    .line 450
    .line 451
    move-result-object v15

    .line 452
    invoke-virtual {v15, v8}, Ljava/math/BigInteger;->equals(Ljava/lang/Object;)Z

    .line 453
    .line 454
    .line 455
    move-result v2

    .line 456
    if-nez v2, :cond_1ca

    .line 457
    .line 458
    goto :goto_1cb

    .line 459
    :cond_1ca
    move-object v15, v14

    .line 460
    :cond_1cb
    :goto_1cb
    invoke-virtual {v15, v8}, Ljava/math/BigInteger;->subtract(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 461
    .line 462
    .line 463
    move-result-object v2

    .line 464
    invoke-virtual {v2, v1}, Ljava/math/BigInteger;->gcd(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 465
    .line 466
    .line 467
    move-result-object v2

    .line 468
    invoke-virtual {v2, v8}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    .line 469
    .line 470
    .line 471
    move-result v2

    .line 472
    if-lez v2, :cond_1e0

    .line 473
    .line 474
    new-instance v2, Lcom/kousei/framework/id;

    .line 475
    .line 476
    const/4 v6, 0x1

    .line 477
    invoke-direct {v2, v6}, Lcom/kousei/framework/id;-><init>(Z)V

    .line 478
    .line 479
    .line 480
    goto :goto_1ef

    .line 481
    :cond_1e0
    const/4 v6, 0x1

    .line 482
    new-instance v2, Lcom/kousei/framework/id;

    .line 483
    .line 484
    invoke-direct {v2, v6}, Lcom/kousei/framework/id;-><init>(Z)V

    .line 485
    .line 486
    .line 487
    goto :goto_1ef

    .line 488
    :goto_1e7
    add-int/lit8 v13, v13, 0x1

    .line 489
    .line 490
    goto :goto_16d

    .line 491
    :cond_1ea
    new-instance v2, Lcom/kousei/framework/id;

    .line 492
    .line 493
    invoke-direct {v2, v7}, Lcom/kousei/framework/id;-><init>(Z)V

    .line 494
    .line 495
    .line 496
    :goto_1ef
    iget-boolean v2, v2, Lcom/kousei/framework/id;->a:Z

    .line 497
    .line 498
    if-eqz v2, :cond_1f4

    .line 499
    .line 500
    goto :goto_206

    .line 501
    :cond_1f4
    const-string v0, "RSA modulus is not composite"

    .line 502
    .line 503
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 504
    .line 505
    .line 506
    throw p4

    .line 507
    :cond_1fa
    const-string v0, "\'iterations\' must be > 0"

    .line 508
    .line 509
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 510
    .line 511
    .line 512
    throw p4

    .line 513
    :cond_200
    const-string v0, "\'random\' cannot be null"

    .line 514
    .line 515
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 516
    .line 517
    .line 518
    throw p4

    .line 519
    :cond_206
    :goto_206
    invoke-virtual {v4, v1}, Lcom/kousei/framework/u2;->a(Ljava/math/BigInteger;)V

    .line 520
    .line 521
    .line 522
    :goto_209
    iput-object v1, v0, Lcom/kousei/framework/xd;->L:Ljava/math/BigInteger;

    .line 523
    .line 524
    move-object/from16 v1, p3

    .line 525
    .line 526
    iput-object v1, v0, Lcom/kousei/framework/xd;->M:Ljava/math/BigInteger;

    .line 527
    .line 528
    return-void

    .line 529
    :cond_210
    const-string v0, "RSA modulus has a small prime factor"

    .line 530
    .line 531
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 532
    .line 533
    .line 534
    throw p4

    .line 535
    :cond_216
    new-instance v0, Ljava/lang/ArithmeticException;

    .line 536
    .line 537
    const-string v1, "BigInteger: modulus not positive"

    .line 538
    .line 539
    invoke-direct {v0, v1}, Ljava/lang/ArithmeticException;-><init>(Ljava/lang/String;)V

    .line 540
    .line 541
    .line 542
    throw v0

    .line 543
    :cond_21e
    move-object/from16 p4, v2

    .line 544
    .line 545
    const-string v0, "\'M\' must be odd"

    .line 546
    .line 547
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 548
    .line 549
    .line 550
    throw p4

    .line 551
    :cond_226
    move-object/from16 p4, v2

    .line 552
    .line 553
    const-string v0, "RSA modulus out of range"

    .line 554
    .line 555
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 556
    .line 557
    .line 558
    throw p4

    .line 559
    :cond_22e
    move-object/from16 p4, v2

    .line 560
    .line 561
    const-string v0, "RSA modulus is even"

    .line 562
    .line 563
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 564
    .line 565
    .line 566
    throw p4

    .line 567
    :catchall_236
    move-exception v0

    .line 568
    :try_start_237
    monitor-exit v4
    :try_end_238
    .catchall {:try_start_237 .. :try_end_238} :catchall_236

    .line 569
    throw v0
.end method
