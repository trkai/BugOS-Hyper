.class public final Lcom/kousei/framework/ib;
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
.method public constructor <init>(Lcom/kousei/framework/gb;[BLcom/kousei/framework/kb;)V
    .registers 41

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
    iget v1, v1, Lcom/kousei/framework/gb;->a:I

    .line 14
    .line 15
    const/4 v11, 0x0

    .line 16
    invoke-direct {v2, v1, v11}, Lcom/kousei/framework/fb;-><init>(II)V

    .line 17
    .line 18
    .line 19
    array-length v1, v8

    .line 20
    const/16 v4, 0x40

    .line 21
    .line 22
    const/16 v5, 0x80

    .line 23
    .line 24
    const/16 v16, 0x3

    .line 25
    .line 26
    const/16 v17, 0x2

    .line 27
    .line 28
    iget v7, v2, Lcom/kousei/framework/fb;->d:I

    .line 29
    .line 30
    iget v6, v2, Lcom/kousei/framework/fb;->b:I

    .line 31
    .line 32
    const/16 v18, 0x7

    .line 33
    .line 34
    iget v12, v2, Lcom/kousei/framework/fb;->c:I

    .line 35
    .line 36
    const/16 v19, 0x5

    .line 37
    .line 38
    const/16 v14, 0x20

    .line 39
    .line 40
    if-ne v1, v14, :cond_29e

    .line 41
    .line 42
    new-array v1, v5, [B

    .line 43
    .line 44
    const/16 v20, 0x4

    .line 45
    .line 46
    new-array v15, v4, [B

    .line 47
    .line 48
    new-array v13, v14, [B

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
    invoke-direct {v5, v2}, Lcom/kousei/framework/y;-><init>(Lcom/kousei/framework/fb;)V

    .line 57
    .line 58
    .line 59
    new-instance v14, Lcom/kousei/framework/dd;

    .line 60
    .line 61
    invoke-direct {v14, v2, v10}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 62
    .line 63
    .line 64
    new-instance v10, Lcom/kousei/framework/dd;

    .line 65
    .line 66
    invoke-direct {v10, v2, v11}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 67
    .line 68
    .line 69
    move/from16 v26, v6

    .line 70
    .line 71
    new-instance v6, Lcom/kousei/framework/dd;

    .line 72
    .line 73
    invoke-direct {v6, v2, v11}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 74
    .line 75
    .line 76
    new-instance v9, Lcom/kousei/framework/dd;

    .line 77
    .line 78
    invoke-direct {v9, v2, v11}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

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
    invoke-virtual {v0, v8, v11, v15}, Lcom/kousei/framework/ba;->update([BII)V

    .line 88
    .line 89
    .line 90
    int-to-byte v15, v12

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
    invoke-virtual {v0, v1, v11, v15}, Lcom/kousei/framework/te;->l([BII)V

    .line 101
    .line 102
    .line 103
    const/16 v15, 0x20

    .line 104
    .line 105
    invoke-static {v1, v11, v13, v11, v15}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 106
    .line 107
    .line 108
    const/16 v8, 0x40

    .line 109
    .line 110
    invoke-static {v1, v15, v3, v11, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 111
    .line 112
    .line 113
    const/16 v8, 0x60

    .line 114
    .line 115
    invoke-static {v1, v8, v4, v11, v15}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 116
    .line 117
    .line 118
    invoke-virtual {v5, v13}, Lcom/kousei/framework/y;->c([B)V

    .line 119
    .line 120
    .line 121
    move v1, v11

    .line 122
    move v8, v1

    .line 123
    :goto_7a
    iget-object v15, v14, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 124
    .line 125
    array-length v11, v15

    .line 126
    if-ge v1, v11, :cond_8c

    .line 127
    .line 128
    aget-object v11, v15, v1

    .line 129
    .line 130
    add-int/lit8 v15, v8, 0x1

    .line 131
    .line 132
    int-to-short v15, v15

    .line 133
    invoke-virtual {v11, v3, v8}, Lcom/kousei/framework/k3;->j([BS)V

    .line 134
    .line 135
    .line 136
    add-int/lit8 v1, v1, 0x1

    .line 137
    .line 138
    move v8, v15

    .line 139
    const/4 v11, 0x0

    .line 140
    goto :goto_7a

    .line 141
    :cond_8c
    int-to-short v1, v7

    .line 142
    const/4 v8, 0x0

    .line 143
    :goto_8e
    iget-object v11, v10, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 144
    .line 145
    array-length v14, v11

    .line 146
    if-ge v8, v14, :cond_9f

    .line 147
    .line 148
    aget-object v11, v11, v8

    .line 149
    .line 150
    add-int/lit8 v14, v1, 0x1

    .line 151
    .line 152
    int-to-short v14, v14

    .line 153
    invoke-virtual {v11, v3, v1}, Lcom/kousei/framework/k3;->j([BS)V

    .line 154
    .line 155
    .line 156
    add-int/lit8 v8, v8, 0x1

    .line 157
    .line 158
    move v1, v14

    .line 159
    goto :goto_8e

    .line 160
    :cond_9f
    new-instance v1, Lcom/kousei/framework/dd;

    .line 161
    .line 162
    const/4 v3, 0x1

    .line 163
    invoke-direct {v1, v2, v3}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 164
    .line 165
    .line 166
    const/4 v3, 0x0

    .line 167
    :goto_a6
    array-length v8, v15

    .line 168
    if-ge v3, v8, :cond_c2

    .line 169
    .line 170
    aget-object v8, v15, v3

    .line 171
    .line 172
    iget-object v10, v1, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 173
    .line 174
    aget-object v10, v10, v3

    .line 175
    .line 176
    iget-object v8, v8, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 177
    .line 178
    check-cast v8, [I

    .line 179
    .line 180
    iget-object v10, v10, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 181
    .line 182
    check-cast v10, [I

    .line 183
    .line 184
    move/from16 v24, v3

    .line 185
    .line 186
    const/4 v3, 0x0

    .line 187
    const/16 v14, 0x100

    .line 188
    .line 189
    invoke-static {v8, v3, v10, v3, v14}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 190
    .line 191
    .line 192
    add-int/lit8 v3, v24, 0x1

    .line 193
    .line 194
    goto :goto_a6

    .line 195
    :cond_c2
    invoke-virtual {v1}, Lcom/kousei/framework/dd;->c()V

    .line 196
    .line 197
    .line 198
    invoke-virtual {v5, v6, v1}, Lcom/kousei/framework/y;->i(Lcom/kousei/framework/dd;Lcom/kousei/framework/dd;)V

    .line 199
    .line 200
    .line 201
    invoke-virtual {v6}, Lcom/kousei/framework/dd;->e()V

    .line 202
    .line 203
    .line 204
    invoke-virtual {v6}, Lcom/kousei/framework/dd;->b()V

    .line 205
    .line 206
    .line 207
    const/4 v1, 0x0

    .line 208
    :goto_cf
    iget-object v3, v6, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

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
    aget-object v5, v11, v1

    .line 216
    .line 217
    const/4 v8, 0x0

    .line 218
    :goto_d9
    const/16 v14, 0x100

    .line 219
    .line 220
    if-ge v8, v14, :cond_f3

    .line 221
    .line 222
    iget-object v10, v3, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 223
    .line 224
    check-cast v10, [I

    .line 225
    .line 226
    aget v14, v10, v8

    .line 227
    .line 228
    move/from16 v24, v1

    .line 229
    .line 230
    iget-object v1, v5, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 231
    .line 232
    check-cast v1, [I

    .line 233
    .line 234
    aget v1, v1, v8

    .line 235
    .line 236
    add-int/2addr v14, v1

    .line 237
    aput v14, v10, v8

    .line 238
    .line 239
    add-int/lit8 v8, v8, 0x1

    .line 240
    .line 241
    move/from16 v1, v24

    .line 242
    .line 243
    goto :goto_d9

    .line 244
    :cond_f3
    move/from16 v24, v1

    .line 245
    .line 246
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 247
    .line 248
    .line 249
    add-int/lit8 v1, v24, 0x1

    .line 250
    .line 251
    goto :goto_cf

    .line 252
    :cond_fb
    invoke-virtual {v6}, Lcom/kousei/framework/dd;->a()V

    .line 253
    .line 254
    .line 255
    invoke-virtual {v6, v9}, Lcom/kousei/framework/dd;->d(Lcom/kousei/framework/dd;)V

    .line 256
    .line 257
    .line 258
    invoke-static {v6, v2}, Lcom/kousei/framework/xc;->Z(Lcom/kousei/framework/dd;Lcom/kousei/framework/fb;)[B

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
    invoke-virtual {v0, v13, v3, v2}, Lcom/kousei/framework/ba;->update([BII)V

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
    const/16 v8, 0x40

    .line 275
    .line 276
    invoke-virtual {v0, v2, v3, v8}, Lcom/kousei/framework/te;->l([BII)V

    .line 277
    .line 278
    .line 279
    const/4 v0, 0x6

    .line 280
    new-array v5, v0, [[B

    .line 281
    .line 282
    aput-object v13, v5, v3

    .line 283
    .line 284
    const/16 v25, 0x1

    .line 285
    .line 286
    aput-object v4, v5, v25

    .line 287
    .line 288
    aput-object v2, v5, v17

    .line 289
    .line 290
    mul-int v6, v7, v26

    .line 291
    .line 292
    new-array v0, v6, [B

    .line 293
    .line 294
    aput-object v0, v5, v16

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
    aget-object v3, v5, v16

    .line 302
    .line 303
    mul-int v6, v0, v26

    .line 304
    .line 305
    invoke-virtual {v2, v6, v3}, Lcom/kousei/framework/k3;->d(I[B)V

    .line 306
    .line 307
    .line 308
    add-int/lit8 v0, v0, 0x1

    .line 309
    .line 310
    goto :goto_128

    .line 311
    :cond_136
    mul-int v6, v12, v26

    .line 312
    .line 313
    new-array v0, v6, [B

    .line 314
    .line 315
    aput-object v0, v5, v20

    .line 316
    .line 317
    const/4 v0, 0x0

    .line 318
    :goto_13d
    if-ge v0, v12, :cond_14b

    .line 319
    .line 320
    aget-object v2, v11, v0

    .line 321
    .line 322
    aget-object v3, v5, v20

    .line 323
    .line 324
    mul-int v6, v0, v26

    .line 325
    .line 326
    invoke-virtual {v2, v6, v3}, Lcom/kousei/framework/k3;->d(I[B)V

    .line 327
    .line 328
    .line 329
    add-int/lit8 v0, v0, 0x1

    .line 330
    .line 331
    goto :goto_13d

    .line 332
    :cond_14b
    mul-int/lit16 v0, v12, 0x1a0

    .line 333
    .line 334
    new-array v0, v0, [B

    .line 335
    .line 336
    aput-object v0, v5, v19

    .line 337
    .line 338
    const/4 v0, 0x0

    .line 339
    :goto_152
    if-ge v0, v12, :cond_25d

    .line 340
    .line 341
    iget-object v2, v9, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 342
    .line 343
    aget-object v2, v2, v0

    .line 344
    .line 345
    aget-object v3, v5, v19

    .line 346
    .line 347
    mul-int/lit16 v4, v0, 0x1a0

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
    iget-object v8, v2, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

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
    add-int/lit8 v13, v7, 0x2

    .line 371
    .line 372
    aget v13, v8, v13

    .line 373
    .line 374
    rsub-int v13, v13, 0x1000

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
    move/from16 v23, v0

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
    move/from16 v34, v0

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
    move/from16 v35, v0

    .line 411
    .line 412
    move/from16 v36, v7

    .line 413
    .line 414
    move/from16 v29, v10

    .line 415
    .line 416
    move/from16 v30, v11

    .line 417
    .line 418
    move/from16 v31, v13

    .line 419
    .line 420
    move/from16 v32, v14

    .line 421
    .line 422
    move/from16 v33, v15

    .line 423
    .line 424
    filled-new-array/range {v29 .. v36}, [I

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
    const/16 v28, 0x0

    .line 432
    .line 433
    aget v8, v0, v28

    .line 434
    .line 435
    int-to-byte v10, v8

    .line 436
    aput-byte v10, v3, v7

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
    aput-byte v8, v3, v10

    .line 444
    .line 445
    const/16 v25, 0x1

    .line 446
    .line 447
    aget v11, v0, v25

    .line 448
    .line 449
    shl-int/lit8 v13, v11, 0x5

    .line 450
    .line 451
    int-to-byte v13, v13

    .line 452
    or-int/2addr v8, v13

    .line 453
    int-to-byte v8, v8

    .line 454
    aput-byte v8, v3, v10

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
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

    .line 469
    .line 470
    aget v11, v0, v17

    .line 471
    .line 472
    shl-int/lit8 v13, v11, 0x2

    .line 473
    .line 474
    int-to-byte v13, v13

    .line 475
    or-int/2addr v10, v13

    .line 476
    int-to-byte v10, v10

    .line 477
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

    .line 487
    .line 488
    aget v11, v0, v16

    .line 489
    .line 490
    shl-int/lit8 v13, v11, 0x7

    .line 491
    .line 492
    int-to-byte v13, v13

    .line 493
    or-int/2addr v10, v13

    .line 494
    int-to-byte v10, v10

    .line 495
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

    .line 510
    .line 511
    aget v11, v0, v20

    .line 512
    .line 513
    shl-int/lit8 v13, v11, 0x4

    .line 514
    .line 515
    int-to-byte v13, v13

    .line 516
    or-int/2addr v10, v13

    .line 517
    int-to-byte v10, v10

    .line 518
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

    .line 533
    .line 534
    aget v11, v0, v19

    .line 535
    .line 536
    shl-int/lit8 v13, v11, 0x1

    .line 537
    .line 538
    int-to-byte v13, v13

    .line 539
    or-int/2addr v10, v13

    .line 540
    int-to-byte v10, v10

    .line 541
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

    .line 549
    .line 550
    const/16 v21, 0x6

    .line 551
    .line 552
    aget v11, v0, v21

    .line 553
    .line 554
    shl-int/lit8 v13, v11, 0x6

    .line 555
    .line 556
    int-to-byte v13, v13

    .line 557
    or-int/2addr v10, v13

    .line 558
    int-to-byte v10, v10

    .line 559
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

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
    aput-byte v10, v3, v8

    .line 574
    .line 575
    aget v0, v0, v18

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
    aput-byte v10, v3, v8

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
    aput-byte v0, v3, v7

    .line 590
    .line 591
    add-int/lit8 v6, v6, 0x1

    .line 592
    .line 593
    move/from16 v0, v23

    .line 594
    .line 595
    goto/16 :goto_15d

    .line 596
    .line 597
    :cond_254
    move/from16 v23, v0

    .line 598
    .line 599
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 600
    .line 601
    .line 602
    add-int/lit8 v0, v23, 0x1

    .line 603
    .line 604
    goto/16 :goto_152

    .line 605
    .line 606
    :cond_25d
    const/16 v28, 0x0

    .line 607
    .line 608
    aget-object v0, v5, v28

    .line 609
    .line 610
    const/16 v25, 0x1

    .line 611
    .line 612
    aget-object v2, v5, v25

    .line 613
    .line 614
    aget-object v3, v5, v17

    .line 615
    .line 616
    aget-object v4, v5, v16

    .line 617
    .line 618
    move-object v6, v5

    .line 619
    aget-object v5, v6, v20

    .line 620
    .line 621
    aget-object v6, v6, v19

    .line 622
    .line 623
    move-object/from16 v8, p2

    .line 624
    .line 625
    move-object v7, v1

    .line 626
    move-object v1, v0

    .line 627
    const/4 v0, 0x0

    .line 628
    filled-new-array/range {v1 .. v8}, [[B

    .line 629
    .line 630
    .line 631
    move-result-object v1

    .line 632
    aget-object v2, v1, v28

    .line 633
    .line 634
    move-object/from16 v3, p0

    .line 635
    .line 636
    iput-object v2, v3, Lcom/kousei/framework/ib;->M:[B

    .line 637
    .line 638
    aget-object v2, v1, v25

    .line 639
    .line 640
    iput-object v2, v3, Lcom/kousei/framework/ib;->N:[B

    .line 641
    .line 642
    aget-object v2, v1, v17

    .line 643
    .line 644
    iput-object v2, v3, Lcom/kousei/framework/ib;->O:[B

    .line 645
    .line 646
    aget-object v2, v1, v16

    .line 647
    .line 648
    iput-object v2, v3, Lcom/kousei/framework/ib;->P:[B

    .line 649
    .line 650
    aget-object v2, v1, v20

    .line 651
    .line 652
    iput-object v2, v3, Lcom/kousei/framework/ib;->Q:[B

    .line 653
    .line 654
    aget-object v2, v1, v19

    .line 655
    .line 656
    iput-object v2, v3, Lcom/kousei/framework/ib;->R:[B

    .line 657
    .line 658
    const/16 v21, 0x6

    .line 659
    .line 660
    aget-object v2, v1, v21

    .line 661
    .line 662
    iput-object v2, v3, Lcom/kousei/framework/ib;->S:[B

    .line 663
    .line 664
    aget-object v1, v1, v18

    .line 665
    .line 666
    iput-object v1, v3, Lcom/kousei/framework/ib;->T:[B

    .line 667
    .line 668
    const/4 v11, 0x0

    .line 669
    goto/16 :goto_4b2

    .line 670
    .line 671
    :cond_29e
    move-object v3, v0

    .line 672
    move/from16 v26, v6

    .line 673
    .line 674
    move v1, v11

    .line 675
    move v15, v14

    .line 676
    const/4 v0, 0x0

    .line 677
    const/16 v20, 0x4

    .line 678
    .line 679
    invoke-static {v8, v1, v15}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 680
    .line 681
    .line 682
    move-result-object v4

    .line 683
    iput-object v4, v3, Lcom/kousei/framework/ib;->M:[B

    .line 684
    .line 685
    const/16 v1, 0x40

    .line 686
    .line 687
    invoke-static {v8, v15, v1}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 688
    .line 689
    .line 690
    move-result-object v5

    .line 691
    iput-object v5, v3, Lcom/kousei/framework/ib;->N:[B

    .line 692
    .line 693
    const/16 v15, 0x80

    .line 694
    .line 695
    invoke-static {v8, v1, v15}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 696
    .line 697
    .line 698
    move-result-object v1

    .line 699
    iput-object v1, v3, Lcom/kousei/framework/ib;->O:[B

    .line 700
    .line 701
    mul-int v6, v7, v26

    .line 702
    .line 703
    add-int/2addr v6, v15

    .line 704
    invoke-static {v8, v15, v6}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 705
    .line 706
    .line 707
    move-result-object v1

    .line 708
    iput-object v1, v3, Lcom/kousei/framework/ib;->P:[B

    .line 709
    .line 710
    mul-int v5, v12, v26

    .line 711
    .line 712
    add-int/2addr v5, v6

    .line 713
    invoke-static {v8, v6, v5}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 714
    .line 715
    .line 716
    move-result-object v6

    .line 717
    iput-object v6, v3, Lcom/kousei/framework/ib;->Q:[B

    .line 718
    .line 719
    mul-int/lit16 v9, v12, 0x1a0

    .line 720
    .line 721
    add-int/2addr v9, v5

    .line 722
    invoke-static {v8, v5, v9}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 723
    .line 724
    .line 725
    move-result-object v5

    .line 726
    iput-object v5, v3, Lcom/kousei/framework/ib;->R:[B

    .line 727
    .line 728
    new-instance v8, Lcom/kousei/framework/y;

    .line 729
    .line 730
    invoke-direct {v8, v2}, Lcom/kousei/framework/y;-><init>(Lcom/kousei/framework/fb;)V

    .line 731
    .line 732
    .line 733
    new-instance v9, Lcom/kousei/framework/dd;

    .line 734
    .line 735
    const/4 v10, 0x1

    .line 736
    invoke-direct {v9, v2, v10}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 737
    .line 738
    .line 739
    new-instance v10, Lcom/kousei/framework/dd;

    .line 740
    .line 741
    const/4 v11, 0x0

    .line 742
    invoke-direct {v10, v2, v11}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 743
    .line 744
    .line 745
    new-instance v13, Lcom/kousei/framework/dd;

    .line 746
    .line 747
    invoke-direct {v13, v2, v11}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 748
    .line 749
    .line 750
    new-instance v14, Lcom/kousei/framework/dd;

    .line 751
    .line 752
    invoke-direct {v14, v2, v11}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 753
    .line 754
    .line 755
    const/4 v11, 0x0

    .line 756
    :goto_2f3
    iget-object v15, v9, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 757
    .line 758
    if-ge v11, v7, :cond_302

    .line 759
    .line 760
    aget-object v15, v15, v11

    .line 761
    .line 762
    mul-int v0, v11, v26

    .line 763
    .line 764
    invoke-virtual {v15, v0, v1}, Lcom/kousei/framework/k3;->e(I[B)V

    .line 765
    .line 766
    .line 767
    add-int/lit8 v11, v11, 0x1

    .line 768
    .line 769
    const/4 v0, 0x0

    .line 770
    goto :goto_2f3

    .line 771
    :cond_302
    const/4 v0, 0x0

    .line 772
    :goto_303
    iget-object v1, v10, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 773
    .line 774
    if-ge v0, v12, :cond_311

    .line 775
    .line 776
    aget-object v1, v1, v0

    .line 777
    .line 778
    mul-int v7, v0, v26

    .line 779
    .line 780
    invoke-virtual {v1, v7, v6}, Lcom/kousei/framework/k3;->e(I[B)V

    .line 781
    .line 782
    .line 783
    add-int/lit8 v0, v0, 0x1

    .line 784
    .line 785
    goto :goto_303

    .line 786
    :cond_311
    const/4 v0, 0x0

    .line 787
    :goto_312
    if-ge v0, v12, :cond_44b

    .line 788
    .line 789
    iget-object v6, v14, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 790
    .line 791
    aget-object v6, v6, v0

    .line 792
    .line 793
    mul-int/lit16 v7, v0, 0x1a0

    .line 794
    .line 795
    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 796
    .line 797
    .line 798
    const/4 v9, 0x0

    .line 799
    :goto_31e
    const/16 v10, 0x20

    .line 800
    .line 801
    if-ge v9, v10, :cond_443

    .line 802
    .line 803
    mul-int/lit8 v11, v9, 0xd

    .line 804
    .line 805
    add-int/2addr v11, v7

    .line 806
    mul-int/lit8 v23, v9, 0x8

    .line 807
    .line 808
    aget-byte v10, v5, v11

    .line 809
    .line 810
    and-int/lit16 v10, v10, 0xff

    .line 811
    .line 812
    add-int/lit8 v24, v11, 0x1

    .line 813
    .line 814
    move/from16 v26, v0

    .line 815
    .line 816
    aget-byte v0, v5, v24

    .line 817
    .line 818
    and-int/lit16 v0, v0, 0xff

    .line 819
    .line 820
    shl-int/lit8 v24, v0, 0x8

    .line 821
    .line 822
    or-int v10, v10, v24

    .line 823
    .line 824
    and-int/lit16 v10, v10, 0x1fff

    .line 825
    .line 826
    move/from16 v24, v0

    .line 827
    .line 828
    iget-object v0, v6, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 829
    .line 830
    check-cast v0, [I

    .line 831
    .line 832
    aput v10, v0, v23

    .line 833
    .line 834
    add-int/lit8 v10, v23, 0x1

    .line 835
    .line 836
    shr-int/lit8 v24, v24, 0x5

    .line 837
    .line 838
    add-int/lit8 v27, v11, 0x2

    .line 839
    .line 840
    move-object/from16 p2, v0

    .line 841
    .line 842
    aget-byte v0, v5, v27

    .line 843
    .line 844
    and-int/lit16 v0, v0, 0xff

    .line 845
    .line 846
    shl-int/lit8 v0, v0, 0x3

    .line 847
    .line 848
    or-int v0, v24, v0

    .line 849
    .line 850
    add-int/lit8 v24, v11, 0x3

    .line 851
    .line 852
    move/from16 v27, v0

    .line 853
    .line 854
    aget-byte v0, v5, v24

    .line 855
    .line 856
    and-int/lit16 v0, v0, 0xff

    .line 857
    .line 858
    shl-int/lit8 v24, v0, 0xb

    .line 859
    .line 860
    move/from16 v29, v0

    .line 861
    .line 862
    or-int v0, v27, v24

    .line 863
    .line 864
    and-int/lit16 v0, v0, 0x1fff

    .line 865
    .line 866
    aput v0, p2, v10

    .line 867
    .line 868
    add-int/lit8 v0, v23, 0x2

    .line 869
    .line 870
    shr-int/lit8 v24, v29, 0x2

    .line 871
    .line 872
    add-int/lit8 v27, v11, 0x4

    .line 873
    .line 874
    move/from16 v29, v0

    .line 875
    .line 876
    aget-byte v0, v5, v27

    .line 877
    .line 878
    and-int/lit16 v0, v0, 0xff

    .line 879
    .line 880
    shl-int/lit8 v27, v0, 0x6

    .line 881
    .line 882
    move/from16 v30, v0

    .line 883
    .line 884
    or-int v0, v24, v27

    .line 885
    .line 886
    and-int/lit16 v0, v0, 0x1fff

    .line 887
    .line 888
    aput v0, p2, v29

    .line 889
    .line 890
    add-int/lit8 v0, v23, 0x3

    .line 891
    .line 892
    shr-int/lit8 v24, v30, 0x7

    .line 893
    .line 894
    add-int/lit8 v27, v11, 0x5

    .line 895
    .line 896
    move/from16 v30, v0

    .line 897
    .line 898
    aget-byte v0, v5, v27

    .line 899
    .line 900
    and-int/lit16 v0, v0, 0xff

    .line 901
    .line 902
    const/16 v25, 0x1

    .line 903
    .line 904
    shl-int/lit8 v0, v0, 0x1

    .line 905
    .line 906
    or-int v0, v24, v0

    .line 907
    .line 908
    add-int/lit8 v24, v11, 0x6

    .line 909
    .line 910
    move/from16 v27, v0

    .line 911
    .line 912
    aget-byte v0, v5, v24

    .line 913
    .line 914
    and-int/lit16 v0, v0, 0xff

    .line 915
    .line 916
    shl-int/lit8 v24, v0, 0x9

    .line 917
    .line 918
    move/from16 v31, v0

    .line 919
    .line 920
    or-int v0, v27, v24

    .line 921
    .line 922
    and-int/lit16 v0, v0, 0x1fff

    .line 923
    .line 924
    aput v0, p2, v30

    .line 925
    .line 926
    add-int/lit8 v0, v23, 0x4

    .line 927
    .line 928
    shr-int/lit8 v24, v31, 0x4

    .line 929
    .line 930
    add-int/lit8 v27, v11, 0x7

    .line 931
    .line 932
    move/from16 v31, v0

    .line 933
    .line 934
    aget-byte v0, v5, v27

    .line 935
    .line 936
    and-int/lit16 v0, v0, 0xff

    .line 937
    .line 938
    shl-int/lit8 v0, v0, 0x4

    .line 939
    .line 940
    or-int v0, v24, v0

    .line 941
    .line 942
    add-int/lit8 v24, v11, 0x8

    .line 943
    .line 944
    move/from16 v27, v0

    .line 945
    .line 946
    aget-byte v0, v5, v24

    .line 947
    .line 948
    and-int/lit16 v0, v0, 0xff

    .line 949
    .line 950
    shl-int/lit8 v24, v0, 0xc

    .line 951
    .line 952
    move/from16 v32, v0

    .line 953
    .line 954
    or-int v0, v27, v24

    .line 955
    .line 956
    and-int/lit16 v0, v0, 0x1fff

    .line 957
    .line 958
    aput v0, p2, v31

    .line 959
    .line 960
    add-int/lit8 v0, v23, 0x5

    .line 961
    .line 962
    const/16 v25, 0x1

    .line 963
    .line 964
    shr-int/lit8 v24, v32, 0x1

    .line 965
    .line 966
    add-int/lit8 v27, v11, 0x9

    .line 967
    .line 968
    move/from16 v32, v0

    .line 969
    .line 970
    aget-byte v0, v5, v27

    .line 971
    .line 972
    and-int/lit16 v0, v0, 0xff

    .line 973
    .line 974
    shl-int/lit8 v27, v0, 0x7

    .line 975
    .line 976
    move/from16 v33, v0

    .line 977
    .line 978
    or-int v0, v24, v27

    .line 979
    .line 980
    and-int/lit16 v0, v0, 0x1fff

    .line 981
    .line 982
    aput v0, p2, v32

    .line 983
    .line 984
    add-int/lit8 v0, v23, 0x6

    .line 985
    .line 986
    const/16 v21, 0x6

    .line 987
    .line 988
    shr-int/lit8 v24, v33, 0x6

    .line 989
    .line 990
    add-int/lit8 v27, v11, 0xa

    .line 991
    .line 992
    move/from16 v33, v0

    .line 993
    .line 994
    aget-byte v0, v5, v27

    .line 995
    .line 996
    and-int/lit16 v0, v0, 0xff

    .line 997
    .line 998
    shl-int/lit8 v0, v0, 0x2

    .line 999
    .line 1000
    or-int v0, v24, v0

    .line 1001
    .line 1002
    add-int/lit8 v24, v11, 0xb

    .line 1003
    .line 1004
    move/from16 v27, v0

    .line 1005
    .line 1006
    aget-byte v0, v5, v24

    .line 1007
    .line 1008
    and-int/lit16 v0, v0, 0xff

    .line 1009
    .line 1010
    shl-int/lit8 v24, v0, 0xa

    .line 1011
    .line 1012
    move/from16 v34, v0

    .line 1013
    .line 1014
    or-int v0, v27, v24

    .line 1015
    .line 1016
    and-int/lit16 v0, v0, 0x1fff

    .line 1017
    .line 1018
    aput v0, p2, v33

    .line 1019
    .line 1020
    add-int/lit8 v0, v23, 0x7

    .line 1021
    .line 1022
    shr-int/lit8 v24, v34, 0x3

    .line 1023
    .line 1024
    add-int/lit8 v11, v11, 0xc

    .line 1025
    .line 1026
    aget-byte v11, v5, v11

    .line 1027
    .line 1028
    and-int/lit16 v11, v11, 0xff

    .line 1029
    .line 1030
    shl-int/lit8 v11, v11, 0x5

    .line 1031
    .line 1032
    or-int v11, v24, v11

    .line 1033
    .line 1034
    and-int/lit16 v11, v11, 0x1fff

    .line 1035
    .line 1036
    aput v11, p2, v0

    .line 1037
    .line 1038
    aget v11, p2, v23

    .line 1039
    .line 1040
    rsub-int v11, v11, 0x1000

    .line 1041
    .line 1042
    aput v11, p2, v23

    .line 1043
    .line 1044
    aget v11, p2, v10

    .line 1045
    .line 1046
    rsub-int v11, v11, 0x1000

    .line 1047
    .line 1048
    aput v11, p2, v10

    .line 1049
    .line 1050
    aget v10, p2, v29

    .line 1051
    .line 1052
    rsub-int v10, v10, 0x1000

    .line 1053
    .line 1054
    aput v10, p2, v29

    .line 1055
    .line 1056
    aget v10, p2, v30

    .line 1057
    .line 1058
    rsub-int v10, v10, 0x1000

    .line 1059
    .line 1060
    aput v10, p2, v30

    .line 1061
    .line 1062
    aget v10, p2, v31

    .line 1063
    .line 1064
    rsub-int v10, v10, 0x1000

    .line 1065
    .line 1066
    aput v10, p2, v31

    .line 1067
    .line 1068
    aget v10, p2, v32

    .line 1069
    .line 1070
    rsub-int v10, v10, 0x1000

    .line 1071
    .line 1072
    aput v10, p2, v32

    .line 1073
    .line 1074
    aget v10, p2, v33

    .line 1075
    .line 1076
    rsub-int v10, v10, 0x1000

    .line 1077
    .line 1078
    aput v10, p2, v33

    .line 1079
    .line 1080
    aget v10, p2, v0

    .line 1081
    .line 1082
    rsub-int v10, v10, 0x1000

    .line 1083
    .line 1084
    aput v10, p2, v0

    .line 1085
    .line 1086
    add-int/lit8 v9, v9, 0x1

    .line 1087
    .line 1088
    move/from16 v0, v26

    .line 1089
    .line 1090
    goto/16 :goto_31e

    .line 1091
    .line 1092
    :cond_443
    move/from16 v26, v0

    .line 1093
    .line 1094
    const/16 v21, 0x6

    .line 1095
    .line 1096
    add-int/lit8 v0, v26, 0x1

    .line 1097
    .line 1098
    goto/16 :goto_312

    .line 1099
    .line 1100
    :cond_44b
    invoke-virtual {v8, v4}, Lcom/kousei/framework/y;->c([B)V

    .line 1101
    .line 1102
    .line 1103
    new-instance v0, Lcom/kousei/framework/dd;

    .line 1104
    .line 1105
    const/4 v10, 0x1

    .line 1106
    invoke-direct {v0, v2, v10}, Lcom/kousei/framework/dd;-><init>(Lcom/kousei/framework/fb;I)V

    .line 1107
    .line 1108
    .line 1109
    const/4 v4, 0x0

    .line 1110
    :goto_455
    array-length v5, v15

    .line 1111
    if-ge v4, v5, :cond_46f

    .line 1112
    .line 1113
    aget-object v5, v15, v4

    .line 1114
    .line 1115
    iget-object v6, v0, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 1116
    .line 1117
    aget-object v6, v6, v4

    .line 1118
    .line 1119
    iget-object v5, v5, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1120
    .line 1121
    check-cast v5, [I

    .line 1122
    .line 1123
    iget-object v6, v6, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1124
    .line 1125
    check-cast v6, [I

    .line 1126
    .line 1127
    const/16 v7, 0x100

    .line 1128
    .line 1129
    const/4 v11, 0x0

    .line 1130
    invoke-static {v5, v11, v6, v11, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1131
    .line 1132
    .line 1133
    add-int/lit8 v4, v4, 0x1

    .line 1134
    .line 1135
    goto :goto_455

    .line 1136
    :cond_46f
    const/4 v11, 0x0

    .line 1137
    invoke-virtual {v0}, Lcom/kousei/framework/dd;->c()V

    .line 1138
    .line 1139
    .line 1140
    invoke-virtual {v8, v13, v0}, Lcom/kousei/framework/y;->i(Lcom/kousei/framework/dd;Lcom/kousei/framework/dd;)V

    .line 1141
    .line 1142
    .line 1143
    invoke-virtual {v13}, Lcom/kousei/framework/dd;->e()V

    .line 1144
    .line 1145
    .line 1146
    invoke-virtual {v13}, Lcom/kousei/framework/dd;->b()V

    .line 1147
    .line 1148
    .line 1149
    move v0, v11

    .line 1150
    :goto_47d
    iget-object v4, v13, Lcom/kousei/framework/dd;->b:[Lcom/kousei/framework/k3;

    .line 1151
    .line 1152
    array-length v5, v4

    .line 1153
    if-ge v0, v5, :cond_4a3

    .line 1154
    .line 1155
    aget-object v4, v4, v0

    .line 1156
    .line 1157
    aget-object v5, v1, v0

    .line 1158
    .line 1159
    move v6, v11

    .line 1160
    const/16 v7, 0x100

    .line 1161
    .line 1162
    :goto_489
    if-ge v6, v7, :cond_49d

    .line 1163
    .line 1164
    iget-object v8, v4, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1165
    .line 1166
    check-cast v8, [I

    .line 1167
    .line 1168
    aget v9, v8, v6

    .line 1169
    .line 1170
    iget-object v10, v5, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 1171
    .line 1172
    check-cast v10, [I

    .line 1173
    .line 1174
    aget v10, v10, v6

    .line 1175
    .line 1176
    add-int/2addr v9, v10

    .line 1177
    aput v9, v8, v6

    .line 1178
    .line 1179
    add-int/lit8 v6, v6, 0x1

    .line 1180
    .line 1181
    goto :goto_489

    .line 1182
    :cond_49d
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1183
    .line 1184
    .line 1185
    add-int/lit8 v0, v0, 0x1

    .line 1186
    .line 1187
    goto :goto_47d

    .line 1188
    :cond_4a3
    invoke-virtual {v13}, Lcom/kousei/framework/dd;->a()V

    .line 1189
    .line 1190
    .line 1191
    invoke-virtual {v13, v14}, Lcom/kousei/framework/dd;->d(Lcom/kousei/framework/dd;)V

    .line 1192
    .line 1193
    .line 1194
    invoke-static {v13, v2}, Lcom/kousei/framework/xc;->Z(Lcom/kousei/framework/dd;Lcom/kousei/framework/fb;)[B

    .line 1195
    .line 1196
    .line 1197
    move-result-object v0

    .line 1198
    iput-object v0, v3, Lcom/kousei/framework/ib;->S:[B

    .line 1199
    .line 1200
    const/4 v0, 0x0

    .line 1201
    iput-object v0, v3, Lcom/kousei/framework/ib;->T:[B

    .line 1202
    .line 1203
    :goto_4b2
    if-eqz p3, :cond_4cb

    .line 1204
    .line 1205
    iget-object v1, v3, Lcom/kousei/framework/ib;->S:[B

    .line 1206
    .line 1207
    move-object/from16 v9, p3

    .line 1208
    .line 1209
    iget-object v2, v9, Lcom/kousei/framework/kb;->N:[B

    .line 1210
    .line 1211
    invoke-static {v2}, Lcom/kousei/framework/i0;->J([B)[B

    .line 1212
    .line 1213
    .line 1214
    move-result-object v2

    .line 1215
    invoke-static {v1, v2}, Lcom/kousei/framework/i0;->P([B[B)Z

    .line 1216
    .line 1217
    .line 1218
    move-result v1

    .line 1219
    if-eqz v1, :cond_4c5

    .line 1220
    .line 1221
    goto :goto_4cb

    .line 1222
    :cond_4c5
    const-string v1, "passed in public key does not match private values"

    .line 1223
    .line 1224
    invoke-static {v1}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 1225
    .line 1226
    .line 1227
    throw v0

    .line 1228
    :cond_4cb
    :goto_4cb
    iget-object v0, v3, Lcom/kousei/framework/ib;->T:[B

    .line 1229
    .line 1230
    if-eqz v0, :cond_4d0

    .line 1231
    .line 1232
    goto :goto_4d2

    .line 1233
    :cond_4d0
    move/from16 v11, v17

    .line 1234
    .line 1235
    :goto_4d2
    iput v11, v3, Lcom/kousei/framework/ib;->U:I

    .line 1236
    .line 1237
    return-void
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


# virtual methods
.method public final getEncoded()[B
    .registers 7

    .line 1
    iget-object v4, p0, Lcom/kousei/framework/ib;->Q:[B

    .line 2
    .line 3
    iget-object v5, p0, Lcom/kousei/framework/ib;->R:[B

    .line 4
    .line 5
    iget-object v0, p0, Lcom/kousei/framework/ib;->M:[B

    .line 6
    .line 7
    iget-object v1, p0, Lcom/kousei/framework/ib;->N:[B

    .line 8
    .line 9
    iget-object v2, p0, Lcom/kousei/framework/ib;->O:[B

    .line 10
    .line 11
    iget-object v3, p0, Lcom/kousei/framework/ib;->P:[B

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
