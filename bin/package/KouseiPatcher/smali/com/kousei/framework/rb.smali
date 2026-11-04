.class public final Lcom/kousei/framework/rb;
.super Lcom/kousei/framework/n2;


# instance fields
.field public final M:[B

.field public final N:[B

.field public final O:[B

.field public final P:[B

.field public final Q:[B

.field public final R:[B

.field public final S:I


# direct methods
.method public constructor <init>(Lcom/kousei/framework/pb;[BLcom/kousei/framework/tb;)V
    .registers 45

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
    const/4 v4, 0x1

    .line 8
    invoke-direct {v0, v4, v1}, Lcom/kousei/framework/n2;-><init>(ZLjava/lang/Object;)V

    .line 9
    .line 10
    .line 11
    sget-object v5, Lcom/kousei/framework/nb;->g:[Lcom/kousei/framework/nb;

    .line 12
    .line 13
    iget v1, v1, Lcom/kousei/framework/pb;->L:I

    .line 14
    .line 15
    const/4 v6, 0x2

    .line 16
    sub-int/2addr v1, v6

    .line 17
    aget-object v1, v5, v1

    .line 18
    .line 19
    array-length v5, v2

    .line 20
    const/4 v9, 0x0

    .line 21
    const/16 v10, 0x20

    .line 22
    .line 23
    const/16 v11, 0x40

    .line 24
    .line 25
    if-ne v5, v11, :cond_2e6

    .line 26
    .line 27
    invoke-static {v2, v9, v10}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 28
    .line 29
    .line 30
    move-result-object v5

    .line 31
    array-length v12, v2

    .line 32
    invoke-static {v2, v10, v12}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 33
    .line 34
    .line 35
    move-result-object v2

    .line 36
    iget-object v12, v1, Lcom/kousei/framework/nb;->a:Lcom/kousei/framework/y;

    .line 37
    .line 38
    iget-object v12, v12, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 39
    .line 40
    check-cast v12, Lcom/kousei/framework/nb;

    .line 41
    .line 42
    iget v13, v12, Lcom/kousei/framework/nb;->b:I

    .line 43
    .line 44
    iget v14, v12, Lcom/kousei/framework/nb;->c:I

    .line 45
    .line 46
    new-instance v15, Lcom/kousei/framework/y;

    .line 47
    .line 48
    move/from16 v19, v4

    .line 49
    .line 50
    const/4 v4, 0x6

    .line 51
    invoke-direct {v15, v13, v4}, Lcom/kousei/framework/y;-><init>(II)V

    .line 52
    .line 53
    .line 54
    iget-object v7, v15, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 55
    .line 56
    check-cast v7, [Lcom/kousei/framework/cd;

    .line 57
    .line 58
    new-instance v6, Lcom/kousei/framework/y;

    .line 59
    .line 60
    invoke-direct {v6, v13, v4}, Lcom/kousei/framework/y;-><init>(II)V

    .line 61
    .line 62
    .line 63
    iget-object v8, v6, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 64
    .line 65
    check-cast v8, [Lcom/kousei/framework/cd;

    .line 66
    .line 67
    new-array v10, v11, [B

    .line 68
    .line 69
    int-to-byte v11, v13

    .line 70
    invoke-static {v5, v11}, Lcom/kousei/framework/i0;->A([BB)[B

    .line 71
    .line 72
    .line 73
    move-result-object v11

    .line 74
    new-instance v4, Lcom/kousei/framework/se;

    .line 75
    .line 76
    const/16 v9, 0x200

    .line 77
    .line 78
    invoke-direct {v4, v9}, Lcom/kousei/framework/se;-><init>(I)V

    .line 79
    .line 80
    .line 81
    array-length v9, v11

    .line 82
    move-object/from16 v17, v6

    .line 83
    .line 84
    const/4 v6, 0x0

    .line 85
    invoke-virtual {v4, v11, v6, v9}, Lcom/kousei/framework/ba;->update([BII)V

    .line 86
    .line 87
    .line 88
    invoke-virtual {v4, v6, v10}, Lcom/kousei/framework/se;->c(I[B)I

    .line 89
    .line 90
    .line 91
    new-array v4, v13, [Lcom/kousei/framework/y;

    .line 92
    .line 93
    const/4 v6, 0x0

    .line 94
    :goto_5d
    if-ge v6, v13, :cond_6a

    .line 95
    .line 96
    new-instance v9, Lcom/kousei/framework/y;

    .line 97
    .line 98
    const/4 v11, 0x6

    .line 99
    invoke-direct {v9, v13, v11}, Lcom/kousei/framework/y;-><init>(II)V

    .line 100
    .line 101
    .line 102
    aput-object v9, v4, v6

    .line 103
    .line 104
    add-int/lit8 v6, v6, 0x1

    .line 105
    .line 106
    goto :goto_5d

    .line 107
    :cond_6a
    new-instance v6, Lcom/kousei/framework/te;

    .line 108
    .line 109
    const/16 v9, 0x80

    .line 110
    .line 111
    invoke-direct {v6, v9}, Lcom/kousei/framework/ba;-><init>(I)V

    .line 112
    .line 113
    .line 114
    const/16 v9, 0x1fa

    .line 115
    .line 116
    new-array v9, v9, [B

    .line 117
    .line 118
    const/4 v11, 0x0

    .line 119
    :goto_76
    if-ge v11, v13, :cond_e9

    .line 120
    .line 121
    move-object/from16 v18, v4

    .line 122
    .line 123
    const/4 v4, 0x0

    .line 124
    :goto_7b
    if-ge v4, v13, :cond_de

    .line 125
    .line 126
    invoke-virtual {v6}, Lcom/kousei/framework/ba;->j()V

    .line 127
    .line 128
    .line 129
    move-object/from16 v23, v7

    .line 130
    .line 131
    move-object/from16 v24, v8

    .line 132
    .line 133
    const/4 v7, 0x0

    .line 134
    const/16 v8, 0x20

    .line 135
    .line 136
    invoke-virtual {v6, v10, v7, v8}, Lcom/kousei/framework/ba;->update([BII)V

    .line 137
    .line 138
    .line 139
    int-to-byte v8, v4

    .line 140
    invoke-virtual {v6, v8}, Lcom/kousei/framework/ba;->d(B)V

    .line 141
    .line 142
    .line 143
    int-to-byte v8, v11

    .line 144
    invoke-virtual {v6, v8}, Lcom/kousei/framework/ba;->d(B)V

    .line 145
    .line 146
    .line 147
    const/16 v8, 0x1f8

    .line 148
    .line 149
    invoke-virtual {v6, v9, v7, v8}, Lcom/kousei/framework/te;->m([BII)V

    .line 150
    .line 151
    .line 152
    aget-object v7, v18, v11

    .line 153
    .line 154
    iget-object v7, v7, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 155
    .line 156
    check-cast v7, [Lcom/kousei/framework/cd;

    .line 157
    .line 158
    aget-object v7, v7, v4

    .line 159
    .line 160
    move/from16 v25, v4

    .line 161
    .line 162
    move/from16 v26, v11

    .line 163
    .line 164
    const/16 v4, 0x100

    .line 165
    .line 166
    const/4 v11, 0x0

    .line 167
    invoke-static {v7, v11, v4, v9, v8}, Lcom/kousei/framework/y;->m(Lcom/kousei/framework/cd;II[BI)I

    .line 168
    .line 169
    .line 170
    move-result v7

    .line 171
    :goto_aa
    if-ge v7, v4, :cond_d5

    .line 172
    .line 173
    rem-int/lit8 v4, v8, 0x3

    .line 174
    .line 175
    const/4 v11, 0x0

    .line 176
    :goto_af
    if-ge v11, v4, :cond_bc

    .line 177
    .line 178
    sub-int v27, v8, v4

    .line 179
    .line 180
    add-int v27, v27, v11

    .line 181
    .line 182
    aget-byte v27, v9, v27

    .line 183
    .line 184
    aput-byte v27, v9, v11

    .line 185
    .line 186
    add-int/lit8 v11, v11, 0x1

    .line 187
    .line 188
    goto :goto_af

    .line 189
    :cond_bc
    const/16 v8, 0x150

    .line 190
    .line 191
    invoke-virtual {v6, v9, v4, v8}, Lcom/kousei/framework/te;->m([BII)V

    .line 192
    .line 193
    .line 194
    add-int/lit16 v8, v4, 0xa8

    .line 195
    .line 196
    aget-object v4, v18, v26

    .line 197
    .line 198
    iget-object v4, v4, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 199
    .line 200
    check-cast v4, [Lcom/kousei/framework/cd;

    .line 201
    .line 202
    aget-object v4, v4, v25

    .line 203
    .line 204
    rsub-int v11, v7, 0x100

    .line 205
    .line 206
    invoke-static {v4, v7, v11, v9, v8}, Lcom/kousei/framework/y;->m(Lcom/kousei/framework/cd;II[BI)I

    .line 207
    .line 208
    .line 209
    move-result v4

    .line 210
    add-int/2addr v7, v4

    .line 211
    const/16 v4, 0x100

    .line 212
    .line 213
    goto :goto_aa

    .line 214
    :cond_d5
    add-int/lit8 v4, v25, 0x1

    .line 215
    .line 216
    move-object/from16 v7, v23

    .line 217
    .line 218
    move-object/from16 v8, v24

    .line 219
    .line 220
    move/from16 v11, v26

    .line 221
    .line 222
    goto :goto_7b

    .line 223
    :cond_de
    move-object/from16 v23, v7

    .line 224
    .line 225
    move-object/from16 v24, v8

    .line 226
    .line 227
    move/from16 v26, v11

    .line 228
    .line 229
    add-int/lit8 v11, v26, 0x1

    .line 230
    .line 231
    move-object/from16 v4, v18

    .line 232
    .line 233
    goto :goto_76

    .line 234
    :cond_e9
    move-object/from16 v18, v4

    .line 235
    .line 236
    move-object/from16 v23, v7

    .line 237
    .line 238
    move-object/from16 v24, v8

    .line 239
    .line 240
    new-instance v4, Lcom/kousei/framework/te;

    .line 241
    .line 242
    const/16 v6, 0x100

    .line 243
    .line 244
    invoke-direct {v4, v6}, Lcom/kousei/framework/te;-><init>(I)V

    .line 245
    .line 246
    .line 247
    iget v6, v12, Lcom/kousei/framework/nb;->d:I

    .line 248
    .line 249
    const/4 v7, 0x2

    .line 250
    if-ne v6, v7, :cond_11a

    .line 251
    .line 252
    const/4 v6, 0x0

    .line 253
    const/4 v7, 0x0

    .line 254
    :goto_fd
    if-ge v6, v13, :cond_10b

    .line 255
    .line 256
    aget-object v8, v23, v6

    .line 257
    .line 258
    add-int/lit8 v9, v7, 0x1

    .line 259
    .line 260
    int-to-byte v9, v9

    .line 261
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->a(Lcom/kousei/framework/te;[BB)V

    .line 262
    .line 263
    .line 264
    add-int/lit8 v6, v6, 0x1

    .line 265
    .line 266
    move v7, v9

    .line 267
    goto :goto_fd

    .line 268
    :cond_10b
    const/4 v6, 0x0

    .line 269
    :goto_10c
    if-ge v6, v13, :cond_139

    .line 270
    .line 271
    aget-object v8, v24, v6

    .line 272
    .line 273
    add-int/lit8 v9, v7, 0x1

    .line 274
    .line 275
    int-to-byte v9, v9

    .line 276
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->a(Lcom/kousei/framework/te;[BB)V

    .line 277
    .line 278
    .line 279
    add-int/lit8 v6, v6, 0x1

    .line 280
    .line 281
    move v7, v9

    .line 282
    goto :goto_10c

    .line 283
    :cond_11a
    const/4 v6, 0x0

    .line 284
    const/4 v7, 0x0

    .line 285
    :goto_11c
    if-ge v6, v13, :cond_12a

    .line 286
    .line 287
    aget-object v8, v23, v6

    .line 288
    .line 289
    add-int/lit8 v9, v7, 0x1

    .line 290
    .line 291
    int-to-byte v9, v9

    .line 292
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->b(Lcom/kousei/framework/te;[BB)V

    .line 293
    .line 294
    .line 295
    add-int/lit8 v6, v6, 0x1

    .line 296
    .line 297
    move v7, v9

    .line 298
    goto :goto_11c

    .line 299
    :cond_12a
    const/4 v6, 0x0

    .line 300
    :goto_12b
    if-ge v6, v13, :cond_139

    .line 301
    .line 302
    aget-object v8, v24, v6

    .line 303
    .line 304
    add-int/lit8 v9, v7, 0x1

    .line 305
    .line 306
    int-to-byte v9, v9

    .line 307
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->b(Lcom/kousei/framework/te;[BB)V

    .line 308
    .line 309
    .line 310
    add-int/lit8 v6, v6, 0x1

    .line 311
    .line 312
    move v7, v9

    .line 313
    goto :goto_12b

    .line 314
    :cond_139
    invoke-virtual {v15}, Lcom/kousei/framework/y;->k()V

    .line 315
    .line 316
    .line 317
    invoke-virtual/range {v17 .. v17}, Lcom/kousei/framework/y;->k()V

    .line 318
    .line 319
    .line 320
    new-instance v4, Lcom/kousei/framework/y;

    .line 321
    .line 322
    const/4 v11, 0x6

    .line 323
    invoke-direct {v4, v13, v11}, Lcom/kousei/framework/y;-><init>(II)V

    .line 324
    .line 325
    .line 326
    iget-object v6, v4, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 327
    .line 328
    check-cast v6, [Lcom/kousei/framework/cd;

    .line 329
    .line 330
    const/4 v7, 0x0

    .line 331
    :goto_14a
    if-ge v7, v13, :cond_247

    .line 332
    .line 333
    aget-object v9, v6, v7

    .line 334
    .line 335
    aget-object v11, v18, v7

    .line 336
    .line 337
    move/from16 v17, v7

    .line 338
    .line 339
    const/16 p2, 0x3

    .line 340
    .line 341
    const/16 v8, 0x100

    .line 342
    .line 343
    new-array v7, v8, [S

    .line 344
    .line 345
    iget-object v8, v11, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 346
    .line 347
    check-cast v8, [Lcom/kousei/framework/cd;

    .line 348
    .line 349
    const/16 v22, 0x0

    .line 350
    .line 351
    aget-object v8, v8, v22

    .line 352
    .line 353
    move-object/from16 v25, v7

    .line 354
    .line 355
    aget-object v7, v23, v22

    .line 356
    .line 357
    const/4 v3, 0x0

    .line 358
    :goto_165
    const/16 v0, 0x40

    .line 359
    .line 360
    if-ge v3, v0, :cond_1b1

    .line 361
    .line 362
    iget-object v0, v9, Lcom/kousei/framework/cd;->b:[S

    .line 363
    .line 364
    mul-int/lit8 v27, v3, 0x4

    .line 365
    .line 366
    move-object/from16 v26, v0

    .line 367
    .line 368
    iget-object v0, v8, Lcom/kousei/framework/cd;->b:[S

    .line 369
    .line 370
    aget-short v28, v0, v27

    .line 371
    .line 372
    add-int/lit8 v29, v27, 0x1

    .line 373
    .line 374
    aget-short v0, v0, v29

    .line 375
    .line 376
    move/from16 v30, v0

    .line 377
    .line 378
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 379
    .line 380
    move/from16 v31, v29

    .line 381
    .line 382
    move/from16 v29, v30

    .line 383
    .line 384
    aget-short v30, v0, v27

    .line 385
    .line 386
    aget-short v31, v0, v31

    .line 387
    .line 388
    sget-object v0, Lcom/kousei/framework/j0;->D:[S

    .line 389
    .line 390
    add-int/lit8 v33, v3, 0x40

    .line 391
    .line 392
    aget-short v32, v0, v33

    .line 393
    .line 394
    invoke-static/range {v26 .. v32}, Lcom/kousei/framework/j0;->w([SISSSSS)V

    .line 395
    .line 396
    .line 397
    move-object/from16 v26, v0

    .line 398
    .line 399
    iget-object v0, v9, Lcom/kousei/framework/cd;->b:[S

    .line 400
    .line 401
    add-int/lit8 v35, v27, 0x2

    .line 402
    .line 403
    move-object/from16 v34, v0

    .line 404
    .line 405
    iget-object v0, v8, Lcom/kousei/framework/cd;->b:[S

    .line 406
    .line 407
    aget-short v36, v0, v35

    .line 408
    .line 409
    add-int/lit8 v27, v27, 0x3

    .line 410
    .line 411
    aget-short v37, v0, v27

    .line 412
    .line 413
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 414
    .line 415
    aget-short v38, v0, v35

    .line 416
    .line 417
    aget-short v39, v0, v27

    .line 418
    .line 419
    aget-short v0, v26, v33

    .line 420
    .line 421
    mul-int/lit8 v0, v0, -0x1

    .line 422
    .line 423
    int-to-short v0, v0

    .line 424
    move/from16 v40, v0

    .line 425
    .line 426
    invoke-static/range {v34 .. v40}, Lcom/kousei/framework/j0;->w([SISSSSS)V

    .line 427
    .line 428
    .line 429
    add-int/lit8 v3, v3, 0x1

    .line 430
    .line 431
    move-object/from16 v0, p0

    .line 432
    .line 433
    goto :goto_165

    .line 434
    :cond_1b1
    move/from16 v0, v19

    .line 435
    .line 436
    :goto_1b3
    if-ge v0, v13, :cond_228

    .line 437
    .line 438
    iget-object v3, v11, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 439
    .line 440
    check-cast v3, [Lcom/kousei/framework/cd;

    .line 441
    .line 442
    aget-object v3, v3, v0

    .line 443
    .line 444
    aget-object v7, v23, v0

    .line 445
    .line 446
    move/from16 v16, v0

    .line 447
    .line 448
    const/4 v8, 0x0

    .line 449
    :goto_1c0
    const/16 v0, 0x40

    .line 450
    .line 451
    if-ge v8, v0, :cond_210

    .line 452
    .line 453
    mul-int/lit8 v26, v8, 0x4

    .line 454
    .line 455
    iget-object v0, v3, Lcom/kousei/framework/cd;->b:[S

    .line 456
    .line 457
    aget-short v27, v0, v26

    .line 458
    .line 459
    add-int/lit8 v28, v26, 0x1

    .line 460
    .line 461
    aget-short v0, v0, v28

    .line 462
    .line 463
    move/from16 v29, v0

    .line 464
    .line 465
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 466
    .line 467
    move/from16 v30, v28

    .line 468
    .line 469
    move/from16 v28, v29

    .line 470
    .line 471
    aget-short v29, v0, v26

    .line 472
    .line 473
    aget-short v30, v0, v30

    .line 474
    .line 475
    sget-object v0, Lcom/kousei/framework/j0;->D:[S

    .line 476
    .line 477
    add-int/lit8 v33, v8, 0x40

    .line 478
    .line 479
    aget-short v31, v0, v33

    .line 480
    .line 481
    invoke-static/range {v25 .. v31}, Lcom/kousei/framework/j0;->w([SISSSSS)V

    .line 482
    .line 483
    .line 484
    move/from16 v27, v26

    .line 485
    .line 486
    add-int/lit8 v26, v27, 0x2

    .line 487
    .line 488
    move-object/from16 v28, v0

    .line 489
    .line 490
    iget-object v0, v3, Lcom/kousei/framework/cd;->b:[S

    .line 491
    .line 492
    move/from16 v29, v27

    .line 493
    .line 494
    aget-short v27, v0, v26

    .line 495
    .line 496
    add-int/lit8 v29, v29, 0x3

    .line 497
    .line 498
    aget-short v0, v0, v29

    .line 499
    .line 500
    move/from16 v30, v0

    .line 501
    .line 502
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 503
    .line 504
    move/from16 v31, v29

    .line 505
    .line 506
    aget-short v29, v0, v26

    .line 507
    .line 508
    aget-short v0, v0, v31

    .line 509
    .line 510
    aget-short v28, v28, v33

    .line 511
    .line 512
    move/from16 v31, v0

    .line 513
    .line 514
    mul-int/lit8 v0, v28, -0x1

    .line 515
    .line 516
    int-to-short v0, v0

    .line 517
    move/from16 v28, v30

    .line 518
    .line 519
    move/from16 v30, v31

    .line 520
    .line 521
    move/from16 v31, v0

    .line 522
    .line 523
    invoke-static/range {v25 .. v31}, Lcom/kousei/framework/j0;->w([SISSSSS)V

    .line 524
    .line 525
    .line 526
    add-int/lit8 v8, v8, 0x1

    .line 527
    .line 528
    goto :goto_1c0

    .line 529
    :cond_210
    const/4 v0, 0x0

    .line 530
    :goto_211
    const/16 v8, 0x100

    .line 531
    .line 532
    if-ge v0, v8, :cond_222

    .line 533
    .line 534
    iget-object v3, v9, Lcom/kousei/framework/cd;->b:[S

    .line 535
    .line 536
    aget-short v7, v3, v0

    .line 537
    .line 538
    aget-short v8, v25, v0

    .line 539
    .line 540
    add-int/2addr v7, v8

    .line 541
    int-to-short v7, v7

    .line 542
    aput-short v7, v3, v0

    .line 543
    .line 544
    add-int/lit8 v0, v0, 0x1

    .line 545
    .line 546
    goto :goto_211

    .line 547
    :cond_222
    invoke-virtual {v9}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 548
    .line 549
    .line 550
    add-int/lit8 v0, v16, 0x1

    .line 551
    .line 552
    goto :goto_1b3

    .line 553
    :cond_228
    invoke-virtual {v9}, Lcom/kousei/framework/cd;->c()V

    .line 554
    .line 555
    .line 556
    aget-object v0, v6, v17

    .line 557
    .line 558
    iget-object v0, v0, Lcom/kousei/framework/cd;->b:[S

    .line 559
    .line 560
    const/4 v3, 0x0

    .line 561
    :goto_230
    const/16 v8, 0x100

    .line 562
    .line 563
    if-ge v3, v8, :cond_241

    .line 564
    .line 565
    aget-short v7, v0, v3

    .line 566
    .line 567
    mul-int/lit16 v7, v7, 0x549

    .line 568
    .line 569
    invoke-static {v7}, Lcom/kousei/framework/xc;->S(I)S

    .line 570
    .line 571
    .line 572
    move-result v7

    .line 573
    aput-short v7, v0, v3

    .line 574
    .line 575
    add-int/lit8 v3, v3, 0x1

    .line 576
    .line 577
    goto :goto_230

    .line 578
    :cond_241
    add-int/lit8 v7, v17, 0x1

    .line 579
    .line 580
    move-object/from16 v0, p0

    .line 581
    .line 582
    goto/16 :goto_14a

    .line 583
    .line 584
    :cond_247
    const/16 p2, 0x3

    .line 585
    .line 586
    const/4 v0, 0x0

    .line 587
    :goto_24a
    array-length v3, v6

    .line 588
    if-ge v0, v3, :cond_26b

    .line 589
    .line 590
    aget-object v3, v6, v0

    .line 591
    .line 592
    aget-object v7, v24, v0

    .line 593
    .line 594
    const/4 v8, 0x0

    .line 595
    :goto_252
    const/16 v9, 0x100

    .line 596
    .line 597
    if-ge v8, v9, :cond_265

    .line 598
    .line 599
    iget-object v9, v3, Lcom/kousei/framework/cd;->b:[S

    .line 600
    .line 601
    aget-short v11, v9, v8

    .line 602
    .line 603
    iget-object v13, v7, Lcom/kousei/framework/cd;->b:[S

    .line 604
    .line 605
    aget-short v13, v13, v8

    .line 606
    .line 607
    add-int/2addr v11, v13

    .line 608
    int-to-short v11, v11

    .line 609
    aput-short v11, v9, v8

    .line 610
    .line 611
    add-int/lit8 v8, v8, 0x1

    .line 612
    .line 613
    goto :goto_252

    .line 614
    :cond_265
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 615
    .line 616
    .line 617
    add-int/lit8 v0, v0, 0x1

    .line 618
    .line 619
    goto :goto_24a

    .line 620
    :cond_26b
    const/4 v0, 0x0

    .line 621
    :goto_26c
    array-length v3, v6

    .line 622
    if-ge v0, v3, :cond_277

    .line 623
    .line 624
    aget-object v3, v6, v0

    .line 625
    .line 626
    invoke-virtual {v3}, Lcom/kousei/framework/cd;->c()V

    .line 627
    .line 628
    .line 629
    add-int/lit8 v0, v0, 0x1

    .line 630
    .line 631
    goto :goto_26c

    .line 632
    :cond_277
    iget v0, v12, Lcom/kousei/framework/nb;->e:I

    .line 633
    .line 634
    new-array v0, v0, [B

    .line 635
    .line 636
    invoke-virtual {v4, v0}, Lcom/kousei/framework/y;->n([B)V

    .line 637
    .line 638
    .line 639
    const/4 v6, 0x0

    .line 640
    const/16 v8, 0x20

    .line 641
    .line 642
    invoke-static {v10, v6, v0, v14, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 643
    .line 644
    .line 645
    new-array v3, v14, [B

    .line 646
    .line 647
    invoke-virtual {v15, v3}, Lcom/kousei/framework/y;->n([B)V

    .line 648
    .line 649
    .line 650
    filled-new-array {v0, v3}, [[B

    .line 651
    .line 652
    .line 653
    move-result-object v0

    .line 654
    iget v3, v1, Lcom/kousei/framework/nb;->f:I

    .line 655
    .line 656
    new-array v15, v3, [B

    .line 657
    .line 658
    aget-object v4, v0, v19

    .line 659
    .line 660
    invoke-static {v4, v6, v15, v6, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 661
    .line 662
    .line 663
    new-array v3, v8, [B

    .line 664
    .line 665
    aget-object v4, v0, v6

    .line 666
    .line 667
    array-length v7, v4

    .line 668
    new-instance v8, Lcom/kousei/framework/se;

    .line 669
    .line 670
    const/16 v9, 0x100

    .line 671
    .line 672
    invoke-direct {v8, v9}, Lcom/kousei/framework/se;-><init>(I)V

    .line 673
    .line 674
    .line 675
    invoke-virtual {v8, v4, v6, v7}, Lcom/kousei/framework/ba;->update([BII)V

    .line 676
    .line 677
    .line 678
    invoke-virtual {v8, v6, v3}, Lcom/kousei/framework/se;->c(I[B)I

    .line 679
    .line 680
    .line 681
    iget v1, v1, Lcom/kousei/framework/nb;->e:I

    .line 682
    .line 683
    new-array v4, v1, [B

    .line 684
    .line 685
    aget-object v0, v0, v6

    .line 686
    .line 687
    invoke-static {v0, v6, v4, v6, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 688
    .line 689
    .line 690
    add-int/lit8 v0, v1, -0x20

    .line 691
    .line 692
    invoke-static {v4, v6, v0}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 693
    .line 694
    .line 695
    move-result-object v13

    .line 696
    invoke-static {v4, v0, v1}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 697
    .line 698
    .line 699
    move-result-object v14

    .line 700
    invoke-static {v5, v2}, Lcom/kousei/framework/i0;->M([B[B)[B

    .line 701
    .line 702
    .line 703
    move-result-object v18

    .line 704
    move-object/from16 v17, v2

    .line 705
    .line 706
    move-object/from16 v16, v3

    .line 707
    .line 708
    filled-new-array/range {v13 .. v18}, [[B

    .line 709
    .line 710
    .line 711
    move-result-object v0

    .line 712
    const/16 v20, 0x2

    .line 713
    .line 714
    aget-object v1, v0, v20

    .line 715
    .line 716
    move-object/from16 v3, p0

    .line 717
    .line 718
    iput-object v1, v3, Lcom/kousei/framework/rb;->M:[B

    .line 719
    .line 720
    aget-object v1, v0, p2

    .line 721
    .line 722
    iput-object v1, v3, Lcom/kousei/framework/rb;->N:[B

    .line 723
    .line 724
    const/4 v1, 0x4

    .line 725
    aget-object v1, v0, v1

    .line 726
    .line 727
    iput-object v1, v3, Lcom/kousei/framework/rb;->O:[B

    .line 728
    .line 729
    aget-object v1, v0, v6

    .line 730
    .line 731
    iput-object v1, v3, Lcom/kousei/framework/rb;->P:[B

    .line 732
    .line 733
    aget-object v1, v0, v19

    .line 734
    .line 735
    iput-object v1, v3, Lcom/kousei/framework/rb;->Q:[B

    .line 736
    .line 737
    const/4 v1, 0x5

    .line 738
    aget-object v0, v0, v1

    .line 739
    .line 740
    iput-object v0, v3, Lcom/kousei/framework/rb;->R:[B

    .line 741
    .line 742
    goto :goto_31e

    .line 743
    :cond_2e6
    move-object v3, v0

    .line 744
    move v6, v9

    .line 745
    iget v0, v1, Lcom/kousei/framework/nb;->f:I

    .line 746
    .line 747
    iget v4, v1, Lcom/kousei/framework/nb;->e:I

    .line 748
    .line 749
    invoke-static {v2, v6, v0}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 750
    .line 751
    .line 752
    move-result-object v0

    .line 753
    iput-object v0, v3, Lcom/kousei/framework/rb;->M:[B

    .line 754
    .line 755
    iget v0, v1, Lcom/kousei/framework/nb;->f:I

    .line 756
    .line 757
    add-int v1, v0, v4

    .line 758
    .line 759
    const/16 v21, 0x20

    .line 760
    .line 761
    add-int/lit8 v1, v1, -0x20

    .line 762
    .line 763
    invoke-static {v2, v0, v1}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 764
    .line 765
    .line 766
    move-result-object v1

    .line 767
    iput-object v1, v3, Lcom/kousei/framework/rb;->P:[B

    .line 768
    .line 769
    add-int/lit8 v4, v4, -0x20

    .line 770
    .line 771
    add-int/2addr v4, v0

    .line 772
    add-int/lit8 v0, v4, 0x20

    .line 773
    .line 774
    invoke-static {v2, v4, v0}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 775
    .line 776
    .line 777
    move-result-object v1

    .line 778
    iput-object v1, v3, Lcom/kousei/framework/rb;->Q:[B

    .line 779
    .line 780
    add-int/lit8 v1, v4, 0x40

    .line 781
    .line 782
    invoke-static {v2, v0, v1}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 783
    .line 784
    .line 785
    move-result-object v0

    .line 786
    iput-object v0, v3, Lcom/kousei/framework/rb;->N:[B

    .line 787
    .line 788
    add-int/lit8 v4, v4, 0x60

    .line 789
    .line 790
    invoke-static {v2, v1, v4}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 791
    .line 792
    .line 793
    move-result-object v0

    .line 794
    iput-object v0, v3, Lcom/kousei/framework/rb;->O:[B

    .line 795
    .line 796
    const/4 v0, 0x0

    .line 797
    iput-object v0, v3, Lcom/kousei/framework/rb;->R:[B

    .line 798
    .line 799
    :goto_31e
    iget-object v0, v3, Lcom/kousei/framework/n2;->L:Ljava/lang/Object;

    .line 800
    .line 801
    check-cast v0, Lcom/kousei/framework/pb;

    .line 802
    .line 803
    sget-object v1, Lcom/kousei/framework/nb;->g:[Lcom/kousei/framework/nb;

    .line 804
    .line 805
    iget v0, v0, Lcom/kousei/framework/pb;->L:I

    .line 806
    .line 807
    const/16 v20, 0x2

    .line 808
    .line 809
    add-int/lit8 v0, v0, -0x2

    .line 810
    .line 811
    aget-object v0, v1, v0

    .line 812
    .line 813
    invoke-virtual {v3}, Lcom/kousei/framework/rb;->getEncoded()[B

    .line 814
    .line 815
    .line 816
    move-result-object v1

    .line 817
    iget v0, v0, Lcom/kousei/framework/nb;->b:I

    .line 818
    .line 819
    mul-int/lit16 v2, v0, 0x180

    .line 820
    .line 821
    mul-int/lit16 v0, v0, 0x300

    .line 822
    .line 823
    add-int/lit8 v4, v0, 0x60

    .line 824
    .line 825
    array-length v5, v1

    .line 826
    if-ne v4, v5, :cond_388

    .line 827
    .line 828
    const/16 v8, 0x20

    .line 829
    .line 830
    new-array v4, v8, [B

    .line 831
    .line 832
    add-int/lit8 v5, v2, 0x20

    .line 833
    .line 834
    new-instance v6, Lcom/kousei/framework/se;

    .line 835
    .line 836
    const/16 v9, 0x100

    .line 837
    .line 838
    invoke-direct {v6, v9}, Lcom/kousei/framework/se;-><init>(I)V

    .line 839
    .line 840
    .line 841
    invoke-virtual {v6, v1, v2, v5}, Lcom/kousei/framework/ba;->update([BII)V

    .line 842
    .line 843
    .line 844
    const/4 v7, 0x0

    .line 845
    invoke-virtual {v6, v7, v4}, Lcom/kousei/framework/se;->c(I[B)I

    .line 846
    .line 847
    .line 848
    add-int/2addr v0, v8

    .line 849
    invoke-static {v0, v4, v1}, Lcom/kousei/framework/i0;->O(I[B[B)Z

    .line 850
    .line 851
    .line 852
    move-result v0

    .line 853
    if-eqz v0, :cond_381

    .line 854
    .line 855
    if-eqz p3, :cond_376

    .line 856
    .line 857
    iget-object v0, v3, Lcom/kousei/framework/rb;->P:[B

    .line 858
    .line 859
    move-object/from16 v1, p3

    .line 860
    .line 861
    iget-object v2, v1, Lcom/kousei/framework/tb;->M:[B

    .line 862
    .line 863
    invoke-static {v0, v2}, Lcom/kousei/framework/i0;->P([B[B)Z

    .line 864
    .line 865
    .line 866
    move-result v0

    .line 867
    if-eqz v0, :cond_36f

    .line 868
    .line 869
    iget-object v0, v3, Lcom/kousei/framework/rb;->Q:[B

    .line 870
    .line 871
    iget-object v1, v1, Lcom/kousei/framework/tb;->N:[B

    .line 872
    .line 873
    invoke-static {v0, v1}, Lcom/kousei/framework/i0;->P([B[B)Z

    .line 874
    .line 875
    .line 876
    move-result v0

    .line 877
    if-eqz v0, :cond_36f

    .line 878
    .line 879
    goto :goto_376

    .line 880
    :cond_36f
    const-string v0, "passed in public key does not match private values"

    .line 881
    .line 882
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 883
    .line 884
    .line 885
    const/4 v0, 0x0

    .line 886
    throw v0

    .line 887
    :cond_376
    :goto_376
    iget-object v0, v3, Lcom/kousei/framework/rb;->R:[B

    .line 888
    .line 889
    if-nez v0, :cond_37d

    .line 890
    .line 891
    move/from16 v6, v20

    .line 892
    .line 893
    goto :goto_37e

    .line 894
    :cond_37d
    move v6, v7

    .line 895
    :goto_37e
    iput v6, v3, Lcom/kousei/framework/rb;->S:I

    .line 896
    .line 897
    return-void

    .line 898
    :cond_381
    const/4 v0, 0x0

    .line 899
    const-string v1, "\'encoding\' fails hash check"

    .line 900
    .line 901
    invoke-static {v1}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 902
    .line 903
    .line 904
    throw v0

    .line 905
    :cond_388
    const/4 v0, 0x0

    .line 906
    const-string v1, "\'encoding\' has invalid length"

    .line 907
    .line 908
    invoke-static {v1}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 909
    .line 910
    .line 911
    throw v0
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


# virtual methods
.method public final getEncoded()[B
    .registers 5

    .line 1
    iget-object v0, p0, Lcom/kousei/framework/rb;->N:[B

    .line 2
    .line 3
    iget-object v1, p0, Lcom/kousei/framework/rb;->O:[B

    .line 4
    .line 5
    iget-object v2, p0, Lcom/kousei/framework/rb;->M:[B

    .line 6
    .line 7
    iget-object v3, p0, Lcom/kousei/framework/rb;->P:[B

    .line 8
    .line 9
    iget-object p0, p0, Lcom/kousei/framework/rb;->Q:[B

    .line 10
    .line 11
    filled-new-array {v2, v3, p0, v0, v1}, [[B

    .line 12
    .line 13
    .line 14
    move-result-object p0

    .line 15
    invoke-static {p0}, Lcom/kousei/framework/i0;->N([[B)[B

    .line 16
    .line 17
    .line 18
    move-result-object p0

    .line 19
    return-object p0
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
