.class public final Lcom/kousei/framework/ed;
.super Ljava/lang/Object;


# instance fields
.field public final synthetic a:I

.field public final b:[Lcom/kousei/framework/k3;


# direct methods
.method public constructor <init>(Lcom/kousei/framework/fb;I)V
    .registers 7

    .line 1
    iput p2, p0, Lcom/kousei/framework/ed;->a:I

    .line 2
    .line 3
    const/4 v0, 0x0

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 5
    .line 6
    .line 7
    packed-switch p2, :pswitch_data_36

    .line 8
    .line 9
    .line 10
    iget p2, p1, Lcom/kousei/framework/fb;->c:I

    .line 11
    .line 12
    new-array v1, p2, [Lcom/kousei/framework/k3;

    .line 13
    .line 14
    iput-object v1, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 15
    .line 16
    move v1, v0

    .line 17
    :goto_10
    if-ge v1, p2, :cond_1e

    .line 18
    .line 19
    iget-object v2, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 20
    .line 21
    new-instance v3, Lcom/kousei/framework/k3;

    .line 22
    .line 23
    invoke-direct {v3, p1, v0}, Lcom/kousei/framework/k3;-><init>(Lcom/kousei/framework/fb;B)V

    .line 24
    .line 25
    .line 26
    aput-object v3, v2, v1

    .line 27
    .line 28
    add-int/lit8 v1, v1, 0x1

    .line 29
    .line 30
    goto :goto_10

    .line 31
    :cond_1e
    return-void

    .line 32
    :pswitch_1f
    iget p2, p1, Lcom/kousei/framework/fb;->d:I

    .line 33
    .line 34
    new-array v1, p2, [Lcom/kousei/framework/k3;

    .line 35
    .line 36
    iput-object v1, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 37
    .line 38
    move v1, v0

    .line 39
    :goto_26
    if-ge v1, p2, :cond_34

    .line 40
    .line 41
    iget-object v2, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 42
    .line 43
    new-instance v3, Lcom/kousei/framework/k3;

    .line 44
    .line 45
    invoke-direct {v3, p1, v0}, Lcom/kousei/framework/k3;-><init>(Lcom/kousei/framework/fb;B)V

    .line 46
    .line 47
    .line 48
    aput-object v3, v2, v1

    .line 49
    .line 50
    add-int/lit8 v1, v1, 0x1

    .line 51
    .line 52
    goto :goto_26

    .line 53
    :cond_34
    return-void

    .line 54
    nop

    .line 55
    :pswitch_data_36
    .packed-switch 0x1
        :pswitch_1f
    .end packed-switch
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
.end method


# virtual methods
.method public a()V
    .registers 9

    .line 1
    const/4 v0, 0x0

    .line 2
    move v1, v0

    .line 3
    :goto_2
    iget-object v2, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 4
    .line 5
    array-length v3, v2

    .line 6
    if-ge v1, v3, :cond_26

    .line 7
    .line 8
    aget-object v2, v2, v1

    .line 9
    .line 10
    move v3, v0

    .line 11
    :goto_a
    const/16 v4, 0x100

    .line 12
    .line 13
    if-ge v3, v4, :cond_20

    .line 14
    .line 15
    iget-object v4, v2, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 16
    .line 17
    check-cast v4, [I

    .line 18
    .line 19
    aget v5, v4, v3

    .line 20
    .line 21
    shr-int/lit8 v6, v5, 0x1f

    .line 22
    .line 23
    const v7, 0x7fe001

    .line 24
    .line 25
    .line 26
    and-int/2addr v6, v7

    .line 27
    add-int/2addr v5, v6

    .line 28
    aput v5, v4, v3

    .line 29
    .line 30
    add-int/lit8 v3, v3, 0x1

    .line 31
    .line 32
    goto :goto_a

    .line 33
    :cond_20
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 34
    .line 35
    .line 36
    add-int/lit8 v1, v1, 0x1

    .line 37
    .line 38
    goto :goto_2

    .line 39
    :cond_26
    return-void
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

.method public b()V
    .registers 16

    .line 1
    const/4 v2, 0x0

    .line 2
    :goto_1
    iget-object v3, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 3
    .line 4
    array-length v4, v3

    .line 5
    if-ge v2, v4, :cond_5f

    .line 6
    .line 7
    aget-object v3, v3, v2

    .line 8
    .line 9
    iget-object v4, v3, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 10
    .line 11
    check-cast v4, [I

    .line 12
    .line 13
    array-length v5, v4

    .line 14
    invoke-static {v5, v4}, Lcom/kousei/framework/i0;->f0(I[I)[I

    .line 15
    .line 16
    .line 17
    move-result-object v4

    .line 18
    const/4 v5, 0x1

    .line 19
    const/16 v6, 0x100

    .line 20
    .line 21
    move v7, v6

    .line 22
    :goto_15
    if-ge v5, v6, :cond_47

    .line 23
    .line 24
    const/4 v8, 0x0

    .line 25
    :goto_18
    if-ge v8, v6, :cond_44

    .line 26
    .line 27
    sget-object v9, Lcom/kousei/framework/j0;->A:[I

    .line 28
    .line 29
    add-int/lit8 v7, v7, -0x1

    .line 30
    .line 31
    aget v9, v9, v7

    .line 32
    .line 33
    mul-int/lit8 v9, v9, -0x1

    .line 34
    .line 35
    move v10, v8

    .line 36
    :goto_23
    add-int v11, v8, v5

    .line 37
    .line 38
    if-ge v10, v11, :cond_41

    .line 39
    .line 40
    aget v11, v4, v10

    .line 41
    .line 42
    add-int v12, v10, v5

    .line 43
    .line 44
    aget v13, v4, v12

    .line 45
    .line 46
    add-int/2addr v13, v11

    .line 47
    aput v13, v4, v10

    .line 48
    .line 49
    aget v13, v4, v12

    .line 50
    .line 51
    sub-int/2addr v11, v13

    .line 52
    aput v11, v4, v12

    .line 53
    .line 54
    int-to-long v13, v9

    .line 55
    int-to-long v0, v11

    .line 56
    mul-long/2addr v13, v0

    .line 57
    invoke-static {v13, v14}, Lcom/kousei/framework/xc;->P(J)I

    .line 58
    .line 59
    .line 60
    move-result v0

    .line 61
    aput v0, v4, v12

    .line 62
    .line 63
    add-int/lit8 v10, v10, 0x1

    .line 64
    .line 65
    goto :goto_23

    .line 66
    :cond_41
    add-int v8, v10, v5

    .line 67
    .line 68
    goto :goto_18

    .line 69
    :cond_44
    shl-int/lit8 v5, v5, 0x1

    .line 70
    .line 71
    goto :goto_15

    .line 72
    :cond_47
    const/4 v0, 0x0

    .line 73
    :goto_48
    if-ge v0, v6, :cond_5a

    .line 74
    .line 75
    aget v1, v4, v0

    .line 76
    .line 77
    int-to-long v7, v1

    .line 78
    const-wide/32 v9, 0xa3fa

    .line 79
    .line 80
    .line 81
    mul-long/2addr v7, v9

    .line 82
    invoke-static {v7, v8}, Lcom/kousei/framework/xc;->P(J)I

    .line 83
    .line 84
    .line 85
    move-result v1

    .line 86
    aput v1, v4, v0

    .line 87
    .line 88
    add-int/lit8 v0, v0, 0x1

    .line 89
    .line 90
    goto :goto_48

    .line 91
    :cond_5a
    iput-object v4, v3, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 92
    .line 93
    add-int/lit8 v2, v2, 0x1

    .line 94
    .line 95
    goto :goto_1

    .line 96
    :cond_5f
    return-void
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

.method public c()V
    .registers 15

    .line 1
    const/4 v0, 0x0

    .line 2
    move v1, v0

    .line 3
    :goto_2
    iget-object v2, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 4
    .line 5
    array-length v3, v2

    .line 6
    if-ge v1, v3, :cond_4a

    .line 7
    .line 8
    aget-object v2, v2, v1

    .line 9
    .line 10
    iget-object v3, v2, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 11
    .line 12
    check-cast v3, [I

    .line 13
    .line 14
    array-length v4, v3

    .line 15
    invoke-static {v4, v3}, Lcom/kousei/framework/i0;->f0(I[I)[I

    .line 16
    .line 17
    .line 18
    move-result-object v3

    .line 19
    const/16 v4, 0x80

    .line 20
    .line 21
    move v5, v0

    .line 22
    :goto_15
    if-lez v4, :cond_45

    .line 23
    .line 24
    move v6, v0

    .line 25
    :goto_18
    const/16 v7, 0x100

    .line 26
    .line 27
    if-ge v6, v7, :cond_42

    .line 28
    .line 29
    sget-object v7, Lcom/kousei/framework/j0;->A:[I

    .line 30
    .line 31
    add-int/lit8 v5, v5, 0x1

    .line 32
    .line 33
    aget v7, v7, v5

    .line 34
    .line 35
    move v8, v6

    .line 36
    :goto_23
    add-int v9, v6, v4

    .line 37
    .line 38
    if-ge v8, v9, :cond_3f

    .line 39
    .line 40
    int-to-long v9, v7

    .line 41
    add-int v11, v8, v4

    .line 42
    .line 43
    aget v12, v3, v11

    .line 44
    .line 45
    int-to-long v12, v12

    .line 46
    mul-long/2addr v9, v12

    .line 47
    invoke-static {v9, v10}, Lcom/kousei/framework/xc;->P(J)I

    .line 48
    .line 49
    .line 50
    move-result v9

    .line 51
    aget v10, v3, v8

    .line 52
    .line 53
    sub-int/2addr v10, v9

    .line 54
    aput v10, v3, v11

    .line 55
    .line 56
    aget v10, v3, v8

    .line 57
    .line 58
    add-int/2addr v10, v9

    .line 59
    aput v10, v3, v8

    .line 60
    .line 61
    add-int/lit8 v8, v8, 0x1

    .line 62
    .line 63
    goto :goto_23

    .line 64
    :cond_3f
    add-int v6, v8, v4

    .line 65
    .line 66
    goto :goto_18

    .line 67
    :cond_42
    ushr-int/lit8 v4, v4, 0x1

    .line 68
    .line 69
    goto :goto_15

    .line 70
    :cond_45
    iput-object v3, v2, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 71
    .line 72
    add-int/lit8 v1, v1, 0x1

    .line 73
    .line 74
    goto :goto_2

    .line 75
    :cond_4a
    return-void
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

.method public d(Lcom/kousei/framework/ed;)V
    .registers 10

    .line 1
    const/4 v0, 0x0

    .line 2
    move v1, v0

    .line 3
    :goto_2
    iget-object v2, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 4
    .line 5
    array-length v3, v2

    .line 6
    if-ge v1, v3, :cond_2d

    .line 7
    .line 8
    aget-object v2, v2, v1

    .line 9
    .line 10
    iget-object v3, p1, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 11
    .line 12
    aget-object v3, v3, v1

    .line 13
    .line 14
    iget-object v2, v2, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 15
    .line 16
    check-cast v2, [I

    .line 17
    .line 18
    iget-object v3, v3, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 19
    .line 20
    check-cast v3, [I

    .line 21
    .line 22
    move v4, v0

    .line 23
    :goto_16
    const/16 v5, 0x100

    .line 24
    .line 25
    if-ge v4, v5, :cond_2a

    .line 26
    .line 27
    aget v5, v2, v4

    .line 28
    .line 29
    add-int/lit16 v6, v5, 0xfff

    .line 30
    .line 31
    and-int/lit16 v7, v6, -0x2000

    .line 32
    .line 33
    sub-int/2addr v5, v7

    .line 34
    shr-int/lit8 v6, v6, 0xd

    .line 35
    .line 36
    aput v6, v2, v4

    .line 37
    .line 38
    aput v5, v3, v4

    .line 39
    .line 40
    add-int/lit8 v4, v4, 0x1

    .line 41
    .line 42
    goto :goto_16

    .line 43
    :cond_2a
    add-int/lit8 v1, v1, 0x1

    .line 44
    .line 45
    goto :goto_2

    .line 46
    :cond_2d
    return-void
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

.method public e()V
    .registers 9

    .line 1
    const/4 v0, 0x0

    .line 2
    move v1, v0

    .line 3
    :goto_2
    iget-object v2, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 4
    .line 5
    array-length v3, v2

    .line 6
    if-ge v1, v3, :cond_29

    .line 7
    .line 8
    aget-object v2, v2, v1

    .line 9
    .line 10
    move v3, v0

    .line 11
    :goto_a
    const/16 v4, 0x100

    .line 12
    .line 13
    if-ge v3, v4, :cond_23

    .line 14
    .line 15
    iget-object v4, v2, Lcom/kousei/framework/k3;->g:Ljava/lang/Object;

    .line 16
    .line 17
    check-cast v4, [I

    .line 18
    .line 19
    aget v5, v4, v3

    .line 20
    .line 21
    const/high16 v6, 0x400000

    .line 22
    .line 23
    add-int/2addr v6, v5

    .line 24
    shr-int/lit8 v6, v6, 0x17

    .line 25
    .line 26
    const v7, 0x7fe001

    .line 27
    .line 28
    .line 29
    mul-int/2addr v6, v7

    .line 30
    sub-int/2addr v5, v6

    .line 31
    aput v5, v4, v3

    .line 32
    .line 33
    add-int/lit8 v3, v3, 0x1

    .line 34
    .line 35
    goto :goto_a

    .line 36
    :cond_23
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 37
    .line 38
    .line 39
    add-int/lit8 v1, v1, 0x1

    .line 40
    .line 41
    goto :goto_2

    .line 42
    :cond_29
    return-void
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

.method public final toString()Ljava/lang/String;
    .registers 7

    .line 1
    iget v0, p0, Lcom/kousei/framework/ed;->a:I

    .line 2
    .line 3
    const-string v1, "]"

    .line 4
    .line 5
    const-string v2, ",\n"

    .line 6
    .line 7
    const-string v3, " "

    .line 8
    .line 9
    const/4 v4, 0x0

    .line 10
    iget-object p0, p0, Lcom/kousei/framework/ed;->b:[Lcom/kousei/framework/k3;

    .line 11
    .line 12
    packed-switch v0, :pswitch_data_78

    .line 13
    .line 14
    .line 15
    const-string v0, "\n["

    .line 16
    .line 17
    :goto_10
    array-length v5, p0

    .line 18
    if-ge v4, v5, :cond_40

    .line 19
    .line 20
    new-instance v5, Ljava/lang/StringBuilder;

    .line 21
    .line 22
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    .line 23
    .line 24
    .line 25
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 26
    .line 27
    .line 28
    const-string v0, "Inner Matrix "

    .line 29
    .line 30
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 31
    .line 32
    .line 33
    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 34
    .line 35
    .line 36
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 37
    .line 38
    .line 39
    aget-object v0, p0, v4

    .line 40
    .line 41
    invoke-virtual {v0}, Lcom/kousei/framework/k3;->toString()Ljava/lang/String;

    .line 42
    .line 43
    .line 44
    move-result-object v0

    .line 45
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 46
    .line 47
    .line 48
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 49
    .line 50
    .line 51
    move-result-object v0

    .line 52
    array-length v5, p0

    .line 53
    add-int/lit8 v5, v5, -0x1

    .line 54
    .line 55
    if-ne v4, v5, :cond_39

    .line 56
    .line 57
    goto :goto_3d

    .line 58
    :cond_39
    invoke-virtual {v0, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 59
    .line 60
    .line 61
    move-result-object v0

    .line 62
    :goto_3d
    add-int/lit8 v4, v4, 0x1

    .line 63
    .line 64
    goto :goto_10

    .line 65
    :cond_40
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 66
    .line 67
    .line 68
    move-result-object p0

    .line 69
    return-object p0

    .line 70
    :pswitch_45
    const-string v0, "["

    .line 71
    .line 72
    :goto_47
    array-length v5, p0

    .line 73
    if-ge v4, v5, :cond_72

    .line 74
    .line 75
    new-instance v5, Ljava/lang/StringBuilder;

    .line 76
    .line 77
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    .line 78
    .line 79
    .line 80
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 81
    .line 82
    .line 83
    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 84
    .line 85
    .line 86
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 87
    .line 88
    .line 89
    aget-object v0, p0, v4

    .line 90
    .line 91
    invoke-virtual {v0}, Lcom/kousei/framework/k3;->toString()Ljava/lang/String;

    .line 92
    .line 93
    .line 94
    move-result-object v0

    .line 95
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 96
    .line 97
    .line 98
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 99
    .line 100
    .line 101
    move-result-object v0

    .line 102
    array-length v5, p0

    .line 103
    add-int/lit8 v5, v5, -0x1

    .line 104
    .line 105
    if-ne v4, v5, :cond_6b

    .line 106
    .line 107
    goto :goto_6f

    .line 108
    :cond_6b
    invoke-virtual {v0, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 109
    .line 110
    .line 111
    move-result-object v0

    .line 112
    :goto_6f
    add-int/lit8 v4, v4, 0x1

    .line 113
    .line 114
    goto :goto_47

    .line 115
    :cond_72
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 116
    .line 117
    .line 118
    move-result-object p0

    .line 119
    return-object p0

    .line 120
    nop

    .line 121
    :pswitch_data_78
    .packed-switch 0x0
        :pswitch_45
    .end packed-switch
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
