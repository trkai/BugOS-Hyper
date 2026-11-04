.class public final Lcom/kousei/framework/qb;
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
.method public constructor <init>(Lcom/kousei/framework/ob;[BLcom/kousei/framework/sb;)V
    .registers 46

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
    iget-object v1, v1, Lcom/kousei/framework/ob;->L:Lcom/kousei/framework/mb;

    .line 12
    .line 13
    array-length v5, v2

    .line 14
    const/4 v9, 0x0

    .line 15
    const/16 v10, 0x20

    .line 16
    .line 17
    const/16 v11, 0x40

    .line 18
    .line 19
    if-ne v5, v11, :cond_2da

    .line 20
    .line 21
    invoke-static {v2, v9, v10}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 22
    .line 23
    .line 24
    move-result-object v5

    .line 25
    array-length v12, v2

    .line 26
    invoke-static {v2, v10, v12}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 27
    .line 28
    .line 29
    move-result-object v2

    .line 30
    iget-object v12, v1, Lcom/kousei/framework/mb;->a:Lcom/kousei/framework/y;

    .line 31
    .line 32
    iget-object v12, v12, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 33
    .line 34
    check-cast v12, Lcom/kousei/framework/mb;

    .line 35
    .line 36
    iget v13, v12, Lcom/kousei/framework/mb;->b:I

    .line 37
    .line 38
    iget v14, v12, Lcom/kousei/framework/mb;->c:I

    .line 39
    .line 40
    new-instance v15, Lcom/kousei/framework/y;

    .line 41
    .line 42
    move/from16 v19, v4

    .line 43
    .line 44
    const/4 v4, 0x5

    .line 45
    invoke-direct {v15, v13, v4}, Lcom/kousei/framework/y;-><init>(II)V

    .line 46
    .line 47
    .line 48
    iget-object v6, v15, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 49
    .line 50
    check-cast v6, [Lcom/kousei/framework/cd;

    .line 51
    .line 52
    new-instance v8, Lcom/kousei/framework/y;

    .line 53
    .line 54
    invoke-direct {v8, v13, v4}, Lcom/kousei/framework/y;-><init>(II)V

    .line 55
    .line 56
    .line 57
    iget-object v7, v8, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 58
    .line 59
    check-cast v7, [Lcom/kousei/framework/cd;

    .line 60
    .line 61
    new-array v10, v11, [B

    .line 62
    .line 63
    int-to-byte v11, v13

    .line 64
    invoke-static {v5, v11}, Lcom/kousei/framework/i0;->A([BB)[B

    .line 65
    .line 66
    .line 67
    move-result-object v11

    .line 68
    new-instance v4, Lcom/kousei/framework/se;

    .line 69
    .line 70
    const/16 v9, 0x200

    .line 71
    .line 72
    invoke-direct {v4, v9}, Lcom/kousei/framework/se;-><init>(I)V

    .line 73
    .line 74
    .line 75
    array-length v9, v11

    .line 76
    move-object/from16 v17, v6

    .line 77
    .line 78
    const/4 v6, 0x0

    .line 79
    invoke-virtual {v4, v11, v6, v9}, Lcom/kousei/framework/ba;->update([BII)V

    .line 80
    .line 81
    .line 82
    invoke-virtual {v4, v6, v10}, Lcom/kousei/framework/se;->c(I[B)I

    .line 83
    .line 84
    .line 85
    new-array v4, v13, [Lcom/kousei/framework/y;

    .line 86
    .line 87
    const/4 v6, 0x0

    .line 88
    :goto_57
    if-ge v6, v13, :cond_64

    .line 89
    .line 90
    new-instance v9, Lcom/kousei/framework/y;

    .line 91
    .line 92
    const/4 v11, 0x5

    .line 93
    invoke-direct {v9, v13, v11}, Lcom/kousei/framework/y;-><init>(II)V

    .line 94
    .line 95
    .line 96
    aput-object v9, v4, v6

    .line 97
    .line 98
    add-int/lit8 v6, v6, 0x1

    .line 99
    .line 100
    goto :goto_57

    .line 101
    :cond_64
    new-instance v6, Lcom/kousei/framework/te;

    .line 102
    .line 103
    const/16 v9, 0x80

    .line 104
    .line 105
    invoke-direct {v6, v9}, Lcom/kousei/framework/ba;-><init>(I)V

    .line 106
    .line 107
    .line 108
    const/16 v9, 0x1fa

    .line 109
    .line 110
    new-array v9, v9, [B

    .line 111
    .line 112
    const/4 v11, 0x0

    .line 113
    :goto_70
    if-ge v11, v13, :cond_e3

    .line 114
    .line 115
    move-object/from16 v18, v4

    .line 116
    .line 117
    const/4 v4, 0x0

    .line 118
    :goto_75
    if-ge v4, v13, :cond_d8

    .line 119
    .line 120
    invoke-virtual {v6}, Lcom/kousei/framework/ba;->j()V

    .line 121
    .line 122
    .line 123
    move-object/from16 v23, v7

    .line 124
    .line 125
    move-object/from16 v24, v8

    .line 126
    .line 127
    const/4 v7, 0x0

    .line 128
    const/16 v8, 0x20

    .line 129
    .line 130
    invoke-virtual {v6, v10, v7, v8}, Lcom/kousei/framework/ba;->update([BII)V

    .line 131
    .line 132
    .line 133
    int-to-byte v8, v4

    .line 134
    invoke-virtual {v6, v8}, Lcom/kousei/framework/ba;->d(B)V

    .line 135
    .line 136
    .line 137
    int-to-byte v8, v11

    .line 138
    invoke-virtual {v6, v8}, Lcom/kousei/framework/ba;->d(B)V

    .line 139
    .line 140
    .line 141
    const/16 v8, 0x1f8

    .line 142
    .line 143
    invoke-virtual {v6, v9, v7, v8}, Lcom/kousei/framework/te;->m([BII)V

    .line 144
    .line 145
    .line 146
    aget-object v7, v18, v11

    .line 147
    .line 148
    iget-object v7, v7, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 149
    .line 150
    check-cast v7, [Lcom/kousei/framework/cd;

    .line 151
    .line 152
    aget-object v7, v7, v4

    .line 153
    .line 154
    move/from16 v25, v4

    .line 155
    .line 156
    move/from16 v26, v11

    .line 157
    .line 158
    const/16 v4, 0x100

    .line 159
    .line 160
    const/4 v11, 0x0

    .line 161
    invoke-static {v7, v11, v4, v9, v8}, Lcom/kousei/framework/y;->l(Lcom/kousei/framework/cd;II[BI)I

    .line 162
    .line 163
    .line 164
    move-result v7

    .line 165
    :goto_a4
    if-ge v7, v4, :cond_cf

    .line 166
    .line 167
    rem-int/lit8 v4, v8, 0x3

    .line 168
    .line 169
    const/4 v11, 0x0

    .line 170
    :goto_a9
    if-ge v11, v4, :cond_b6

    .line 171
    .line 172
    sub-int v27, v8, v4

    .line 173
    .line 174
    add-int v27, v27, v11

    .line 175
    .line 176
    aget-byte v27, v9, v27

    .line 177
    .line 178
    aput-byte v27, v9, v11

    .line 179
    .line 180
    add-int/lit8 v11, v11, 0x1

    .line 181
    .line 182
    goto :goto_a9

    .line 183
    :cond_b6
    const/16 v8, 0x150

    .line 184
    .line 185
    invoke-virtual {v6, v9, v4, v8}, Lcom/kousei/framework/te;->m([BII)V

    .line 186
    .line 187
    .line 188
    add-int/lit16 v8, v4, 0xa8

    .line 189
    .line 190
    aget-object v4, v18, v26

    .line 191
    .line 192
    iget-object v4, v4, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 193
    .line 194
    check-cast v4, [Lcom/kousei/framework/cd;

    .line 195
    .line 196
    aget-object v4, v4, v25

    .line 197
    .line 198
    rsub-int v11, v7, 0x100

    .line 199
    .line 200
    invoke-static {v4, v7, v11, v9, v8}, Lcom/kousei/framework/y;->l(Lcom/kousei/framework/cd;II[BI)I

    .line 201
    .line 202
    .line 203
    move-result v4

    .line 204
    add-int/2addr v7, v4

    .line 205
    const/16 v4, 0x100

    .line 206
    .line 207
    goto :goto_a4

    .line 208
    :cond_cf
    add-int/lit8 v4, v25, 0x1

    .line 209
    .line 210
    move-object/from16 v7, v23

    .line 211
    .line 212
    move-object/from16 v8, v24

    .line 213
    .line 214
    move/from16 v11, v26

    .line 215
    .line 216
    goto :goto_75

    .line 217
    :cond_d8
    move-object/from16 v23, v7

    .line 218
    .line 219
    move-object/from16 v24, v8

    .line 220
    .line 221
    move/from16 v26, v11

    .line 222
    .line 223
    add-int/lit8 v11, v26, 0x1

    .line 224
    .line 225
    move-object/from16 v4, v18

    .line 226
    .line 227
    goto :goto_70

    .line 228
    :cond_e3
    move-object/from16 v18, v4

    .line 229
    .line 230
    move-object/from16 v23, v7

    .line 231
    .line 232
    move-object/from16 v24, v8

    .line 233
    .line 234
    new-instance v4, Lcom/kousei/framework/te;

    .line 235
    .line 236
    const/16 v6, 0x100

    .line 237
    .line 238
    invoke-direct {v4, v6}, Lcom/kousei/framework/te;-><init>(I)V

    .line 239
    .line 240
    .line 241
    iget v6, v12, Lcom/kousei/framework/mb;->d:I

    .line 242
    .line 243
    const/4 v7, 0x2

    .line 244
    if-ne v6, v7, :cond_114

    .line 245
    .line 246
    const/4 v6, 0x0

    .line 247
    const/4 v7, 0x0

    .line 248
    :goto_f7
    if-ge v6, v13, :cond_105

    .line 249
    .line 250
    aget-object v8, v17, v6

    .line 251
    .line 252
    add-int/lit8 v9, v7, 0x1

    .line 253
    .line 254
    int-to-byte v9, v9

    .line 255
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->a(Lcom/kousei/framework/te;[BB)V

    .line 256
    .line 257
    .line 258
    add-int/lit8 v6, v6, 0x1

    .line 259
    .line 260
    move v7, v9

    .line 261
    goto :goto_f7

    .line 262
    :cond_105
    const/4 v6, 0x0

    .line 263
    :goto_106
    if-ge v6, v13, :cond_133

    .line 264
    .line 265
    aget-object v8, v23, v6

    .line 266
    .line 267
    add-int/lit8 v9, v7, 0x1

    .line 268
    .line 269
    int-to-byte v9, v9

    .line 270
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->a(Lcom/kousei/framework/te;[BB)V

    .line 271
    .line 272
    .line 273
    add-int/lit8 v6, v6, 0x1

    .line 274
    .line 275
    move v7, v9

    .line 276
    goto :goto_106

    .line 277
    :cond_114
    const/4 v6, 0x0

    .line 278
    const/4 v7, 0x0

    .line 279
    :goto_116
    if-ge v6, v13, :cond_124

    .line 280
    .line 281
    aget-object v8, v17, v6

    .line 282
    .line 283
    add-int/lit8 v9, v7, 0x1

    .line 284
    .line 285
    int-to-byte v9, v9

    .line 286
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->b(Lcom/kousei/framework/te;[BB)V

    .line 287
    .line 288
    .line 289
    add-int/lit8 v6, v6, 0x1

    .line 290
    .line 291
    move v7, v9

    .line 292
    goto :goto_116

    .line 293
    :cond_124
    const/4 v6, 0x0

    .line 294
    :goto_125
    if-ge v6, v13, :cond_133

    .line 295
    .line 296
    aget-object v8, v23, v6

    .line 297
    .line 298
    add-int/lit8 v9, v7, 0x1

    .line 299
    .line 300
    int-to-byte v9, v9

    .line 301
    invoke-virtual {v8, v4, v10, v7}, Lcom/kousei/framework/cd;->b(Lcom/kousei/framework/te;[BB)V

    .line 302
    .line 303
    .line 304
    add-int/lit8 v6, v6, 0x1

    .line 305
    .line 306
    move v7, v9

    .line 307
    goto :goto_125

    .line 308
    :cond_133
    invoke-virtual {v15}, Lcom/kousei/framework/y;->k()V

    .line 309
    .line 310
    .line 311
    invoke-virtual/range {v24 .. v24}, Lcom/kousei/framework/y;->k()V

    .line 312
    .line 313
    .line 314
    new-instance v4, Lcom/kousei/framework/y;

    .line 315
    .line 316
    const/4 v11, 0x5

    .line 317
    invoke-direct {v4, v13, v11}, Lcom/kousei/framework/y;-><init>(II)V

    .line 318
    .line 319
    .line 320
    iget-object v6, v4, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 321
    .line 322
    check-cast v6, [Lcom/kousei/framework/cd;

    .line 323
    .line 324
    const/4 v7, 0x0

    .line 325
    :goto_144
    if-ge v7, v13, :cond_23b

    .line 326
    .line 327
    aget-object v9, v6, v7

    .line 328
    .line 329
    aget-object v11, v18, v7

    .line 330
    .line 331
    move/from16 v32, v7

    .line 332
    .line 333
    const/16 v8, 0x100

    .line 334
    .line 335
    const/16 v24, 0x3

    .line 336
    .line 337
    new-array v7, v8, [S

    .line 338
    .line 339
    iget-object v8, v11, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 340
    .line 341
    check-cast v8, [Lcom/kousei/framework/cd;

    .line 342
    .line 343
    const/16 v22, 0x0

    .line 344
    .line 345
    aget-object v8, v8, v22

    .line 346
    .line 347
    move-object/from16 v25, v7

    .line 348
    .line 349
    aget-object v7, v17, v22

    .line 350
    .line 351
    const/4 v3, 0x0

    .line 352
    :goto_15f
    const/16 v0, 0x40

    .line 353
    .line 354
    if-ge v3, v0, :cond_1a5

    .line 355
    .line 356
    iget-object v0, v9, Lcom/kousei/framework/cd;->b:[S

    .line 357
    .line 358
    mul-int/lit8 v34, v3, 0x4

    .line 359
    .line 360
    move-object/from16 v33, v0

    .line 361
    .line 362
    iget-object v0, v8, Lcom/kousei/framework/cd;->b:[S

    .line 363
    .line 364
    aget-short v35, v0, v34

    .line 365
    .line 366
    add-int/lit8 v26, v34, 0x1

    .line 367
    .line 368
    aget-short v36, v0, v26

    .line 369
    .line 370
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 371
    .line 372
    aget-short v37, v0, v34

    .line 373
    .line 374
    aget-short v38, v0, v26

    .line 375
    .line 376
    sget-object v0, Lcom/kousei/framework/j0;->C:[S

    .line 377
    .line 378
    add-int/lit8 v26, v3, 0x40

    .line 379
    .line 380
    aget-short v39, v0, v26

    .line 381
    .line 382
    invoke-static/range {v33 .. v39}, Lcom/kousei/framework/j0;->v([SISSSSS)V

    .line 383
    .line 384
    .line 385
    move-object/from16 v27, v0

    .line 386
    .line 387
    iget-object v0, v9, Lcom/kousei/framework/cd;->b:[S

    .line 388
    .line 389
    add-int/lit8 v36, v34, 0x2

    .line 390
    .line 391
    move-object/from16 v35, v0

    .line 392
    .line 393
    iget-object v0, v8, Lcom/kousei/framework/cd;->b:[S

    .line 394
    .line 395
    aget-short v37, v0, v36

    .line 396
    .line 397
    add-int/lit8 v34, v34, 0x3

    .line 398
    .line 399
    aget-short v38, v0, v34

    .line 400
    .line 401
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 402
    .line 403
    aget-short v39, v0, v36

    .line 404
    .line 405
    aget-short v40, v0, v34

    .line 406
    .line 407
    aget-short v0, v27, v26

    .line 408
    .line 409
    mul-int/lit8 v0, v0, -0x1

    .line 410
    .line 411
    int-to-short v0, v0

    .line 412
    move/from16 v41, v0

    .line 413
    .line 414
    invoke-static/range {v35 .. v41}, Lcom/kousei/framework/j0;->v([SISSSSS)V

    .line 415
    .line 416
    .line 417
    add-int/lit8 v3, v3, 0x1

    .line 418
    .line 419
    move-object/from16 v0, p0

    .line 420
    .line 421
    goto :goto_15f

    .line 422
    :cond_1a5
    move/from16 v0, v19

    .line 423
    .line 424
    :goto_1a7
    if-ge v0, v13, :cond_21c

    .line 425
    .line 426
    iget-object v3, v11, Lcom/kousei/framework/y;->L:Ljava/lang/Object;

    .line 427
    .line 428
    check-cast v3, [Lcom/kousei/framework/cd;

    .line 429
    .line 430
    aget-object v3, v3, v0

    .line 431
    .line 432
    aget-object v7, v17, v0

    .line 433
    .line 434
    move/from16 v16, v0

    .line 435
    .line 436
    const/4 v8, 0x0

    .line 437
    :goto_1b4
    const/16 v0, 0x40

    .line 438
    .line 439
    if-ge v8, v0, :cond_204

    .line 440
    .line 441
    mul-int/lit8 v26, v8, 0x4

    .line 442
    .line 443
    iget-object v0, v3, Lcom/kousei/framework/cd;->b:[S

    .line 444
    .line 445
    aget-short v27, v0, v26

    .line 446
    .line 447
    add-int/lit8 v28, v26, 0x1

    .line 448
    .line 449
    aget-short v0, v0, v28

    .line 450
    .line 451
    move/from16 v29, v0

    .line 452
    .line 453
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 454
    .line 455
    move/from16 v30, v28

    .line 456
    .line 457
    move/from16 v28, v29

    .line 458
    .line 459
    aget-short v29, v0, v26

    .line 460
    .line 461
    aget-short v30, v0, v30

    .line 462
    .line 463
    sget-object v0, Lcom/kousei/framework/j0;->C:[S

    .line 464
    .line 465
    add-int/lit8 v34, v8, 0x40

    .line 466
    .line 467
    aget-short v31, v0, v34

    .line 468
    .line 469
    invoke-static/range {v25 .. v31}, Lcom/kousei/framework/j0;->v([SISSSSS)V

    .line 470
    .line 471
    .line 472
    move/from16 v27, v26

    .line 473
    .line 474
    add-int/lit8 v26, v27, 0x2

    .line 475
    .line 476
    move-object/from16 v28, v0

    .line 477
    .line 478
    iget-object v0, v3, Lcom/kousei/framework/cd;->b:[S

    .line 479
    .line 480
    move/from16 v29, v27

    .line 481
    .line 482
    aget-short v27, v0, v26

    .line 483
    .line 484
    add-int/lit8 v29, v29, 0x3

    .line 485
    .line 486
    aget-short v0, v0, v29

    .line 487
    .line 488
    move/from16 v30, v0

    .line 489
    .line 490
    iget-object v0, v7, Lcom/kousei/framework/cd;->b:[S

    .line 491
    .line 492
    move/from16 v31, v29

    .line 493
    .line 494
    aget-short v29, v0, v26

    .line 495
    .line 496
    aget-short v0, v0, v31

    .line 497
    .line 498
    aget-short v28, v28, v34

    .line 499
    .line 500
    move/from16 v31, v0

    .line 501
    .line 502
    mul-int/lit8 v0, v28, -0x1

    .line 503
    .line 504
    int-to-short v0, v0

    .line 505
    move/from16 v28, v30

    .line 506
    .line 507
    move/from16 v30, v31

    .line 508
    .line 509
    move/from16 v31, v0

    .line 510
    .line 511
    invoke-static/range {v25 .. v31}, Lcom/kousei/framework/j0;->v([SISSSSS)V

    .line 512
    .line 513
    .line 514
    add-int/lit8 v8, v8, 0x1

    .line 515
    .line 516
    goto :goto_1b4

    .line 517
    :cond_204
    const/4 v0, 0x0

    .line 518
    :goto_205
    const/16 v8, 0x100

    .line 519
    .line 520
    if-ge v0, v8, :cond_216

    .line 521
    .line 522
    iget-object v3, v9, Lcom/kousei/framework/cd;->b:[S

    .line 523
    .line 524
    aget-short v7, v3, v0

    .line 525
    .line 526
    aget-short v8, v25, v0

    .line 527
    .line 528
    add-int/2addr v7, v8

    .line 529
    int-to-short v7, v7

    .line 530
    aput-short v7, v3, v0

    .line 531
    .line 532
    add-int/lit8 v0, v0, 0x1

    .line 533
    .line 534
    goto :goto_205

    .line 535
    :cond_216
    invoke-virtual {v9}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 536
    .line 537
    .line 538
    add-int/lit8 v0, v16, 0x1

    .line 539
    .line 540
    goto :goto_1a7

    .line 541
    :cond_21c
    invoke-virtual {v9}, Lcom/kousei/framework/cd;->c()V

    .line 542
    .line 543
    .line 544
    aget-object v0, v6, v32

    .line 545
    .line 546
    iget-object v0, v0, Lcom/kousei/framework/cd;->b:[S

    .line 547
    .line 548
    const/4 v3, 0x0

    .line 549
    :goto_224
    const/16 v8, 0x100

    .line 550
    .line 551
    if-ge v3, v8, :cond_235

    .line 552
    .line 553
    aget-short v7, v0, v3

    .line 554
    .line 555
    mul-int/lit16 v7, v7, 0x549

    .line 556
    .line 557
    invoke-static {v7}, Lcom/kousei/framework/xc;->Q(I)S

    .line 558
    .line 559
    .line 560
    move-result v7

    .line 561
    aput-short v7, v0, v3

    .line 562
    .line 563
    add-int/lit8 v3, v3, 0x1

    .line 564
    .line 565
    goto :goto_224

    .line 566
    :cond_235
    add-int/lit8 v7, v32, 0x1

    .line 567
    .line 568
    move-object/from16 v0, p0

    .line 569
    .line 570
    goto/16 :goto_144

    .line 571
    .line 572
    :cond_23b
    const/16 v24, 0x3

    .line 573
    .line 574
    const/4 v0, 0x0

    .line 575
    :goto_23e
    array-length v3, v6

    .line 576
    if-ge v0, v3, :cond_25f

    .line 577
    .line 578
    aget-object v3, v6, v0

    .line 579
    .line 580
    aget-object v7, v23, v0

    .line 581
    .line 582
    const/4 v8, 0x0

    .line 583
    :goto_246
    const/16 v9, 0x100

    .line 584
    .line 585
    if-ge v8, v9, :cond_259

    .line 586
    .line 587
    iget-object v9, v3, Lcom/kousei/framework/cd;->b:[S

    .line 588
    .line 589
    aget-short v11, v9, v8

    .line 590
    .line 591
    iget-object v13, v7, Lcom/kousei/framework/cd;->b:[S

    .line 592
    .line 593
    aget-short v13, v13, v8

    .line 594
    .line 595
    add-int/2addr v11, v13

    .line 596
    int-to-short v11, v11

    .line 597
    aput-short v11, v9, v8

    .line 598
    .line 599
    add-int/lit8 v8, v8, 0x1

    .line 600
    .line 601
    goto :goto_246

    .line 602
    :cond_259
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 603
    .line 604
    .line 605
    add-int/lit8 v0, v0, 0x1

    .line 606
    .line 607
    goto :goto_23e

    .line 608
    :cond_25f
    const/4 v0, 0x0

    .line 609
    :goto_260
    array-length v3, v6

    .line 610
    if-ge v0, v3, :cond_26b

    .line 611
    .line 612
    aget-object v3, v6, v0

    .line 613
    .line 614
    invoke-virtual {v3}, Lcom/kousei/framework/cd;->c()V

    .line 615
    .line 616
    .line 617
    add-int/lit8 v0, v0, 0x1

    .line 618
    .line 619
    goto :goto_260

    .line 620
    :cond_26b
    iget v0, v12, Lcom/kousei/framework/mb;->e:I

    .line 621
    .line 622
    new-array v0, v0, [B

    .line 623
    .line 624
    invoke-virtual {v4, v0}, Lcom/kousei/framework/y;->n([B)V

    .line 625
    .line 626
    .line 627
    const/4 v6, 0x0

    .line 628
    const/16 v8, 0x20

    .line 629
    .line 630
    invoke-static {v10, v6, v0, v14, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 631
    .line 632
    .line 633
    new-array v3, v14, [B

    .line 634
    .line 635
    invoke-virtual {v15, v3}, Lcom/kousei/framework/y;->n([B)V

    .line 636
    .line 637
    .line 638
    filled-new-array {v0, v3}, [[B

    .line 639
    .line 640
    .line 641
    move-result-object v0

    .line 642
    iget v3, v1, Lcom/kousei/framework/mb;->f:I

    .line 643
    .line 644
    new-array v15, v3, [B

    .line 645
    .line 646
    aget-object v4, v0, v19

    .line 647
    .line 648
    invoke-static {v4, v6, v15, v6, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 649
    .line 650
    .line 651
    new-array v3, v8, [B

    .line 652
    .line 653
    aget-object v4, v0, v6

    .line 654
    .line 655
    array-length v7, v4

    .line 656
    new-instance v8, Lcom/kousei/framework/se;

    .line 657
    .line 658
    const/16 v9, 0x100

    .line 659
    .line 660
    invoke-direct {v8, v9}, Lcom/kousei/framework/se;-><init>(I)V

    .line 661
    .line 662
    .line 663
    invoke-virtual {v8, v4, v6, v7}, Lcom/kousei/framework/ba;->update([BII)V

    .line 664
    .line 665
    .line 666
    invoke-virtual {v8, v6, v3}, Lcom/kousei/framework/se;->c(I[B)I

    .line 667
    .line 668
    .line 669
    iget v1, v1, Lcom/kousei/framework/mb;->e:I

    .line 670
    .line 671
    new-array v4, v1, [B

    .line 672
    .line 673
    aget-object v0, v0, v6

    .line 674
    .line 675
    invoke-static {v0, v6, v4, v6, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 676
    .line 677
    .line 678
    add-int/lit8 v0, v1, -0x20

    .line 679
    .line 680
    invoke-static {v4, v6, v0}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 681
    .line 682
    .line 683
    move-result-object v13

    .line 684
    invoke-static {v4, v0, v1}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 685
    .line 686
    .line 687
    move-result-object v14

    .line 688
    invoke-static {v5, v2}, Lcom/kousei/framework/i0;->M([B[B)[B

    .line 689
    .line 690
    .line 691
    move-result-object v18

    .line 692
    move-object/from16 v17, v2

    .line 693
    .line 694
    move-object/from16 v16, v3

    .line 695
    .line 696
    filled-new-array/range {v13 .. v18}, [[B

    .line 697
    .line 698
    .line 699
    move-result-object v0

    .line 700
    const/16 v20, 0x2

    .line 701
    .line 702
    aget-object v1, v0, v20

    .line 703
    .line 704
    move-object/from16 v3, p0

    .line 705
    .line 706
    iput-object v1, v3, Lcom/kousei/framework/qb;->M:[B

    .line 707
    .line 708
    aget-object v1, v0, v24

    .line 709
    .line 710
    iput-object v1, v3, Lcom/kousei/framework/qb;->N:[B

    .line 711
    .line 712
    const/4 v1, 0x4

    .line 713
    aget-object v1, v0, v1

    .line 714
    .line 715
    iput-object v1, v3, Lcom/kousei/framework/qb;->O:[B

    .line 716
    .line 717
    aget-object v1, v0, v6

    .line 718
    .line 719
    iput-object v1, v3, Lcom/kousei/framework/qb;->P:[B

    .line 720
    .line 721
    aget-object v1, v0, v19

    .line 722
    .line 723
    iput-object v1, v3, Lcom/kousei/framework/qb;->Q:[B

    .line 724
    .line 725
    const/4 v11, 0x5

    .line 726
    aget-object v0, v0, v11

    .line 727
    .line 728
    iput-object v0, v3, Lcom/kousei/framework/qb;->R:[B

    .line 729
    .line 730
    goto :goto_314

    .line 731
    :cond_2da
    move-object v3, v0

    .line 732
    move v6, v9

    .line 733
    const/16 v20, 0x2

    .line 734
    .line 735
    iget v0, v1, Lcom/kousei/framework/mb;->f:I

    .line 736
    .line 737
    iget v4, v1, Lcom/kousei/framework/mb;->e:I

    .line 738
    .line 739
    invoke-static {v2, v6, v0}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 740
    .line 741
    .line 742
    move-result-object v0

    .line 743
    iput-object v0, v3, Lcom/kousei/framework/qb;->M:[B

    .line 744
    .line 745
    iget v0, v1, Lcom/kousei/framework/mb;->f:I

    .line 746
    .line 747
    add-int v1, v0, v4

    .line 748
    .line 749
    const/16 v21, 0x20

    .line 750
    .line 751
    add-int/lit8 v1, v1, -0x20

    .line 752
    .line 753
    invoke-static {v2, v0, v1}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 754
    .line 755
    .line 756
    move-result-object v1

    .line 757
    iput-object v1, v3, Lcom/kousei/framework/qb;->P:[B

    .line 758
    .line 759
    add-int/lit8 v4, v4, -0x20

    .line 760
    .line 761
    add-int/2addr v4, v0

    .line 762
    add-int/lit8 v0, v4, 0x20

    .line 763
    .line 764
    invoke-static {v2, v4, v0}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 765
    .line 766
    .line 767
    move-result-object v1

    .line 768
    iput-object v1, v3, Lcom/kousei/framework/qb;->Q:[B

    .line 769
    .line 770
    add-int/lit8 v1, v4, 0x40

    .line 771
    .line 772
    invoke-static {v2, v0, v1}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 773
    .line 774
    .line 775
    move-result-object v0

    .line 776
    iput-object v0, v3, Lcom/kousei/framework/qb;->N:[B

    .line 777
    .line 778
    add-int/lit8 v4, v4, 0x60

    .line 779
    .line 780
    invoke-static {v2, v1, v4}, Lcom/kousei/framework/i0;->e0([BII)[B

    .line 781
    .line 782
    .line 783
    move-result-object v0

    .line 784
    iput-object v0, v3, Lcom/kousei/framework/qb;->O:[B

    .line 785
    .line 786
    const/4 v0, 0x0

    .line 787
    iput-object v0, v3, Lcom/kousei/framework/qb;->R:[B

    .line 788
    .line 789
    :goto_314
    iget-object v0, v3, Lcom/kousei/framework/n2;->L:Ljava/lang/Object;

    .line 790
    .line 791
    check-cast v0, Lcom/kousei/framework/ob;

    .line 792
    .line 793
    iget-object v0, v0, Lcom/kousei/framework/ob;->L:Lcom/kousei/framework/mb;

    .line 794
    .line 795
    invoke-virtual {v3}, Lcom/kousei/framework/qb;->getEncoded()[B

    .line 796
    .line 797
    .line 798
    move-result-object v1

    .line 799
    iget v0, v0, Lcom/kousei/framework/mb;->b:I

    .line 800
    .line 801
    mul-int/lit16 v2, v0, 0x180

    .line 802
    .line 803
    mul-int/lit16 v0, v0, 0x300

    .line 804
    .line 805
    add-int/lit8 v4, v0, 0x60

    .line 806
    .line 807
    array-length v5, v1

    .line 808
    if-ne v4, v5, :cond_376

    .line 809
    .line 810
    const/16 v8, 0x20

    .line 811
    .line 812
    new-array v4, v8, [B

    .line 813
    .line 814
    add-int/lit8 v5, v2, 0x20

    .line 815
    .line 816
    new-instance v6, Lcom/kousei/framework/se;

    .line 817
    .line 818
    const/16 v9, 0x100

    .line 819
    .line 820
    invoke-direct {v6, v9}, Lcom/kousei/framework/se;-><init>(I)V

    .line 821
    .line 822
    .line 823
    invoke-virtual {v6, v1, v2, v5}, Lcom/kousei/framework/ba;->update([BII)V

    .line 824
    .line 825
    .line 826
    const/4 v7, 0x0

    .line 827
    invoke-virtual {v6, v7, v4}, Lcom/kousei/framework/se;->c(I[B)I

    .line 828
    .line 829
    .line 830
    add-int/2addr v0, v8

    .line 831
    invoke-static {v0, v4, v1}, Lcom/kousei/framework/i0;->O(I[B[B)Z

    .line 832
    .line 833
    .line 834
    move-result v0

    .line 835
    if-eqz v0, :cond_36f

    .line 836
    .line 837
    if-eqz p3, :cond_364

    .line 838
    .line 839
    iget-object v0, v3, Lcom/kousei/framework/qb;->P:[B

    .line 840
    .line 841
    move-object/from16 v1, p3

    .line 842
    .line 843
    iget-object v2, v1, Lcom/kousei/framework/sb;->M:[B

    .line 844
    .line 845
    invoke-static {v0, v2}, Lcom/kousei/framework/i0;->P([B[B)Z

    .line 846
    .line 847
    .line 848
    move-result v0

    .line 849
    if-eqz v0, :cond_35d

    .line 850
    .line 851
    iget-object v0, v3, Lcom/kousei/framework/qb;->Q:[B

    .line 852
    .line 853
    iget-object v1, v1, Lcom/kousei/framework/sb;->N:[B

    .line 854
    .line 855
    invoke-static {v0, v1}, Lcom/kousei/framework/i0;->P([B[B)Z

    .line 856
    .line 857
    .line 858
    move-result v0

    .line 859
    if-eqz v0, :cond_35d

    .line 860
    .line 861
    goto :goto_364

    .line 862
    :cond_35d
    const-string v0, "passed in public key does not match private values"

    .line 863
    .line 864
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 865
    .line 866
    .line 867
    const/4 v0, 0x0

    .line 868
    throw v0

    .line 869
    :cond_364
    :goto_364
    iget-object v0, v3, Lcom/kousei/framework/qb;->R:[B

    .line 870
    .line 871
    if-nez v0, :cond_36b

    .line 872
    .line 873
    move/from16 v8, v20

    .line 874
    .line 875
    goto :goto_36c

    .line 876
    :cond_36b
    move v8, v7

    .line 877
    :goto_36c
    iput v8, v3, Lcom/kousei/framework/qb;->S:I

    .line 878
    .line 879
    return-void

    .line 880
    :cond_36f
    const/4 v0, 0x0

    .line 881
    const-string v1, "\'encoding\' fails hash check"

    .line 882
    .line 883
    invoke-static {v1}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 884
    .line 885
    .line 886
    throw v0

    .line 887
    :cond_376
    const/4 v0, 0x0

    .line 888
    const-string v1, "\'encoding\' has invalid length"

    .line 889
    .line 890
    invoke-static {v1}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 891
    .line 892
    .line 893
    throw v0
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


# virtual methods
.method public final getEncoded()[B
    .registers 5

    .line 1
    iget-object v0, p0, Lcom/kousei/framework/qb;->N:[B

    .line 2
    .line 3
    iget-object v1, p0, Lcom/kousei/framework/qb;->O:[B

    .line 4
    .line 5
    iget-object v2, p0, Lcom/kousei/framework/qb;->M:[B

    .line 6
    .line 7
    iget-object v3, p0, Lcom/kousei/framework/qb;->P:[B

    .line 8
    .line 9
    iget-object p0, p0, Lcom/kousei/framework/qb;->Q:[B

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
