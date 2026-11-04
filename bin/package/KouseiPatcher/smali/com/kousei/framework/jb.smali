.class public final Lcom/kousei/framework/jb;
.super Lcom/kousei/framework/n2;


# instance fields
.field public final M:[B

.field public final N:[B

.field public final O:[B

.field public final P:[B

.field public final Q:[B

.field public final R:[B

.field public final S:[B

.field public final T:[B

.field public final U:I


# direct methods
.method public constructor <init>(Lcom/kousei/framework/hb;[BLcom/kousei/framework/lb;)V
    .registers 39

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p1

    .line 4
    .line 5
    move-object/from16 v8, p2

    .line 6
    .line 7
    const/4 v10, 0x1

    .line 8
    invoke-direct {v0, v10, v1}, Lcom/kousei/framework/n2;-><init>(ZLjava/lang/Object;)V

    .line 9
    .line 10
    .line 11
    new-instance v2, Lcom/kousei/framework/fb;

    .line 12
    .line 13
    iget v1, v1, Lcom/kousei/framework/hb;->a:I

    .line 14
    .line 15
    invoke-direct {v2, v1, v10}, Lcom/kousei/framework/fb;-><init>(II)V

    .line 16
    .line 17
    .line 18
    array-length v1, v8

    .line 19
    const/16 v4, 0x40

    .line 20
    .line 21
    const/16 v5, 0x80

    .line 22
    .line 23
    const/16 v16, 0x2

    .line 24
    .line 25
    const/4 v6, 0x0

    .line 26
    iget v7, v2, Lcom/kousei/framework/fb;->d:I

    .line 27
    .line 28
    const/16 v17, 0x7

    .line 29
    .line 30
    iget v11, v2, Lcom/kousei/framework/fb;->b:I

    .line 31
    .line 32
    const/16 v18, 0x5

    .line 33
    .line 34
    iget v13, v2, Lcom/kousei/framework/fb;->c:I

    .line 35
    .line 36
    const/16 v19, 0x4

    .line 37
    .line 38
    const/16 v14, 0x20

    .line 39
    .line 40
    if-ne v1, v14, :cond_2a0

    .line 41
    .line 42
    new-array v1, v5, [B

    .line 43
    .line 44
    const/16 v20, 0x3

    .line 45
    .line 46
    new-array v15, v4, [B

    .line 47
    .line 48
    new-array v12, v14, [B

    .line 49
    .line 50
    new-array v3, v4, [B

    .line 51
    .line 52
    new-array v4, v14, [B

    .line 53
    .line 54
    new-instance v5, Lcom/kousei/framework/y;

    .line 55
    .line 56
    invoke-direct {v5, v2, v6}, Lcom/kousei/framework/y;-><init>(Lcom/kousei/framework/fb;B)V

    .line 57
    .line 58
    .line 59
    new-instance v14, Lcom/kousei/framework/ed;

    .line 60
    .line 61
    invoke-direct {v14, v2, v10}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 62
    .line 63
    .line 64
    new-instance v10, Lcom/kousei/framework/ed;

    .line 65
    .line 66
    invoke-direct {v10, v2, v6}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 67
    .line 68
    .line 69
    move/from16 v26, v11

    .line 70
    .line 71
    new-instance v11, Lcom/kousei/framework/ed;

    .line 72
    .line 73
    invoke-direct {v11, v2, v6}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 74
    .line 75
    .line 76
    new-instance v9, Lcom/kousei/framework/ed;

    .line 77
    .line 78
    invoke-direct {v9, v2, v6}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 79
    .line 80
    .line 81
    iget-object v0, v2, Lcom/kousei/framework/fb;->a:Lcom/kousei/framework/te;

    .line 82
    .line 83
    move-object/from16 v27, v15

    .line 84
    .line 85
    const/16 v15, 0x20

    .line 86
    .line 87
    invoke-virtual {v0, v8, v6, v15}, Lcom/kousei/framework/ba;->update([BII)V

    .line 88
    .line 89
    .line 90
    int-to-byte v15, v13

    .line 91
    invoke-virtual {v0, v15}, Lcom/kousei/framework/ba;->d(B)V

    .line 92
    .line 93
    .line 94
    int-to-byte v15, v7

    .line 95
    invoke-virtual {v0, v15}, Lcom/kousei/framework/ba;->d(B)V

    .line 96
    .line 97
    .line 98
    const/16 v15, 0x80

    .line 99
    .line 100
    invoke-virtual {v0, v1, v6, v15}, Lcom/kousei/framework/te;->l([BII)V

    .line 101
    .line 102
    .line 103
    const/16 v15, 0x20

    .line 104
    .line 105
    invoke-static {v1, v6, v12, v6, v15}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 106
    .line 107
    .line 108
    const/16 v8, 0x40

    .line 109
    .line 110
    invoke-static {v1, v15, v3, v6, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 111
    .line 112
    .line 113
    const/16 v8, 0x60

    .line 114
    .line 115
    invoke-static {v1, v8, v4, v6, v15}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 116
    .line 117
    .line 118
    invoke-virtual {v5, v12}, Lcom/kousei/framework/y;->c([B)V

    .line 119
    .line 120
    .line 121
    move v1, v6

    .line 122
    move v8, v1

    .line 123
    :goto_7a
    iget-object v15, v14, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 124
    .line 125
    array-length v6, v15

    .line 126
    if-ge v1, v6, :cond_8c

    .line 127
    .line 128
    aget-object v6, v15, v1

    .line 129
    .line 130
    add-int/lit8 v15, v8, 0x1

    .line 131
    .line 132
    int-to-short v15, v15

    .line 133
    invoke-virtual {v6, v3, v8}, Lcom/kousei/framework/k3;->j([BS)V

    .line 134
    .line 135
    .line 136
    add-int/lit8 v1, v1, 0x1

    .line 137
    .line 138
    move v8, v15

    .line 139
    const/4 v6, 0x0

    .line 140
    goto :goto_7a

    .line 141
    :cond_8c
    int-to-short v1, v7

    .line 142
    const/4 v6, 0x0

    .line 143
    :goto_8e
    iget-object v8, v10, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 144
    .line 145
    array-length v14, v8

    .line 146
    if-ge v6, v14, :cond_9f

    .line 147
    .line 148
    aget-object v8, v8, v6

    .line 149
    .line 150
    add-int/lit8 v14, v1, 0x1

    .line 151
    .line 152
    int-to-short v14, v14

    .line 153
    invoke-virtual {v8, v3, v1}, Lcom/kousei/framework/k3;->j([BS)V

    .line 154
    .line 155
    .line 156
    add-int/lit8 v6, v6, 0x1

    .line 157
    .line 158
    move v1, v14

    .line 159
    goto :goto_8e

    .line 160
    :cond_9f
    new-instance v1, Lcom/kousei/framework/ed;

    .line 161
    .line 162
    const/4 v3, 0x1

    .line 163
    invoke-direct {v1, v2, v3}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 164
    .line 165
    .line 166
    const/4 v3, 0x0

    .line 167
    :goto_a6
    array-length v6, v15

    .line 168
    if-ge v3, v6, :cond_c2

    .line 169
    .line 170
    aget-object v6, v15, v3

    .line 171
    .line 172
    iget-object v10, v1, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 173
    .line 174
    aget-object v10, v10, v3

    .line 175
    .line 176
    iget-object v6, v6, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 177
    .line 178
    check-cast v6, [I

    .line 179
    .line 180
    iget-object v10, v10, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 181
    .line 182
    check-cast v10, [I

    .line 183
    .line 184
    move/from16 v28, v3

    .line 185
    .line 186
    const/4 v3, 0x0

    .line 187
    const/16 v14, 0x100

    .line 188
    .line 189
    invoke-static {v6, v3, v10, v3, v14}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 190
    .line 191
    .line 192
    add-int/lit8 v3, v28, 0x1

    .line 193
    .line 194
    goto :goto_a6

    .line 195
    :cond_c2
    invoke-virtual {v1}, Lcom/kousei/framework/ed;->c()V

    .line 196
    .line 197
    .line 198
    invoke-virtual {v5, v11, v1}, Lcom/kousei/framework/y;->j(Lcom/kousei/framework/ed;Lcom/kousei/framework/ed;)V

    .line 199
    .line 200
    .line 201
    invoke-virtual {v11}, Lcom/kousei/framework/ed;->e()V

    .line 202
    .line 203
    .line 204
    invoke-virtual {v11}, Lcom/kousei/framework/ed;->b()V

    .line 205
    .line 206
    .line 207
    const/4 v1, 0x0

    .line 208
    :goto_cf
    iget-object v3, v11, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 209
    .line 210
    array-length v5, v3

    .line 211
    if-ge v1, v5, :cond_fb

    .line 212
    .line 213
    aget-object v3, v3, v1

    .line 214
    .line 215
    aget-object v5, v8, v1

    .line 216
    .line 217
    const/4 v6, 0x0

    .line 218
    :goto_d9
    const/16 v14, 0x100

    .line 219
    .line 220
    if-ge v6, v14, :cond_f3

    .line 221
    .line 222
    iget-object v10, v3, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 223
    .line 224
    check-cast v10, [I

    .line 225
    .line 226
    aget v14, v10, v6

    .line 227
    .line 228
    move/from16 v28, v1

    .line 229
    .line 230
    iget-object v1, v5, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 231
    .line 232
    check-cast v1, [I

    .line 233
    .line 234
    aget v1, v1, v6

    .line 235
    .line 236
    add-int/2addr v14, v1

    .line 237
    aput v14, v10, v6

    .line 238
    .line 239
    add-int/lit8 v6, v6, 0x1

    .line 240
    .line 241
    move/from16 v1, v28

    .line 242
    .line 243
    goto :goto_d9

    .line 244
    :cond_f3
    move/from16 v28, v1

    .line 245
    .line 246
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 247
    .line 248
    .line 249
    add-int/lit8 v1, v28, 0x1

    .line 250
    .line 251
    goto :goto_cf

    .line 252
    :cond_fb
    invoke-virtual {v11}, Lcom/kousei/framework/ed;->a()V

    .line 253
    .line 254
    .line 255
    invoke-virtual {v11, v9}, Lcom/kousei/framework/ed;->d(Lcom/kousei/framework/ed;)V

    .line 256
    .line 257
    .line 258
    invoke-static {v11, v2}, Lcom/kousei/framework/xc;->a0(Lcom/kousei/framework/ed;Lcom/kousei/framework/fb;)[B

    .line 259
    .line 260
    .line 261
    move-result-object v1

    .line 262
    const/16 v2, 0x20

    .line 263
    .line 264
    const/4 v3, 0x0

    .line 265
    invoke-virtual {v0, v12, v3, v2}, Lcom/kousei/framework/ba;->update([BII)V

    .line 266
    .line 267
    .line 268
    array-length v2, v1

    .line 269
    invoke-virtual {v0, v1, v3, v2}, Lcom/kousei/framework/ba;->update([BII)V

    .line 270
    .line 271
    .line 272
    move-object/from16 v2, v27

    .line 273
    .line 274
    const/16 v5, 0x40

    .line 275
    .line 276
    invoke-virtual {v0, v2, v3, v5}, Lcom/kousei/framework/te;->l([BII)V

    .line 277
    .line 278
    .line 279
    const/4 v0, 0x6

    .line 280
    new-array v5, v0, [[B

    .line 281
    .line 282
    aput-object v12, v5, v3

    .line 283
    .line 284
    const/16 v25, 0x1

    .line 285
    .line 286
    aput-object v4, v5, v25

    .line 287
    .line 288
    aput-object v2, v5, v16

    .line 289
    .line 290
    mul-int v11, v7, v26

    .line 291
    .line 292
    new-array v0, v11, [B

    .line 293
    .line 294
    aput-object v0, v5, v20

    .line 295
    .line 296
    const/4 v0, 0x0

    .line 297
    :goto_128
    if-ge v0, v7, :cond_136

    .line 298
    .line 299
    aget-object v2, v15, v0

    .line 300
    .line 301
    aget-object v3, v5, v20

    .line 302
    .line 303
    mul-int v11, v0, v26

    .line 304
    .line 305
    invoke-virtual {v2, v11, v3}, Lcom/kousei/framework/k3;->d(I[B)V

    .line 306
    .line 307
    .line 308
    add-int/lit8 v0, v0, 0x1

    .line 309
    .line 310
    goto :goto_128

    .line 311
    :cond_136
    mul-int v11, v13, v26

    .line 312
    .line 313
    new-array v0, v11, [B

    .line 314
    .line 315
    aput-object v0, v5, v19

    .line 316
    .line 317
    const/4 v0, 0x0

    .line 318
    :goto_13d
    if-ge v0, v13, :cond_14b

    .line 319
    .line 320
    aget-object v2, v8, v0

    .line 321
    .line 322
    aget-object v3, v5, v19

    .line 323
    .line 324
    mul-int v11, v0, v26

    .line 325
    .line 326
    invoke-virtual {v2, v11, v3}, Lcom/kousei/framework/k3;->d(I[B)V

    .line 327
    .line 328
    .line 329
    add-int/lit8 v0, v0, 0x1

    .line 330
    .line 331
    goto :goto_13d

    .line 332
    :cond_14b
    mul-int/lit16 v0, v13, 0x1a0

    .line 333
    .line 334
    new-array v0, v0, [B

    .line 335
    .line 336
    aput-object v0, v5, v18

    .line 337
    .line 338
    const/4 v3, 0x0

    .line 339
    :goto_152
    if-ge v3, v13, :cond_25d

    .line 340
    .line 341
    iget-object v0, v9, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 342
    .line 343
    aget-object v0, v0, v3

    .line 344
    .line 345
    aget-object v2, v5, v18

    .line 346
    .line 347
    mul-int/lit16 v4, v3, 0x1a0

    .line 348
    .line 349
    const/4 v6, 0x0

    .line 350
    :goto_15d
    const/16 v15, 0x20

    .line 351
    .line 352
    if-ge v6, v15, :cond_254

    .line 353
    .line 354
    mul-int/lit8 v7, v6, 0x8

    .line 355
    .line 356
    iget-object v8, v0, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 357
    .line 358
    check-cast v8, [I

    .line 359
    .line 360
    aget v10, v8, v7

    .line 361
    .line 362
    rsub-int v10, v10, 0x1000

    .line 363
    .line 364
    add-int/lit8 v11, v7, 0x1

    .line 365
    .line 366
    aget v11, v8, v11

    .line 367
    .line 368
    rsub-int v11, v11, 0x1000

    .line 369
    .line 370
    add-int/lit8 v12, v7, 0x2

    .line 371
    .line 372
    aget v12, v8, v12

    .line 373
    .line 374
    rsub-int v12, v12, 0x1000

    .line 375
    .line 376
    add-int/lit8 v14, v7, 0x3

    .line 377
    .line 378
    aget v14, v8, v14

    .line 379
    .line 380
    rsub-int v14, v14, 0x1000

    .line 381
    .line 382
    add-int/lit8 v15, v7, 0x4

    .line 383
    .line 384
    aget v15, v8, v15

    .line 385
    .line 386
    rsub-int v15, v15, 0x1000

    .line 387
    .line 388
    add-int/lit8 v22, v7, 0x5

    .line 389
    .line 390
    move-object/from16 v23, v0

    .line 391
    .line 392
    aget v0, v8, v22

    .line 393
    .line 394
    rsub-int v0, v0, 0x1000

    .line 395
    .line 396
    add-int/lit8 v22, v7, 0x6

    .line 397
    .line 398
    move/from16 v31, v0

    .line 399
    .line 400
    aget v0, v8, v22

    .line 401
    .line 402
    rsub-int v0, v0, 0x1000

    .line 403
    .line 404
    add-int/lit8 v7, v7, 0x7

    .line 405
    .line 406
    aget v7, v8, v7

    .line 407
    .line 408
    rsub-int v7, v7, 0x1000

    .line 409
    .line 410
    move/from16 v32, v0

    .line 411
    .line 412
    move/from16 v33, v7

    .line 413
    .line 414
    move/from16 v26, v10

    .line 415
    .line 416
    move/from16 v27, v11

    .line 417
    .line 418
    move/from16 v28, v12

    .line 419
    .line 420
    move/from16 v29, v14

    .line 421
    .line 422
    move/from16 v30, v15

    .line 423
    .line 424
    filled-new-array/range {v26 .. v33}, [I

    .line 425
    .line 426
    .line 427
    move-result-object v0

    .line 428
    mul-int/lit8 v7, v6, 0xd

    .line 429
    .line 430
    add-int/2addr v7, v4

    .line 431
    const/16 v24, 0x0

    .line 432
    .line 433
    aget v8, v0, v24

    .line 434
    .line 435
    int-to-byte v10, v8

    .line 436
    aput-byte v10, v2, v7

    .line 437
    .line 438
    add-int/lit8 v10, v7, 0x1

    .line 439
    .line 440
    shr-int/lit8 v8, v8, 0x8

    .line 441
    .line 442
    int-to-byte v8, v8

    .line 443
    aput-byte v8, v2, v10

    .line 444
    .line 445
    const/16 v25, 0x1

    .line 446
    .line 447
    aget v11, v0, v25

    .line 448
    .line 449
    shl-int/lit8 v12, v11, 0x5

    .line 450
    .line 451
    int-to-byte v12, v12

    .line 452
    or-int/2addr v8, v12

    .line 453
    int-to-byte v8, v8

    .line 454
    aput-byte v8, v2, v10

    .line 455
    .line 456
    add-int/lit8 v8, v7, 0x2

    .line 457
    .line 458
    shr-int/lit8 v10, v11, 0x3

    .line 459
    .line 460
    int-to-byte v10, v10

    .line 461
    aput-byte v10, v2, v8

    .line 462
    .line 463
    add-int/lit8 v8, v7, 0x3

    .line 464
    .line 465
    shr-int/lit8 v10, v11, 0xb

    .line 466
    .line 467
    int-to-byte v10, v10

    .line 468
    aput-byte v10, v2, v8

    .line 469
    .line 470
    aget v11, v0, v16

    .line 471
    .line 472
    shl-int/lit8 v12, v11, 0x2

    .line 473
    .line 474
    int-to-byte v12, v12

    .line 475
    or-int/2addr v10, v12

    .line 476
    int-to-byte v10, v10

    .line 477
    aput-byte v10, v2, v8

    .line 478
    .line 479
    add-int/lit8 v8, v7, 0x4

    .line 480
    .line 481
    const/16 v21, 0x6

    .line 482
    .line 483
    shr-int/lit8 v10, v11, 0x6

    .line 484
    .line 485
    int-to-byte v10, v10

    .line 486
    aput-byte v10, v2, v8

    .line 487
    .line 488
    aget v11, v0, v20

    .line 489
    .line 490
    shl-int/lit8 v12, v11, 0x7

    .line 491
    .line 492
    int-to-byte v12, v12

    .line 493
    or-int/2addr v10, v12

    .line 494
    int-to-byte v10, v10

    .line 495
    aput-byte v10, v2, v8

    .line 496
    .line 497
    add-int/lit8 v8, v7, 0x5

    .line 498
    .line 499
    shr-int/lit8 v10, v11, 0x1

    .line 500
    .line 501
    int-to-byte v10, v10

    .line 502
    aput-byte v10, v2, v8

    .line 503
    .line 504
    add-int/lit8 v8, v7, 0x6

    .line 505
    .line 506
    shr-int/lit8 v10, v11, 0x9

    .line 507
    .line 508
    int-to-byte v10, v10

    .line 509
    aput-byte v10, v2, v8

    .line 510
    .line 511
    aget v11, v0, v19

    .line 512
    .line 513
    shl-int/lit8 v12, v11, 0x4

    .line 514
    .line 515
    int-to-byte v12, v12

    .line 516
    or-int/2addr v10, v12

    .line 517
    int-to-byte v10, v10

    .line 518
    aput-byte v10, v2, v8

    .line 519
    .line 520
    add-int/lit8 v8, v7, 0x7

    .line 521
    .line 522
    shr-int/lit8 v10, v11, 0x4

    .line 523
    .line 524
    int-to-byte v10, v10

    .line 525
    aput-byte v10, v2, v8

    .line 526
    .line 527
    add-int/lit8 v8, v7, 0x8

    .line 528
    .line 529
    shr-int/lit8 v10, v11, 0xc

    .line 530
    .line 531
    int-to-byte v10, v10

    .line 532
    aput-byte v10, v2, v8

    .line 533
    .line 534
    aget v11, v0, v18

    .line 535
    .line 536
    shl-int/lit8 v12, v11, 0x1

    .line 537
    .line 538
    int-to-byte v12, v12

    .line 539
    or-int/2addr v10, v12

    .line 540
    int-to-byte v10, v10

    .line 541
    aput-byte v10, v2, v8

    .line 542
    .line 543
    add-int/lit8 v8, v7, 0x9

    .line 544
    .line 545
    shr-int/lit8 v10, v11, 0x7

    .line 546
    .line 547
    int-to-byte v10, v10

    .line 548
    aput-byte v10, v2, v8

    .line 549
    .line 550
    const/16 v21, 0x6

    .line 551
    .line 552
    aget v11, v0, v21

    .line 553
    .line 554
    shl-int/lit8 v12, v11, 0x6

    .line 555
    .line 556
    int-to-byte v12, v12

    .line 557
    or-int/2addr v10, v12

    .line 558
    int-to-byte v10, v10

    .line 559
    aput-byte v10, v2, v8

    .line 560
    .line 561
    add-int/lit8 v8, v7, 0xa

    .line 562
    .line 563
    shr-int/lit8 v10, v11, 0x2

    .line 564
    .line 565
    int-to-byte v10, v10

    .line 566
    aput-byte v10, v2, v8

    .line 567
    .line 568
    add-int/lit8 v8, v7, 0xb

    .line 569
    .line 570
    shr-int/lit8 v10, v11, 0xa

    .line 571
    .line 572
    int-to-byte v10, v10

    .line 573
    aput-byte v10, v2, v8

    .line 574
    .line 575
    aget v0, v0, v17

    .line 576
    .line 577
    shl-int/lit8 v11, v0, 0x3

    .line 578
    .line 579
    int-to-byte v11, v11

    .line 580
    or-int/2addr v10, v11

    .line 581
    int-to-byte v10, v10

    .line 582
    aput-byte v10, v2, v8

    .line 583
    .line 584
    add-int/lit8 v7, v7, 0xc

    .line 585
    .line 586
    shr-int/lit8 v0, v0, 0x5

    .line 587
    .line 588
    int-to-byte v0, v0

    .line 589
    aput-byte v0, v2, v7

    .line 590
    .line 591
    add-int/lit8 v6, v6, 0x1

    .line 592
    .line 593
    move-object/from16 v0, v23

    .line 594
    .line 595
    goto/16 :goto_15d

    .line 596
    .line 597
    :cond_254
    move-object/from16 v23, v0

    .line 598
    .line 599
    invoke-virtual/range {v23 .. v23}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 600
    .line 601
    .line 602
    add-int/lit8 v3, v3, 0x1

    .line 603
    .line 604
    goto/16 :goto_152

    .line 605
    .line 606
    :cond_25d
    const/16 v24, 0x0

    .line 607
    .line 608
    aget-object v0, v5, v24

    .line 609
    .line 610
    const/16 v25, 0x1

    .line 611
    .line 612
    aget-object v2, v5, v25

    .line 613
    .line 614
    aget-object v3, v5, v16

    .line 615
    .line 616
    aget-object v4, v5, v20

    .line 617
    .line 618
    move-object v6, v5

    .line 619
    aget-object v5, v6, v19

    .line 620
    .line 621
    aget-object v6, v6, v18

    .line 622
    .line 623
    move-object/from16 v8, p2

    .line 624
    .line 625
    move-object v7, v1

    .line 626
    const/4 v9, 0x0

    .line 627
    move-object v1, v0

    .line 628
    move/from16 v0, v24

    .line 629
    .line 630
    filled-new-array/range {v1 .. v8}, [[B

    .line 631
    .line 632
    .line 633
    move-result-object v1

    .line 634
    aget-object v2, v1, v0

    .line 635
    .line 636
    move-object/from16 v3, p0

    .line 637
    .line 638
    iput-object v2, v3, Lcom/kousei/framework/jb;->M:[B

    .line 639
    .line 640
    aget-object v2, v1, v25

    .line 641
    .line 642
    iput-object v2, v3, Lcom/kousei/framework/jb;->N:[B

    .line 643
    .line 644
    aget-object v2, v1, v16

    .line 645
    .line 646
    iput-object v2, v3, Lcom/kousei/framework/jb;->O:[B

    .line 647
    .line 648
    aget-object v2, v1, v20

    .line 649
    .line 650
    iput-object v2, v3, Lcom/kousei/framework/jb;->P:[B

    .line 651
    .line 652
    aget-object v2, v1, v19

    .line 653
    .line 654
    iput-object v2, v3, Lcom/kousei/framework/jb;->Q:[B

    .line 655
    .line 656
    aget-object v2, v1, v18

    .line 657
    .line 658
    iput-object v2, v3, Lcom/kousei/framework/jb;->R:[B

    .line 659
    .line 660
    const/16 v21, 0x6

    .line 661
    .line 662
    aget-object v2, v1, v21

    .line 663
    .line 664
    iput-object v2, v3, Lcom/kousei/framework/jb;->S:[B

    .line 665
    .line 666
    aget-object v1, v1, v17

    .line 667
    .line 668
    iput-object v1, v3, Lcom/kousei/framework/jb;->T:[B

    .line 669
    .line 670
    move v7, v0

    .line 671
    goto/16 :goto_4b7

    .line 672
    .line 673
    :cond_2a0
    move-object v3, v0

    .line 674
    move v0, v6

    .line 675
    move/from16 v26, v11

    .line 676
    .line 677
    move v15, v14

    .line 678
    const/4 v9, 0x0

    .line 679
    const/16 v20, 0x3

    .line 680
    .line 681
    invoke-static {v8, v0, v15}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 682
    .line 683
    .line 684
    move-result-object v1

    .line 685
    iput-object v1, v3, Lcom/kousei/framework/jb;->M:[B

    .line 686
    .line 687
    const/16 v5, 0x40

    .line 688
    .line 689
    invoke-static {v8, v15, v5}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 690
    .line 691
    .line 692
    move-result-object v4

    .line 693
    iput-object v4, v3, Lcom/kousei/framework/jb;->N:[B

    .line 694
    .line 695
    const/16 v15, 0x80

    .line 696
    .line 697
    invoke-static {v8, v5, v15}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 698
    .line 699
    .line 700
    move-result-object v4

    .line 701
    iput-object v4, v3, Lcom/kousei/framework/jb;->O:[B

    .line 702
    .line 703
    mul-int v11, v7, v26

    .line 704
    .line 705
    add-int/2addr v11, v15

    .line 706
    invoke-static {v8, v15, v11}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 707
    .line 708
    .line 709
    move-result-object v4

    .line 710
    iput-object v4, v3, Lcom/kousei/framework/jb;->P:[B

    .line 711
    .line 712
    mul-int v5, v13, v26

    .line 713
    .line 714
    add-int/2addr v5, v11

    .line 715
    invoke-static {v8, v11, v5}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 716
    .line 717
    .line 718
    move-result-object v6

    .line 719
    iput-object v6, v3, Lcom/kousei/framework/jb;->Q:[B

    .line 720
    .line 721
    mul-int/lit16 v10, v13, 0x1a0

    .line 722
    .line 723
    add-int/2addr v10, v5

    .line 724
    invoke-static {v8, v5, v10}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 725
    .line 726
    .line 727
    move-result-object v5

    .line 728
    iput-object v5, v3, Lcom/kousei/framework/jb;->R:[B

    .line 729
    .line 730
    new-instance v8, Lcom/kousei/framework/y;

    .line 731
    .line 732
    invoke-direct {v8, v2, v0}, Lcom/kousei/framework/y;-><init>(Lcom/kousei/framework/fb;B)V

    .line 733
    .line 734
    .line 735
    new-instance v10, Lcom/kousei/framework/ed;

    .line 736
    .line 737
    const/4 v11, 0x1

    .line 738
    invoke-direct {v10, v2, v11}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 739
    .line 740
    .line 741
    new-instance v11, Lcom/kousei/framework/ed;

    .line 742
    .line 743
    invoke-direct {v11, v2, v0}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 744
    .line 745
    .line 746
    new-instance v12, Lcom/kousei/framework/ed;

    .line 747
    .line 748
    invoke-direct {v12, v2, v0}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 749
    .line 750
    .line 751
    new-instance v14, Lcom/kousei/framework/ed;

    .line 752
    .line 753
    invoke-direct {v14, v2, v0}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 754
    .line 755
    .line 756
    move v15, v0

    .line 757
    :goto_2f4
    iget-object v9, v10, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 758
    .line 759
    if-ge v15, v7, :cond_303

    .line 760
    .line 761
    aget-object v9, v9, v15

    .line 762
    .line 763
    mul-int v0, v15, v26

    .line 764
    .line 765
    invoke-virtual {v9, v0, v4}, Lcom/kousei/framework/k3;->e(I[B)V

    .line 766
    .line 767
    .line 768
    add-int/lit8 v15, v15, 0x1

    .line 769
    .line 770
    const/4 v0, 0x0

    .line 771
    goto :goto_2f4

    .line 772
    :cond_303
    const/4 v0, 0x0

    .line 773
    :goto_304
    iget-object v4, v11, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 774
    .line 775
    if-ge v0, v13, :cond_312

    .line 776
    .line 777
    aget-object v4, v4, v0

    .line 778
    .line 779
    mul-int v7, v0, v26

    .line 780
    .line 781
    invoke-virtual {v4, v7, v6}, Lcom/kousei/framework/k3;->e(I[B)V

    .line 782
    .line 783
    .line 784
    add-int/lit8 v0, v0, 0x1

    .line 785
    .line 786
    goto :goto_304

    .line 787
    :cond_312
    const/4 v6, 0x0

    .line 788
    :goto_313
    if-ge v6, v13, :cond_44e

    .line 789
    .line 790
    iget-object v0, v14, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 791
    .line 792
    aget-object v0, v0, v6

    .line 793
    .line 794
    mul-int/lit16 v7, v6, 0x1a0

    .line 795
    .line 796
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 797
    .line 798
    .line 799
    const/4 v10, 0x0

    .line 800
    :goto_31f
    const/16 v15, 0x20

    .line 801
    .line 802
    if-ge v10, v15, :cond_446

    .line 803
    .line 804
    mul-int/lit8 v11, v10, 0xd

    .line 805
    .line 806
    add-int/2addr v11, v7

    .line 807
    mul-int/lit8 v23, v10, 0x8

    .line 808
    .line 809
    aget-byte v15, v5, v11

    .line 810
    .line 811
    and-int/lit16 v15, v15, 0xff

    .line 812
    .line 813
    add-int/lit8 v26, v11, 0x1

    .line 814
    .line 815
    move-object/from16 v27, v4

    .line 816
    .line 817
    aget-byte v4, v5, v26

    .line 818
    .line 819
    and-int/lit16 v4, v4, 0xff

    .line 820
    .line 821
    shl-int/lit8 v26, v4, 0x8

    .line 822
    .line 823
    or-int v15, v15, v26

    .line 824
    .line 825
    and-int/lit16 v15, v15, 0x1fff

    .line 826
    .line 827
    move/from16 v26, v4

    .line 828
    .line 829
    iget-object v4, v0, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 830
    .line 831
    check-cast v4, [I

    .line 832
    .line 833
    aput v15, v4, v23

    .line 834
    .line 835
    add-int/lit8 v15, v23, 0x1

    .line 836
    .line 837
    shr-int/lit8 v26, v26, 0x5

    .line 838
    .line 839
    add-int/lit8 v28, v11, 0x2

    .line 840
    .line 841
    move-object/from16 p2, v0

    .line 842
    .line 843
    aget-byte v0, v5, v28

    .line 844
    .line 845
    and-int/lit16 v0, v0, 0xff

    .line 846
    .line 847
    shl-int/lit8 v0, v0, 0x3

    .line 848
    .line 849
    or-int v0, v26, v0

    .line 850
    .line 851
    add-int/lit8 v26, v11, 0x3

    .line 852
    .line 853
    move/from16 v28, v0

    .line 854
    .line 855
    aget-byte v0, v5, v26

    .line 856
    .line 857
    and-int/lit16 v0, v0, 0xff

    .line 858
    .line 859
    shl-int/lit8 v26, v0, 0xb

    .line 860
    .line 861
    move/from16 v29, v0

    .line 862
    .line 863
    or-int v0, v28, v26

    .line 864
    .line 865
    and-int/lit16 v0, v0, 0x1fff

    .line 866
    .line 867
    aput v0, v4, v15

    .line 868
    .line 869
    add-int/lit8 v0, v23, 0x2

    .line 870
    .line 871
    shr-int/lit8 v26, v29, 0x2

    .line 872
    .line 873
    add-int/lit8 v28, v11, 0x4

    .line 874
    .line 875
    move/from16 v29, v0

    .line 876
    .line 877
    aget-byte v0, v5, v28

    .line 878
    .line 879
    and-int/lit16 v0, v0, 0xff

    .line 880
    .line 881
    shl-int/lit8 v28, v0, 0x6

    .line 882
    .line 883
    move/from16 v30, v0

    .line 884
    .line 885
    or-int v0, v26, v28

    .line 886
    .line 887
    and-int/lit16 v0, v0, 0x1fff

    .line 888
    .line 889
    aput v0, v4, v29

    .line 890
    .line 891
    add-int/lit8 v0, v23, 0x3

    .line 892
    .line 893
    shr-int/lit8 v26, v30, 0x7

    .line 894
    .line 895
    add-int/lit8 v28, v11, 0x5

    .line 896
    .line 897
    move/from16 v30, v0

    .line 898
    .line 899
    aget-byte v0, v5, v28

    .line 900
    .line 901
    and-int/lit16 v0, v0, 0xff

    .line 902
    .line 903
    const/16 v25, 0x1

    .line 904
    .line 905
    shl-int/lit8 v0, v0, 0x1

    .line 906
    .line 907
    or-int v0, v26, v0

    .line 908
    .line 909
    add-int/lit8 v26, v11, 0x6

    .line 910
    .line 911
    move/from16 v28, v0

    .line 912
    .line 913
    aget-byte v0, v5, v26

    .line 914
    .line 915
    and-int/lit16 v0, v0, 0xff

    .line 916
    .line 917
    shl-int/lit8 v26, v0, 0x9

    .line 918
    .line 919
    move/from16 v31, v0

    .line 920
    .line 921
    or-int v0, v28, v26

    .line 922
    .line 923
    and-int/lit16 v0, v0, 0x1fff

    .line 924
    .line 925
    aput v0, v4, v30

    .line 926
    .line 927
    add-int/lit8 v0, v23, 0x4

    .line 928
    .line 929
    shr-int/lit8 v26, v31, 0x4

    .line 930
    .line 931
    add-int/lit8 v28, v11, 0x7

    .line 932
    .line 933
    move/from16 v31, v0

    .line 934
    .line 935
    aget-byte v0, v5, v28

    .line 936
    .line 937
    and-int/lit16 v0, v0, 0xff

    .line 938
    .line 939
    shl-int/lit8 v0, v0, 0x4

    .line 940
    .line 941
    or-int v0, v26, v0

    .line 942
    .line 943
    add-int/lit8 v26, v11, 0x8

    .line 944
    .line 945
    move/from16 v28, v0

    .line 946
    .line 947
    aget-byte v0, v5, v26

    .line 948
    .line 949
    and-int/lit16 v0, v0, 0xff

    .line 950
    .line 951
    shl-int/lit8 v26, v0, 0xc

    .line 952
    .line 953
    move/from16 v32, v0

    .line 954
    .line 955
    or-int v0, v28, v26

    .line 956
    .line 957
    and-int/lit16 v0, v0, 0x1fff

    .line 958
    .line 959
    aput v0, v4, v31

    .line 960
    .line 961
    add-int/lit8 v0, v23, 0x5

    .line 962
    .line 963
    const/16 v25, 0x1

    .line 964
    .line 965
    shr-int/lit8 v26, v32, 0x1

    .line 966
    .line 967
    add-int/lit8 v28, v11, 0x9

    .line 968
    .line 969
    move/from16 v32, v0

    .line 970
    .line 971
    aget-byte v0, v5, v28

    .line 972
    .line 973
    and-int/lit16 v0, v0, 0xff

    .line 974
    .line 975
    shl-int/lit8 v28, v0, 0x7

    .line 976
    .line 977
    move/from16 v33, v0

    .line 978
    .line 979
    or-int v0, v26, v28

    .line 980
    .line 981
    and-int/lit16 v0, v0, 0x1fff

    .line 982
    .line 983
    aput v0, v4, v32

    .line 984
    .line 985
    add-int/lit8 v0, v23, 0x6

    .line 986
    .line 987
    const/16 v21, 0x6

    .line 988
    .line 989
    shr-int/lit8 v26, v33, 0x6

    .line 990
    .line 991
    add-int/lit8 v28, v11, 0xa

    .line 992
    .line 993
    move/from16 v33, v0

    .line 994
    .line 995
    aget-byte v0, v5, v28

    .line 996
    .line 997
    and-int/lit16 v0, v0, 0xff

    .line 998
    .line 999
    shl-int/lit8 v0, v0, 0x2

    .line 1000
    .line 1001
    or-int v0, v26, v0

    .line 1002
    .line 1003
    add-int/lit8 v26, v11, 0xb

    .line 1004
    .line 1005
    move/from16 v28, v0

    .line 1006
    .line 1007
    aget-byte v0, v5, v26

    .line 1008
    .line 1009
    and-int/lit16 v0, v0, 0xff

    .line 1010
    .line 1011
    shl-int/lit8 v26, v0, 0xa

    .line 1012
    .line 1013
    move/from16 v34, v0

    .line 1014
    .line 1015
    or-int v0, v28, v26

    .line 1016
    .line 1017
    and-int/lit16 v0, v0, 0x1fff

    .line 1018
    .line 1019
    aput v0, v4, v33

    .line 1020
    .line 1021
    add-int/lit8 v0, v23, 0x7

    .line 1022
    .line 1023
    shr-int/lit8 v26, v34, 0x3

    .line 1024
    .line 1025
    add-int/lit8 v11, v11, 0xc

    .line 1026
    .line 1027
    aget-byte v11, v5, v11

    .line 1028
    .line 1029
    and-int/lit16 v11, v11, 0xff

    .line 1030
    .line 1031
    shl-int/lit8 v11, v11, 0x5

    .line 1032
    .line 1033
    or-int v11, v26, v11

    .line 1034
    .line 1035
    and-int/lit16 v11, v11, 0x1fff

    .line 1036
    .line 1037
    aput v11, v4, v0

    .line 1038
    .line 1039
    aget v11, v4, v23

    .line 1040
    .line 1041
    rsub-int v11, v11, 0x1000

    .line 1042
    .line 1043
    aput v11, v4, v23

    .line 1044
    .line 1045
    aget v11, v4, v15

    .line 1046
    .line 1047
    rsub-int v11, v11, 0x1000

    .line 1048
    .line 1049
    aput v11, v4, v15

    .line 1050
    .line 1051
    aget v11, v4, v29

    .line 1052
    .line 1053
    rsub-int v11, v11, 0x1000

    .line 1054
    .line 1055
    aput v11, v4, v29

    .line 1056
    .line 1057
    aget v11, v4, v30

    .line 1058
    .line 1059
    rsub-int v11, v11, 0x1000

    .line 1060
    .line 1061
    aput v11, v4, v30

    .line 1062
    .line 1063
    aget v11, v4, v31

    .line 1064
    .line 1065
    rsub-int v11, v11, 0x1000

    .line 1066
    .line 1067
    aput v11, v4, v31

    .line 1068
    .line 1069
    aget v11, v4, v32

    .line 1070
    .line 1071
    rsub-int v11, v11, 0x1000

    .line 1072
    .line 1073
    aput v11, v4, v32

    .line 1074
    .line 1075
    aget v11, v4, v33

    .line 1076
    .line 1077
    rsub-int v11, v11, 0x1000

    .line 1078
    .line 1079
    aput v11, v4, v33

    .line 1080
    .line 1081
    aget v11, v4, v0

    .line 1082
    .line 1083
    rsub-int v11, v11, 0x1000

    .line 1084
    .line 1085
    aput v11, v4, v0

    .line 1086
    .line 1087
    add-int/lit8 v10, v10, 0x1

    .line 1088
    .line 1089
    move-object/from16 v0, p2

    .line 1090
    .line 1091
    move-object/from16 v4, v27

    .line 1092
    .line 1093
    goto/16 :goto_31f

    .line 1094
    .line 1095
    :cond_446
    move-object/from16 v27, v4

    .line 1096
    .line 1097
    const/16 v21, 0x6

    .line 1098
    .line 1099
    add-int/lit8 v6, v6, 0x1

    .line 1100
    .line 1101
    goto/16 :goto_313

    .line 1102
    .line 1103
    :cond_44e
    move-object/from16 v27, v4

    .line 1104
    .line 1105
    invoke-virtual {v8, v1}, Lcom/kousei/framework/y;->c([B)V

    .line 1106
    .line 1107
    .line 1108
    new-instance v0, Lcom/kousei/framework/ed;

    .line 1109
    .line 1110
    const/4 v11, 0x1

    .line 1111
    invoke-direct {v0, v2, v11}, Lcom/kousei/framework/ed;-><init>(Lcom/kousei/framework/fb;I)V

    .line 1112
    .line 1113
    .line 1114
    const/4 v6, 0x0

    .line 1115
    :goto_45a
    array-length v1, v9

    .line 1116
    if-ge v6, v1, :cond_474

    .line 1117
    .line 1118
    aget-object v1, v9, v6

    .line 1119
    .line 1120
    iget-object v4, v0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 1121
    .line 1122
    aget-object v4, v4, v6

    .line 1123
    .line 1124
    iget-object v1, v1, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1125
    .line 1126
    check-cast v1, [I

    .line 1127
    .line 1128
    iget-object v4, v4, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1129
    .line 1130
    check-cast v4, [I

    .line 1131
    .line 1132
    const/16 v5, 0x100

    .line 1133
    .line 1134
    const/4 v7, 0x0

    .line 1135
    invoke-static {v1, v7, v4, v7, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1136
    .line 1137
    .line 1138
    add-int/lit8 v6, v6, 0x1

    .line 1139
    .line 1140
    goto :goto_45a

    .line 1141
    :cond_474
    const/4 v7, 0x0

    .line 1142
    invoke-virtual {v0}, Lcom/kousei/framework/ed;->c()V

    .line 1143
    .line 1144
    .line 1145
    invoke-virtual {v8, v12, v0}, Lcom/kousei/framework/y;->j(Lcom/kousei/framework/ed;Lcom/kousei/framework/ed;)V

    .line 1146
    .line 1147
    .line 1148
    invoke-virtual {v12}, Lcom/kousei/framework/ed;->e()V

    .line 1149
    .line 1150
    .line 1151
    invoke-virtual {v12}, Lcom/kousei/framework/ed;->b()V

    .line 1152
    .line 1153
    .line 1154
    move v6, v7

    .line 1155
    :goto_482
    iget-object v0, v12, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 1156
    .line 1157
    array-length v1, v0

    .line 1158
    if-ge v6, v1, :cond_4a8

    .line 1159
    .line 1160
    aget-object v0, v0, v6

    .line 1161
    .line 1162
    aget-object v1, v27, v6

    .line 1163
    .line 1164
    move v4, v7

    .line 1165
    const/16 v5, 0x100

    .line 1166
    .line 1167
    :goto_48e
    if-ge v4, v5, :cond_4a2

    .line 1168
    .line 1169
    iget-object v8, v0, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1170
    .line 1171
    check-cast v8, [I

    .line 1172
    .line 1173
    aget v9, v8, v4

    .line 1174
    .line 1175
    iget-object v10, v1, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1176
    .line 1177
    check-cast v10, [I

    .line 1178
    .line 1179
    aget v10, v10, v4

    .line 1180
    .line 1181
    add-int/2addr v9, v10

    .line 1182
    aput v9, v8, v4

    .line 1183
    .line 1184
    add-int/lit8 v4, v4, 0x1

    .line 1185
    .line 1186
    goto :goto_48e

    .line 1187
    :cond_4a2
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1188
    .line 1189
    .line 1190
    add-int/lit8 v6, v6, 0x1

    .line 1191
    .line 1192
    goto :goto_482

    .line 1193
    :cond_4a8
    invoke-virtual {v12}, Lcom/kousei/framework/ed;->a()V

    .line 1194
    .line 1195
    .line 1196
    invoke-virtual {v12, v14}, Lcom/kousei/framework/ed;->d(Lcom/kousei/framework/ed;)V

    .line 1197
    .line 1198
    .line 1199
    invoke-static {v12, v2}, Lcom/kousei/framework/xc;->a0(Lcom/kousei/framework/ed;Lcom/kousei/framework/fb;)[B

    .line 1200
    .line 1201
    .line 1202
    move-result-object v0

    .line 1203
    iput-object v0, v3, Lcom/kousei/framework/jb;->S:[B

    .line 1204
    .line 1205
    const/4 v9, 0x0

    .line 1206
    iput-object v9, v3, Lcom/kousei/framework/jb;->T:[B

    .line 1207
    .line 1208
    :goto_4b7
    if-eqz p3, :cond_4d0

    .line 1209
    .line 1210
    iget-object v0, v3, Lcom/kousei/framework/jb;->S:[B

    .line 1211
    .line 1212
    move-object/from16 v1, p3

    .line 1213
    .line 1214
    iget-object v1, v1, Lcom/kousei/framework/lb;->N:[B

    .line 1215
    .line 1216
    invoke-static {v1}, Lcom/kousei/framework/i0;->J([B)[B

    .line 1217
    .line 1218
    .line 1219
    move-result-object v1

    .line 1220
    invoke-static {v0, v1}, Lcom/kousei/framework/i0;->P([B[B)Z

    .line 1221
    .line 1222
    .line 1223
    move-result v0

    .line 1224
    if-eqz v0, :cond_4ca

    .line 1225
    .line 1226
    goto :goto_4d0

    .line 1227
    :cond_4ca
    const-string v0, "passed in public key does not match private values"

    .line 1228
    .line 1229
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 1230
    .line 1231
    .line 1232
    throw v9

    .line 1233
    :cond_4d0
    :goto_4d0
    iget-object v0, v3, Lcom/kousei/framework/jb;->T:[B

    .line 1234
    .line 1235
    if-eqz v0, :cond_4d5

    .line 1236
    .line 1237
    goto :goto_4d7

    .line 1238
    :cond_4d5
    move/from16 v7, v16

    .line 1239
    .line 1240
    :goto_4d7
    iput v7, v3, Lcom/kousei/framework/jb;->U:I

    .line 1241
    .line 1242
    return-void
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


# virtual methods
.method public final getEncoded()[B
    .registers 7

    .line 1
    iget-object v4, p0, Lcom/kousei/framework/jb;->Q:[B

    .line 2
    .line 3
    iget-object v5, p0, Lcom/kousei/framework/jb;->R:[B

    .line 4
    .line 5
    iget-object v0, p0, Lcom/kousei/framework/jb;->M:[B

    .line 6
    .line 7
    iget-object v1, p0, Lcom/kousei/framework/jb;->N:[B

    .line 8
    .line 9
    iget-object v2, p0, Lcom/kousei/framework/jb;->O:[B

    .line 10
    .line 11
    iget-object v3, p0, Lcom/kousei/framework/jb;->P:[B

    .line 12
    .line 13
    filled-new-array/range {v0 .. v5}, [[B

    .line 14
    .line 15
    .line 16
    move-result-object p0

    .line 17
    invoke-static {p0}, Lcom/kousei/framework/i0;->N([[B)[B

    .line 18
    .line 19
    .line 20
    move-result-object p0

    .line 21
    return-object p0
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
