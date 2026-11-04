.class public final Lcom/kousei/framework/td;
.super Ljava/lang/Object;


# static fields
.field public static final d:Ljava/math/BigInteger;


# instance fields
.field public a:Lcom/kousei/framework/ud;

.field public b:Lcom/kousei/framework/xd;

.field public c:Ljava/security/SecureRandom;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 1
    const-wide/16 v0, 0x1

    .line 2
    .line 3
    invoke-static {v0, v1}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    sput-object v0, Lcom/kousei/framework/td;->d:Ljava/math/BigInteger;

    .line 8
    .line 9
    return-void
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


# virtual methods
.method public final a(I[B)[B
    .registers 9

    .line 1
    iget-object v0, p0, Lcom/kousei/framework/td;->a:Lcom/kousei/framework/ud;

    .line 2
    .line 3
    iget-object v1, p0, Lcom/kousei/framework/td;->b:Lcom/kousei/framework/xd;

    .line 4
    .line 5
    if-eqz v1, :cond_c8

    .line 6
    .line 7
    invoke-virtual {v0}, Lcom/kousei/framework/ud;->a()I

    .line 8
    .line 9
    .line 10
    move-result v1

    .line 11
    const/4 v2, 0x1

    .line 12
    add-int/2addr v1, v2

    .line 13
    const-string v3, "input too large for RSA cipher."

    .line 14
    .line 15
    if-gt p1, v1, :cond_c2

    .line 16
    .line 17
    invoke-virtual {v0}, Lcom/kousei/framework/ud;->a()I

    .line 18
    .line 19
    .line 20
    move-result v1

    .line 21
    add-int/2addr v1, v2

    .line 22
    if-ne p1, v1, :cond_22

    .line 23
    .line 24
    iget-boolean v1, v0, Lcom/kousei/framework/ud;->b:Z

    .line 25
    .line 26
    if-eqz v1, :cond_1c

    .line 27
    .line 28
    goto :goto_22

    .line 29
    :cond_1c
    new-instance p0, Lcom/kousei/framework/t5;

    .line 30
    .line 31
    invoke-direct {p0, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 32
    .line 33
    .line 34
    throw p0

    .line 35
    :cond_22
    :goto_22
    array-length v1, p2

    .line 36
    const/4 v4, 0x0

    .line 37
    if-eq p1, v1, :cond_2c

    .line 38
    .line 39
    new-array v1, p1, [B

    .line 40
    .line 41
    invoke-static {p2, v4, v1, v4, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 42
    .line 43
    .line 44
    move-object p2, v1

    .line 45
    :cond_2c
    new-instance p1, Ljava/math/BigInteger;

    .line 46
    .line 47
    invoke-direct {p1, v2, p2}, Ljava/math/BigInteger;-><init>(I[B)V

    .line 48
    .line 49
    .line 50
    iget-object p2, v0, Lcom/kousei/framework/ud;->a:Lcom/kousei/framework/xd;

    .line 51
    .line 52
    iget-object p2, p2, Lcom/kousei/framework/xd;->L:Ljava/math/BigInteger;

    .line 53
    .line 54
    invoke-virtual {p1, p2}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    .line 55
    .line 56
    .line 57
    move-result p2

    .line 58
    if-gez p2, :cond_bc

    .line 59
    .line 60
    iget-object p2, p0, Lcom/kousei/framework/td;->b:Lcom/kousei/framework/xd;

    .line 61
    .line 62
    instance-of v1, p2, Lcom/kousei/framework/yd;

    .line 63
    .line 64
    if-eqz v1, :cond_72

    .line 65
    .line 66
    check-cast p2, Lcom/kousei/framework/yd;

    .line 67
    .line 68
    iget-object v1, p2, Lcom/kousei/framework/yd;->P:Ljava/math/BigInteger;

    .line 69
    .line 70
    if-eqz v1, :cond_72

    .line 71
    .line 72
    iget-object p2, p2, Lcom/kousei/framework/xd;->L:Ljava/math/BigInteger;

    .line 73
    .line 74
    sget-object v3, Lcom/kousei/framework/td;->d:Ljava/math/BigInteger;

    .line 75
    .line 76
    invoke-virtual {p2, v3}, Ljava/math/BigInteger;->subtract(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 77
    .line 78
    .line 79
    move-result-object v5

    .line 80
    iget-object p0, p0, Lcom/kousei/framework/td;->c:Ljava/security/SecureRandom;

    .line 81
    .line 82
    invoke-static {v3, v5, p0}, Lcom/kousei/framework/v2;->c(Ljava/math/BigInteger;Ljava/math/BigInteger;Ljava/security/SecureRandom;)Ljava/math/BigInteger;

    .line 83
    .line 84
    .line 85
    move-result-object p0

    .line 86
    invoke-virtual {p0, v1, p2}, Ljava/math/BigInteger;->modPow(Ljava/math/BigInteger;Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 87
    .line 88
    .line 89
    move-result-object v1

    .line 90
    invoke-static {p2, p0}, Lcom/kousei/framework/v2;->e(Ljava/math/BigInteger;Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 91
    .line 92
    .line 93
    move-result-object p0

    .line 94
    invoke-virtual {v1, p1}, Ljava/math/BigInteger;->multiply(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 95
    .line 96
    .line 97
    move-result-object p1

    .line 98
    invoke-virtual {p1, p2}, Ljava/math/BigInteger;->mod(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 99
    .line 100
    .line 101
    move-result-object p1

    .line 102
    invoke-virtual {v0, p1}, Lcom/kousei/framework/ud;->c(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 103
    .line 104
    .line 105
    move-result-object p1

    .line 106
    invoke-virtual {p0, p1}, Ljava/math/BigInteger;->multiply(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 107
    .line 108
    .line 109
    move-result-object p0

    .line 110
    invoke-virtual {p0, p2}, Ljava/math/BigInteger;->mod(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 111
    .line 112
    .line 113
    move-result-object p0

    .line 114
    goto :goto_76

    .line 115
    :cond_72
    invoke-virtual {v0, p1}, Lcom/kousei/framework/ud;->c(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    .line 116
    .line 117
    .line 118
    move-result-object p0

    .line 119
    :goto_76
    invoke-virtual {p0}, Ljava/math/BigInteger;->toByteArray()[B

    .line 120
    .line 121
    .line 122
    move-result-object p0

    .line 123
    iget-boolean p1, v0, Lcom/kousei/framework/ud;->b:Z

    .line 124
    .line 125
    if-eqz p1, :cond_a6

    .line 126
    .line 127
    aget-byte p1, p0, v4

    .line 128
    .line 129
    if-nez p1, :cond_91

    .line 130
    .line 131
    array-length p1, p0

    .line 132
    invoke-virtual {v0}, Lcom/kousei/framework/ud;->b()I

    .line 133
    .line 134
    .line 135
    move-result p2

    .line 136
    if-le p1, p2, :cond_91

    .line 137
    .line 138
    array-length p1, p0

    .line 139
    sub-int/2addr p1, v2

    .line 140
    new-array p2, p1, [B

    .line 141
    .line 142
    invoke-static {p0, v2, p2, v4, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 143
    .line 144
    .line 145
    return-object p2

    .line 146
    :cond_91
    array-length p1, p0

    .line 147
    invoke-virtual {v0}, Lcom/kousei/framework/ud;->b()I

    .line 148
    .line 149
    .line 150
    move-result p2

    .line 151
    if-ge p1, p2, :cond_a5

    .line 152
    .line 153
    invoke-virtual {v0}, Lcom/kousei/framework/ud;->b()I

    .line 154
    .line 155
    .line 156
    move-result p1

    .line 157
    new-array p2, p1, [B

    .line 158
    .line 159
    array-length v0, p0

    .line 160
    sub-int/2addr p1, v0

    .line 161
    array-length v0, p0

    .line 162
    invoke-static {p0, v4, p2, p1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 163
    .line 164
    .line 165
    return-object p2

    .line 166
    :cond_a5
    return-object p0

    .line 167
    :cond_a6
    aget-byte p1, p0, v4

    .line 168
    .line 169
    if-nez p1, :cond_b2

    .line 170
    .line 171
    array-length p1, p0

    .line 172
    sub-int/2addr p1, v2

    .line 173
    new-array p2, p1, [B

    .line 174
    .line 175
    invoke-static {p0, v2, p2, v4, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 176
    .line 177
    .line 178
    goto :goto_b8

    .line 179
    :cond_b2
    array-length p1, p0

    .line 180
    new-array p2, p1, [B

    .line 181
    .line 182
    invoke-static {p0, v4, p2, v4, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 183
    .line 184
    .line 185
    :goto_b8
    invoke-static {p0, v4}, Ljava/util/Arrays;->fill([BB)V

    .line 186
    .line 187
    .line 188
    return-object p2

    .line 189
    :cond_bc
    new-instance p0, Lcom/kousei/framework/t5;

    .line 190
    .line 191
    invoke-direct {p0, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 192
    .line 193
    .line 194
    throw p0

    .line 195
    :cond_c2
    new-instance p0, Lcom/kousei/framework/t5;

    .line 196
    .line 197
    invoke-direct {p0, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 198
    .line 199
    .line 200
    throw p0

    .line 201
    :cond_c8
    const-string p0, "RSA engine not initialised"

    .line 202
    .line 203
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 204
    .line 205
    .line 206
    const/4 p0, 0x0

    .line 207
    return-object p0
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
