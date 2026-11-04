.class public final Lcom/kousei/framework/q6;
.super Lcom/kousei/framework/n6;


# instance fields
.field public g:I

.field public h:I

.field public i:I

.field public j:I

.field public k:Lcom/kousei/framework/d7;


# direct methods
.method public constructor <init>(IIIILjava/math/BigInteger;Ljava/math/BigInteger;Ljava/math/BigInteger;Ljava/math/BigInteger;)V
    .registers 9

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/kousei/framework/n6;-><init>(IIII)V

    iput p1, p0, Lcom/kousei/framework/q6;->g:I

    iput p2, p0, Lcom/kousei/framework/q6;->h:I

    iput p3, p0, Lcom/kousei/framework/q6;->i:I

    iput p4, p0, Lcom/kousei/framework/q6;->j:I

    iput-object p7, p0, Lcom/kousei/framework/s6;->d:Ljava/math/BigInteger;

    iput-object p8, p0, Lcom/kousei/framework/s6;->e:Ljava/math/BigInteger;

    new-instance p1, Lcom/kousei/framework/d7;

    const/4 p2, 0x0

    const/4 p3, 0x0

    .line 1
    invoke-direct {p1, p0, p2, p2, p3}, Lcom/kousei/framework/d7;-><init>(Lcom/kousei/framework/s6;Lcom/kousei/framework/i0;Lcom/kousei/framework/i0;I)V

    .line 2
    iput-object p1, p0, Lcom/kousei/framework/q6;->k:Lcom/kousei/framework/d7;

    invoke-virtual {p0, p5}, Lcom/kousei/framework/q6;->h(Ljava/math/BigInteger;)Lcom/kousei/framework/i0;

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/s6;->b:Lcom/kousei/framework/i0;

    invoke-virtual {p0, p6}, Lcom/kousei/framework/q6;->h(Ljava/math/BigInteger;)Lcom/kousei/framework/i0;

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/s6;->c:Lcom/kousei/framework/i0;

    const/4 p1, 0x6

    iput p1, p0, Lcom/kousei/framework/s6;->f:I

    return-void
.end method

.method public constructor <init>(IILjava/math/BigInteger;Ljava/math/BigInteger;Ljava/math/BigInteger;Ljava/math/BigInteger;)V
    .registers 16

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move-object v5, p3

    move-object v6, p4

    move-object v7, p5

    move-object v8, p6

    .line 3
    invoke-direct/range {v0 .. v8}, Lcom/kousei/framework/q6;-><init>(IIIILjava/math/BigInteger;Ljava/math/BigInteger;Ljava/math/BigInteger;Ljava/math/BigInteger;)V

    return-void
.end method


# virtual methods
.method public final a()Lcom/kousei/framework/s6;
    .registers 9

    .line 1
    new-instance v0, Lcom/kousei/framework/q6;

    .line 2
    .line 3
    iget v1, p0, Lcom/kousei/framework/q6;->g:I

    .line 4
    .line 5
    iget v2, p0, Lcom/kousei/framework/q6;->h:I

    .line 6
    .line 7
    iget v3, p0, Lcom/kousei/framework/q6;->i:I

    .line 8
    .line 9
    iget v4, p0, Lcom/kousei/framework/q6;->j:I

    .line 10
    .line 11
    iget-object v5, p0, Lcom/kousei/framework/s6;->b:Lcom/kousei/framework/i0;

    .line 12
    .line 13
    iget-object v6, p0, Lcom/kousei/framework/s6;->c:Lcom/kousei/framework/i0;

    .line 14
    .line 15
    iget-object v7, p0, Lcom/kousei/framework/s6;->d:Ljava/math/BigInteger;

    .line 16
    .line 17
    iget-object p0, p0, Lcom/kousei/framework/s6;->e:Ljava/math/BigInteger;

    .line 18
    .line 19
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/kousei/framework/n6;-><init>(IIII)V

    .line 20
    .line 21
    .line 22
    iput v1, v0, Lcom/kousei/framework/q6;->g:I

    .line 23
    .line 24
    iput v2, v0, Lcom/kousei/framework/q6;->h:I

    .line 25
    .line 26
    iput v3, v0, Lcom/kousei/framework/q6;->i:I

    .line 27
    .line 28
    iput v4, v0, Lcom/kousei/framework/q6;->j:I

    .line 29
    .line 30
    iput-object v7, v0, Lcom/kousei/framework/s6;->d:Ljava/math/BigInteger;

    .line 31
    .line 32
    iput-object p0, v0, Lcom/kousei/framework/s6;->e:Ljava/math/BigInteger;

    .line 33
    .line 34
    new-instance p0, Lcom/kousei/framework/d7;

    .line 35
    .line 36
    const/4 v1, 0x0

    .line 37
    const/4 v2, 0x0

    .line 38
    invoke-direct {p0, v0, v1, v1, v2}, Lcom/kousei/framework/d7;-><init>(Lcom/kousei/framework/s6;Lcom/kousei/framework/i0;Lcom/kousei/framework/i0;I)V

    .line 39
    .line 40
    .line 41
    iput-object p0, v0, Lcom/kousei/framework/q6;->k:Lcom/kousei/framework/d7;

    .line 42
    .line 43
    iput-object v5, v0, Lcom/kousei/framework/s6;->b:Lcom/kousei/framework/i0;

    .line 44
    .line 45
    iput-object v6, v0, Lcom/kousei/framework/s6;->c:Lcom/kousei/framework/i0;

    .line 46
    .line 47
    const/4 p0, 0x6

    .line 48
    iput p0, v0, Lcom/kousei/framework/s6;->f:I

    .line 49
    .line 50
    return-object v0
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

.method public final b([Lcom/kousei/framework/c7;I)Lcom/kousei/framework/i0;
    .registers 12

    .line 1
    iget v0, p0, Lcom/kousei/framework/q6;->h:I

    .line 2
    .line 3
    iget v1, p0, Lcom/kousei/framework/q6;->j:I

    .line 4
    .line 5
    iget v2, p0, Lcom/kousei/framework/q6;->g:I

    .line 6
    .line 7
    add-int/lit8 v2, v2, 0x3f

    .line 8
    .line 9
    ushr-int/lit8 v6, v2, 0x6

    .line 10
    .line 11
    iget v2, p0, Lcom/kousei/framework/q6;->i:I

    .line 12
    .line 13
    const/4 v3, 0x2

    .line 14
    const/4 v4, 0x1

    .line 15
    const/4 v5, 0x0

    .line 16
    if-nez v2, :cond_19

    .line 17
    .line 18
    if-nez v1, :cond_19

    .line 19
    .line 20
    new-array v1, v4, [I

    .line 21
    .line 22
    aput v0, v1, v5

    .line 23
    .line 24
    move-object v8, v1

    .line 25
    goto :goto_23

    .line 26
    :cond_19
    const/4 v7, 0x3

    .line 27
    new-array v7, v7, [I

    .line 28
    .line 29
    aput v0, v7, v5

    .line 30
    .line 31
    aput v2, v7, v4

    .line 32
    .line 33
    aput v1, v7, v3

    .line 34
    .line 35
    move-object v8, v7

    .line 36
    :goto_23
    mul-int v0, p2, v6

    .line 37
    .line 38
    mul-int/2addr v0, v3

    .line 39
    new-array v7, v0, [J

    .line 40
    .line 41
    move v0, v5

    .line 42
    move v1, v0

    .line 43
    :goto_2a
    if-ge v0, p2, :cond_4b

    .line 44
    .line 45
    aget-object v2, p1, v0

    .line 46
    .line 47
    iget-object v3, v2, Lcom/kousei/framework/c7;->b:Lcom/kousei/framework/i0;

    .line 48
    .line 49
    check-cast v3, Lcom/kousei/framework/w6;

    .line 50
    .line 51
    iget-object v3, v3, Lcom/kousei/framework/w6;->j:Lcom/kousei/framework/eb;

    .line 52
    .line 53
    iget-object v3, v3, Lcom/kousei/framework/eb;->K:[J

    .line 54
    .line 55
    array-length v4, v3

    .line 56
    invoke-static {v3, v5, v7, v1, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 57
    .line 58
    .line 59
    add-int/2addr v1, v6

    .line 60
    iget-object v2, v2, Lcom/kousei/framework/c7;->c:Lcom/kousei/framework/i0;

    .line 61
    .line 62
    check-cast v2, Lcom/kousei/framework/w6;

    .line 63
    .line 64
    iget-object v2, v2, Lcom/kousei/framework/w6;->j:Lcom/kousei/framework/eb;

    .line 65
    .line 66
    iget-object v2, v2, Lcom/kousei/framework/eb;->K:[J

    .line 67
    .line 68
    array-length v3, v2

    .line 69
    invoke-static {v2, v5, v7, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 70
    .line 71
    .line 72
    add-int/2addr v1, v6

    .line 73
    add-int/lit8 v0, v0, 0x1

    .line 74
    .line 75
    goto :goto_2a

    .line 76
    :cond_4b
    new-instance v3, Lcom/kousei/framework/p6;

    .line 77
    .line 78
    move-object v4, p0

    .line 79
    move v5, p2

    .line 80
    invoke-direct/range {v3 .. v8}, Lcom/kousei/framework/p6;-><init>(Lcom/kousei/framework/q6;II[J[I)V

    .line 81
    .line 82
    .line 83
    return-object v3
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

.method public final d(Lcom/kousei/framework/i0;Lcom/kousei/framework/i0;)Lcom/kousei/framework/c7;
    .registers 5

    .line 1
    new-instance v0, Lcom/kousei/framework/d7;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, p0, p1, p2, v1}, Lcom/kousei/framework/d7;-><init>(Lcom/kousei/framework/s6;Lcom/kousei/framework/i0;Lcom/kousei/framework/i0;I)V

    .line 5
    .line 6
    .line 7
    return-object v0
    .line 8
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

.method public final h(Ljava/math/BigInteger;)Lcom/kousei/framework/i0;
    .registers 18

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    if-eqz p1, :cond_aa

    .line 5
    .line 6
    invoke-virtual/range {p1 .. p1}, Ljava/math/BigInteger;->signum()I

    .line 7
    .line 8
    .line 9
    move-result v2

    .line 10
    if-ltz v2, :cond_aa

    .line 11
    .line 12
    invoke-virtual/range {p1 .. p1}, Ljava/math/BigInteger;->bitLength()I

    .line 13
    .line 14
    .line 15
    move-result v2

    .line 16
    iget v3, v0, Lcom/kousei/framework/q6;->g:I

    .line 17
    .line 18
    if-gt v2, v3, :cond_aa

    .line 19
    .line 20
    iget v2, v0, Lcom/kousei/framework/q6;->i:I

    .line 21
    .line 22
    iget v4, v0, Lcom/kousei/framework/q6;->j:I

    .line 23
    .line 24
    or-int v5, v2, v4

    .line 25
    .line 26
    iget v0, v0, Lcom/kousei/framework/q6;->h:I

    .line 27
    .line 28
    const/4 v6, 0x2

    .line 29
    const/4 v7, 0x0

    .line 30
    const/4 v8, 0x1

    .line 31
    if-nez v5, :cond_25

    .line 32
    .line 33
    new-array v2, v8, [I

    .line 34
    .line 35
    aput v0, v2, v7

    .line 36
    .line 37
    goto :goto_2f

    .line 38
    :cond_25
    const/4 v5, 0x3

    .line 39
    new-array v5, v5, [I

    .line 40
    .line 41
    aput v0, v5, v7

    .line 42
    .line 43
    aput v2, v5, v8

    .line 44
    .line 45
    aput v4, v5, v6

    .line 46
    .line 47
    move-object v2, v5

    .line 48
    :goto_2f
    new-instance v0, Lcom/kousei/framework/w6;

    .line 49
    .line 50
    new-instance v4, Lcom/kousei/framework/eb;

    .line 51
    .line 52
    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    .line 53
    .line 54
    .line 55
    invoke-virtual/range {p1 .. p1}, Ljava/math/BigInteger;->signum()I

    .line 56
    .line 57
    .line 58
    move-result v5

    .line 59
    if-ltz v5, :cond_a4

    .line 60
    .line 61
    invoke-virtual/range {p1 .. p1}, Ljava/math/BigInteger;->signum()I

    .line 62
    .line 63
    .line 64
    move-result v1

    .line 65
    const-wide/16 v9, 0x0

    .line 66
    .line 67
    if-nez v1, :cond_4b

    .line 68
    .line 69
    new-array v1, v8, [J

    .line 70
    .line 71
    aput-wide v9, v1, v7

    .line 72
    .line 73
    iput-object v1, v4, Lcom/kousei/framework/eb;->K:[J

    .line 74
    .line 75
    goto :goto_a0

    .line 76
    :cond_4b
    invoke-virtual/range {p1 .. p1}, Ljava/math/BigInteger;->toByteArray()[B

    .line 77
    .line 78
    .line 79
    move-result-object v1

    .line 80
    array-length v5, v1

    .line 81
    aget-byte v11, v1, v7

    .line 82
    .line 83
    if-nez v11, :cond_57

    .line 84
    .line 85
    add-int/lit8 v5, v5, -0x1

    .line 86
    .line 87
    goto :goto_58

    .line 88
    :cond_57
    move v8, v7

    .line 89
    :goto_58
    add-int/lit8 v11, v5, 0x7

    .line 90
    .line 91
    const/16 v12, 0x8

    .line 92
    .line 93
    div-int/2addr v11, v12

    .line 94
    new-array v13, v11, [J

    .line 95
    .line 96
    iput-object v13, v4, Lcom/kousei/framework/eb;->K:[J

    .line 97
    .line 98
    add-int/lit8 v13, v11, -0x1

    .line 99
    .line 100
    rem-int/2addr v5, v12

    .line 101
    add-int/2addr v5, v8

    .line 102
    if-ge v8, v5, :cond_86

    .line 103
    .line 104
    move-wide v14, v9

    .line 105
    :goto_68
    if-ge v8, v5, :cond_7b

    .line 106
    .line 107
    shl-long/2addr v14, v12

    .line 108
    move/from16 p0, v6

    .line 109
    .line 110
    aget-byte v6, v1, v8

    .line 111
    .line 112
    and-int/lit16 v6, v6, 0xff

    .line 113
    .line 114
    move/from16 p1, v8

    .line 115
    .line 116
    int-to-long v7, v6

    .line 117
    or-long/2addr v14, v7

    .line 118
    add-int/lit8 v8, p1, 0x1

    .line 119
    .line 120
    move/from16 v6, p0

    .line 121
    .line 122
    const/4 v7, 0x0

    .line 123
    goto :goto_68

    .line 124
    :cond_7b
    move/from16 p0, v6

    .line 125
    .line 126
    move/from16 p1, v8

    .line 127
    .line 128
    iget-object v5, v4, Lcom/kousei/framework/eb;->K:[J

    .line 129
    .line 130
    add-int/lit8 v11, v11, -0x2

    .line 131
    .line 132
    aput-wide v14, v5, v13

    .line 133
    .line 134
    move v13, v11

    .line 135
    :cond_86
    :goto_86
    if-ltz v13, :cond_a0

    .line 136
    .line 137
    move-wide v6, v9

    .line 138
    const/4 v5, 0x0

    .line 139
    :goto_8a
    if-ge v5, v12, :cond_99

    .line 140
    .line 141
    shl-long/2addr v6, v12

    .line 142
    add-int/lit8 v11, v8, 0x1

    .line 143
    .line 144
    aget-byte v8, v1, v8

    .line 145
    .line 146
    and-int/lit16 v8, v8, 0xff

    .line 147
    .line 148
    int-to-long v14, v8

    .line 149
    or-long/2addr v6, v14

    .line 150
    add-int/lit8 v5, v5, 0x1

    .line 151
    .line 152
    move v8, v11

    .line 153
    goto :goto_8a

    .line 154
    :cond_99
    iget-object v5, v4, Lcom/kousei/framework/eb;->K:[J

    .line 155
    .line 156
    aput-wide v6, v5, v13

    .line 157
    .line 158
    add-int/lit8 v13, v13, -0x1

    .line 159
    .line 160
    goto :goto_86

    .line 161
    :cond_a0
    :goto_a0
    invoke-direct {v0, v3, v2, v4}, Lcom/kousei/framework/w6;-><init>(I[ILcom/kousei/framework/eb;)V

    .line 162
    .line 163
    .line 164
    return-object v0

    .line 165
    :cond_a4
    const-string v0, "invalid F2m field value"

    .line 166
    .line 167
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 168
    .line 169
    .line 170
    return-object v1

    .line 171
    :cond_aa
    const-string v0, "x value invalid in F2m field element"

    .line 172
    .line 173
    invoke-static {v0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 174
    .line 175
    .line 176
    return-object v1
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

.method public final i()I
    .registers 1

    .line 1
    iget p0, p0, Lcom/kousei/framework/q6;->g:I

    .line 2
    .line 3
    return p0
    .line 4
    .line 5
    .line 6
    .line 7
    .line 8
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

.method public final j()Lcom/kousei/framework/c7;
    .registers 1

    .line 1
    iget-object p0, p0, Lcom/kousei/framework/q6;->k:Lcom/kousei/framework/d7;

    .line 2
    .line 3
    return-object p0
    .line 4
    .line 5
    .line 6
    .line 7
    .line 8
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

.method public final o(I)Z
    .registers 3

    .line 1
    const/4 p0, 0x1

    .line 2
    if-eqz p1, :cond_9

    .line 3
    .line 4
    if-eq p1, p0, :cond_9

    .line 5
    .line 6
    const/4 v0, 0x6

    .line 7
    if-eq p1, v0, :cond_9

    .line 8
    .line 9
    const/4 p0, 0x0

    .line 10
    :cond_9
    return p0
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
