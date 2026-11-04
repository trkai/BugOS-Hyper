.class public final Lcom/kousei/framework/p;
.super Ljava/io/FilterInputStream;


# instance fields
.field public final K:I

.field public final L:Z

.field public final M:[[B

.field public final N:I

.field public final O:I


# direct methods
.method public constructor <init>(I[B)V
    .registers 4

    .line 29
    new-instance p1, Ljava/io/ByteArrayInputStream;

    invoke-direct {p1, p2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    array-length p2, p2

    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, v0}, Lcom/kousei/framework/p;-><init>(Ljava/io/ByteArrayInputStream;IZ)V

    return-void
.end method

.method public constructor <init>(Lcom/kousei/framework/y5;IZ[[BII)V
    .registers 7

    .line 28
    invoke-direct {p0, p1}, Ljava/io/FilterInputStream;-><init>(Ljava/io/InputStream;)V

    iput p2, p0, Lcom/kousei/framework/p;->K:I

    iput-boolean p3, p0, Lcom/kousei/framework/p;->L:Z

    iput-object p4, p0, Lcom/kousei/framework/p;->M:[[B

    iput p5, p0, Lcom/kousei/framework/p;->N:I

    iput p6, p0, Lcom/kousei/framework/p;->O:I

    return-void
.end method

.method public constructor <init>(Ljava/io/ByteArrayInputStream;IZ)V
    .registers 5

    .line 1
    const/16 v0, 0xb

    .line 2
    .line 3
    new-array v0, v0, [[B

    .line 4
    .line 5
    invoke-direct {p0, p1}, Ljava/io/FilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 6
    .line 7
    .line 8
    iput p2, p0, Lcom/kousei/framework/p;->K:I

    .line 9
    .line 10
    iput-boolean p3, p0, Lcom/kousei/framework/p;->L:Z

    .line 11
    .line 12
    iput-object v0, p0, Lcom/kousei/framework/p;->M:[[B

    .line 13
    .line 14
    const/4 p1, 0x0

    .line 15
    iput p1, p0, Lcom/kousei/framework/p;->N:I

    .line 16
    .line 17
    const-string p1, "org.bouncycastle.asn1.max_cons_depth"

    .line 18
    .line 19
    const/16 p2, 0x20

    .line 20
    .line 21
    invoke-static {p2, p1}, Lcom/kousei/framework/md;->a(ILjava/lang/String;)I

    .line 22
    .line 23
    .line 24
    move-result p1

    .line 25
    iput p1, p0, Lcom/kousei/framework/p;->O:I

    .line 26
    .line 27
    return-void
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

.method public constructor <init>([B)V
    .registers 4

    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-direct {v0, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    array-length p1, p1

    const/4 v1, 0x0

    .line 30
    invoke-direct {p0, v0, p1, v1}, Lcom/kousei/framework/p;-><init>(Ljava/io/ByteArrayInputStream;IZ)V

    return-void
.end method

.method public static b(ILcom/kousei/framework/y5;[[B)Lcom/kousei/framework/a0;
    .registers 8

    .line 1
    const-string v0, "unsupported tag "

    .line 2
    .line 3
    const-string v1, "unknown tag "

    .line 4
    .line 5
    const/4 v2, 0x0

    .line 6
    const-string v3, " encountered"

    .line 7
    .line 8
    const/4 v4, 0x1

    .line 9
    packed-switch p0, :pswitch_data_146

    .line 10
    .line 11
    .line 12
    :pswitch_b
    :try_start_b
    new-instance p1, Ljava/io/IOException;

    .line 13
    .line 14
    new-instance p2, Ljava/lang/StringBuilder;

    .line 15
    .line 16
    invoke-direct {p2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 17
    .line 18
    .line 19
    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 20
    .line 21
    .line 22
    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 23
    .line 24
    .line 25
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 26
    .line 27
    .line 28
    move-result-object p0

    .line 29
    invoke-direct {p1, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 30
    .line 31
    .line 32
    throw p1

    .line 33
    :catch_20
    move-exception p0

    .line 34
    goto/16 :goto_131

    .line 35
    .line 36
    :catch_23
    move-exception p0

    .line 37
    goto/16 :goto_13b

    .line 38
    .line 39
    :pswitch_26
    invoke-static {p1}, Lcom/kousei/framework/p;->c(Lcom/kousei/framework/y5;)[C

    .line 40
    .line 41
    .line 42
    move-result-object p0

    .line 43
    new-instance p1, Lcom/kousei/framework/f4;

    .line 44
    .line 45
    invoke-direct {p1, p0}, Lcom/kousei/framework/f4;-><init>([C)V

    .line 46
    .line 47
    .line 48
    return-object p1

    .line 49
    :pswitch_30
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 50
    .line 51
    .line 52
    move-result-object p0

    .line 53
    new-instance p1, Lcom/kousei/framework/w4;

    .line 54
    .line 55
    invoke-direct {p1, p0}, Lcom/kousei/framework/w4;-><init>([B)V

    .line 56
    .line 57
    .line 58
    return-object p1

    .line 59
    :pswitch_3a
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 60
    .line 61
    .line 62
    move-result-object p0

    .line 63
    new-instance p1, Lcom/kousei/framework/i4;

    .line 64
    .line 65
    invoke-direct {p1, p0}, Lcom/kousei/framework/i4;-><init>([B)V

    .line 66
    .line 67
    .line 68
    return-object p1

    .line 69
    :pswitch_44
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 70
    .line 71
    .line 72
    move-result-object p0

    .line 73
    new-instance p1, Lcom/kousei/framework/y4;

    .line 74
    .line 75
    invoke-direct {p1, p0}, Lcom/kousei/framework/y4;-><init>([B)V

    .line 76
    .line 77
    .line 78
    return-object p1

    .line 79
    :pswitch_4e
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 80
    .line 81
    .line 82
    move-result-object p0

    .line 83
    new-instance p1, Lcom/kousei/framework/k4;

    .line 84
    .line 85
    invoke-direct {p1, p0}, Lcom/kousei/framework/k4;-><init>([B)V

    .line 86
    .line 87
    .line 88
    return-object p1

    .line 89
    :pswitch_58
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 90
    .line 91
    .line 92
    move-result-object p0

    .line 93
    new-instance p1, Lcom/kousei/framework/o;

    .line 94
    .line 95
    invoke-direct {p1, p0}, Lcom/kousei/framework/o;-><init>([B)V

    .line 96
    .line 97
    .line 98
    return-object p1

    .line 99
    :pswitch_62
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 100
    .line 101
    .line 102
    move-result-object p0

    .line 103
    new-instance p1, Lcom/kousei/framework/h0;

    .line 104
    .line 105
    invoke-direct {p1, p0}, Lcom/kousei/framework/h0;-><init>([B)V

    .line 106
    .line 107
    .line 108
    return-object p1

    .line 109
    :pswitch_6c
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 110
    .line 111
    .line 112
    move-result-object p0

    .line 113
    new-instance p1, Lcom/kousei/framework/l4;

    .line 114
    .line 115
    invoke-direct {p1, p0}, Lcom/kousei/framework/l4;-><init>([B)V

    .line 116
    .line 117
    .line 118
    return-object p1

    .line 119
    :pswitch_76
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 120
    .line 121
    .line 122
    move-result-object p0

    .line 123
    new-instance p1, Lcom/kousei/framework/x4;

    .line 124
    .line 125
    invoke-direct {p1, p0}, Lcom/kousei/framework/x4;-><init>([B)V

    .line 126
    .line 127
    .line 128
    return-object p1

    .line 129
    :pswitch_80
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 130
    .line 131
    .line 132
    move-result-object p0

    .line 133
    new-instance p1, Lcom/kousei/framework/t4;

    .line 134
    .line 135
    invoke-direct {p1, p0}, Lcom/kousei/framework/t4;-><init>([B)V

    .line 136
    .line 137
    .line 138
    return-object p1

    .line 139
    :pswitch_8a
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 140
    .line 141
    .line 142
    move-result-object p0

    .line 143
    new-instance p1, Lcom/kousei/framework/q4;

    .line 144
    .line 145
    invoke-direct {p1, p0}, Lcom/kousei/framework/q4;-><init>([B)V

    .line 146
    .line 147
    .line 148
    return-object p1

    .line 149
    :pswitch_94
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 150
    .line 151
    .line 152
    move-result-object p0

    .line 153
    new-instance p1, Lcom/kousei/framework/n4;

    .line 154
    .line 155
    invoke-direct {p1, p0}, Lcom/kousei/framework/n4;-><init>([B)V

    .line 156
    .line 157
    .line 158
    return-object p1

    .line 159
    :pswitch_9e
    new-instance p1, Ljava/io/IOException;

    .line 160
    .line 161
    new-instance p2, Ljava/lang/StringBuilder;

    .line 162
    .line 163
    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 164
    .line 165
    .line 166
    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 167
    .line 168
    .line 169
    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 170
    .line 171
    .line 172
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 173
    .line 174
    .line 175
    move-result-object p0

    .line 176
    invoke-direct {p1, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 177
    .line 178
    .line 179
    throw p1

    .line 180
    :pswitch_b3
    iget p0, p1, Lcom/kousei/framework/y5;->N:I

    .line 181
    .line 182
    sget-object v0, Lcom/kousei/framework/b0;->M:Ljava/util/concurrent/ConcurrentHashMap;

    .line 183
    .line 184
    const/16 v0, 0x1000

    .line 185
    .line 186
    if-gt p0, v0, :cond_c4

    .line 187
    .line 188
    invoke-static {p1, p2}, Lcom/kousei/framework/p;->d(Lcom/kousei/framework/y5;[[B)[B

    .line 189
    .line 190
    .line 191
    move-result-object p0

    .line 192
    invoke-static {p0, v4}, Lcom/kousei/framework/b0;->q([BZ)Lcom/kousei/framework/b0;

    .line 193
    .line 194
    .line 195
    move-result-object p0

    .line 196
    return-object p0

    .line 197
    :cond_c4
    new-instance p0, Ljava/lang/IllegalArgumentException;

    .line 198
    .line 199
    const-string p1, "exceeded relative OID contents length limit"

    .line 200
    .line 201
    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .line 202
    .line 203
    .line 204
    throw p0

    .line 205
    :pswitch_cc
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 206
    .line 207
    .line 208
    move-result-object p0

    .line 209
    new-instance p1, Lcom/kousei/framework/v4;

    .line 210
    .line 211
    invoke-direct {p1, p0}, Lcom/kousei/framework/v4;-><init>([B)V

    .line 212
    .line 213
    .line 214
    return-object p1

    .line 215
    :pswitch_d6
    invoke-static {p1, p2}, Lcom/kousei/framework/p;->d(Lcom/kousei/framework/y5;[[B)[B

    .line 216
    .line 217
    .line 218
    move-result-object p0

    .line 219
    invoke-static {p0, v4}, Lcom/kousei/framework/m;->q([BZ)Lcom/kousei/framework/m;

    .line 220
    .line 221
    .line 222
    move-result-object p0

    .line 223
    return-object p0

    .line 224
    :pswitch_df
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 225
    .line 226
    .line 227
    move-result-object p0

    .line 228
    new-instance p1, Lcom/kousei/framework/t;

    .line 229
    .line 230
    new-instance p2, Lcom/kousei/framework/k4;

    .line 231
    .line 232
    invoke-direct {p2, p0}, Lcom/kousei/framework/k4;-><init>([B)V

    .line 233
    .line 234
    .line 235
    invoke-direct {p1, p2}, Lcom/kousei/framework/t;-><init>(Lcom/kousei/framework/k4;)V

    .line 236
    .line 237
    .line 238
    return-object p1

    .line 239
    :pswitch_ee
    iget p0, p1, Lcom/kousei/framework/y5;->N:I

    .line 240
    .line 241
    invoke-static {p0}, Lcom/kousei/framework/v;->r(I)V

    .line 242
    .line 243
    .line 244
    invoke-static {p1, p2}, Lcom/kousei/framework/p;->d(Lcom/kousei/framework/y5;[[B)[B

    .line 245
    .line 246
    .line 247
    move-result-object p0

    .line 248
    invoke-static {p0, v4}, Lcom/kousei/framework/v;->s([BZ)Lcom/kousei/framework/v;

    .line 249
    .line 250
    .line 251
    move-result-object p0

    .line 252
    return-object p0

    .line 253
    :pswitch_fc
    iget p0, p1, Lcom/kousei/framework/y5;->N:I

    .line 254
    .line 255
    if-nez p0, :cond_103

    .line 256
    .line 257
    sget-object p0, Lcom/kousei/framework/m4;->K:Lcom/kousei/framework/m4;

    .line 258
    .line 259
    return-object p0

    .line 260
    :cond_103
    new-instance p0, Ljava/lang/IllegalStateException;

    .line 261
    .line 262
    const-string p1, "malformed NULL encoding encountered"

    .line 263
    .line 264
    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 265
    .line 266
    .line 267
    throw p0

    .line 268
    :pswitch_10b
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 269
    .line 270
    .line 271
    move-result-object p0

    .line 272
    new-instance p1, Lcom/kousei/framework/o4;

    .line 273
    .line 274
    invoke-direct {p1, p0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 275
    .line 276
    .line 277
    return-object p1

    .line 278
    :pswitch_115
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 279
    .line 280
    .line 281
    move-result-object p0

    .line 282
    invoke-static {p0}, Lcom/kousei/framework/g;->q([B)Lcom/kousei/framework/g;

    .line 283
    .line 284
    .line 285
    move-result-object p0

    .line 286
    return-object p0

    .line 287
    :pswitch_11e
    invoke-virtual {p1}, Lcom/kousei/framework/y5;->b()[B

    .line 288
    .line 289
    .line 290
    move-result-object p0

    .line 291
    new-instance p1, Lcom/kousei/framework/q;

    .line 292
    .line 293
    invoke-direct {p1, p0}, Lcom/kousei/framework/q;-><init>([B)V

    .line 294
    .line 295
    .line 296
    return-object p1

    .line 297
    :pswitch_128
    invoke-static {p1, p2}, Lcom/kousei/framework/p;->d(Lcom/kousei/framework/y5;[[B)[B

    .line 298
    .line 299
    .line 300
    move-result-object p0

    .line 301
    invoke-static {p0}, Lcom/kousei/framework/i;->q([B)Lcom/kousei/framework/i;

    .line 302
    .line 303
    .line 304
    move-result-object p0
    :try_end_130
    .catch Ljava/lang/IllegalArgumentException; {:try_start_b .. :try_end_130} :catch_23
    .catch Ljava/lang/IllegalStateException; {:try_start_b .. :try_end_130} :catch_20

    .line 305
    return-object p0

    .line 306
    :goto_131
    new-instance p1, Lcom/kousei/framework/n;

    .line 307
    .line 308
    invoke-virtual {p0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    .line 309
    .line 310
    .line 311
    move-result-object p2

    .line 312
    invoke-direct {p1, p2, p0, v2}, Lcom/kousei/framework/n;-><init>(Ljava/lang/String;Ljava/lang/Exception;I)V

    .line 313
    .line 314
    .line 315
    throw p1

    .line 316
    :goto_13b
    new-instance p1, Lcom/kousei/framework/n;

    .line 317
    .line 318
    invoke-virtual {p0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    .line 319
    .line 320
    .line 321
    move-result-object p2

    .line 322
    invoke-direct {p1, p2, p0, v2}, Lcom/kousei/framework/n;-><init>(Ljava/lang/String;Ljava/lang/Exception;I)V

    .line 323
    .line 324
    .line 325
    throw p1

    .line 326
    nop

    .line 327
    :pswitch_data_146
    .packed-switch 0x1
        :pswitch_128
        :pswitch_11e
        :pswitch_115
        :pswitch_10b
        :pswitch_fc
        :pswitch_ee
        :pswitch_df
        :pswitch_b
        :pswitch_b
        :pswitch_d6
        :pswitch_b
        :pswitch_cc
        :pswitch_b3
        :pswitch_9e
        :pswitch_b
        :pswitch_b
        :pswitch_b
        :pswitch_94
        :pswitch_8a
        :pswitch_80
        :pswitch_76
        :pswitch_6c
        :pswitch_62
        :pswitch_58
        :pswitch_4e
        :pswitch_44
        :pswitch_3a
        :pswitch_30
        :pswitch_b
        :pswitch_26
        :pswitch_9e
        :pswitch_9e
        :pswitch_9e
        :pswitch_9e
        :pswitch_9e
        :pswitch_9e
    .end packed-switch
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

.method public static c(Lcom/kousei/framework/y5;)[C
    .registers 12

    .line 1
    iget v0, p0, Lcom/kousei/framework/y5;->N:I

    .line 2
    .line 3
    and-int/lit8 v1, v0, 0x1

    .line 4
    .line 5
    if-nez v1, :cond_8d

    .line 6
    .line 7
    div-int/lit8 v1, v0, 0x2

    .line 8
    .line 9
    new-array v2, v1, [C

    .line 10
    .line 11
    const/16 v3, 0x8

    .line 12
    .line 13
    new-array v4, v3, [B

    .line 14
    .line 15
    const/4 v5, 0x0

    .line 16
    move v6, v5

    .line 17
    :goto_10
    const-string v7, "EOF encountered in middle of BMPString"

    .line 18
    .line 19
    const/4 v8, 0x2

    .line 20
    if-lt v0, v3, :cond_5e

    .line 21
    .line 22
    invoke-static {p0, v4, v3}, Lcom/kousei/framework/xc;->e0(Ljava/io/InputStream;[BI)I

    .line 23
    .line 24
    .line 25
    move-result v9

    .line 26
    if-ne v9, v3, :cond_58

    .line 27
    .line 28
    aget-byte v7, v4, v5

    .line 29
    .line 30
    shl-int/2addr v7, v3

    .line 31
    const/4 v9, 0x1

    .line 32
    aget-byte v9, v4, v9

    .line 33
    .line 34
    and-int/lit16 v9, v9, 0xff

    .line 35
    .line 36
    or-int/2addr v7, v9

    .line 37
    int-to-char v7, v7

    .line 38
    aput-char v7, v2, v6

    .line 39
    .line 40
    add-int/lit8 v7, v6, 0x1

    .line 41
    .line 42
    aget-byte v8, v4, v8

    .line 43
    .line 44
    shl-int/2addr v8, v3

    .line 45
    const/4 v9, 0x3

    .line 46
    aget-byte v9, v4, v9

    .line 47
    .line 48
    and-int/lit16 v9, v9, 0xff

    .line 49
    .line 50
    or-int/2addr v8, v9

    .line 51
    int-to-char v8, v8

    .line 52
    aput-char v8, v2, v7

    .line 53
    .line 54
    add-int/lit8 v7, v6, 0x2

    .line 55
    .line 56
    const/4 v8, 0x4

    .line 57
    aget-byte v8, v4, v8

    .line 58
    .line 59
    shl-int/2addr v8, v3

    .line 60
    const/4 v9, 0x5

    .line 61
    aget-byte v9, v4, v9

    .line 62
    .line 63
    and-int/lit16 v9, v9, 0xff

    .line 64
    .line 65
    or-int/2addr v8, v9

    .line 66
    int-to-char v8, v8

    .line 67
    aput-char v8, v2, v7

    .line 68
    .line 69
    add-int/lit8 v7, v6, 0x3

    .line 70
    .line 71
    const/4 v8, 0x6

    .line 72
    aget-byte v8, v4, v8

    .line 73
    .line 74
    shl-int/2addr v8, v3

    .line 75
    const/4 v9, 0x7

    .line 76
    aget-byte v9, v4, v9

    .line 77
    .line 78
    and-int/lit16 v9, v9, 0xff

    .line 79
    .line 80
    or-int/2addr v8, v9

    .line 81
    int-to-char v8, v8

    .line 82
    aput-char v8, v2, v7

    .line 83
    .line 84
    add-int/lit8 v6, v6, 0x4

    .line 85
    .line 86
    add-int/lit8 v0, v0, -0x8

    .line 87
    .line 88
    goto :goto_10

    .line 89
    :cond_58
    new-instance p0, Ljava/io/EOFException;

    .line 90
    .line 91
    invoke-direct {p0, v7}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    .line 92
    .line 93
    .line 94
    throw p0

    .line 95
    :cond_5e
    if-lez v0, :cond_80

    .line 96
    .line 97
    invoke-static {p0, v4, v0}, Lcom/kousei/framework/xc;->e0(Ljava/io/InputStream;[BI)I

    .line 98
    .line 99
    .line 100
    move-result v9

    .line 101
    if-ne v9, v0, :cond_7a

    .line 102
    .line 103
    :cond_66
    add-int/lit8 v7, v5, 0x1

    .line 104
    .line 105
    aget-byte v9, v4, v5

    .line 106
    .line 107
    shl-int/2addr v9, v3

    .line 108
    add-int/2addr v5, v8

    .line 109
    aget-byte v7, v4, v7

    .line 110
    .line 111
    and-int/lit16 v7, v7, 0xff

    .line 112
    .line 113
    add-int/lit8 v10, v6, 0x1

    .line 114
    .line 115
    or-int/2addr v7, v9

    .line 116
    int-to-char v7, v7

    .line 117
    aput-char v7, v2, v6

    .line 118
    .line 119
    move v6, v10

    .line 120
    if-lt v5, v0, :cond_66

    .line 121
    .line 122
    goto :goto_80

    .line 123
    :cond_7a
    new-instance p0, Ljava/io/EOFException;

    .line 124
    .line 125
    invoke-direct {p0, v7}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    .line 126
    .line 127
    .line 128
    throw p0

    .line 129
    :cond_80
    :goto_80
    iget p0, p0, Lcom/kousei/framework/y5;->N:I

    .line 130
    .line 131
    if-nez p0, :cond_87

    .line 132
    .line 133
    if-ne v1, v6, :cond_87

    .line 134
    .line 135
    return-object v2

    .line 136
    :cond_87
    new-instance p0, Ljava/lang/IllegalStateException;

    .line 137
    .line 138
    invoke-direct {p0}, Ljava/lang/IllegalStateException;-><init>()V

    .line 139
    .line 140
    .line 141
    throw p0

    .line 142
    :cond_8d
    new-instance p0, Ljava/io/IOException;

    .line 143
    .line 144
    const-string v0, "malformed BMPString encoding encountered"

    .line 145
    .line 146
    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 147
    .line 148
    .line 149
    throw p0
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

.method public static d(Lcom/kousei/framework/y5;[[B)[B
    .registers 6

    .line 1
    iget v0, p0, Lcom/kousei/framework/y5;->N:I

    .line 2
    .line 3
    array-length v1, p1

    .line 4
    if-lt v0, v1, :cond_a

    .line 5
    .line 6
    invoke-virtual {p0}, Lcom/kousei/framework/y5;->b()[B

    .line 7
    .line 8
    .line 9
    move-result-object p0

    .line 10
    return-object p0

    .line 11
    :cond_a
    aget-object v1, p1, v0

    .line 12
    .line 13
    if-nez v1, :cond_12

    .line 14
    .line 15
    new-array v1, v0, [B

    .line 16
    .line 17
    aput-object v1, p1, v0

    .line 18
    .line 19
    :cond_12
    array-length p1, v1

    .line 20
    const/4 v2, 0x0

    .line 21
    if-ne v0, p1, :cond_53

    .line 22
    .line 23
    if-nez v0, :cond_19

    .line 24
    .line 25
    return-object v1

    .line 26
    :cond_19
    iget p1, p0, Lcom/kousei/framework/cb;->L:I

    .line 27
    .line 28
    if-ge v0, p1, :cond_35

    .line 29
    .line 30
    iget-object p1, p0, Lcom/kousei/framework/cb;->K:Ljava/io/InputStream;

    .line 31
    .line 32
    array-length v3, v1

    .line 33
    invoke-static {p1, v1, v3}, Lcom/kousei/framework/xc;->e0(Ljava/io/InputStream;[BI)I

    .line 34
    .line 35
    .line 36
    move-result p1

    .line 37
    sub-int/2addr v0, p1

    .line 38
    iput v0, p0, Lcom/kousei/framework/y5;->N:I

    .line 39
    .line 40
    if-nez v0, :cond_2d

    .line 41
    .line 42
    invoke-virtual {p0}, Lcom/kousei/framework/cb;->a()V

    .line 43
    .line 44
    .line 45
    return-object v1

    .line 46
    :cond_2d
    iget p1, p0, Lcom/kousei/framework/y5;->M:I

    .line 47
    .line 48
    iget p0, p0, Lcom/kousei/framework/y5;->N:I

    .line 49
    .line 50
    invoke-static {p1, p0}, Lcom/kousei/framework/f;->a(II)V

    .line 51
    .line 52
    .line 53
    return-object v2

    .line 54
    :cond_35
    new-instance v0, Ljava/io/IOException;

    .line 55
    .line 56
    iget p0, p0, Lcom/kousei/framework/y5;->N:I

    .line 57
    .line 58
    new-instance v1, Ljava/lang/StringBuilder;

    .line 59
    .line 60
    const-string v2, "corrupted stream - out of bounds length found: "

    .line 61
    .line 62
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 63
    .line 64
    .line 65
    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 66
    .line 67
    .line 68
    const-string p0, " >= "

    .line 69
    .line 70
    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 71
    .line 72
    .line 73
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 74
    .line 75
    .line 76
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 77
    .line 78
    .line 79
    move-result-object p0

    .line 80
    invoke-direct {v0, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 81
    .line 82
    .line 83
    throw v0

    .line 84
    :cond_53
    const-string p0, "buffer length not right for data"

    .line 85
    .line 86
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 87
    .line 88
    .line 89
    return-object v2
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

.method public static e(Ljava/io/InputStream;IZ)I
    .registers 8

    .line 1
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    ushr-int/lit8 v1, v0, 0x7

    .line 6
    .line 7
    if-nez v1, :cond_9

    .line 8
    .line 9
    return v0

    .line 10
    :cond_9
    const/16 v1, 0x80

    .line 11
    .line 12
    if-ne v1, v0, :cond_f

    .line 13
    .line 14
    const/4 p0, -0x1

    .line 15
    return p0

    .line 16
    :cond_f
    if-ltz v0, :cond_64

    .line 17
    .line 18
    const/16 v1, 0xff

    .line 19
    .line 20
    if-eq v1, v0, :cond_5c

    .line 21
    .line 22
    and-int/lit8 v0, v0, 0x7f

    .line 23
    .line 24
    const/4 v1, 0x0

    .line 25
    move v2, v1

    .line 26
    :cond_19
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    .line 27
    .line 28
    .line 29
    move-result v3

    .line 30
    if-ltz v3, :cond_54

    .line 31
    .line 32
    ushr-int/lit8 v4, v1, 0x17

    .line 33
    .line 34
    if-nez v4, :cond_4c

    .line 35
    .line 36
    shl-int/lit8 v1, v1, 0x8

    .line 37
    .line 38
    add-int/2addr v1, v3

    .line 39
    add-int/lit8 v2, v2, 0x1

    .line 40
    .line 41
    if-lt v2, v0, :cond_19

    .line 42
    .line 43
    if-lt v1, p1, :cond_4b

    .line 44
    .line 45
    if-eqz p2, :cond_2f

    .line 46
    .line 47
    goto :goto_4b

    .line 48
    :cond_2f
    new-instance p0, Ljava/io/IOException;

    .line 49
    .line 50
    new-instance p2, Ljava/lang/StringBuilder;

    .line 51
    .line 52
    const-string v0, "corrupted stream - out of bounds length found: "

    .line 53
    .line 54
    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 55
    .line 56
    .line 57
    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 58
    .line 59
    .line 60
    const-string v0, " >= "

    .line 61
    .line 62
    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 63
    .line 64
    .line 65
    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 66
    .line 67
    .line 68
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 69
    .line 70
    .line 71
    move-result-object p1

    .line 72
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 73
    .line 74
    .line 75
    throw p0

    .line 76
    :cond_4b
    :goto_4b
    return v1

    .line 77
    :cond_4c
    new-instance p0, Ljava/io/IOException;

    .line 78
    .line 79
    const-string p1, "long form definite-length more than 31 bits"

    .line 80
    .line 81
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 82
    .line 83
    .line 84
    throw p0

    .line 85
    :cond_54
    new-instance p0, Ljava/io/EOFException;

    .line 86
    .line 87
    const-string p1, "EOF found reading length"

    .line 88
    .line 89
    invoke-direct {p0, p1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    .line 90
    .line 91
    .line 92
    throw p0

    .line 93
    :cond_5c
    new-instance p0, Ljava/io/IOException;

    .line 94
    .line 95
    const-string p1, "invalid long form definite-length 0xFF"

    .line 96
    .line 97
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 98
    .line 99
    .line 100
    throw p0

    .line 101
    :cond_64
    new-instance p0, Ljava/io/EOFException;

    .line 102
    .line 103
    const-string p1, "EOF found when length expected"

    .line 104
    .line 105
    invoke-direct {p0, p1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    .line 106
    .line 107
    .line 108
    throw p0
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

.method public static g(Ljava/io/InputStream;I)I
    .registers 6

    .line 1
    const/16 v0, 0x1f

    .line 2
    .line 3
    and-int/2addr p1, v0

    .line 4
    if-ne p1, v0, :cond_4f

    .line 5
    .line 6
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    .line 7
    .line 8
    .line 9
    move-result p1

    .line 10
    const-string v1, "EOF found inside tag value."

    .line 11
    .line 12
    if-ge p1, v0, :cond_1d

    .line 13
    .line 14
    if-gez p1, :cond_15

    .line 15
    .line 16
    new-instance p0, Ljava/io/EOFException;

    .line 17
    .line 18
    invoke-direct {p0, v1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    .line 19
    .line 20
    .line 21
    throw p0

    .line 22
    :cond_15
    new-instance p0, Ljava/io/IOException;

    .line 23
    .line 24
    const-string p1, "corrupted stream - high tag number < 31 found"

    .line 25
    .line 26
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 27
    .line 28
    .line 29
    throw p0

    .line 30
    :cond_1d
    and-int/lit8 v0, p1, 0x7f

    .line 31
    .line 32
    if-eqz v0, :cond_47

    .line 33
    .line 34
    :goto_21
    and-int/lit16 p1, p1, 0x80

    .line 35
    .line 36
    if-eqz p1, :cond_46

    .line 37
    .line 38
    ushr-int/lit8 p1, v0, 0x18

    .line 39
    .line 40
    if-nez p1, :cond_3e

    .line 41
    .line 42
    shl-int/lit8 p1, v0, 0x7

    .line 43
    .line 44
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    .line 45
    .line 46
    .line 47
    move-result v0

    .line 48
    if-ltz v0, :cond_38

    .line 49
    .line 50
    and-int/lit8 v2, v0, 0x7f

    .line 51
    .line 52
    or-int/2addr p1, v2

    .line 53
    move v3, v0

    .line 54
    move v0, p1

    .line 55
    move p1, v3

    .line 56
    goto :goto_21

    .line 57
    :cond_38
    new-instance p0, Ljava/io/EOFException;

    .line 58
    .line 59
    invoke-direct {p0, v1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    .line 60
    .line 61
    .line 62
    throw p0

    .line 63
    :cond_3e
    new-instance p0, Ljava/io/IOException;

    .line 64
    .line 65
    const-string p1, "Tag number more than 31 bits"

    .line 66
    .line 67
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 68
    .line 69
    .line 70
    throw p0

    .line 71
    :cond_46
    return v0

    .line 72
    :cond_47
    new-instance p0, Ljava/io/IOException;

    .line 73
    .line 74
    const-string p1, "corrupted stream - invalid high tag number found"

    .line 75
    .line 76
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 77
    .line 78
    .line 79
    throw p0

    .line 80
    :cond_4f
    return p1
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


# virtual methods
.method public final a(III)Lcom/kousei/framework/a0;
    .registers 10

    .line 1
    new-instance v0, Lcom/kousei/framework/y5;

    .line 2
    .line 3
    iget v1, p0, Lcom/kousei/framework/p;->K:I

    .line 4
    .line 5
    invoke-direct {v0, p0, p3, v1}, Lcom/kousei/framework/y5;-><init>(Ljava/io/InputStream;II)V

    .line 6
    .line 7
    .line 8
    and-int/lit16 p3, p1, 0xe0

    .line 9
    .line 10
    if-nez p3, :cond_12

    .line 11
    .line 12
    iget-object p0, p0, Lcom/kousei/framework/p;->M:[[B

    .line 13
    .line 14
    invoke-static {p2, v0, p0}, Lcom/kousei/framework/p;->b(ILcom/kousei/framework/y5;[[B)Lcom/kousei/framework/a0;

    .line 15
    .line 16
    .line 17
    move-result-object p0

    .line 18
    return-object p0

    .line 19
    :cond_12
    and-int/lit16 v2, p1, 0xc0

    .line 20
    .line 21
    const/4 v1, 0x3

    .line 22
    move p3, v1

    .line 23
    const/4 v1, 0x4

    .line 24
    const/4 v3, 0x0

    .line 25
    const/4 v4, 0x1

    .line 26
    if-eqz v2, :cond_51

    .line 27
    .line 28
    and-int/lit8 p1, p1, 0x20

    .line 29
    .line 30
    if-eqz p1, :cond_40

    .line 31
    .line 32
    invoke-virtual {p0, v0}, Lcom/kousei/framework/p;->h(Lcom/kousei/framework/y5;)Lcom/kousei/framework/l;

    .line 33
    .line 34
    .line 35
    move-result-object p0

    .line 36
    iget p1, p0, Lcom/kousei/framework/l;->b:I

    .line 37
    .line 38
    if-ne p1, v4, :cond_34

    .line 39
    .line 40
    new-instance v0, Lcom/kousei/framework/k2;

    .line 41
    .line 42
    invoke-virtual {p0, v3}, Lcom/kousei/framework/l;->c(I)Lcom/kousei/framework/k;

    .line 43
    .line 44
    .line 45
    move-result-object v4

    .line 46
    const/4 v5, 0x2

    .line 47
    move v3, p2

    .line 48
    move v1, p3

    .line 49
    invoke-direct/range {v0 .. v5}, Lcom/kousei/framework/k2;-><init>(IIILcom/kousei/framework/k;I)V

    .line 50
    .line 51
    .line 52
    return-object v0

    .line 53
    :cond_34
    move v3, p2

    .line 54
    new-instance v0, Lcom/kousei/framework/k2;

    .line 55
    .line 56
    invoke-static {p0}, Lcom/kousei/framework/h5;->a(Lcom/kousei/framework/l;)Lcom/kousei/framework/r4;

    .line 57
    .line 58
    .line 59
    move-result-object v4

    .line 60
    const/4 v5, 0x2

    .line 61
    invoke-direct/range {v0 .. v5}, Lcom/kousei/framework/k2;-><init>(IIILcom/kousei/framework/k;I)V

    .line 62
    .line 63
    .line 64
    return-object v0

    .line 65
    :cond_40
    move v3, p2

    .line 66
    invoke-virtual {v0}, Lcom/kousei/framework/y5;->b()[B

    .line 67
    .line 68
    .line 69
    move-result-object p0

    .line 70
    new-instance v0, Lcom/kousei/framework/k2;

    .line 71
    .line 72
    new-instance v4, Lcom/kousei/framework/o4;

    .line 73
    .line 74
    invoke-direct {v4, p0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 75
    .line 76
    .line 77
    const/4 v5, 0x2

    .line 78
    invoke-direct/range {v0 .. v5}, Lcom/kousei/framework/k2;-><init>(IIILcom/kousei/framework/k;I)V

    .line 79
    .line 80
    .line 81
    return-object v0

    .line 82
    :cond_51
    move p1, p2

    .line 83
    const/4 p2, 0x0

    .line 84
    if-eq p1, p3, :cond_ed

    .line 85
    .line 86
    if-eq p1, v1, :cond_c0

    .line 87
    .line 88
    const/16 p2, 0x8

    .line 89
    .line 90
    if-eq p1, p2, :cond_b2

    .line 91
    .line 92
    const/16 p2, 0x10

    .line 93
    .line 94
    if-eq p1, p2, :cond_92

    .line 95
    .line 96
    const/16 p2, 0x11

    .line 97
    .line 98
    if-ne p1, p2, :cond_79

    .line 99
    .line 100
    invoke-virtual {p0, v0}, Lcom/kousei/framework/p;->h(Lcom/kousei/framework/y5;)Lcom/kousei/framework/l;

    .line 101
    .line 102
    .line 103
    move-result-object p0

    .line 104
    sget-object p1, Lcom/kousei/framework/h5;->a:Lcom/kousei/framework/r4;

    .line 105
    .line 106
    iget p1, p0, Lcom/kousei/framework/l;->b:I

    .line 107
    .line 108
    if-ge p1, v4, :cond_70

    .line 109
    .line 110
    sget-object p0, Lcom/kousei/framework/h5;->b:Lcom/kousei/framework/s4;

    .line 111
    .line 112
    return-object p0

    .line 113
    :cond_70
    new-instance p1, Lcom/kousei/framework/s4;

    .line 114
    .line 115
    invoke-direct {p1, p0}, Lcom/kousei/framework/s4;-><init>(Lcom/kousei/framework/l;)V

    .line 116
    .line 117
    .line 118
    const/4 p0, -0x1

    .line 119
    iput p0, p1, Lcom/kousei/framework/s4;->O:I

    .line 120
    .line 121
    return-object p1

    .line 122
    :cond_79
    new-instance p0, Ljava/io/IOException;

    .line 123
    .line 124
    new-instance p2, Ljava/lang/StringBuilder;

    .line 125
    .line 126
    const-string p3, "unknown tag "

    .line 127
    .line 128
    invoke-direct {p2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 129
    .line 130
    .line 131
    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 132
    .line 133
    .line 134
    const-string p1, " encountered"

    .line 135
    .line 136
    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 137
    .line 138
    .line 139
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 140
    .line 141
    .line 142
    move-result-object p1

    .line 143
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 144
    .line 145
    .line 146
    throw p0

    .line 147
    :cond_92
    iget p1, v0, Lcom/kousei/framework/y5;->N:I

    .line 148
    .line 149
    if-ge p1, v4, :cond_99

    .line 150
    .line 151
    sget-object p0, Lcom/kousei/framework/h5;->a:Lcom/kousei/framework/r4;

    .line 152
    .line 153
    return-object p0

    .line 154
    :cond_99
    iget-boolean p1, p0, Lcom/kousei/framework/p;->L:Z

    .line 155
    .line 156
    if-eqz p1, :cond_a9

    .line 157
    .line 158
    new-instance p0, Lcom/kousei/framework/bb;

    .line 159
    .line 160
    invoke-virtual {v0}, Lcom/kousei/framework/y5;->b()[B

    .line 161
    .line 162
    .line 163
    move-result-object p1

    .line 164
    invoke-direct {p0}, Lcom/kousei/framework/d0;-><init>()V

    .line 165
    .line 166
    .line 167
    iput-object p1, p0, Lcom/kousei/framework/bb;->M:[B

    .line 168
    .line 169
    return-object p0

    .line 170
    :cond_a9
    invoke-virtual {p0, v0}, Lcom/kousei/framework/p;->h(Lcom/kousei/framework/y5;)Lcom/kousei/framework/l;

    .line 171
    .line 172
    .line 173
    move-result-object p0

    .line 174
    invoke-static {p0}, Lcom/kousei/framework/h5;->a(Lcom/kousei/framework/l;)Lcom/kousei/framework/r4;

    .line 175
    .line 176
    .line 177
    move-result-object p0

    .line 178
    return-object p0

    .line 179
    :cond_b2
    invoke-virtual {p0, v0}, Lcom/kousei/framework/p;->h(Lcom/kousei/framework/y5;)Lcom/kousei/framework/l;

    .line 180
    .line 181
    .line 182
    move-result-object p0

    .line 183
    invoke-static {p0}, Lcom/kousei/framework/h5;->a(Lcom/kousei/framework/l;)Lcom/kousei/framework/r4;

    .line 184
    .line 185
    .line 186
    move-result-object p0

    .line 187
    new-instance p1, Lcom/kousei/framework/h4;

    .line 188
    .line 189
    invoke-direct {p1, p0, v4}, Lcom/kousei/framework/h4;-><init>(Lcom/kousei/framework/d0;I)V

    .line 190
    .line 191
    .line 192
    return-object p1

    .line 193
    :cond_c0
    invoke-virtual {p0, v0}, Lcom/kousei/framework/p;->h(Lcom/kousei/framework/y5;)Lcom/kousei/framework/l;

    .line 194
    .line 195
    .line 196
    move-result-object p0

    .line 197
    iget p1, p0, Lcom/kousei/framework/l;->b:I

    .line 198
    .line 199
    new-array p3, p1, [Lcom/kousei/framework/w;

    .line 200
    .line 201
    :goto_c8
    if-eq v3, p1, :cond_e3

    .line 202
    .line 203
    invoke-virtual {p0, v3}, Lcom/kousei/framework/l;->c(I)Lcom/kousei/framework/k;

    .line 204
    .line 205
    .line 206
    move-result-object v0

    .line 207
    instance-of v1, v0, Lcom/kousei/framework/w;

    .line 208
    .line 209
    if-eqz v1, :cond_d9

    .line 210
    .line 211
    check-cast v0, Lcom/kousei/framework/w;

    .line 212
    .line 213
    aput-object v0, p3, v3

    .line 214
    .line 215
    add-int/lit8 v3, v3, 0x1

    .line 216
    .line 217
    goto :goto_c8

    .line 218
    :cond_d9
    const-string p0, "unknown object encountered in constructed OCTET STRING: "

    .line 219
    .line 220
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 221
    .line 222
    .line 223
    move-result-object p1

    .line 224
    invoke-static {p1, p0}, Lcom/kousei/framework/f;->d(Ljava/lang/Object;Ljava/lang/String;)V

    .line 225
    .line 226
    .line 227
    return-object p2

    .line 228
    :cond_e3
    new-instance p0, Lcom/kousei/framework/f2;

    .line 229
    .line 230
    invoke-static {p3}, Lcom/kousei/framework/f2;->r([Lcom/kousei/framework/w;)[B

    .line 231
    .line 232
    .line 233
    move-result-object p1

    .line 234
    invoke-direct {p0, p1, p3}, Lcom/kousei/framework/f2;-><init>([B[Lcom/kousei/framework/w;)V

    .line 235
    .line 236
    .line 237
    return-object p0

    .line 238
    :cond_ed
    invoke-virtual {p0, v0}, Lcom/kousei/framework/p;->h(Lcom/kousei/framework/y5;)Lcom/kousei/framework/l;

    .line 239
    .line 240
    .line 241
    move-result-object p0

    .line 242
    iget p1, p0, Lcom/kousei/framework/l;->b:I

    .line 243
    .line 244
    new-array p3, p1, [Lcom/kousei/framework/g;

    .line 245
    .line 246
    :goto_f5
    if-eq v3, p1, :cond_110

    .line 247
    .line 248
    invoke-virtual {p0, v3}, Lcom/kousei/framework/l;->c(I)Lcom/kousei/framework/k;

    .line 249
    .line 250
    .line 251
    move-result-object v0

    .line 252
    instance-of v1, v0, Lcom/kousei/framework/g;

    .line 253
    .line 254
    if-eqz v1, :cond_106

    .line 255
    .line 256
    check-cast v0, Lcom/kousei/framework/g;

    .line 257
    .line 258
    aput-object v0, p3, v3

    .line 259
    .line 260
    add-int/lit8 v3, v3, 0x1

    .line 261
    .line 262
    goto :goto_f5

    .line 263
    :cond_106
    const-string p0, "unknown object encountered in constructed BIT STRING: "

    .line 264
    .line 265
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 266
    .line 267
    .line 268
    move-result-object p1

    .line 269
    invoke-static {p1, p0}, Lcom/kousei/framework/f;->d(Ljava/lang/Object;Ljava/lang/String;)V

    .line 270
    .line 271
    .line 272
    return-object p2

    .line 273
    :cond_110
    new-instance p0, Lcom/kousei/framework/c2;

    .line 274
    .line 275
    invoke-direct {p0, p3}, Lcom/kousei/framework/c2;-><init>([Lcom/kousei/framework/g;)V

    .line 276
    .line 277
    .line 278
    return-object p0
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

.method public final f()Lcom/kousei/framework/a0;
    .registers 7

    .line 1
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    const/4 v1, 0x0

    .line 6
    if-gtz v0, :cond_12

    .line 7
    .line 8
    if-eqz v0, :cond_a

    .line 9
    .line 10
    return-object v1

    .line 11
    :cond_a
    new-instance p0, Ljava/io/IOException;

    .line 12
    .line 13
    const-string v0, "unexpected end-of-contents marker"

    .line 14
    .line 15
    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 16
    .line 17
    .line 18
    throw p0

    .line 19
    :cond_12
    invoke-static {p0, v0}, Lcom/kousei/framework/p;->g(Ljava/io/InputStream;I)I

    .line 20
    .line 21
    .line 22
    move-result v2

    .line 23
    iget v3, p0, Lcom/kousei/framework/p;->K:I

    .line 24
    .line 25
    const/4 v4, 0x0

    .line 26
    invoke-static {p0, v3, v4}, Lcom/kousei/framework/p;->e(Ljava/io/InputStream;IZ)I

    .line 27
    .line 28
    .line 29
    move-result v5

    .line 30
    if-ltz v5, :cond_2d

    .line 31
    .line 32
    :try_start_1f
    invoke-virtual {p0, v0, v2, v5}, Lcom/kousei/framework/p;->a(III)Lcom/kousei/framework/a0;

    .line 33
    .line 34
    .line 35
    move-result-object p0
    :try_end_23
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1f .. :try_end_23} :catch_24

    .line 36
    return-object p0

    .line 37
    :catch_24
    move-exception p0

    .line 38
    new-instance v0, Lcom/kousei/framework/n;

    .line 39
    .line 40
    const-string v1, "corrupted stream detected"

    .line 41
    .line 42
    invoke-direct {v0, v1, p0, v4}, Lcom/kousei/framework/n;-><init>(Ljava/lang/String;Ljava/lang/Exception;I)V

    .line 43
    .line 44
    .line 45
    throw v0

    .line 46
    :cond_2d
    and-int/lit8 v4, v0, 0x20

    .line 47
    .line 48
    if-eqz v4, :cond_8d

    .line 49
    .line 50
    new-instance v4, Lcom/kousei/framework/q9;

    .line 51
    .line 52
    invoke-direct {v4, p0, v3}, Lcom/kousei/framework/q9;-><init>(Ljava/io/InputStream;I)V

    .line 53
    .line 54
    .line 55
    new-instance v5, Lcom/kousei/framework/f0;

    .line 56
    .line 57
    iget-object p0, p0, Lcom/kousei/framework/p;->M:[[B

    .line 58
    .line 59
    invoke-direct {v5, v4, v3, p0}, Lcom/kousei/framework/f0;-><init>(Lcom/kousei/framework/q9;I[[B)V

    .line 60
    .line 61
    .line 62
    and-int/lit16 p0, v0, 0xc0

    .line 63
    .line 64
    if-eqz p0, :cond_46

    .line 65
    .line 66
    invoke-virtual {v5, p0, v2}, Lcom/kousei/framework/f0;->b(II)Lcom/kousei/framework/k2;

    .line 67
    .line 68
    .line 69
    move-result-object p0

    .line 70
    return-object p0

    .line 71
    :cond_46
    const/4 p0, 0x3

    .line 72
    if-eq v2, p0, :cond_88

    .line 73
    .line 74
    const/4 p0, 0x4

    .line 75
    if-eq v2, p0, :cond_79

    .line 76
    .line 77
    const/16 p0, 0x8

    .line 78
    .line 79
    if-eq v2, p0, :cond_74

    .line 80
    .line 81
    const/16 p0, 0x10

    .line 82
    .line 83
    if-eq v2, p0, :cond_6a

    .line 84
    .line 85
    const/16 p0, 0x11

    .line 86
    .line 87
    if-ne v2, p0, :cond_62

    .line 88
    .line 89
    new-instance p0, Lcom/kousei/framework/j2;

    .line 90
    .line 91
    invoke-virtual {v5}, Lcom/kousei/framework/f0;->c()Lcom/kousei/framework/l;

    .line 92
    .line 93
    .line 94
    move-result-object v0

    .line 95
    invoke-direct {p0, v0}, Lcom/kousei/framework/e0;-><init>(Lcom/kousei/framework/l;)V

    .line 96
    .line 97
    .line 98
    return-object p0

    .line 99
    :cond_62
    new-instance p0, Ljava/io/IOException;

    .line 100
    .line 101
    const-string v0, "unknown BER object encountered"

    .line 102
    .line 103
    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 104
    .line 105
    .line 106
    throw p0

    .line 107
    :cond_6a
    new-instance p0, Lcom/kousei/framework/h2;

    .line 108
    .line 109
    invoke-virtual {v5}, Lcom/kousei/framework/f0;->c()Lcom/kousei/framework/l;

    .line 110
    .line 111
    .line 112
    move-result-object v0

    .line 113
    invoke-direct {p0, v0}, Lcom/kousei/framework/d0;-><init>(Lcom/kousei/framework/l;)V

    .line 114
    .line 115
    .line 116
    return-object p0

    .line 117
    :cond_74
    invoke-static {v5}, Lcom/kousei/framework/i2;->c(Lcom/kousei/framework/f0;)Lcom/kousei/framework/h4;

    .line 118
    .line 119
    .line 120
    move-result-object p0

    .line 121
    return-object p0

    .line 122
    :cond_79
    new-instance p0, Lcom/kousei/framework/f2;

    .line 123
    .line 124
    new-instance v0, Lcom/kousei/framework/q3;

    .line 125
    .line 126
    invoke-direct {v0, v5}, Lcom/kousei/framework/q3;-><init>(Lcom/kousei/framework/f0;)V

    .line 127
    .line 128
    .line 129
    invoke-static {v0}, Lcom/kousei/framework/xc;->d0(Ljava/io/InputStream;)[B

    .line 130
    .line 131
    .line 132
    move-result-object v0

    .line 133
    invoke-direct {p0, v0, v1}, Lcom/kousei/framework/f2;-><init>([B[Lcom/kousei/framework/w;)V

    .line 134
    .line 135
    .line 136
    return-object p0

    .line 137
    :cond_88
    invoke-static {v5}, Lcom/kousei/framework/d2;->c(Lcom/kousei/framework/f0;)Lcom/kousei/framework/c2;

    .line 138
    .line 139
    .line 140
    move-result-object p0

    .line 141
    return-object p0

    .line 142
    :cond_8d
    new-instance p0, Ljava/io/IOException;

    .line 143
    .line 144
    const-string v0, "indefinite-length primitive encoding encountered"

    .line 145
    .line 146
    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 147
    .line 148
    .line 149
    throw p0
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

.method public final h(Lcom/kousei/framework/y5;)Lcom/kousei/framework/l;
    .registers 10

    .line 1
    iget v2, p1, Lcom/kousei/framework/y5;->N:I

    .line 2
    .line 3
    const/4 v7, 0x0

    .line 4
    const/4 v0, 0x1

    .line 5
    if-ge v2, v0, :cond_c

    .line 6
    .line 7
    new-instance p0, Lcom/kousei/framework/l;

    .line 8
    .line 9
    invoke-direct {p0, v7}, Lcom/kousei/framework/l;-><init>(I)V

    .line 10
    .line 11
    .line 12
    return-object p0

    .line 13
    :cond_c
    iget v1, p0, Lcom/kousei/framework/p;->N:I

    .line 14
    .line 15
    iget v6, p0, Lcom/kousei/framework/p;->O:I

    .line 16
    .line 17
    if-eq v1, v6, :cond_3a

    .line 18
    .line 19
    move v3, v0

    .line 20
    new-instance v0, Lcom/kousei/framework/p;

    .line 21
    .line 22
    iget-object v4, p0, Lcom/kousei/framework/p;->M:[[B

    .line 23
    .line 24
    add-int/lit8 v5, v1, 0x1

    .line 25
    .line 26
    iget-boolean v3, p0, Lcom/kousei/framework/p;->L:Z

    .line 27
    .line 28
    move-object v1, p1

    .line 29
    invoke-direct/range {v0 .. v6}, Lcom/kousei/framework/p;-><init>(Lcom/kousei/framework/y5;IZ[[BII)V

    .line 30
    .line 31
    .line 32
    invoke-virtual {v0}, Lcom/kousei/framework/p;->f()Lcom/kousei/framework/a0;

    .line 33
    .line 34
    .line 35
    move-result-object p0

    .line 36
    if-nez p0, :cond_2b

    .line 37
    .line 38
    new-instance p0, Lcom/kousei/framework/l;

    .line 39
    .line 40
    invoke-direct {p0, v7}, Lcom/kousei/framework/l;-><init>(I)V

    .line 41
    .line 42
    .line 43
    return-object p0

    .line 44
    :cond_2b
    new-instance p1, Lcom/kousei/framework/l;

    .line 45
    .line 46
    invoke-direct {p1}, Lcom/kousei/framework/l;-><init>()V

    .line 47
    .line 48
    .line 49
    :cond_30
    invoke-virtual {p1, p0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 50
    .line 51
    .line 52
    invoke-virtual {v0}, Lcom/kousei/framework/p;->f()Lcom/kousei/framework/a0;

    .line 53
    .line 54
    .line 55
    move-result-object p0

    .line 56
    if-nez p0, :cond_30

    .line 57
    .line 58
    return-object p1

    .line 59
    :cond_3a
    new-instance p1, Ljava/io/IOException;

    .line 60
    .line 61
    new-instance v0, Ljava/lang/StringBuilder;

    .line 62
    .line 63
    const-string v1, "maximum nested construction level reached - increase org.bouncycastle.asn1.max_cons_depth (currently "

    .line 64
    .line 65
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 66
    .line 67
    .line 68
    iget p0, p0, Lcom/kousei/framework/p;->O:I

    .line 69
    .line 70
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 71
    .line 72
    .line 73
    const-string p0, ")"

    .line 74
    .line 75
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 76
    .line 77
    .line 78
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 79
    .line 80
    .line 81
    move-result-object p0

    .line 82
    invoke-direct {p1, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 83
    .line 84
    .line 85
    throw p1
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
