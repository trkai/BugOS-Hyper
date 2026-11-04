.class public abstract Lcom/kousei/framework/m3;
.super Ljava/lang/Object;
.source "r8-map-id-ab9d9a36b7cfe29bbfb78ee9a77c1feaf549e881397fc2be336a306d7a6faedf"


# static fields
.field public static final a:Ljava/util/concurrent/ConcurrentHashMap;

.field public static final b:Ljava/util/concurrent/ConcurrentHashMap;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 1
    const-wide v0, -0x53dfdf5b40d7L

    .line 2
    .line 3
    .line 4
    .line 5
    .line 6
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 7
    .line 8
    .line 9
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    .line 10
    .line 11
    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    .line 12
    .line 13
    .line 14
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    .line 15
    .line 16
    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    .line 17
    .line 18
    .line 19
    sput-object v0, Lcom/kousei/framework/m3;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 20
    .line 21
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    .line 22
    .line 23
    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    .line 24
    .line 25
    .line 26
    sput-object v0, Lcom/kousei/framework/m3;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 27
    .line 28
    return-void
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

.method public static a(Lcom/kousei/framework/k;)Z
    .registers 8

    .line 1
    const/4 v0, 0x0

    .line 2
    :try_start_1
    invoke-static {p0}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 3
    .line 4
    .line 5
    move-result-object p0

    .line 6
    move v1, v0

    .line 7
    :goto_6
    invoke-virtual {p0}, Lcom/kousei/framework/d0;->size()I

    .line 8
    .line 9
    .line 10
    move-result v2

    .line 11
    if-ge v1, v2, :cond_47

    .line 12
    .line 13
    invoke-virtual {p0, v1}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 14
    .line 15
    .line 16
    move-result-object v2

    .line 17
    instance-of v3, v2, Lcom/kousei/framework/k2;

    .line 18
    .line 19
    if-nez v3, :cond_15

    .line 20
    .line 21
    goto :goto_44

    .line 22
    :cond_15
    check-cast v2, Lcom/kousei/framework/k2;

    .line 23
    .line 24
    iget v3, v2, Lcom/kousei/framework/k2;->M:I

    .line 25
    .line 26
    const/4 v4, 0x1

    .line 27
    if-eq v3, v4, :cond_1d

    .line 28
    .line 29
    goto :goto_44

    .line 30
    :cond_1d
    invoke-virtual {v2}, Lcom/kousei/framework/k2;->q()Lcom/kousei/framework/s;

    .line 31
    .line 32
    .line 33
    move-result-object v2

    .line 34
    invoke-virtual {v2}, Lcom/kousei/framework/s;->b()Lcom/kousei/framework/a0;

    .line 35
    .line 36
    .line 37
    move-result-object v2

    .line 38
    invoke-static {v2}, Lcom/kousei/framework/e0;->r(Lcom/kousei/framework/k;)Lcom/kousei/framework/e0;

    .line 39
    .line 40
    .line 41
    move-result-object v2

    .line 42
    move v3, v0

    .line 43
    :goto_2a
    iget-object v5, v2, Lcom/kousei/framework/e0;->K:[Lcom/kousei/framework/k;

    .line 44
    .line 45
    array-length v6, v5

    .line 46
    if-ge v3, v6, :cond_44

    .line 47
    .line 48
    aget-object v5, v5, v3

    .line 49
    .line 50
    invoke-static {v5}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 51
    .line 52
    .line 53
    move-result-object v5

    .line 54
    invoke-virtual {v5}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 55
    .line 56
    .line 57
    move-result-object v5

    .line 58
    invoke-virtual {v5}, Ljava/math/BigInteger;->intValue()I

    .line 59
    .line 60
    .line 61
    move-result v5
    :try_end_3d
    .catchall {:try_start_1 .. :try_end_3d} :catchall_47

    .line 62
    const/4 v6, 0x7

    .line 63
    if-ne v5, v6, :cond_41

    .line 64
    .line 65
    return v4

    .line 66
    :cond_41
    add-int/lit8 v3, v3, 0x1

    .line 67
    .line 68
    goto :goto_2a

    .line 69
    :cond_44
    :goto_44
    add-int/lit8 v1, v1, 0x1

    .line 70
    .line 71
    goto :goto_6

    .line 72
    :catchall_47
    :cond_47
    return v0
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

.method public static b(Ljava/lang/String;Ljava/security/PrivateKey;)Lcom/kousei/framework/k3;
    .registers 6

    .line 1
    new-instance v0, Lcom/kousei/framework/u5;

    .line 2
    .line 3
    invoke-static {p0}, Lcom/kousei/framework/u5;->e(Ljava/lang/String;)Lcom/kousei/framework/k0;

    .line 4
    .line 5
    .line 6
    move-result-object p0

    .line 7
    instance-of v0, p1, Ljava/security/interfaces/ECPrivateKey;

    .line 8
    .line 9
    if-eqz v0, :cond_16

    .line 10
    .line 11
    invoke-static {p1}, Lcom/kousei/framework/i0;->J0(Ljava/security/PrivateKey;)Lcom/kousei/framework/n0;

    .line 12
    .line 13
    .line 14
    move-result-object p1

    .line 15
    check-cast p1, Lcom/kousei/framework/f7;

    .line 16
    .line 17
    new-instance v0, Lcom/kousei/framework/k3;

    .line 18
    .line 19
    invoke-direct {v0, p0, p1}, Lcom/kousei/framework/k3;-><init>(Lcom/kousei/framework/k0;Lcom/kousei/framework/f7;)V

    .line 20
    .line 21
    .line 22
    return-object v0

    .line 23
    :cond_16
    instance-of v0, p1, Ljava/security/interfaces/RSAPrivateCrtKey;

    .line 24
    .line 25
    if-eqz v0, :cond_31

    .line 26
    .line 27
    check-cast p1, Ljava/security/interfaces/RSAPrivateCrtKey;

    .line 28
    .line 29
    new-instance v0, Lcom/kousei/framework/xd;

    .line 30
    .line 31
    invoke-interface {p1}, Ljava/security/interfaces/RSAKey;->getModulus()Ljava/math/BigInteger;

    .line 32
    .line 33
    .line 34
    move-result-object v1

    .line 35
    invoke-interface {p1}, Ljava/security/interfaces/RSAPrivateKey;->getPrivateExponent()Ljava/math/BigInteger;

    .line 36
    .line 37
    .line 38
    move-result-object p1

    .line 39
    const/4 v2, 0x0

    .line 40
    const/4 v3, 0x1

    .line 41
    invoke-direct {v0, v3, v1, p1, v2}, Lcom/kousei/framework/xd;-><init>(ZLjava/math/BigInteger;Ljava/math/BigInteger;I)V

    .line 42
    .line 43
    .line 44
    new-instance p1, Lcom/kousei/framework/k3;

    .line 45
    .line 46
    invoke-direct {p1, p0, v0}, Lcom/kousei/framework/k3;-><init>(Lcom/kousei/framework/k0;Lcom/kousei/framework/xd;)V

    .line 47
    .line 48
    .line 49
    return-object p1

    .line 50
    :cond_31
    const-wide v0, -0x523ddf5b40d7L

    .line 51
    .line 52
    .line 53
    .line 54
    .line 55
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 56
    .line 57
    .line 58
    move-result-object p0

    .line 59
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 60
    .line 61
    .line 62
    move-result-object p1

    .line 63
    new-instance v0, Ljava/lang/StringBuilder;

    .line 64
    .line 65
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 66
    .line 67
    .line 68
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 69
    .line 70
    .line 71
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 72
    .line 73
    .line 74
    new-instance p0, Ljava/lang/IllegalArgumentException;

    .line 75
    .line 76
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 77
    .line 78
    .line 79
    move-result-object p1

    .line 80
    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .line 81
    .line 82
    .line 83
    throw p0
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
.end method

.method public static c(Lcom/kousei/framework/a0;Lcom/kousei/framework/l;[Lcom/kousei/framework/k;Lcom/kousei/framework/h7;)Lcom/kousei/framework/a8;
    .registers 20

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p1

    .line 4
    .line 5
    move-object/from16 v2, p2

    .line 6
    .line 7
    move-object/from16 v3, p3

    .line 8
    .line 9
    sget-object v4, Lcom/kousei/framework/o0;->a:[B

    .line 10
    .line 11
    if-nez v4, :cond_1a

    .line 12
    .line 13
    const/16 v4, 0x20

    .line 14
    .line 15
    new-array v4, v4, [B

    .line 16
    .line 17
    new-instance v5, Ljava/security/SecureRandom;

    .line 18
    .line 19
    invoke-direct {v5}, Ljava/security/SecureRandom;-><init>()V

    .line 20
    .line 21
    .line 22
    invoke-virtual {v5, v4}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 23
    .line 24
    .line 25
    sput-object v4, Lcom/kousei/framework/o0;->a:[B

    .line 26
    .line 27
    :cond_1a
    sget-object v4, Lcom/kousei/framework/o0;->a:[B

    .line 28
    .line 29
    invoke-static {}, Lcom/kousei/framework/o0;->d()[B

    .line 30
    .line 31
    .line 32
    move-result-object v5

    .line 33
    const/4 v6, 0x3

    .line 34
    if-nez v5, :cond_46

    .line 35
    .line 36
    instance-of v7, v0, Lcom/kousei/framework/d0;

    .line 37
    .line 38
    if-eqz v7, :cond_46

    .line 39
    .line 40
    :try_start_27
    check-cast v0, Lcom/kousei/framework/d0;

    .line 41
    .line 42
    invoke-virtual {v0, v6}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 43
    .line 44
    .line 45
    move-result-object v0

    .line 46
    instance-of v7, v0, Lcom/kousei/framework/o4;

    .line 47
    .line 48
    if-eqz v7, :cond_46

    .line 49
    .line 50
    check-cast v0, Lcom/kousei/framework/o4;

    .line 51
    .line 52
    iget-object v5, v0, Lcom/kousei/framework/w;->K:[B
    :try_end_35
    .catch Ljava/lang/Exception; {:try_start_27 .. :try_end_35} :catch_36

    .line 53
    .line 54
    goto :goto_46

    .line 55
    :catch_36
    const-wide v7, -0x5216df5b40d7L

    .line 56
    .line 57
    .line 58
    .line 59
    .line 60
    invoke-static {v7, v8}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 61
    .line 62
    .line 63
    const-wide v7, -0x53eddf5b40d7L

    .line 64
    .line 65
    .line 66
    .line 67
    .line 68
    invoke-static {v7, v8}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 69
    .line 70
    .line 71
    :cond_46
    :goto_46
    if-nez v5, :cond_4c

    .line 72
    .line 73
    invoke-static {}, Lcom/kousei/framework/o0;->d()[B

    .line 74
    .line 75
    .line 76
    move-result-object v5

    .line 77
    :cond_4c
    new-instance v0, Lcom/kousei/framework/o4;

    .line 78
    .line 79
    invoke-direct {v0, v4}, Lcom/kousei/framework/w;-><init>([B)V

    .line 80
    .line 81
    .line 82
    new-instance v4, Lcom/kousei/framework/m;

    .line 83
    .line 84
    const/4 v7, 0x0

    .line 85
    invoke-direct {v4, v7}, Lcom/kousei/framework/m;-><init>(I)V

    .line 86
    .line 87
    .line 88
    new-instance v8, Lcom/kousei/framework/o4;

    .line 89
    .line 90
    invoke-direct {v8, v5}, Lcom/kousei/framework/w;-><init>([B)V

    .line 91
    .line 92
    .line 93
    const/4 v5, 0x4

    .line 94
    new-array v5, v5, [Lcom/kousei/framework/k;

    .line 95
    .line 96
    aput-object v0, v5, v7

    .line 97
    .line 98
    sget-object v0, Lcom/kousei/framework/i;->M:Lcom/kousei/framework/i;

    .line 99
    .line 100
    const/4 v9, 0x1

    .line 101
    aput-object v0, v5, v9

    .line 102
    .line 103
    const/4 v0, 0x2

    .line 104
    aput-object v4, v5, v0

    .line 105
    .line 106
    aput-object v8, v5, v6

    .line 107
    .line 108
    new-instance v0, Lcom/kousei/framework/r4;

    .line 109
    .line 110
    invoke-direct {v0, v5, v7}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 111
    .line 112
    .line 113
    if-eqz v3, :cond_127

    .line 114
    .line 115
    iget-object v4, v3, Lcom/kousei/framework/h7;->e:Ljava/lang/Object;

    .line 116
    .line 117
    check-cast v4, [B

    .line 118
    .line 119
    iget-object v5, v3, Lcom/kousei/framework/h7;->d:Ljava/lang/Object;

    .line 120
    .line 121
    check-cast v5, [B

    .line 122
    .line 123
    iget-object v6, v3, Lcom/kousei/framework/h7;->c:Ljava/lang/Object;

    .line 124
    .line 125
    check-cast v6, [B

    .line 126
    .line 127
    iget-object v8, v3, Lcom/kousei/framework/h7;->b:Ljava/lang/Object;

    .line 128
    .line 129
    check-cast v8, [B

    .line 130
    .line 131
    iget-object v3, v3, Lcom/kousei/framework/h7;->a:Ljava/lang/Object;

    .line 132
    .line 133
    check-cast v3, [B

    .line 134
    .line 135
    if-nez v3, :cond_92

    .line 136
    .line 137
    if-nez v8, :cond_92

    .line 138
    .line 139
    if-nez v6, :cond_92

    .line 140
    .line 141
    if-nez v5, :cond_92

    .line 142
    .line 143
    if-nez v4, :cond_92

    .line 144
    .line 145
    goto/16 :goto_127

    .line 146
    .line 147
    :cond_92
    new-instance v10, Lcom/kousei/framework/l;

    .line 148
    .line 149
    invoke-direct {v10}, Lcom/kousei/framework/l;-><init>()V

    .line 150
    .line 151
    .line 152
    iget v11, v1, Lcom/kousei/framework/l;->b:I

    .line 153
    .line 154
    move v12, v7

    .line 155
    :goto_9a
    const/16 v15, 0x2c8

    .line 156
    .line 157
    const/16 v7, 0x2c7

    .line 158
    .line 159
    const/16 v9, 0x2c6

    .line 160
    .line 161
    if-ge v12, v11, :cond_d4

    .line 162
    .line 163
    invoke-virtual {v1, v12}, Lcom/kousei/framework/l;->c(I)Lcom/kousei/framework/k;

    .line 164
    .line 165
    .line 166
    move-result-object v13

    .line 167
    instance-of v14, v13, Lcom/kousei/framework/k2;

    .line 168
    .line 169
    if-eqz v14, :cond_cc

    .line 170
    .line 171
    move-object v14, v13

    .line 172
    check-cast v14, Lcom/kousei/framework/k2;

    .line 173
    .line 174
    iget v14, v14, Lcom/kousei/framework/k2;->M:I

    .line 175
    .line 176
    if-eqz v3, :cond_b4

    .line 177
    .line 178
    if-ne v14, v9, :cond_b4

    .line 179
    .line 180
    goto :goto_cf

    .line 181
    :cond_b4
    if-eqz v8, :cond_b9

    .line 182
    .line 183
    if-ne v14, v7, :cond_b9

    .line 184
    .line 185
    goto :goto_cf

    .line 186
    :cond_b9
    if-eqz v6, :cond_be

    .line 187
    .line 188
    if-ne v14, v15, :cond_be

    .line 189
    .line 190
    goto :goto_cf

    .line 191
    :cond_be
    if-eqz v5, :cond_c5

    .line 192
    .line 193
    const/16 v7, 0x2cc

    .line 194
    .line 195
    if-ne v14, v7, :cond_c5

    .line 196
    .line 197
    goto :goto_cf

    .line 198
    :cond_c5
    if-eqz v4, :cond_cc

    .line 199
    .line 200
    const/16 v7, 0x2cd

    .line 201
    .line 202
    if-ne v14, v7, :cond_cc

    .line 203
    .line 204
    goto :goto_cf

    .line 205
    :cond_cc
    invoke-virtual {v10, v13}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 206
    .line 207
    .line 208
    :goto_cf
    add-int/lit8 v12, v12, 0x1

    .line 209
    .line 210
    const/4 v7, 0x0

    .line 211
    const/4 v9, 0x1

    .line 212
    goto :goto_9a

    .line 213
    :cond_d4
    if-eqz v3, :cond_e5

    .line 214
    .line 215
    new-instance v1, Lcom/kousei/framework/k2;

    .line 216
    .line 217
    new-instance v11, Lcom/kousei/framework/o4;

    .line 218
    .line 219
    invoke-direct {v11, v3}, Lcom/kousei/framework/w;-><init>([B)V

    .line 220
    .line 221
    .line 222
    const/4 v3, 0x1

    .line 223
    invoke-direct {v1, v3, v9, v11, v3}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 224
    .line 225
    .line 226
    invoke-virtual {v10, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 227
    .line 228
    .line 229
    goto :goto_e6

    .line 230
    :cond_e5
    const/4 v3, 0x1

    .line 231
    :goto_e6
    if-eqz v8, :cond_f5

    .line 232
    .line 233
    new-instance v1, Lcom/kousei/framework/k2;

    .line 234
    .line 235
    new-instance v9, Lcom/kousei/framework/o4;

    .line 236
    .line 237
    invoke-direct {v9, v8}, Lcom/kousei/framework/w;-><init>([B)V

    .line 238
    .line 239
    .line 240
    invoke-direct {v1, v3, v7, v9, v3}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 241
    .line 242
    .line 243
    invoke-virtual {v10, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 244
    .line 245
    .line 246
    :cond_f5
    if-eqz v6, :cond_104

    .line 247
    .line 248
    new-instance v1, Lcom/kousei/framework/k2;

    .line 249
    .line 250
    new-instance v7, Lcom/kousei/framework/o4;

    .line 251
    .line 252
    invoke-direct {v7, v6}, Lcom/kousei/framework/w;-><init>([B)V

    .line 253
    .line 254
    .line 255
    invoke-direct {v1, v3, v15, v7, v3}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 256
    .line 257
    .line 258
    invoke-virtual {v10, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 259
    .line 260
    .line 261
    :cond_104
    if-eqz v5, :cond_115

    .line 262
    .line 263
    new-instance v1, Lcom/kousei/framework/k2;

    .line 264
    .line 265
    new-instance v6, Lcom/kousei/framework/o4;

    .line 266
    .line 267
    invoke-direct {v6, v5}, Lcom/kousei/framework/w;-><init>([B)V

    .line 268
    .line 269
    .line 270
    const/16 v7, 0x2cc

    .line 271
    .line 272
    invoke-direct {v1, v3, v7, v6, v3}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 273
    .line 274
    .line 275
    invoke-virtual {v10, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 276
    .line 277
    .line 278
    :cond_115
    if-eqz v4, :cond_126

    .line 279
    .line 280
    new-instance v1, Lcom/kousei/framework/k2;

    .line 281
    .line 282
    new-instance v5, Lcom/kousei/framework/o4;

    .line 283
    .line 284
    invoke-direct {v5, v4}, Lcom/kousei/framework/w;-><init>([B)V

    .line 285
    .line 286
    .line 287
    const/16 v7, 0x2cd

    .line 288
    .line 289
    invoke-direct {v1, v3, v7, v5, v3}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 290
    .line 291
    .line 292
    invoke-virtual {v10, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 293
    .line 294
    .line 295
    :cond_126
    move-object v1, v10

    .line 296
    :cond_127
    :goto_127
    new-instance v3, Lcom/kousei/framework/k2;

    .line 297
    .line 298
    new-instance v4, Lcom/kousei/framework/q;

    .line 299
    .line 300
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 301
    .line 302
    .line 303
    move-result-object v5

    .line 304
    iget-object v5, v5, Lcom/kousei/framework/gi;->f:Lcom/kousei/framework/k3;

    .line 305
    .line 306
    if-eqz v5, :cond_145

    .line 307
    .line 308
    iget-object v5, v5, Lcom/kousei/framework/k3;->i:Ljava/lang/Object;

    .line 309
    .line 310
    check-cast v5, Ljava/lang/String;

    .line 311
    .line 312
    if-eqz v5, :cond_145

    .line 313
    .line 314
    const/4 v6, 0x1

    .line 315
    invoke-static {v5, v6}, Lcom/kousei/framework/o0;->g(Ljava/lang/String;Z)Ljava/lang/Integer;

    .line 316
    .line 317
    .line 318
    move-result-object v5

    .line 319
    if-eqz v5, :cond_146

    .line 320
    .line 321
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    .line 322
    .line 323
    .line 324
    move-result v5

    .line 325
    goto :goto_14c

    .line 326
    :cond_145
    const/4 v6, 0x1

    .line 327
    :cond_146
    sget-object v5, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    .line 328
    .line 329
    invoke-static {v6}, Lcom/kousei/framework/o0;->b(Z)I

    .line 330
    .line 331
    .line 332
    move-result v5

    .line 333
    :goto_14c
    invoke-direct {v4, v5}, Lcom/kousei/framework/q;-><init>(I)V

    .line 334
    .line 335
    .line 336
    const/16 v5, 0x2ce

    .line 337
    .line 338
    invoke-direct {v3, v6, v5, v4, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 339
    .line 340
    .line 341
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 342
    .line 343
    .line 344
    new-instance v3, Lcom/kousei/framework/k2;

    .line 345
    .line 346
    new-instance v4, Lcom/kousei/framework/q;

    .line 347
    .line 348
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 349
    .line 350
    .line 351
    move-result-object v5

    .line 352
    iget-object v5, v5, Lcom/kousei/framework/gi;->f:Lcom/kousei/framework/k3;

    .line 353
    .line 354
    if-eqz v5, :cond_174

    .line 355
    .line 356
    iget-object v5, v5, Lcom/kousei/framework/k3;->h:Ljava/lang/Object;

    .line 357
    .line 358
    check-cast v5, Ljava/lang/String;

    .line 359
    .line 360
    if-eqz v5, :cond_174

    .line 361
    .line 362
    invoke-static {v5, v6}, Lcom/kousei/framework/o0;->g(Ljava/lang/String;Z)Ljava/lang/Integer;

    .line 363
    .line 364
    .line 365
    move-result-object v5

    .line 366
    if-eqz v5, :cond_174

    .line 367
    .line 368
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    .line 369
    .line 370
    .line 371
    move-result v5

    .line 372
    goto :goto_17a

    .line 373
    :cond_174
    sget-object v5, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    .line 374
    .line 375
    invoke-static {v6}, Lcom/kousei/framework/o0;->b(Z)I

    .line 376
    .line 377
    .line 378
    move-result v5

    .line 379
    :goto_17a
    invoke-direct {v4, v5}, Lcom/kousei/framework/q;-><init>(I)V

    .line 380
    .line 381
    .line 382
    const/16 v5, 0x2cf

    .line 383
    .line 384
    invoke-direct {v3, v6, v5, v4, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 385
    .line 386
    .line 387
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 388
    .line 389
    .line 390
    new-instance v3, Lcom/kousei/framework/k2;

    .line 391
    .line 392
    new-instance v4, Lcom/kousei/framework/q;

    .line 393
    .line 394
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 395
    .line 396
    .line 397
    move-result-object v5

    .line 398
    iget-object v5, v5, Lcom/kousei/framework/gi;->f:Lcom/kousei/framework/k3;

    .line 399
    .line 400
    if-eqz v5, :cond_1a3

    .line 401
    .line 402
    iget-object v5, v5, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 403
    .line 404
    check-cast v5, Ljava/lang/String;

    .line 405
    .line 406
    if-eqz v5, :cond_1a3

    .line 407
    .line 408
    const/4 v6, 0x0

    .line 409
    invoke-static {v5, v6}, Lcom/kousei/framework/o0;->g(Ljava/lang/String;Z)Ljava/lang/Integer;

    .line 410
    .line 411
    .line 412
    move-result-object v5

    .line 413
    if-eqz v5, :cond_1a4

    .line 414
    .line 415
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    .line 416
    .line 417
    .line 418
    move-result v5

    .line 419
    goto :goto_1aa

    .line 420
    :cond_1a3
    const/4 v6, 0x0

    .line 421
    :cond_1a4
    sget-object v5, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    .line 422
    .line 423
    invoke-static {v6}, Lcom/kousei/framework/o0;->b(Z)I

    .line 424
    .line 425
    .line 426
    move-result v5

    .line 427
    :goto_1aa
    invoke-direct {v4, v5}, Lcom/kousei/framework/q;-><init>(I)V

    .line 428
    .line 429
    .line 430
    const/16 v5, 0x2c2

    .line 431
    .line 432
    const/4 v6, 0x1

    .line 433
    invoke-direct {v3, v6, v5, v4, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 434
    .line 435
    .line 436
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 437
    .line 438
    .line 439
    new-instance v3, Lcom/kousei/framework/k2;

    .line 440
    .line 441
    new-instance v4, Lcom/kousei/framework/q;

    .line 442
    .line 443
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 444
    .line 445
    packed-switch v5, :pswitch_data_206

    .line 446
    .line 447
    .line 448
    const v5, 0x27100

    .line 449
    .line 450
    .line 451
    goto :goto_1d2

    .line 452
    :pswitch_1c3
    const v5, 0x249f0

    .line 453
    .line 454
    .line 455
    goto :goto_1d2

    .line 456
    :pswitch_1c7
    const v5, 0x222e0

    .line 457
    .line 458
    .line 459
    goto :goto_1d2

    .line 460
    :pswitch_1cb
    const v5, 0x1fbd0

    .line 461
    .line 462
    .line 463
    goto :goto_1d2

    .line 464
    :pswitch_1cf
    const v5, 0x1d524

    .line 465
    .line 466
    .line 467
    :goto_1d2
    invoke-direct {v4, v5}, Lcom/kousei/framework/q;-><init>(I)V

    .line 468
    .line 469
    .line 470
    const/16 v5, 0x2c1

    .line 471
    .line 472
    const/4 v6, 0x1

    .line 473
    invoke-direct {v3, v6, v5, v4, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 474
    .line 475
    .line 476
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 477
    .line 478
    .line 479
    new-instance v3, Lcom/kousei/framework/k2;

    .line 480
    .line 481
    const/16 v4, 0x2c0

    .line 482
    .line 483
    invoke-direct {v3, v6, v4, v0, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 484
    .line 485
    .line 486
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 487
    .line 488
    .line 489
    new-instance v0, Lcom/kousei/framework/r4;

    .line 490
    .line 491
    const/4 v6, 0x0

    .line 492
    invoke-direct {v0, v1, v6}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 493
    .line 494
    .line 495
    const/4 v1, -0x1

    .line 496
    iput v1, v0, Lcom/kousei/framework/r4;->N:I

    .line 497
    .line 498
    const/4 v1, 0x7

    .line 499
    aput-object v0, v2, v1

    .line 500
    .line 501
    new-instance v0, Lcom/kousei/framework/r4;

    .line 502
    .line 503
    invoke-direct {v0, v2, v6}, Lcom/kousei/framework/r4;-><init>([Lcom/kousei/framework/k;I)V

    .line 504
    .line 505
    .line 506
    new-instance v1, Lcom/kousei/framework/o4;

    .line 507
    .line 508
    invoke-direct {v1, v0}, Lcom/kousei/framework/o4;-><init>(Lcom/kousei/framework/s;)V

    .line 509
    .line 510
    .line 511
    new-instance v0, Lcom/kousei/framework/a8;

    .line 512
    .line 513
    sget-object v2, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 514
    .line 515
    invoke-direct {v0, v2, v6, v1}, Lcom/kousei/framework/a8;-><init>(Lcom/kousei/framework/v;ZLcom/kousei/framework/o4;)V

    .line 516
    .line 517
    .line 518
    return-object v0

    .line 519
    :pswitch_data_206
    .packed-switch 0x20
        :pswitch_1cf
        :pswitch_1cb
        :pswitch_1c7
        :pswitch_1c3
    .end packed-switch
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

.method public static d(Ljava/security/cert/X509Certificate;Ljava/security/cert/CertificateFactory;Lcom/kousei/framework/h7;)[Ljava/security/cert/Certificate;
    .registers 21

    .line 1
    const/4 v1, 0x0

    .line 2
    :try_start_1
    new-instance v0, Lcom/kousei/framework/yi;

    .line 3
    .line 4
    invoke-virtual/range {p0 .. p0}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 5
    .line 6
    .line 7
    move-result-object v2

    .line 8
    invoke-direct {v0, v2}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 9
    .line 10
    .line 11
    iget-object v2, v0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 12
    .line 13
    sget-object v3, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 14
    .line 15
    invoke-virtual {v0, v3}, Lcom/kousei/framework/yi;->a(Lcom/kousei/framework/v;)Lcom/kousei/framework/a8;

    .line 16
    .line 17
    .line 18
    move-result-object v3

    .line 19
    if-nez v3, :cond_15

    .line 20
    .line 21
    goto :goto_6b

    .line 22
    :cond_15
    iget-object v3, v3, Lcom/kousei/framework/a8;->M:Lcom/kousei/framework/w;

    .line 23
    .line 24
    iget-object v3, v3, Lcom/kousei/framework/w;->K:[B

    .line 25
    .line 26
    invoke-static {v3}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 27
    .line 28
    .line 29
    move-result-object v3

    .line 30
    invoke-virtual {v3}, Lcom/kousei/framework/d0;->z()[Lcom/kousei/framework/k;

    .line 31
    .line 32
    .line 33
    move-result-object v3

    .line 34
    const/4 v4, 0x7

    .line 35
    aget-object v4, v3, v4

    .line 36
    .line 37
    check-cast v4, Lcom/kousei/framework/d0;

    .line 38
    .line 39
    new-instance v5, Lcom/kousei/framework/l;

    .line 40
    .line 41
    invoke-direct {v5}, Lcom/kousei/framework/l;-><init>()V

    .line 42
    .line 43
    .line 44
    invoke-virtual {v4}, Lcom/kousei/framework/d0;->iterator()Ljava/util/Iterator;

    .line 45
    .line 46
    .line 47
    move-result-object v4

    .line 48
    move-object v6, v1

    .line 49
    :goto_30
    move-object v7, v4

    .line 50
    check-cast v7, Lcom/kousei/framework/l0;

    .line 51
    .line 52
    invoke-virtual {v7}, Lcom/kousei/framework/l0;->hasNext()Z

    .line 53
    .line 54
    .line 55
    move-result v8

    .line 56
    if-eqz v8, :cond_57

    .line 57
    .line 58
    invoke-virtual {v7}, Lcom/kousei/framework/l0;->next()Ljava/lang/Object;

    .line 59
    .line 60
    .line 61
    move-result-object v7

    .line 62
    check-cast v7, Lcom/kousei/framework/k;

    .line 63
    .line 64
    check-cast v7, Lcom/kousei/framework/k2;

    .line 65
    .line 66
    iget v8, v7, Lcom/kousei/framework/k2;->M:I

    .line 67
    .line 68
    const/16 v9, 0x2c0

    .line 69
    .line 70
    if-ne v8, v9, :cond_53

    .line 71
    .line 72
    invoke-virtual {v7}, Lcom/kousei/framework/k2;->q()Lcom/kousei/framework/s;

    .line 73
    .line 74
    .line 75
    move-result-object v6

    .line 76
    invoke-virtual {v6}, Lcom/kousei/framework/s;->b()Lcom/kousei/framework/a0;

    .line 77
    .line 78
    .line 79
    move-result-object v6

    .line 80
    goto :goto_30

    .line 81
    :catch_50
    move-exception v0

    .line 82
    goto/16 :goto_17b

    .line 83
    .line 84
    :cond_53
    invoke-virtual {v5, v7}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 85
    .line 86
    .line 87
    goto :goto_30

    .line 88
    :cond_57
    invoke-virtual/range {p0 .. p0}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    .line 89
    .line 90
    .line 91
    move-result-object v4

    .line 92
    invoke-interface {v4}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 93
    .line 94
    .line 95
    move-result-object v4

    .line 96
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 97
    .line 98
    .line 99
    move-result-object v7

    .line 100
    iget-object v7, v7, Lcom/kousei/framework/gi;->i:Lcom/kousei/framework/da;

    .line 101
    .line 102
    invoke-virtual {v7, v4}, Lcom/kousei/framework/da;->b(Ljava/lang/String;)Lcom/kousei/framework/ca;

    .line 103
    .line 104
    .line 105
    move-result-object v4

    .line 106
    if-nez v4, :cond_6c

    .line 107
    .line 108
    :goto_6b
    return-object v1

    .line 109
    :cond_6c
    iget-object v7, v4, Lcom/kousei/framework/ca;->a:Ljava/security/KeyPair;

    .line 110
    .line 111
    new-instance v8, Ljava/util/ArrayList;

    .line 112
    .line 113
    iget-object v4, v4, Lcom/kousei/framework/ca;->b:Ljava/util/ArrayList;

    .line 114
    .line 115
    invoke-direct {v8, v4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 116
    .line 117
    .line 118
    new-instance v4, Lcom/kousei/framework/yi;

    .line 119
    .line 120
    const/4 v9, 0x0

    .line 121
    invoke-virtual {v8, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 122
    .line 123
    .line 124
    move-result-object v10

    .line 125
    check-cast v10, Ljava/security/cert/Certificate;

    .line 126
    .line 127
    invoke-virtual {v10}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 128
    .line 129
    .line 130
    move-result-object v10

    .line 131
    invoke-direct {v4, v10}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 132
    .line 133
    .line 134
    invoke-virtual {v0}, Lcom/kousei/framework/yi;->b()Lcom/kousei/framework/wi;

    .line 135
    .line 136
    .line 137
    move-result-object v16
    :try_end_89
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_89} :catch_50

    .line 138
    :try_start_89
    invoke-virtual/range {v16 .. v16}, Lcom/kousei/framework/wi;->toString()Ljava/lang/String;

    .line 139
    .line 140
    .line 141
    move-result-object v10
    :try_end_8d
    .catchall {:try_start_89 .. :try_end_8d} :catchall_8e

    .line 142
    goto :goto_a0

    .line 143
    :catchall_8e
    :try_start_8e
    new-instance v10, Ljava/lang/String;

    .line 144
    .line 145
    invoke-virtual/range {v16 .. v16}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 146
    .line 147
    .line 148
    move-result-object v11

    .line 149
    invoke-direct {v10, v11}, Ljava/lang/String;-><init>([B)V
    :try_end_97
    .catchall {:try_start_8e .. :try_end_97} :catchall_98

    .line 150
    .line 151
    .line 152
    goto :goto_a0

    .line 153
    :catchall_98
    :try_start_98
    invoke-static/range {v16 .. v16}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    .line 154
    .line 155
    .line 156
    move-result v10

    .line 157
    invoke-static {v10}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    .line 158
    .line 159
    .line 160
    move-result-object v10

    .line 161
    :goto_a0
    sget-object v11, Lcom/kousei/framework/m3;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 162
    .line 163
    invoke-virtual {v11, v10}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 164
    .line 165
    .line 166
    move-result-object v10

    .line 167
    check-cast v10, Lcom/kousei/framework/l3;

    .line 168
    .line 169
    if-eqz v10, :cond_b1

    .line 170
    .line 171
    iget-object v10, v10, Lcom/kousei/framework/l3;->a:Ljava/security/KeyPair;

    .line 172
    .line 173
    invoke-virtual {v10}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    .line 174
    .line 175
    .line 176
    move-result-object v10

    .line 177
    goto :goto_d7

    .line 178
    :cond_b1
    const-wide v10, -0x5224df5b40d7L

    .line 179
    .line 180
    .line 181
    .line 182
    .line 183
    invoke-static {v10, v11}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 184
    .line 185
    .line 186
    move-result-object v10

    .line 187
    invoke-static {v10}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;)Ljava/security/KeyPairGenerator;

    .line 188
    .line 189
    .line 190
    move-result-object v10

    .line 191
    new-instance v11, Ljava/security/spec/ECGenParameterSpec;

    .line 192
    .line 193
    const-wide v12, -0x5221df5b40d7L

    .line 194
    .line 195
    .line 196
    .line 197
    .line 198
    invoke-static {v12, v13}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 199
    .line 200
    .line 201
    move-result-object v12

    .line 202
    invoke-direct {v11, v12}, Ljava/security/spec/ECGenParameterSpec;-><init>(Ljava/lang/String;)V

    .line 203
    .line 204
    .line 205
    invoke-virtual {v10, v11}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 206
    .line 207
    .line 208
    invoke-virtual {v10}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;

    .line 209
    .line 210
    .line 211
    move-result-object v10

    .line 212
    invoke-virtual {v10}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    .line 213
    .line 214
    .line 215
    move-result-object v10

    .line 216
    :goto_d7
    invoke-interface {v10}, Ljava/security/Key;->getEncoded()[B

    .line 217
    .line 218
    .line 219
    move-result-object v10

    .line 220
    invoke-static {v10}, Lcom/kousei/framework/xh;->h(Ljava/lang/Object;)Lcom/kousei/framework/xh;

    .line 221
    .line 222
    .line 223
    move-result-object v17

    .line 224
    new-instance v11, Lcom/kousei/framework/m8;

    .line 225
    .line 226
    invoke-virtual {v4}, Lcom/kousei/framework/yi;->b()Lcom/kousei/framework/wi;

    .line 227
    .line 228
    .line 229
    move-result-object v12

    .line 230
    iget-object v4, v2, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 231
    .line 232
    iget-object v4, v4, Lcom/kousei/framework/ai;->M:Lcom/kousei/framework/q;

    .line 233
    .line 234
    invoke-virtual {v4}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 235
    .line 236
    .line 237
    move-result-object v13

    .line 238
    iget-object v4, v2, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 239
    .line 240
    iget-object v4, v4, Lcom/kousei/framework/ai;->P:Lcom/kousei/framework/ni;

    .line 241
    .line 242
    iget-object v4, v4, Lcom/kousei/framework/ni;->K:Lcom/kousei/framework/ei;

    .line 243
    .line 244
    invoke-virtual {v4}, Lcom/kousei/framework/ei;->h()Ljava/util/Date;

    .line 245
    .line 246
    .line 247
    move-result-object v14

    .line 248
    iget-object v2, v2, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 249
    .line 250
    iget-object v2, v2, Lcom/kousei/framework/ai;->P:Lcom/kousei/framework/ni;

    .line 251
    .line 252
    iget-object v2, v2, Lcom/kousei/framework/ni;->L:Lcom/kousei/framework/ei;

    .line 253
    .line 254
    invoke-virtual {v2}, Lcom/kousei/framework/ei;->h()Ljava/util/Date;

    .line 255
    .line 256
    .line 257
    move-result-object v15

    .line 258
    invoke-direct/range {v11 .. v17}, Lcom/kousei/framework/m8;-><init>(Lcom/kousei/framework/wi;Ljava/math/BigInteger;Ljava/util/Date;Ljava/util/Date;Lcom/kousei/framework/wi;Lcom/kousei/framework/xh;)V

    .line 259
    .line 260
    .line 261
    invoke-virtual {v7}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    .line 262
    .line 263
    .line 264
    move-result-object v2

    .line 265
    invoke-static {v2}, Lcom/kousei/framework/m3;->k(Ljava/security/PrivateKey;)Ljava/lang/String;

    .line 266
    .line 267
    .line 268
    move-result-object v2

    .line 269
    invoke-virtual {v7}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    .line 270
    .line 271
    .line 272
    move-result-object v4

    .line 273
    invoke-static {v2, v4}, Lcom/kousei/framework/m3;->b(Ljava/lang/String;Ljava/security/PrivateKey;)Lcom/kousei/framework/k3;

    .line 274
    .line 275
    .line 276
    move-result-object v2

    .line 277
    move-object/from16 v4, p2

    .line 278
    .line 279
    invoke-static {v6, v5, v3, v4}, Lcom/kousei/framework/m3;->c(Lcom/kousei/framework/a0;Lcom/kousei/framework/l;[Lcom/kousei/framework/k;Lcom/kousei/framework/h7;)Lcom/kousei/framework/a8;

    .line 280
    .line 281
    .line 282
    move-result-object v3

    .line 283
    iget-object v4, v11, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 284
    .line 285
    check-cast v4, Lcom/kousei/framework/c8;

    .line 286
    .line 287
    invoke-virtual {v4, v3}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 288
    .line 289
    .line 290
    iget-object v3, v0, Lcom/kousei/framework/yi;->L:Lcom/kousei/framework/b8;

    .line 291
    .line 292
    invoke-virtual {v3}, Lcom/kousei/framework/b8;->h()[Lcom/kousei/framework/v;

    .line 293
    .line 294
    .line 295
    move-result-object v3

    .line 296
    array-length v4, v3

    .line 297
    move v5, v9

    .line 298
    :goto_129
    if-ge v5, v4, :cond_150

    .line 299
    .line 300
    aget-object v6, v3, v5

    .line 301
    .line 302
    invoke-virtual {v6}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 303
    .line 304
    .line 305
    move-result-object v6

    .line 306
    sget-object v7, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 307
    .line 308
    invoke-virtual {v7}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 309
    .line 310
    .line 311
    move-result-object v7

    .line 312
    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 313
    .line 314
    .line 315
    move-result v7

    .line 316
    if-nez v7, :cond_14d

    .line 317
    .line 318
    new-instance v7, Lcom/kousei/framework/v;

    .line 319
    .line 320
    invoke-direct {v7, v6}, Lcom/kousei/framework/v;-><init>(Ljava/lang/String;)V

    .line 321
    .line 322
    .line 323
    invoke-virtual {v0, v7}, Lcom/kousei/framework/yi;->a(Lcom/kousei/framework/v;)Lcom/kousei/framework/a8;

    .line 324
    .line 325
    .line 326
    move-result-object v6

    .line 327
    iget-object v7, v11, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 328
    .line 329
    check-cast v7, Lcom/kousei/framework/c8;

    .line 330
    .line 331
    invoke-virtual {v7, v6}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 332
    .line 333
    .line 334
    :cond_14d
    add-int/lit8 v5, v5, 0x1

    .line 335
    .line 336
    goto :goto_129

    .line 337
    :cond_150
    invoke-virtual {v11, v2}, Lcom/kousei/framework/m8;->c(Lcom/kousei/framework/k3;)Lcom/kousei/framework/yi;

    .line 338
    .line 339
    .line 340
    move-result-object v0

    .line 341
    new-instance v2, Ljava/io/ByteArrayInputStream;

    .line 342
    .line 343
    iget-object v0, v0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 344
    .line 345
    invoke-virtual {v0}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 346
    .line 347
    .line 348
    move-result-object v0

    .line 349
    invoke-direct {v2, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 350
    .line 351
    .line 352
    move-object/from16 v0, p1

    .line 353
    .line 354
    invoke-virtual {v0, v2}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 355
    .line 356
    .line 357
    move-result-object v0

    .line 358
    check-cast v0, Ljava/security/cert/X509Certificate;

    .line 359
    .line 360
    new-instance v2, Ljava/util/ArrayList;

    .line 361
    .line 362
    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 363
    .line 364
    .line 365
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 366
    .line 367
    .line 368
    invoke-virtual {v2, v8}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 369
    .line 370
    .line 371
    new-array v0, v9, [Ljava/security/cert/Certificate;

    .line 372
    .line 373
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    .line 374
    .line 375
    .line 376
    move-result-object v0

    .line 377
    check-cast v0, [Ljava/security/cert/Certificate;
    :try_end_17a
    .catch Ljava/lang/Exception; {:try_start_98 .. :try_end_17a} :catch_50

    .line 378
    .line 379
    return-object v0

    .line 380
    :goto_17b
    const-wide v2, -0x5288df5b40d7L

    .line 381
    .line 382
    .line 383
    .line 384
    .line 385
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 386
    .line 387
    .line 388
    move-result-object v2

    .line 389
    const-wide v3, -0x526fdf5b40d7L

    .line 390
    .line 391
    .line 392
    .line 393
    .line 394
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 395
    .line 396
    .line 397
    move-result-object v3

    .line 398
    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 399
    .line 400
    .line 401
    return-object v1
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

.method public static e([Ljava/security/cert/Certificate;Lcom/kousei/framework/h7;)[Ljava/security/cert/Certificate;
    .registers 6

    .line 1
    array-length v0, p0

    .line 2
    if-nez v0, :cond_4

    .line 3
    .line 4
    goto :goto_2f

    .line 5
    :cond_4
    const-wide v0, -0x5587df5b40d7L

    .line 6
    .line 7
    .line 8
    .line 9
    .line 10
    :try_start_9
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    invoke-static {v0}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    .line 15
    .line 16
    .line 17
    move-result-object v0

    .line 18
    new-instance v1, Ljava/io/ByteArrayInputStream;

    .line 19
    .line 20
    const/4 v2, 0x0

    .line 21
    aget-object v2, p0, v2

    .line 22
    .line 23
    invoke-virtual {v2}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 24
    .line 25
    .line 26
    move-result-object v2

    .line 27
    invoke-direct {v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 28
    .line 29
    .line 30
    invoke-virtual {v0, v1}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 31
    .line 32
    .line 33
    move-result-object v1

    .line 34
    check-cast v1, Ljava/security/cert/X509Certificate;

    .line 35
    .line 36
    sget-object v2, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 37
    .line 38
    invoke-virtual {v2}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 39
    .line 40
    .line 41
    move-result-object v2

    .line 42
    invoke-interface {v1, v2}, Ljava/security/cert/X509Extension;->getExtensionValue(Ljava/lang/String;)[B

    .line 43
    .line 44
    .line 45
    move-result-object v2

    .line 46
    if-nez v2, :cond_30

    .line 47
    .line 48
    :goto_2f
    return-object p0

    .line 49
    :cond_30
    invoke-static {}, Lcom/kousei/framework/m3;->j()V

    .line 50
    .line 51
    .line 52
    invoke-static {v1}, Lcom/kousei/framework/m3;->h(Ljava/security/cert/X509Certificate;)Z

    .line 53
    .line 54
    .line 55
    move-result v2

    .line 56
    if-eqz v2, :cond_42

    .line 57
    .line 58
    invoke-static {v1, v0, p1}, Lcom/kousei/framework/m3;->d(Ljava/security/cert/X509Certificate;Ljava/security/cert/CertificateFactory;Lcom/kousei/framework/h7;)[Ljava/security/cert/Certificate;

    .line 59
    .line 60
    .line 61
    move-result-object v2

    .line 62
    if-eqz v2, :cond_4d

    .line 63
    .line 64
    return-object v2

    .line 65
    :catch_40
    move-exception p1

    .line 66
    goto :goto_52

    .line 67
    :cond_42
    array-length v2, p0

    .line 68
    const/4 v3, 0x1

    .line 69
    if-ne v2, v3, :cond_4d

    .line 70
    .line 71
    invoke-static {v1, v0, p1}, Lcom/kousei/framework/m3;->g(Ljava/security/cert/X509Certificate;Ljava/security/cert/CertificateFactory;Lcom/kousei/framework/h7;)[Ljava/security/cert/Certificate;

    .line 72
    .line 73
    .line 74
    move-result-object v2

    .line 75
    if-eqz v2, :cond_4d

    .line 76
    .line 77
    return-object v2

    .line 78
    :cond_4d
    invoke-static {v1, p0, v0, p1}, Lcom/kousei/framework/m3;->f(Ljava/security/cert/X509Certificate;[Ljava/security/cert/Certificate;Ljava/security/cert/CertificateFactory;Lcom/kousei/framework/h7;)[Ljava/security/cert/Certificate;

    .line 79
    .line 80
    .line 81
    move-result-object p0
    :try_end_51
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_51} :catch_40

    .line 82
    return-object p0

    .line 83
    :goto_52
    const-wide v0, -0x5581df5b40d7L

    .line 84
    .line 85
    .line 86
    .line 87
    .line 88
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 89
    .line 90
    .line 91
    move-result-object v0

    .line 92
    const-wide v1, -0x5598df5b40d7L

    .line 93
    .line 94
    .line 95
    .line 96
    .line 97
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 98
    .line 99
    .line 100
    move-result-object v1

    .line 101
    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 102
    .line 103
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
.end method

.method public static f(Ljava/security/cert/X509Certificate;[Ljava/security/cert/Certificate;Ljava/security/cert/CertificateFactory;Lcom/kousei/framework/h7;)[Ljava/security/cert/Certificate;
    .registers 21

    .line 1
    :try_start_0
    new-instance v0, Lcom/kousei/framework/yi;

    .line 2
    .line 3
    invoke-virtual/range {p0 .. p0}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 4
    .line 5
    .line 6
    move-result-object v1

    .line 7
    invoke-direct {v0, v1}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 8
    .line 9
    .line 10
    iget-object v1, v0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 11
    .line 12
    sget-object v2, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 13
    .line 14
    invoke-virtual {v0, v2}, Lcom/kousei/framework/yi;->a(Lcom/kousei/framework/v;)Lcom/kousei/framework/a8;

    .line 15
    .line 16
    .line 17
    move-result-object v2

    .line 18
    iget-object v2, v2, Lcom/kousei/framework/a8;->M:Lcom/kousei/framework/w;

    .line 19
    .line 20
    iget-object v2, v2, Lcom/kousei/framework/w;->K:[B

    .line 21
    .line 22
    invoke-static {v2}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 23
    .line 24
    .line 25
    move-result-object v2

    .line 26
    invoke-virtual {v2}, Lcom/kousei/framework/d0;->z()[Lcom/kousei/framework/k;

    .line 27
    .line 28
    .line 29
    move-result-object v2

    .line 30
    const/4 v3, 0x7

    .line 31
    aget-object v3, v2, v3

    .line 32
    .line 33
    check-cast v3, Lcom/kousei/framework/d0;

    .line 34
    .line 35
    new-instance v4, Lcom/kousei/framework/l;

    .line 36
    .line 37
    invoke-direct {v4}, Lcom/kousei/framework/l;-><init>()V

    .line 38
    .line 39
    .line 40
    invoke-virtual {v3}, Lcom/kousei/framework/d0;->iterator()Ljava/util/Iterator;

    .line 41
    .line 42
    .line 43
    move-result-object v3

    .line 44
    const/4 v5, 0x0

    .line 45
    :goto_2c
    move-object v6, v3

    .line 46
    check-cast v6, Lcom/kousei/framework/l0;

    .line 47
    .line 48
    invoke-virtual {v6}, Lcom/kousei/framework/l0;->hasNext()Z

    .line 49
    .line 50
    .line 51
    move-result v7

    .line 52
    if-eqz v7, :cond_53

    .line 53
    .line 54
    invoke-virtual {v6}, Lcom/kousei/framework/l0;->next()Ljava/lang/Object;

    .line 55
    .line 56
    .line 57
    move-result-object v6

    .line 58
    check-cast v6, Lcom/kousei/framework/k;

    .line 59
    .line 60
    check-cast v6, Lcom/kousei/framework/k2;

    .line 61
    .line 62
    iget v7, v6, Lcom/kousei/framework/k2;->M:I

    .line 63
    .line 64
    const/16 v8, 0x2c0

    .line 65
    .line 66
    if-ne v7, v8, :cond_4f

    .line 67
    .line 68
    invoke-virtual {v6}, Lcom/kousei/framework/k2;->q()Lcom/kousei/framework/s;

    .line 69
    .line 70
    .line 71
    move-result-object v5

    .line 72
    invoke-virtual {v5}, Lcom/kousei/framework/s;->b()Lcom/kousei/framework/a0;

    .line 73
    .line 74
    .line 75
    move-result-object v5

    .line 76
    goto :goto_2c

    .line 77
    :catch_4c
    move-exception v0

    .line 78
    goto/16 :goto_157

    .line 79
    .line 80
    :cond_4f
    invoke-virtual {v4, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 81
    .line 82
    .line 83
    goto :goto_2c

    .line 84
    :cond_53
    invoke-virtual/range {p0 .. p0}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    .line 85
    .line 86
    .line 87
    move-result-object v3

    .line 88
    invoke-interface {v3}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 89
    .line 90
    .line 91
    move-result-object v3

    .line 92
    invoke-static {}, Lcom/kousei/framework/gi;->c()Lcom/kousei/framework/gi;

    .line 93
    .line 94
    .line 95
    move-result-object v6

    .line 96
    iget-object v6, v6, Lcom/kousei/framework/gi;->i:Lcom/kousei/framework/da;

    .line 97
    .line 98
    invoke-virtual {v6, v3}, Lcom/kousei/framework/da;->b(Ljava/lang/String;)Lcom/kousei/framework/ca;

    .line 99
    .line 100
    .line 101
    move-result-object v6

    .line 102
    if-nez v6, :cond_98

    .line 103
    .line 104
    new-instance v0, Ljava/lang/StringBuilder;

    .line 105
    .line 106
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 107
    .line 108
    .line 109
    const-wide v1, -0x5547df5b40d7L

    .line 110
    .line 111
    .line 112
    .line 113
    .line 114
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 115
    .line 116
    .line 117
    move-result-object v1

    .line 118
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 119
    .line 120
    .line 121
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 122
    .line 123
    .line 124
    const-wide v1, -0x5553df5b40d7L

    .line 125
    .line 126
    .line 127
    .line 128
    .line 129
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 130
    .line 131
    .line 132
    move-result-object v1

    .line 133
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 134
    .line 135
    .line 136
    const-wide v1, -0x552ddf5b40d7L

    .line 137
    .line 138
    .line 139
    .line 140
    .line 141
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 142
    .line 143
    .line 144
    move-result-object v1

    .line 145
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 146
    .line 147
    .line 148
    move-result-object v0

    .line 149
    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    .line 151
    .line 152
    return-object p1

    .line 153
    :cond_98
    iget-object v3, v6, Lcom/kousei/framework/ca;->a:Ljava/security/KeyPair;

    .line 154
    .line 155
    new-instance v7, Ljava/util/ArrayList;

    .line 156
    .line 157
    iget-object v6, v6, Lcom/kousei/framework/ca;->b:Ljava/util/ArrayList;

    .line 158
    .line 159
    invoke-direct {v7, v6}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 160
    .line 161
    .line 162
    new-instance v6, Lcom/kousei/framework/yi;

    .line 163
    .line 164
    const/4 v8, 0x0

    .line 165
    invoke-virtual {v7, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 166
    .line 167
    .line 168
    move-result-object v9

    .line 169
    check-cast v9, Ljava/security/cert/Certificate;

    .line 170
    .line 171
    invoke-virtual {v9}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 172
    .line 173
    .line 174
    move-result-object v9

    .line 175
    invoke-direct {v6, v9}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 176
    .line 177
    .line 178
    new-instance v10, Lcom/kousei/framework/m8;

    .line 179
    .line 180
    invoke-virtual {v6}, Lcom/kousei/framework/yi;->b()Lcom/kousei/framework/wi;

    .line 181
    .line 182
    .line 183
    move-result-object v11

    .line 184
    iget-object v6, v1, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 185
    .line 186
    iget-object v6, v6, Lcom/kousei/framework/ai;->M:Lcom/kousei/framework/q;

    .line 187
    .line 188
    invoke-virtual {v6}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 189
    .line 190
    .line 191
    move-result-object v12

    .line 192
    iget-object v6, v1, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 193
    .line 194
    iget-object v6, v6, Lcom/kousei/framework/ai;->P:Lcom/kousei/framework/ni;

    .line 195
    .line 196
    iget-object v6, v6, Lcom/kousei/framework/ni;->K:Lcom/kousei/framework/ei;

    .line 197
    .line 198
    invoke-virtual {v6}, Lcom/kousei/framework/ei;->h()Ljava/util/Date;

    .line 199
    .line 200
    .line 201
    move-result-object v13

    .line 202
    iget-object v6, v1, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 203
    .line 204
    iget-object v6, v6, Lcom/kousei/framework/ai;->P:Lcom/kousei/framework/ni;

    .line 205
    .line 206
    iget-object v6, v6, Lcom/kousei/framework/ni;->L:Lcom/kousei/framework/ei;

    .line 207
    .line 208
    invoke-virtual {v6}, Lcom/kousei/framework/ei;->h()Ljava/util/Date;

    .line 209
    .line 210
    .line 211
    move-result-object v14

    .line 212
    invoke-virtual {v0}, Lcom/kousei/framework/yi;->b()Lcom/kousei/framework/wi;

    .line 213
    .line 214
    .line 215
    move-result-object v15

    .line 216
    iget-object v1, v1, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 217
    .line 218
    iget-object v1, v1, Lcom/kousei/framework/ai;->R:Lcom/kousei/framework/xh;

    .line 219
    .line 220
    move-object/from16 v16, v1

    .line 221
    .line 222
    invoke-direct/range {v10 .. v16}, Lcom/kousei/framework/m8;-><init>(Lcom/kousei/framework/wi;Ljava/math/BigInteger;Ljava/util/Date;Ljava/util/Date;Lcom/kousei/framework/wi;Lcom/kousei/framework/xh;)V

    .line 223
    .line 224
    .line 225
    invoke-virtual {v3}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    .line 226
    .line 227
    .line 228
    move-result-object v1

    .line 229
    invoke-static {v1}, Lcom/kousei/framework/m3;->k(Ljava/security/PrivateKey;)Ljava/lang/String;

    .line 230
    .line 231
    .line 232
    move-result-object v1

    .line 233
    invoke-virtual {v3}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    .line 234
    .line 235
    .line 236
    move-result-object v3

    .line 237
    invoke-static {v1, v3}, Lcom/kousei/framework/m3;->b(Ljava/lang/String;Ljava/security/PrivateKey;)Lcom/kousei/framework/k3;

    .line 238
    .line 239
    .line 240
    move-result-object v1

    .line 241
    move-object/from16 v3, p3

    .line 242
    .line 243
    invoke-static {v5, v4, v2, v3}, Lcom/kousei/framework/m3;->c(Lcom/kousei/framework/a0;Lcom/kousei/framework/l;[Lcom/kousei/framework/k;Lcom/kousei/framework/h7;)Lcom/kousei/framework/a8;

    .line 244
    .line 245
    .line 246
    move-result-object v2

    .line 247
    iget-object v3, v10, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 248
    .line 249
    check-cast v3, Lcom/kousei/framework/c8;

    .line 250
    .line 251
    invoke-virtual {v3, v2}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 252
    .line 253
    .line 254
    iget-object v2, v0, Lcom/kousei/framework/yi;->L:Lcom/kousei/framework/b8;

    .line 255
    .line 256
    invoke-virtual {v2}, Lcom/kousei/framework/b8;->h()[Lcom/kousei/framework/v;

    .line 257
    .line 258
    .line 259
    move-result-object v2

    .line 260
    array-length v3, v2

    .line 261
    move v4, v8

    .line 262
    :goto_105
    if-ge v4, v3, :cond_12c

    .line 263
    .line 264
    aget-object v5, v2, v4

    .line 265
    .line 266
    invoke-virtual {v5}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 267
    .line 268
    .line 269
    move-result-object v5

    .line 270
    sget-object v6, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 271
    .line 272
    invoke-virtual {v6}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 273
    .line 274
    .line 275
    move-result-object v6

    .line 276
    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 277
    .line 278
    .line 279
    move-result v6

    .line 280
    if-nez v6, :cond_129

    .line 281
    .line 282
    new-instance v6, Lcom/kousei/framework/v;

    .line 283
    .line 284
    invoke-direct {v6, v5}, Lcom/kousei/framework/v;-><init>(Ljava/lang/String;)V

    .line 285
    .line 286
    .line 287
    invoke-virtual {v0, v6}, Lcom/kousei/framework/yi;->a(Lcom/kousei/framework/v;)Lcom/kousei/framework/a8;

    .line 288
    .line 289
    .line 290
    move-result-object v5

    .line 291
    iget-object v6, v10, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 292
    .line 293
    check-cast v6, Lcom/kousei/framework/c8;

    .line 294
    .line 295
    invoke-virtual {v6, v5}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 296
    .line 297
    .line 298
    :cond_129
    add-int/lit8 v4, v4, 0x1

    .line 299
    .line 300
    goto :goto_105

    .line 301
    :cond_12c
    invoke-virtual {v10, v1}, Lcom/kousei/framework/m8;->c(Lcom/kousei/framework/k3;)Lcom/kousei/framework/yi;

    .line 302
    .line 303
    .line 304
    move-result-object v0

    .line 305
    new-instance v1, Ljava/io/ByteArrayInputStream;

    .line 306
    .line 307
    iget-object v0, v0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 308
    .line 309
    invoke-virtual {v0}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 310
    .line 311
    .line 312
    move-result-object v0

    .line 313
    invoke-direct {v1, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 314
    .line 315
    .line 316
    move-object/from16 v0, p2

    .line 317
    .line 318
    invoke-virtual {v0, v1}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 319
    .line 320
    .line 321
    move-result-object v0

    .line 322
    check-cast v0, Ljava/security/cert/X509Certificate;

    .line 323
    .line 324
    new-instance v1, Ljava/util/ArrayList;

    .line 325
    .line 326
    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 327
    .line 328
    .line 329
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 330
    .line 331
    .line 332
    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 333
    .line 334
    .line 335
    new-array v0, v8, [Ljava/security/cert/Certificate;

    .line 336
    .line 337
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    .line 338
    .line 339
    .line 340
    move-result-object v0

    .line 341
    check-cast v0, [Ljava/security/cert/Certificate;
    :try_end_156
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_156} :catch_4c

    .line 342
    .line 343
    return-object v0

    .line 344
    :goto_157
    const-wide v1, -0x5504df5b40d7L

    .line 345
    .line 346
    .line 347
    .line 348
    .line 349
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 350
    .line 351
    .line 352
    move-result-object v1

    .line 353
    const-wide v2, -0x551bdf5b40d7L

    .line 354
    .line 355
    .line 356
    .line 357
    .line 358
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 359
    .line 360
    .line 361
    move-result-object v2

    .line 362
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 363
    .line 364
    .line 365
    return-object p1
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

.method public static g(Ljava/security/cert/X509Certificate;Ljava/security/cert/CertificateFactory;Lcom/kousei/framework/h7;)[Ljava/security/cert/Certificate;
    .registers 16

    .line 1
    const/4 v1, 0x0

    .line 2
    :try_start_1
    new-instance v0, Lcom/kousei/framework/yi;

    .line 3
    .line 4
    invoke-virtual {p0}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 5
    .line 6
    .line 7
    move-result-object p0

    .line 8
    invoke-direct {v0, p0}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 9
    .line 10
    .line 11
    iget-object p0, v0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 12
    .line 13
    sget-object v2, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 14
    .line 15
    invoke-virtual {v0, v2}, Lcom/kousei/framework/yi;->a(Lcom/kousei/framework/v;)Lcom/kousei/framework/a8;

    .line 16
    .line 17
    .line 18
    move-result-object v2

    .line 19
    if-nez v2, :cond_15

    .line 20
    .line 21
    return-object v1

    .line 22
    :cond_15
    iget-object v2, v2, Lcom/kousei/framework/a8;->M:Lcom/kousei/framework/w;

    .line 23
    .line 24
    iget-object v2, v2, Lcom/kousei/framework/w;->K:[B

    .line 25
    .line 26
    invoke-static {v2}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 27
    .line 28
    .line 29
    move-result-object v2

    .line 30
    invoke-virtual {v2}, Lcom/kousei/framework/d0;->z()[Lcom/kousei/framework/k;

    .line 31
    .line 32
    .line 33
    move-result-object v2

    .line 34
    const/4 v3, 0x7

    .line 35
    aget-object v3, v2, v3

    .line 36
    .line 37
    check-cast v3, Lcom/kousei/framework/d0;

    .line 38
    .line 39
    new-instance v4, Lcom/kousei/framework/l;

    .line 40
    .line 41
    invoke-direct {v4}, Lcom/kousei/framework/l;-><init>()V

    .line 42
    .line 43
    .line 44
    invoke-virtual {v3}, Lcom/kousei/framework/d0;->iterator()Ljava/util/Iterator;

    .line 45
    .line 46
    .line 47
    move-result-object v3

    .line 48
    move-object v5, v1

    .line 49
    :goto_30
    move-object v6, v3

    .line 50
    check-cast v6, Lcom/kousei/framework/l0;

    .line 51
    .line 52
    invoke-virtual {v6}, Lcom/kousei/framework/l0;->hasNext()Z

    .line 53
    .line 54
    .line 55
    move-result v7

    .line 56
    if-eqz v7, :cond_58

    .line 57
    .line 58
    invoke-virtual {v6}, Lcom/kousei/framework/l0;->next()Ljava/lang/Object;

    .line 59
    .line 60
    .line 61
    move-result-object v6

    .line 62
    check-cast v6, Lcom/kousei/framework/k;

    .line 63
    .line 64
    check-cast v6, Lcom/kousei/framework/k2;

    .line 65
    .line 66
    iget v7, v6, Lcom/kousei/framework/k2;->M:I

    .line 67
    .line 68
    const/16 v8, 0x2c0

    .line 69
    .line 70
    if-ne v7, v8, :cond_54

    .line 71
    .line 72
    invoke-virtual {v6}, Lcom/kousei/framework/k2;->q()Lcom/kousei/framework/s;

    .line 73
    .line 74
    .line 75
    move-result-object v5

    .line 76
    invoke-virtual {v5}, Lcom/kousei/framework/s;->b()Lcom/kousei/framework/a0;

    .line 77
    .line 78
    .line 79
    move-result-object v5

    .line 80
    goto :goto_30

    .line 81
    :catch_50
    move-exception v0

    .line 82
    move-object p0, v0

    .line 83
    goto/16 :goto_13d

    .line 84
    .line 85
    :cond_54
    invoke-virtual {v4, v6}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 86
    .line 87
    .line 88
    goto :goto_30

    .line 89
    :cond_58
    iget-object v3, p0, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 90
    .line 91
    iget-object v3, v3, Lcom/kousei/framework/ai;->O:Lcom/kousei/framework/wi;

    .line 92
    .line 93
    invoke-static {v3}, Lcom/kousei/framework/wi;->h(Ljava/lang/Object;)Lcom/kousei/framework/wi;

    .line 94
    .line 95
    .line 96
    move-result-object v7
    :try_end_60
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_60} :catch_50

    .line 97
    :try_start_60
    invoke-virtual {v7}, Lcom/kousei/framework/wi;->toString()Ljava/lang/String;

    .line 98
    .line 99
    .line 100
    move-result-object v3
    :try_end_64
    .catchall {:try_start_60 .. :try_end_64} :catchall_65

    .line 101
    goto :goto_77

    .line 102
    :catchall_65
    :try_start_65
    new-instance v3, Ljava/lang/String;

    .line 103
    .line 104
    invoke-virtual {v7}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 105
    .line 106
    .line 107
    move-result-object v6

    .line 108
    invoke-direct {v3, v6}, Ljava/lang/String;-><init>([B)V
    :try_end_6e
    .catchall {:try_start_65 .. :try_end_6e} :catchall_6f

    .line 109
    .line 110
    .line 111
    goto :goto_77

    .line 112
    :catchall_6f
    :try_start_6f
    invoke-static {v7}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    .line 113
    .line 114
    .line 115
    move-result v3

    .line 116
    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    .line 117
    .line 118
    .line 119
    move-result-object v3

    .line 120
    :goto_77
    sget-object v6, Lcom/kousei/framework/m3;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 121
    .line 122
    invoke-virtual {v6, v3}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 123
    .line 124
    .line 125
    move-result-object v8

    .line 126
    check-cast v8, Lcom/kousei/framework/l3;

    .line 127
    .line 128
    if-nez v8, :cond_ac

    .line 129
    .line 130
    const-wide v8, -0x5224df5b40d7L

    .line 131
    .line 132
    .line 133
    .line 134
    .line 135
    invoke-static {v8, v9}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 136
    .line 137
    .line 138
    move-result-object v8

    .line 139
    invoke-static {v8}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;)Ljava/security/KeyPairGenerator;

    .line 140
    .line 141
    .line 142
    move-result-object v8

    .line 143
    new-instance v9, Ljava/security/spec/ECGenParameterSpec;

    .line 144
    .line 145
    const-wide v10, -0x5221df5b40d7L

    .line 146
    .line 147
    .line 148
    .line 149
    .line 150
    invoke-static {v10, v11}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 151
    .line 152
    .line 153
    move-result-object v10

    .line 154
    invoke-direct {v9, v10}, Ljava/security/spec/ECGenParameterSpec;-><init>(Ljava/lang/String;)V

    .line 155
    .line 156
    .line 157
    invoke-virtual {v8, v9}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 158
    .line 159
    .line 160
    invoke-virtual {v8}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;

    .line 161
    .line 162
    .line 163
    move-result-object v8

    .line 164
    new-instance v9, Lcom/kousei/framework/l3;

    .line 165
    .line 166
    invoke-direct {v9, v8, v1}, Lcom/kousei/framework/l3;-><init>(Ljava/security/KeyPair;Lcom/kousei/framework/wi;)V

    .line 167
    .line 168
    .line 169
    invoke-virtual {v6, v3, v9}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 170
    .line 171
    .line 172
    move-object v8, v9

    .line 173
    :cond_ac
    iget-object v3, v8, Lcom/kousei/framework/l3;->a:Ljava/security/KeyPair;

    .line 174
    .line 175
    new-instance v6, Lcom/kousei/framework/m8;

    .line 176
    .line 177
    iget-object v8, p0, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 178
    .line 179
    iget-object v8, v8, Lcom/kousei/framework/ai;->M:Lcom/kousei/framework/q;

    .line 180
    .line 181
    invoke-virtual {v8}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 182
    .line 183
    .line 184
    move-result-object v8

    .line 185
    iget-object v9, p0, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 186
    .line 187
    iget-object v9, v9, Lcom/kousei/framework/ai;->P:Lcom/kousei/framework/ni;

    .line 188
    .line 189
    iget-object v9, v9, Lcom/kousei/framework/ni;->K:Lcom/kousei/framework/ei;

    .line 190
    .line 191
    invoke-virtual {v9}, Lcom/kousei/framework/ei;->h()Ljava/util/Date;

    .line 192
    .line 193
    .line 194
    move-result-object v9

    .line 195
    iget-object v10, p0, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 196
    .line 197
    iget-object v10, v10, Lcom/kousei/framework/ai;->P:Lcom/kousei/framework/ni;

    .line 198
    .line 199
    iget-object v10, v10, Lcom/kousei/framework/ni;->L:Lcom/kousei/framework/ei;

    .line 200
    .line 201
    invoke-virtual {v10}, Lcom/kousei/framework/ei;->h()Ljava/util/Date;

    .line 202
    .line 203
    .line 204
    move-result-object v10

    .line 205
    invoke-virtual {v0}, Lcom/kousei/framework/yi;->b()Lcom/kousei/framework/wi;

    .line 206
    .line 207
    .line 208
    move-result-object v11

    .line 209
    iget-object p0, p0, Lcom/kousei/framework/h3;->L:Lcom/kousei/framework/ai;

    .line 210
    .line 211
    iget-object v12, p0, Lcom/kousei/framework/ai;->R:Lcom/kousei/framework/xh;

    .line 212
    .line 213
    invoke-direct/range {v6 .. v12}, Lcom/kousei/framework/m8;-><init>(Lcom/kousei/framework/wi;Ljava/math/BigInteger;Ljava/util/Date;Ljava/util/Date;Lcom/kousei/framework/wi;Lcom/kousei/framework/xh;)V

    .line 214
    .line 215
    .line 216
    invoke-virtual {v3}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    .line 217
    .line 218
    .line 219
    move-result-object p0

    .line 220
    invoke-static {p0}, Lcom/kousei/framework/m3;->k(Ljava/security/PrivateKey;)Ljava/lang/String;

    .line 221
    .line 222
    .line 223
    move-result-object p0

    .line 224
    invoke-virtual {v3}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    .line 225
    .line 226
    .line 227
    move-result-object v3

    .line 228
    invoke-static {p0, v3}, Lcom/kousei/framework/m3;->b(Ljava/lang/String;Ljava/security/PrivateKey;)Lcom/kousei/framework/k3;

    .line 229
    .line 230
    .line 231
    move-result-object p0

    .line 232
    invoke-static {v5, v4, v2, p2}, Lcom/kousei/framework/m3;->c(Lcom/kousei/framework/a0;Lcom/kousei/framework/l;[Lcom/kousei/framework/k;Lcom/kousei/framework/h7;)Lcom/kousei/framework/a8;

    .line 233
    .line 234
    .line 235
    move-result-object p2

    .line 236
    iget-object v2, v6, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 237
    .line 238
    check-cast v2, Lcom/kousei/framework/c8;

    .line 239
    .line 240
    invoke-virtual {v2, p2}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 241
    .line 242
    .line 243
    iget-object p2, v0, Lcom/kousei/framework/yi;->L:Lcom/kousei/framework/b8;

    .line 244
    .line 245
    invoke-virtual {p2}, Lcom/kousei/framework/b8;->h()[Lcom/kousei/framework/v;

    .line 246
    .line 247
    .line 248
    move-result-object p2

    .line 249
    array-length v2, p2

    .line 250
    const/4 v3, 0x0

    .line 251
    move v4, v3

    .line 252
    :goto_fb
    if-ge v4, v2, :cond_122

    .line 253
    .line 254
    aget-object v5, p2, v4

    .line 255
    .line 256
    invoke-virtual {v5}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 257
    .line 258
    .line 259
    move-result-object v5

    .line 260
    sget-object v7, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 261
    .line 262
    invoke-virtual {v7}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 263
    .line 264
    .line 265
    move-result-object v7

    .line 266
    invoke-virtual {v5, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 267
    .line 268
    .line 269
    move-result v7

    .line 270
    if-nez v7, :cond_11f

    .line 271
    .line 272
    new-instance v7, Lcom/kousei/framework/v;

    .line 273
    .line 274
    invoke-direct {v7, v5}, Lcom/kousei/framework/v;-><init>(Ljava/lang/String;)V

    .line 275
    .line 276
    .line 277
    invoke-virtual {v0, v7}, Lcom/kousei/framework/yi;->a(Lcom/kousei/framework/v;)Lcom/kousei/framework/a8;

    .line 278
    .line 279
    .line 280
    move-result-object v5

    .line 281
    iget-object v7, v6, Lcom/kousei/framework/m8;->b:Ljava/lang/Object;

    .line 282
    .line 283
    check-cast v7, Lcom/kousei/framework/c8;

    .line 284
    .line 285
    invoke-virtual {v7, v5}, Lcom/kousei/framework/c8;->b(Lcom/kousei/framework/a8;)V

    .line 286
    .line 287
    .line 288
    :cond_11f
    add-int/lit8 v4, v4, 0x1

    .line 289
    .line 290
    goto :goto_fb

    .line 291
    :cond_122
    invoke-virtual {v6, p0}, Lcom/kousei/framework/m8;->c(Lcom/kousei/framework/k3;)Lcom/kousei/framework/yi;

    .line 292
    .line 293
    .line 294
    move-result-object p0

    .line 295
    new-instance p2, Ljava/io/ByteArrayInputStream;

    .line 296
    .line 297
    iget-object p0, p0, Lcom/kousei/framework/yi;->K:Lcom/kousei/framework/h3;

    .line 298
    .line 299
    invoke-virtual {p0}, Lcom/kousei/framework/s;->getEncoded()[B

    .line 300
    .line 301
    .line 302
    move-result-object p0

    .line 303
    invoke-direct {p2, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 304
    .line 305
    .line 306
    invoke-virtual {p1, p2}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    .line 307
    .line 308
    .line 309
    move-result-object p0

    .line 310
    check-cast p0, Ljava/security/cert/X509Certificate;

    .line 311
    .line 312
    const/4 p1, 0x1

    .line 313
    new-array p1, p1, [Ljava/security/cert/Certificate;

    .line 314
    .line 315
    aput-object p0, p1, v3
    :try_end_13c
    .catch Ljava/lang/Exception; {:try_start_6f .. :try_end_13c} :catch_50

    .line 316
    .line 317
    return-object p1

    .line 318
    :goto_13d
    const-wide p1, -0x52f1df5b40d7L

    .line 319
    .line 320
    .line 321
    .line 322
    .line 323
    invoke-static {p1, p2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 324
    .line 325
    .line 326
    move-result-object p1

    .line 327
    const-wide v2, -0x52c8df5b40d7L

    .line 328
    .line 329
    .line 330
    .line 331
    .line 332
    invoke-static {v2, v3}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 333
    .line 334
    .line 335
    move-result-object p2

    .line 336
    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 337
    .line 338
    .line 339
    return-object v1
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

.method public static h(Ljava/security/cert/X509Certificate;)Z
    .registers 3

    .line 1
    :try_start_0
    sget-object v0, Lcom/kousei/framework/j3;->a:Lcom/kousei/framework/v;

    .line 2
    .line 3
    invoke-virtual {v0}, Lcom/kousei/framework/v;->t()Ljava/lang/String;

    .line 4
    .line 5
    .line 6
    move-result-object v1

    .line 7
    invoke-interface {p0, v1}, Ljava/security/cert/X509Extension;->getExtensionValue(Ljava/lang/String;)[B

    .line 8
    .line 9
    .line 10
    move-result-object v1

    .line 11
    if-nez v1, :cond_d

    .line 12
    .line 13
    goto :goto_46

    .line 14
    :cond_d
    new-instance v1, Lcom/kousei/framework/yi;

    .line 15
    .line 16
    invoke-virtual {p0}, Ljava/security/cert/Certificate;->getEncoded()[B

    .line 17
    .line 18
    .line 19
    move-result-object p0

    .line 20
    invoke-direct {v1, p0}, Lcom/kousei/framework/yi;-><init>([B)V

    .line 21
    .line 22
    .line 23
    invoke-virtual {v1, v0}, Lcom/kousei/framework/yi;->a(Lcom/kousei/framework/v;)Lcom/kousei/framework/a8;

    .line 24
    .line 25
    .line 26
    move-result-object p0

    .line 27
    if-nez p0, :cond_1d

    .line 28
    .line 29
    goto :goto_46

    .line 30
    :cond_1d
    iget-object p0, p0, Lcom/kousei/framework/a8;->M:Lcom/kousei/framework/w;

    .line 31
    .line 32
    iget-object p0, p0, Lcom/kousei/framework/w;->K:[B

    .line 33
    .line 34
    invoke-static {p0}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 35
    .line 36
    .line 37
    move-result-object p0

    .line 38
    invoke-virtual {p0}, Lcom/kousei/framework/d0;->size()I

    .line 39
    .line 40
    .line 41
    move-result v0

    .line 42
    const/16 v1, 0x8

    .line 43
    .line 44
    if-ge v0, v1, :cond_2e

    .line 45
    .line 46
    goto :goto_46

    .line 47
    :cond_2e
    const/4 v0, 0x6

    .line 48
    invoke-virtual {p0, v0}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 49
    .line 50
    .line 51
    move-result-object v0

    .line 52
    invoke-static {v0}, Lcom/kousei/framework/m3;->a(Lcom/kousei/framework/k;)Z

    .line 53
    .line 54
    .line 55
    move-result v0

    .line 56
    if-nez v0, :cond_44

    .line 57
    .line 58
    const/4 v0, 0x7

    .line 59
    invoke-virtual {p0, v0}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 60
    .line 61
    .line 62
    move-result-object p0

    .line 63
    invoke-static {p0}, Lcom/kousei/framework/m3;->a(Lcom/kousei/framework/k;)Z

    .line 64
    .line 65
    .line 66
    move-result p0
    :try_end_42
    .catchall {:try_start_0 .. :try_end_42} :catchall_46

    .line 67
    if-eqz p0, :cond_46

    .line 68
    .line 69
    :cond_44
    const/4 p0, 0x1

    .line 70
    return p0

    .line 71
    :catchall_46
    :cond_46
    :goto_46
    const/4 p0, 0x0

    .line 72
    return p0
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

.method public static i(Ljava/lang/String;)Lcom/kousei/framework/l3;
    .registers 8

    .line 1
    const/4 v0, 0x0

    .line 2
    if-nez p0, :cond_4

    .line 3
    .line 4
    goto :goto_e

    .line 5
    :cond_4
    sget-object v1, Lcom/kousei/framework/m3;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 6
    .line 7
    invoke-virtual {v1, p0}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 8
    .line 9
    .line 10
    move-result-object v2

    .line 11
    check-cast v2, Lcom/kousei/framework/l3;

    .line 12
    .line 13
    if-nez v2, :cond_f

    .line 14
    .line 15
    :goto_e
    return-object v0

    .line 16
    :cond_f
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 17
    .line 18
    .line 19
    move-result-wide v3

    .line 20
    iget-wide v5, v2, Lcom/kousei/framework/l3;->c:J

    .line 21
    .line 22
    sub-long/2addr v3, v5

    .line 23
    const-wide/32 v5, 0x36ee80

    .line 24
    .line 25
    .line 26
    cmp-long v3, v3, v5

    .line 27
    .line 28
    if-lez v3, :cond_21

    .line 29
    .line 30
    invoke-virtual {v1, p0}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 31
    .line 32
    .line 33
    return-object v0

    .line 34
    :cond_21
    return-object v2
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

.method public static j()V
    .registers 7

    .line 1
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 2
    .line 3
    .line 4
    move-result-wide v0

    .line 5
    sget-object v2, Lcom/kousei/framework/m3;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 6
    .line 7
    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentHashMap;->entrySet()Ljava/util/Set;

    .line 8
    .line 9
    .line 10
    move-result-object v2

    .line 11
    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    .line 12
    .line 13
    .line 14
    move-result-object v2

    .line 15
    :cond_e
    :goto_e
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 16
    .line 17
    .line 18
    move-result v3

    .line 19
    if-eqz v3, :cond_2f

    .line 20
    .line 21
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 22
    .line 23
    .line 24
    move-result-object v3

    .line 25
    check-cast v3, Ljava/util/Map$Entry;

    .line 26
    .line 27
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    .line 28
    .line 29
    .line 30
    move-result-object v3

    .line 31
    check-cast v3, Lcom/kousei/framework/l3;

    .line 32
    .line 33
    iget-wide v3, v3, Lcom/kousei/framework/l3;->c:J

    .line 34
    .line 35
    sub-long v3, v0, v3

    .line 36
    .line 37
    const-wide/32 v5, 0x1d4c0

    .line 38
    .line 39
    .line 40
    cmp-long v3, v3, v5

    .line 41
    .line 42
    if-lez v3, :cond_e

    .line 43
    .line 44
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    .line 45
    .line 46
    .line 47
    goto :goto_e

    .line 48
    :cond_2f
    sget-object v2, Lcom/kousei/framework/m3;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 49
    .line 50
    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentHashMap;->entrySet()Ljava/util/Set;

    .line 51
    .line 52
    .line 53
    move-result-object v2

    .line 54
    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    .line 55
    .line 56
    .line 57
    move-result-object v2

    .line 58
    :cond_39
    :goto_39
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 59
    .line 60
    .line 61
    move-result v3

    .line 62
    if-eqz v3, :cond_5a

    .line 63
    .line 64
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 65
    .line 66
    .line 67
    move-result-object v3

    .line 68
    check-cast v3, Ljava/util/Map$Entry;

    .line 69
    .line 70
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    .line 71
    .line 72
    .line 73
    move-result-object v3

    .line 74
    check-cast v3, Lcom/kousei/framework/l3;

    .line 75
    .line 76
    iget-wide v3, v3, Lcom/kousei/framework/l3;->c:J

    .line 77
    .line 78
    sub-long v3, v0, v3

    .line 79
    .line 80
    const-wide/32 v5, 0x36ee80

    .line 81
    .line 82
    .line 83
    cmp-long v3, v3, v5

    .line 84
    .line 85
    if-lez v3, :cond_39

    .line 86
    .line 87
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V
    :try_end_59
    .catchall {:try_start_0 .. :try_end_59} :catchall_5a

    .line 88
    .line 89
    .line 90
    goto :goto_39

    .line 91
    :catchall_5a
    :cond_5a
    return-void
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

.method public static k(Ljava/security/PrivateKey;)Ljava/lang/String;
    .registers 3

    .line 1
    instance-of v0, p0, Ljava/security/interfaces/RSAPrivateCrtKey;

    .line 2
    .line 3
    if-nez v0, :cond_4a

    .line 4
    .line 5
    instance-of v0, p0, Ljava/security/interfaces/RSAPrivateKey;

    .line 6
    .line 7
    if-eqz v0, :cond_9

    .line 8
    .line 9
    goto :goto_4a

    .line 10
    :cond_9
    instance-of v0, p0, Ljava/security/interfaces/ECPrivateKey;

    .line 11
    .line 12
    if-eqz v0, :cond_17

    .line 13
    .line 14
    const-wide v0, -0x55cadf5b40d7L

    .line 15
    .line 16
    .line 17
    .line 18
    .line 19
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 20
    .line 21
    .line 22
    move-result-object p0

    .line 23
    return-object p0

    .line 24
    :cond_17
    if-eqz p0, :cond_1e

    .line 25
    .line 26
    invoke-interface {p0}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    .line 27
    .line 28
    .line 29
    move-result-object p0

    .line 30
    goto :goto_27

    .line 31
    :cond_1e
    const-wide v0, -0x55dadf5b40d7L

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
    :goto_27
    const-wide v0, -0x55d9df5b40d7L

    .line 41
    .line 42
    .line 43
    .line 44
    .line 45
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 46
    .line 47
    .line 48
    move-result-object v0

    .line 49
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    .line 50
    .line 51
    .line 52
    move-result p0

    .line 53
    if-eqz p0, :cond_40

    .line 54
    .line 55
    const-wide v0, -0x55a5df5b40d7L

    .line 56
    .line 57
    .line 58
    .line 59
    .line 60
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 61
    .line 62
    .line 63
    move-result-object p0

    .line 64
    return-object p0

    .line 65
    :cond_40
    const-wide v0, -0x55b7df5b40d7L

    .line 66
    .line 67
    .line 68
    .line 69
    .line 70
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 71
    .line 72
    .line 73
    move-result-object p0

    .line 74
    return-object p0

    .line 75
    :cond_4a
    :goto_4a
    const-wide v0, -0x55f8df5b40d7L

    .line 76
    .line 77
    .line 78
    .line 79
    .line 80
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 81
    .line 82
    .line 83
    move-result-object p0

    .line 84
    return-object p0
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
