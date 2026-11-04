.class public final Lcom/kousei/framework/fb;
.super Ljava/lang/Object;


# instance fields
.field public final a:Lcom/kousei/framework/te;

.field public final b:I

.field public final c:I

.field public final d:I

.field public final e:I

.field public final f:I

.field public final g:I

.field public final h:Ljava/lang/Object;


# direct methods
.method public constructor <init>(II)V
    .registers 9

    .line 1
    packed-switch p2, :pswitch_data_d8

    .line 2
    .line 3
    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 5
    .line 6
    .line 7
    new-instance p2, Lcom/kousei/framework/te;

    .line 8
    .line 9
    const/16 v0, 0x100

    .line 10
    .line 11
    invoke-direct {p2, v0}, Lcom/kousei/framework/te;-><init>(I)V

    .line 12
    .line 13
    .line 14
    iput-object p2, p0, Lcom/kousei/framework/fb;->a:Lcom/kousei/framework/te;

    .line 15
    .line 16
    const/high16 p2, 0x20000

    .line 17
    .line 18
    const/16 v0, 0x60

    .line 19
    .line 20
    const/4 v1, 0x4

    .line 21
    const/high16 v2, 0x80000

    .line 22
    .line 23
    const/4 v3, 0x2

    .line 24
    if-eq p1, v3, :cond_44

    .line 25
    .line 26
    const/4 v4, 0x3

    .line 27
    const/4 v5, 0x5

    .line 28
    if-eq p1, v4, :cond_36

    .line 29
    .line 30
    if-ne p1, v5, :cond_2d

    .line 31
    .line 32
    const/16 p1, 0x8

    .line 33
    .line 34
    iput p1, p0, Lcom/kousei/framework/fb;->c:I

    .line 35
    .line 36
    const/4 p1, 0x7

    .line 37
    iput p1, p0, Lcom/kousei/framework/fb;->d:I

    .line 38
    .line 39
    iput v3, p0, Lcom/kousei/framework/fb;->e:I

    .line 40
    .line 41
    iput v2, p0, Lcom/kousei/framework/fb;->f:I

    .line 42
    .line 43
    :goto_2a
    iput v0, p0, Lcom/kousei/framework/fb;->b:I

    .line 44
    .line 45
    goto :goto_4d

    .line 46
    :cond_2d
    const-string p0, "The mode "

    .line 47
    .line 48
    const-string p2, "is not supported by Crystals Dilithium!"

    .line 49
    .line 50
    invoke-static {p0, p1, p2}, Lcom/kousei/framework/f;->f(Ljava/lang/String;ILjava/lang/Object;)V

    .line 51
    .line 52
    .line 53
    const/4 p0, 0x0

    .line 54
    throw p0

    .line 55
    :cond_36
    const/4 p1, 0x6

    .line 56
    iput p1, p0, Lcom/kousei/framework/fb;->c:I

    .line 57
    .line 58
    iput v5, p0, Lcom/kousei/framework/fb;->d:I

    .line 59
    .line 60
    iput v1, p0, Lcom/kousei/framework/fb;->e:I

    .line 61
    .line 62
    iput v2, p0, Lcom/kousei/framework/fb;->f:I

    .line 63
    .line 64
    const/16 p1, 0x80

    .line 65
    .line 66
    iput p1, p0, Lcom/kousei/framework/fb;->b:I

    .line 67
    .line 68
    goto :goto_4d

    .line 69
    :cond_44
    iput v1, p0, Lcom/kousei/framework/fb;->c:I

    .line 70
    .line 71
    iput v1, p0, Lcom/kousei/framework/fb;->d:I

    .line 72
    .line 73
    iput v3, p0, Lcom/kousei/framework/fb;->e:I

    .line 74
    .line 75
    iput p2, p0, Lcom/kousei/framework/fb;->f:I

    .line 76
    .line 77
    goto :goto_2a

    .line 78
    :goto_4d
    new-instance p1, Lcom/kousei/framework/zh;

    .line 79
    .line 80
    const/4 v0, 0x0

    .line 81
    invoke-direct {p1, v0}, Lcom/kousei/framework/zh;-><init>(I)V

    .line 82
    .line 83
    .line 84
    iput-object p1, p0, Lcom/kousei/framework/fb;->h:Ljava/lang/Object;

    .line 85
    .line 86
    iget p1, p0, Lcom/kousei/framework/fb;->c:I

    .line 87
    .line 88
    mul-int/lit16 p1, p1, 0x140

    .line 89
    .line 90
    add-int/lit8 p1, p1, 0x20

    .line 91
    .line 92
    iput p1, p0, Lcom/kousei/framework/fb;->g:I

    .line 93
    .line 94
    iget p0, p0, Lcom/kousei/framework/fb;->f:I

    .line 95
    .line 96
    if-ne p0, p2, :cond_62

    .line 97
    .line 98
    goto :goto_64

    .line 99
    :cond_62
    if-ne p0, v2, :cond_65

    .line 100
    .line 101
    :goto_64
    return-void

    .line 102
    :cond_65
    new-instance p0, Ljava/lang/RuntimeException;

    .line 103
    .line 104
    const-string p1, "Wrong Dilithium Gamma1!"

    .line 105
    .line 106
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 107
    .line 108
    .line 109
    throw p0

    .line 110
    :pswitch_6d
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 111
    .line 112
    .line 113
    new-instance p2, Lcom/kousei/framework/te;

    .line 114
    .line 115
    const/16 v0, 0x100

    .line 116
    .line 117
    invoke-direct {p2, v0}, Lcom/kousei/framework/te;-><init>(I)V

    .line 118
    .line 119
    .line 120
    iput-object p2, p0, Lcom/kousei/framework/fb;->a:Lcom/kousei/framework/te;

    .line 121
    .line 122
    const/high16 p2, 0x20000

    .line 123
    .line 124
    const/16 v0, 0x60

    .line 125
    .line 126
    const/4 v1, 0x4

    .line 127
    const/high16 v2, 0x80000

    .line 128
    .line 129
    const/4 v3, 0x2

    .line 130
    if-eq p1, v3, :cond_ae

    .line 131
    .line 132
    const/4 v4, 0x3

    .line 133
    const/4 v5, 0x5

    .line 134
    if-eq p1, v4, :cond_a0

    .line 135
    .line 136
    if-ne p1, v5, :cond_97

    .line 137
    .line 138
    const/16 p1, 0x8

    .line 139
    .line 140
    iput p1, p0, Lcom/kousei/framework/fb;->c:I

    .line 141
    .line 142
    const/4 p1, 0x7

    .line 143
    iput p1, p0, Lcom/kousei/framework/fb;->d:I

    .line 144
    .line 145
    iput v3, p0, Lcom/kousei/framework/fb;->e:I

    .line 146
    .line 147
    iput v2, p0, Lcom/kousei/framework/fb;->f:I

    .line 148
    .line 149
    :goto_94
    iput v0, p0, Lcom/kousei/framework/fb;->b:I

    .line 150
    .line 151
    goto :goto_b7

    .line 152
    :cond_97
    const-string p0, "The mode "

    .line 153
    .line 154
    const-string p2, "is not supported by Crystals Dilithium!"

    .line 155
    .line 156
    invoke-static {p0, p1, p2}, Lcom/kousei/framework/f;->f(Ljava/lang/String;ILjava/lang/Object;)V

    .line 157
    .line 158
    .line 159
    const/4 p0, 0x0

    .line 160
    throw p0

    .line 161
    :cond_a0
    const/4 p1, 0x6

    .line 162
    iput p1, p0, Lcom/kousei/framework/fb;->c:I

    .line 163
    .line 164
    iput v5, p0, Lcom/kousei/framework/fb;->d:I

    .line 165
    .line 166
    iput v1, p0, Lcom/kousei/framework/fb;->e:I

    .line 167
    .line 168
    iput v2, p0, Lcom/kousei/framework/fb;->f:I

    .line 169
    .line 170
    const/16 p1, 0x80

    .line 171
    .line 172
    iput p1, p0, Lcom/kousei/framework/fb;->b:I

    .line 173
    .line 174
    goto :goto_b7

    .line 175
    :cond_ae
    iput v1, p0, Lcom/kousei/framework/fb;->c:I

    .line 176
    .line 177
    iput v1, p0, Lcom/kousei/framework/fb;->d:I

    .line 178
    .line 179
    iput v3, p0, Lcom/kousei/framework/fb;->e:I

    .line 180
    .line 181
    iput p2, p0, Lcom/kousei/framework/fb;->f:I

    .line 182
    .line 183
    goto :goto_94

    .line 184
    :goto_b7
    new-instance p1, Lcom/kousei/framework/zh;

    .line 185
    .line 186
    const/4 v0, 0x1

    .line 187
    invoke-direct {p1, v0}, Lcom/kousei/framework/zh;-><init>(I)V

    .line 188
    .line 189
    .line 190
    iput-object p1, p0, Lcom/kousei/framework/fb;->h:Ljava/lang/Object;

    .line 191
    .line 192
    iget p1, p0, Lcom/kousei/framework/fb;->c:I

    .line 193
    .line 194
    mul-int/lit16 p1, p1, 0x140

    .line 195
    .line 196
    add-int/lit8 p1, p1, 0x20

    .line 197
    .line 198
    iput p1, p0, Lcom/kousei/framework/fb;->g:I

    .line 199
    .line 200
    iget p0, p0, Lcom/kousei/framework/fb;->f:I

    .line 201
    .line 202
    if-ne p0, p2, :cond_cc

    .line 203
    .line 204
    goto :goto_ce

    .line 205
    :cond_cc
    if-ne p0, v2, :cond_cf

    .line 206
    .line 207
    :goto_ce
    return-void

    .line 208
    :cond_cf
    new-instance p0, Ljava/lang/RuntimeException;

    .line 209
    .line 210
    const-string p1, "Wrong Dilithium Gamma1!"

    .line 211
    .line 212
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 213
    .line 214
    .line 215
    throw p0

    .line 216
    nop

    .line 217
    :pswitch_data_d8
    .packed-switch 0x1
        :pswitch_6d
    .end packed-switch
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
