.class public final Lcom/kousei/framework/z1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field public final transient K:Lcom/kousei/framework/i7;

.field public final L:I

.field public final M:Ljava/util/ArrayList;

.field public final N:I

.field public final O:Ljava/util/ArrayList;

.field public final P:Ljava/util/TreeMap;

.field public final Q:Ljava/util/Stack;

.field public final R:Ljava/util/TreeMap;

.field public S:I

.field public final transient T:I


# direct methods
.method public constructor <init>(Lcom/kousei/framework/i7;III)V
    .registers 6

    .line 210
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    iput p2, p0, Lcom/kousei/framework/z1;->L:I

    iput p4, p0, Lcom/kousei/framework/z1;->T:I

    iput p3, p0, Lcom/kousei/framework/z1;->N:I

    if-gt p3, p2, :cond_4c

    const/4 p1, 0x2

    if-lt p3, p1, :cond_4c

    sub-int/2addr p2, p3

    rem-int/lit8 p1, p2, 0x2

    if-nez p1, :cond_4c

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    new-instance p1, Ljava/util/TreeMap;

    invoke-direct {p1}, Ljava/util/TreeMap;-><init>()V

    iput-object p1, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    new-instance p1, Ljava/util/Stack;

    invoke-direct {p1}, Ljava/util/Stack;-><init>()V

    iput-object p1, p0, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    const/4 p1, 0x0

    move p3, p1

    :goto_33
    if-ge p3, p2, :cond_42

    iget-object p4, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    new-instance v0, Lcom/kousei/framework/b2;

    invoke-direct {v0, p3}, Lcom/kousei/framework/b2;-><init>(I)V

    invoke-virtual {p4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x1

    goto :goto_33

    :cond_42
    new-instance p2, Ljava/util/TreeMap;

    invoke-direct {p2}, Ljava/util/TreeMap;-><init>()V

    iput-object p2, p0, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    iput p1, p0, Lcom/kousei/framework/z1;->S:I

    return-void

    :cond_4c
    const-string p0, "illegal value for BDS parameter k"

    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    throw p0
.end method

.method public constructor <init>(Lcom/kousei/framework/tj;[B[BLcom/kousei/framework/rc;)V
    .registers 9

    .line 211
    new-instance v0, Lcom/kousei/framework/i7;

    .line 212
    iget-object v1, p1, Lcom/kousei/framework/tj;->g:Lcom/kousei/framework/ri;

    .line 213
    invoke-direct {v0, v1}, Lcom/kousei/framework/i7;-><init>(Lcom/kousei/framework/ri;)V

    .line 214
    iget v1, p1, Lcom/kousei/framework/tj;->b:I

    .line 215
    iget p1, p1, Lcom/kousei/framework/tj;->c:I

    const/4 v2, 0x1

    shl-int v3, v2, v1

    sub-int/2addr v3, v2

    .line 216
    invoke-direct {p0, v0, v1, p1, v3}, Lcom/kousei/framework/z1;-><init>(Lcom/kousei/framework/i7;III)V

    invoke-virtual {p0, p2, p3, p4}, Lcom/kousei/framework/z1;->a([B[BLcom/kousei/framework/rc;)V

    return-void
.end method

.method public constructor <init>(Lcom/kousei/framework/z1;)V
    .registers 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/kousei/framework/i7;

    iget-object v1, p1, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    .line 206
    iget-object v1, v1, Lcom/kousei/framework/i7;->a:Ljava/lang/Object;

    check-cast v1, Lcom/kousei/framework/ri;

    .line 207
    invoke-direct {v0, v1}, Lcom/kousei/framework/i7;-><init>(Lcom/kousei/framework/ri;)V

    iput-object v0, p0, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    iget v0, p1, Lcom/kousei/framework/z1;->L:I

    iput v0, p0, Lcom/kousei/framework/z1;->L:I

    iget v0, p1, Lcom/kousei/framework/z1;->N:I

    iput v0, p0, Lcom/kousei/framework/z1;->N:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    iget-object v1, p1, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    iget-object v0, p1, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    invoke-virtual {v0}, Ljava/util/TreeMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_35
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_55

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    iget-object v2, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    iget-object v3, p1, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    invoke-virtual {v3, v1}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/LinkedList;

    invoke-virtual {v3}, Ljava/util/LinkedList;->clone()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/LinkedList;

    invoke-virtual {v2, v1, v3}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_35

    :cond_55
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    iget-object v1, p1, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    invoke-virtual {v0, v1}, Ljava/util/AbstractCollection;->addAll(Ljava/util/Collection;)Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    iget-object v0, p1, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6e
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_84

    iget-object v1, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/kousei/framework/b2;

    invoke-virtual {v2}, Lcom/kousei/framework/b2;->a()Lcom/kousei/framework/b2;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_6e

    :cond_84
    new-instance v0, Ljava/util/TreeMap;

    iget-object v1, p1, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    invoke-direct {v0, v1}, Ljava/util/TreeMap;-><init>(Ljava/util/Map;)V

    iput-object v0, p0, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    iget v0, p1, Lcom/kousei/framework/z1;->S:I

    iput v0, p0, Lcom/kousei/framework/z1;->S:I

    iget p1, p1, Lcom/kousei/framework/z1;->T:I

    iput p1, p0, Lcom/kousei/framework/z1;->T:I

    return-void
.end method

.method public constructor <init>(Lcom/kousei/framework/z1;Lcom/kousei/framework/v;)V
    .registers 6

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    new-instance v0, Lcom/kousei/framework/i7;

    .line 5
    .line 6
    new-instance v1, Lcom/kousei/framework/ri;

    .line 7
    .line 8
    invoke-direct {v1, p2}, Lcom/kousei/framework/ri;-><init>(Lcom/kousei/framework/v;)V

    .line 9
    .line 10
    .line 11
    invoke-direct {v0, v1}, Lcom/kousei/framework/i7;-><init>(Lcom/kousei/framework/ri;)V

    .line 12
    .line 13
    .line 14
    iput-object v0, p0, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    .line 15
    .line 16
    iget p2, p1, Lcom/kousei/framework/z1;->L:I

    .line 17
    .line 18
    iput p2, p0, Lcom/kousei/framework/z1;->L:I

    .line 19
    .line 20
    iget p2, p1, Lcom/kousei/framework/z1;->N:I

    .line 21
    .line 22
    iput p2, p0, Lcom/kousei/framework/z1;->N:I

    .line 23
    .line 24
    new-instance p2, Ljava/util/ArrayList;

    .line 25
    .line 26
    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    .line 27
    .line 28
    .line 29
    iput-object p2, p0, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    .line 30
    .line 31
    iget-object v0, p1, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    .line 32
    .line 33
    invoke-virtual {p2, v0}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 34
    .line 35
    .line 36
    new-instance p2, Ljava/util/TreeMap;

    .line 37
    .line 38
    invoke-direct {p2}, Ljava/util/TreeMap;-><init>()V

    .line 39
    .line 40
    .line 41
    iput-object p2, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    .line 42
    .line 43
    iget-object p2, p1, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    .line 44
    .line 45
    invoke-virtual {p2}, Ljava/util/TreeMap;->keySet()Ljava/util/Set;

    .line 46
    .line 47
    .line 48
    move-result-object p2

    .line 49
    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    .line 50
    .line 51
    .line 52
    move-result-object p2

    .line 53
    :goto_34
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    .line 54
    .line 55
    .line 56
    move-result v0

    .line 57
    if-eqz v0, :cond_54

    .line 58
    .line 59
    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 60
    .line 61
    .line 62
    move-result-object v0

    .line 63
    check-cast v0, Ljava/lang/Integer;

    .line 64
    .line 65
    iget-object v1, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    .line 66
    .line 67
    iget-object v2, p1, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    .line 68
    .line 69
    invoke-virtual {v2, v0}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 70
    .line 71
    .line 72
    move-result-object v2

    .line 73
    check-cast v2, Ljava/util/LinkedList;

    .line 74
    .line 75
    invoke-virtual {v2}, Ljava/util/LinkedList;->clone()Ljava/lang/Object;

    .line 76
    .line 77
    .line 78
    move-result-object v2

    .line 79
    check-cast v2, Ljava/util/LinkedList;

    .line 80
    .line 81
    invoke-virtual {v1, v0, v2}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 82
    .line 83
    .line 84
    goto :goto_34

    .line 85
    :cond_54
    new-instance p2, Ljava/util/Stack;

    .line 86
    .line 87
    invoke-direct {p2}, Ljava/util/Stack;-><init>()V

    .line 88
    .line 89
    .line 90
    iput-object p2, p0, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    .line 91
    .line 92
    iget-object v0, p1, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    .line 93
    .line 94
    invoke-virtual {p2, v0}, Ljava/util/AbstractCollection;->addAll(Ljava/util/Collection;)Z

    .line 95
    .line 96
    .line 97
    new-instance p2, Ljava/util/ArrayList;

    .line 98
    .line 99
    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    .line 100
    .line 101
    .line 102
    iput-object p2, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    .line 103
    .line 104
    iget-object p2, p1, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    .line 105
    .line 106
    invoke-virtual {p2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 107
    .line 108
    .line 109
    move-result-object p2

    .line 110
    :goto_6d
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    .line 111
    .line 112
    .line 113
    move-result v0

    .line 114
    if-eqz v0, :cond_83

    .line 115
    .line 116
    iget-object v0, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    .line 117
    .line 118
    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 119
    .line 120
    .line 121
    move-result-object v1

    .line 122
    check-cast v1, Lcom/kousei/framework/b2;

    .line 123
    .line 124
    invoke-virtual {v1}, Lcom/kousei/framework/b2;->a()Lcom/kousei/framework/b2;

    .line 125
    .line 126
    .line 127
    move-result-object v1

    .line 128
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 129
    .line 130
    .line 131
    goto :goto_6d

    .line 132
    :cond_83
    new-instance p2, Ljava/util/TreeMap;

    .line 133
    .line 134
    iget-object v0, p1, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    .line 135
    .line 136
    invoke-direct {p2, v0}, Ljava/util/TreeMap;-><init>(Ljava/util/Map;)V

    .line 137
    .line 138
    .line 139
    iput-object p2, p0, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    .line 140
    .line 141
    iget p2, p1, Lcom/kousei/framework/z1;->S:I

    .line 142
    .line 143
    iput p2, p0, Lcom/kousei/framework/z1;->S:I

    .line 144
    .line 145
    iget p1, p1, Lcom/kousei/framework/z1;->T:I

    .line 146
    .line 147
    iput p1, p0, Lcom/kousei/framework/z1;->T:I

    .line 148
    .line 149
    iget-object p1, p0, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    .line 150
    .line 151
    const/4 v0, 0x0

    .line 152
    if-eqz p1, :cond_c7

    .line 153
    .line 154
    iget-object p1, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    .line 155
    .line 156
    if-eqz p1, :cond_c1

    .line 157
    .line 158
    iget-object p1, p0, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    .line 159
    .line 160
    if-eqz p1, :cond_bb

    .line 161
    .line 162
    iget-object p1, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    .line 163
    .line 164
    if-eqz p1, :cond_b5

    .line 165
    .line 166
    iget p0, p0, Lcom/kousei/framework/z1;->L:I

    .line 167
    .line 168
    int-to-long p1, p2

    .line 169
    invoke-static {p0, p1, p2}, Lcom/kousei/framework/xc;->L(IJ)Z

    .line 170
    .line 171
    .line 172
    move-result p0

    .line 173
    if-eqz p0, :cond_af

    .line 174
    .line 175
    return-void

    .line 176
    :cond_af
    const-string p0, "index in BDS state out of bounds"

    .line 177
    .line 178
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 179
    .line 180
    .line 181
    throw v0

    .line 182
    :cond_b5
    const-string p0, "treeHashInstances == null"

    .line 183
    .line 184
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 185
    .line 186
    .line 187
    throw v0

    .line 188
    :cond_bb
    const-string p0, "stack == null"

    .line 189
    .line 190
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 191
    .line 192
    .line 193
    throw v0

    .line 194
    :cond_c1
    const-string p0, "retain == null"

    .line 195
    .line 196
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 197
    .line 198
    .line 199
    throw v0

    .line 200
    :cond_c7
    const-string p0, "authenticationPath == null"

    .line 201
    .line 202
    invoke-static {p0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 203
    .line 204
    .line 205
    throw v0
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

.method public constructor <init>(Lcom/kousei/framework/z1;[B[BLcom/kousei/framework/rc;)V
    .registers 9

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/kousei/framework/i7;

    iget-object v1, p1, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    .line 208
    iget-object v1, v1, Lcom/kousei/framework/i7;->a:Ljava/lang/Object;

    check-cast v1, Lcom/kousei/framework/ri;

    .line 209
    invoke-direct {v0, v1}, Lcom/kousei/framework/i7;-><init>(Lcom/kousei/framework/ri;)V

    iput-object v0, p0, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    iget v0, p1, Lcom/kousei/framework/z1;->L:I

    iput v0, p0, Lcom/kousei/framework/z1;->L:I

    iget v0, p1, Lcom/kousei/framework/z1;->N:I

    iput v0, p0, Lcom/kousei/framework/z1;->N:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    iget-object v1, p1, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    iget-object v0, p1, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    invoke-virtual {v0}, Ljava/util/TreeMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_35
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_55

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    iget-object v2, p0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    iget-object v3, p1, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    invoke-virtual {v3, v1}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/LinkedList;

    invoke-virtual {v3}, Ljava/util/LinkedList;->clone()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/LinkedList;

    invoke-virtual {v2, v1, v3}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_35

    :cond_55
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    iget-object v1, p1, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    invoke-virtual {v0, v1}, Ljava/util/AbstractCollection;->addAll(Ljava/util/Collection;)Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    iget-object v0, p1, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6e
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_84

    iget-object v1, p0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/kousei/framework/b2;

    invoke-virtual {v2}, Lcom/kousei/framework/b2;->a()Lcom/kousei/framework/b2;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_6e

    :cond_84
    new-instance v0, Ljava/util/TreeMap;

    iget-object v1, p1, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    invoke-direct {v0, v1}, Ljava/util/TreeMap;-><init>(Ljava/util/Map;)V

    iput-object v0, p0, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    iget v0, p1, Lcom/kousei/framework/z1;->S:I

    iput v0, p0, Lcom/kousei/framework/z1;->S:I

    iget p1, p1, Lcom/kousei/framework/z1;->T:I

    iput p1, p0, Lcom/kousei/framework/z1;->T:I

    invoke-virtual {p0, p2, p3, p4}, Lcom/kousei/framework/z1;->b([B[BLcom/kousei/framework/rc;)V

    return-void
.end method


# virtual methods
.method public final a([B[BLcom/kousei/framework/rc;)V
    .registers 21

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p3

    .line 4
    .line 5
    iget-wide v2, v1, Lcom/kousei/framework/jj;->b:J

    .line 6
    .line 7
    iget v4, v1, Lcom/kousei/framework/jj;->a:I

    .line 8
    .line 9
    new-instance v5, Lcom/kousei/framework/ya;

    .line 10
    .line 11
    const/4 v6, 0x0

    .line 12
    invoke-direct {v5, v6}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 13
    .line 14
    .line 15
    iput v4, v5, Lcom/kousei/framework/jj;->c:I

    .line 16
    .line 17
    iput-wide v2, v5, Lcom/kousei/framework/jj;->b:J

    .line 18
    .line 19
    new-instance v7, Lcom/kousei/framework/za;

    .line 20
    .line 21
    invoke-direct {v7, v5}, Lcom/kousei/framework/za;-><init>(Lcom/kousei/framework/ya;)V

    .line 22
    .line 23
    .line 24
    new-instance v5, Lcom/kousei/framework/f9;

    .line 25
    .line 26
    invoke-direct {v5}, Lcom/kousei/framework/f9;-><init>()V

    .line 27
    .line 28
    .line 29
    iput v4, v5, Lcom/kousei/framework/jj;->c:I

    .line 30
    .line 31
    iput-wide v2, v5, Lcom/kousei/framework/jj;->b:J

    .line 32
    .line 33
    new-instance v2, Lcom/kousei/framework/g9;

    .line 34
    .line 35
    invoke-direct {v2, v5}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 36
    .line 37
    .line 38
    move v3, v6

    .line 39
    :goto_26
    const/4 v4, 0x1

    .line 40
    iget v5, v0, Lcom/kousei/framework/z1;->L:I

    .line 41
    .line 42
    shl-int v8, v4, v5

    .line 43
    .line 44
    iget-object v9, v0, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    .line 45
    .line 46
    if-ge v3, v8, :cond_17e

    .line 47
    .line 48
    new-instance v8, Lcom/kousei/framework/ya;

    .line 49
    .line 50
    invoke-direct {v8, v4}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 51
    .line 52
    .line 53
    iget v10, v1, Lcom/kousei/framework/jj;->a:I

    .line 54
    .line 55
    iput v10, v8, Lcom/kousei/framework/jj;->c:I

    .line 56
    .line 57
    iget-wide v10, v1, Lcom/kousei/framework/jj;->b:J

    .line 58
    .line 59
    iput-wide v10, v8, Lcom/kousei/framework/jj;->b:J

    .line 60
    .line 61
    iput v3, v8, Lcom/kousei/framework/ya;->e:I

    .line 62
    .line 63
    iget v10, v1, Lcom/kousei/framework/rc;->f:I

    .line 64
    .line 65
    iput v10, v8, Lcom/kousei/framework/ya;->f:I

    .line 66
    .line 67
    iget v10, v1, Lcom/kousei/framework/rc;->g:I

    .line 68
    .line 69
    iput v10, v8, Lcom/kousei/framework/ya;->g:I

    .line 70
    .line 71
    iget v1, v1, Lcom/kousei/framework/jj;->d:I

    .line 72
    .line 73
    iput v1, v8, Lcom/kousei/framework/jj;->d:I

    .line 74
    .line 75
    new-instance v1, Lcom/kousei/framework/rc;

    .line 76
    .line 77
    invoke-direct {v1, v8}, Lcom/kousei/framework/rc;-><init>(Lcom/kousei/framework/ya;)V

    .line 78
    .line 79
    .line 80
    iget-object v8, v0, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    .line 81
    .line 82
    move-object/from16 v10, p2

    .line 83
    .line 84
    invoke-virtual {v8, v10, v1}, Lcom/kousei/framework/i7;->c([BLcom/kousei/framework/rc;)[B

    .line 85
    .line 86
    .line 87
    move-result-object v11

    .line 88
    move-object/from16 v12, p1

    .line 89
    .line 90
    invoke-virtual {v8, v11, v12}, Lcom/kousei/framework/i7;->d([B[B)V

    .line 91
    .line 92
    .line 93
    invoke-virtual {v8, v1}, Lcom/kousei/framework/i7;->b(Lcom/kousei/framework/rc;)Lcom/kousei/framework/y;

    .line 94
    .line 95
    .line 96
    move-result-object v11

    .line 97
    new-instance v13, Lcom/kousei/framework/ya;

    .line 98
    .line 99
    invoke-direct {v13, v6}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 100
    .line 101
    .line 102
    iget v14, v7, Lcom/kousei/framework/jj;->a:I

    .line 103
    .line 104
    iput v14, v13, Lcom/kousei/framework/jj;->c:I

    .line 105
    .line 106
    iget-wide v14, v7, Lcom/kousei/framework/jj;->b:J

    .line 107
    .line 108
    iput-wide v14, v13, Lcom/kousei/framework/jj;->b:J

    .line 109
    .line 110
    iput v3, v13, Lcom/kousei/framework/ya;->e:I

    .line 111
    .line 112
    iget v14, v7, Lcom/kousei/framework/za;->f:I

    .line 113
    .line 114
    iput v14, v13, Lcom/kousei/framework/ya;->f:I

    .line 115
    .line 116
    iget v14, v7, Lcom/kousei/framework/za;->g:I

    .line 117
    .line 118
    iput v14, v13, Lcom/kousei/framework/ya;->g:I

    .line 119
    .line 120
    iget v7, v7, Lcom/kousei/framework/jj;->d:I

    .line 121
    .line 122
    iput v7, v13, Lcom/kousei/framework/jj;->d:I

    .line 123
    .line 124
    new-instance v7, Lcom/kousei/framework/za;

    .line 125
    .line 126
    invoke-direct {v7, v13}, Lcom/kousei/framework/za;-><init>(Lcom/kousei/framework/ya;)V

    .line 127
    .line 128
    .line 129
    invoke-static {v8, v11, v7}, Lcom/kousei/framework/xc;->M(Lcom/kousei/framework/i7;Lcom/kousei/framework/y;Lcom/kousei/framework/za;)Lcom/kousei/framework/sj;

    .line 130
    .line 131
    .line 132
    move-result-object v11

    .line 133
    new-instance v13, Lcom/kousei/framework/f9;

    .line 134
    .line 135
    invoke-direct {v13}, Lcom/kousei/framework/f9;-><init>()V

    .line 136
    .line 137
    .line 138
    iget v14, v2, Lcom/kousei/framework/jj;->a:I

    .line 139
    .line 140
    iput v14, v13, Lcom/kousei/framework/jj;->c:I

    .line 141
    .line 142
    iget-wide v14, v2, Lcom/kousei/framework/jj;->b:J

    .line 143
    .line 144
    iput-wide v14, v13, Lcom/kousei/framework/jj;->b:J

    .line 145
    .line 146
    iput v3, v13, Lcom/kousei/framework/f9;->f:I

    .line 147
    .line 148
    iget v2, v2, Lcom/kousei/framework/jj;->d:I

    .line 149
    .line 150
    iput v2, v13, Lcom/kousei/framework/jj;->d:I

    .line 151
    .line 152
    new-instance v2, Lcom/kousei/framework/g9;

    .line 153
    .line 154
    invoke-direct {v2, v13}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 155
    .line 156
    .line 157
    :goto_9c
    invoke-virtual {v9}, Ljava/util/AbstractCollection;->isEmpty()Z

    .line 158
    .line 159
    .line 160
    move-result v13

    .line 161
    if-nez v13, :cond_172

    .line 162
    .line 163
    invoke-virtual {v9}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    .line 164
    .line 165
    .line 166
    move-result-object v13

    .line 167
    check-cast v13, Lcom/kousei/framework/sj;

    .line 168
    .line 169
    iget v13, v13, Lcom/kousei/framework/sj;->K:I

    .line 170
    .line 171
    iget v14, v11, Lcom/kousei/framework/sj;->K:I

    .line 172
    .line 173
    if-ne v13, v14, :cond_172

    .line 174
    .line 175
    shl-int v13, v4, v14

    .line 176
    .line 177
    div-int v13, v3, v13

    .line 178
    .line 179
    if-ne v13, v4, :cond_b9

    .line 180
    .line 181
    iget-object v15, v0, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    .line 182
    .line 183
    invoke-virtual {v15, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 184
    .line 185
    .line 186
    :cond_b9
    iget v15, v0, Lcom/kousei/framework/z1;->N:I

    .line 187
    .line 188
    const/4 v6, 0x3

    .line 189
    if-ne v13, v6, :cond_db

    .line 190
    .line 191
    sub-int v6, v5, v15

    .line 192
    .line 193
    if-ge v14, v6, :cond_d8

    .line 194
    .line 195
    iget-object v6, v0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    .line 196
    .line 197
    invoke-virtual {v6, v14}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 198
    .line 199
    .line 200
    move-result-object v6

    .line 201
    check-cast v6, Lcom/kousei/framework/b2;

    .line 202
    .line 203
    iput-object v11, v6, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 204
    .line 205
    iput v14, v6, Lcom/kousei/framework/b2;->M:I

    .line 206
    .line 207
    move-object/from16 v16, v1

    .line 208
    .line 209
    iget v1, v6, Lcom/kousei/framework/b2;->L:I

    .line 210
    .line 211
    if-ne v14, v1, :cond_d6

    .line 212
    .line 213
    iput-boolean v4, v6, Lcom/kousei/framework/b2;->P:Z

    .line 214
    .line 215
    :cond_d6
    :goto_d6
    const/4 v1, 0x3

    .line 216
    goto :goto_de

    .line 217
    :cond_d8
    move-object/from16 v16, v1

    .line 218
    .line 219
    goto :goto_d6

    .line 220
    :cond_db
    move-object/from16 v16, v1

    .line 221
    .line 222
    move v1, v6

    .line 223
    :goto_de
    if-lt v13, v1, :cond_115

    .line 224
    .line 225
    and-int/lit8 v1, v13, 0x1

    .line 226
    .line 227
    if-ne v1, v4, :cond_115

    .line 228
    .line 229
    sub-int v1, v5, v15

    .line 230
    .line 231
    if-lt v14, v1, :cond_115

    .line 232
    .line 233
    add-int/lit8 v1, v5, -0x2

    .line 234
    .line 235
    if-gt v14, v1, :cond_115

    .line 236
    .line 237
    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 238
    .line 239
    .line 240
    move-result-object v1

    .line 241
    iget-object v6, v0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    .line 242
    .line 243
    invoke-virtual {v6, v1}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 244
    .line 245
    .line 246
    move-result-object v1

    .line 247
    if-nez v1, :cond_108

    .line 248
    .line 249
    new-instance v1, Ljava/util/LinkedList;

    .line 250
    .line 251
    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    .line 252
    .line 253
    .line 254
    invoke-virtual {v1, v11}, Ljava/util/LinkedList;->add(Ljava/lang/Object;)Z

    .line 255
    .line 256
    .line 257
    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 258
    .line 259
    .line 260
    move-result-object v13

    .line 261
    invoke-virtual {v6, v13, v1}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 262
    .line 263
    .line 264
    goto :goto_115

    .line 265
    :cond_108
    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 266
    .line 267
    .line 268
    move-result-object v1

    .line 269
    invoke-virtual {v6, v1}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 270
    .line 271
    .line 272
    move-result-object v1

    .line 273
    check-cast v1, Ljava/util/LinkedList;

    .line 274
    .line 275
    invoke-virtual {v1, v11}, Ljava/util/LinkedList;->add(Ljava/lang/Object;)Z

    .line 276
    .line 277
    .line 278
    :cond_115
    :goto_115
    new-instance v1, Lcom/kousei/framework/f9;

    .line 279
    .line 280
    invoke-direct {v1}, Lcom/kousei/framework/f9;-><init>()V

    .line 281
    .line 282
    .line 283
    iget v6, v2, Lcom/kousei/framework/jj;->a:I

    .line 284
    .line 285
    iput v6, v1, Lcom/kousei/framework/jj;->c:I

    .line 286
    .line 287
    iget-wide v13, v2, Lcom/kousei/framework/jj;->b:J

    .line 288
    .line 289
    iput-wide v13, v1, Lcom/kousei/framework/jj;->b:J

    .line 290
    .line 291
    iget v6, v2, Lcom/kousei/framework/g9;->e:I

    .line 292
    .line 293
    iput v6, v1, Lcom/kousei/framework/f9;->e:I

    .line 294
    .line 295
    iget v6, v2, Lcom/kousei/framework/g9;->f:I

    .line 296
    .line 297
    sub-int/2addr v6, v4

    .line 298
    div-int/lit8 v6, v6, 0x2

    .line 299
    .line 300
    iput v6, v1, Lcom/kousei/framework/f9;->f:I

    .line 301
    .line 302
    iget v2, v2, Lcom/kousei/framework/jj;->d:I

    .line 303
    .line 304
    iput v2, v1, Lcom/kousei/framework/jj;->d:I

    .line 305
    .line 306
    new-instance v2, Lcom/kousei/framework/g9;

    .line 307
    .line 308
    invoke-direct {v2, v1}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 309
    .line 310
    .line 311
    invoke-virtual {v9}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    .line 312
    .line 313
    .line 314
    move-result-object v1

    .line 315
    check-cast v1, Lcom/kousei/framework/sj;

    .line 316
    .line 317
    invoke-static {v8, v1, v11, v2}, Lcom/kousei/framework/xc;->c0(Lcom/kousei/framework/i7;Lcom/kousei/framework/sj;Lcom/kousei/framework/sj;Lcom/kousei/framework/jj;)Lcom/kousei/framework/sj;

    .line 318
    .line 319
    .line 320
    move-result-object v1

    .line 321
    new-instance v11, Lcom/kousei/framework/sj;

    .line 322
    .line 323
    iget v6, v1, Lcom/kousei/framework/sj;->K:I

    .line 324
    .line 325
    add-int/2addr v6, v4

    .line 326
    iget-object v1, v1, Lcom/kousei/framework/sj;->L:[B

    .line 327
    .line 328
    invoke-static {v1}, Lcom/kousei/framework/xc;->g([B)[B

    .line 329
    .line 330
    .line 331
    move-result-object v1

    .line 332
    invoke-direct {v11, v6, v1}, Lcom/kousei/framework/sj;-><init>(I[B)V

    .line 333
    .line 334
    .line 335
    new-instance v1, Lcom/kousei/framework/f9;

    .line 336
    .line 337
    invoke-direct {v1}, Lcom/kousei/framework/f9;-><init>()V

    .line 338
    .line 339
    .line 340
    iget v6, v2, Lcom/kousei/framework/jj;->a:I

    .line 341
    .line 342
    iput v6, v1, Lcom/kousei/framework/jj;->c:I

    .line 343
    .line 344
    iget-wide v13, v2, Lcom/kousei/framework/jj;->b:J

    .line 345
    .line 346
    iput-wide v13, v1, Lcom/kousei/framework/jj;->b:J

    .line 347
    .line 348
    iget v6, v2, Lcom/kousei/framework/g9;->e:I

    .line 349
    .line 350
    add-int/2addr v6, v4

    .line 351
    iput v6, v1, Lcom/kousei/framework/f9;->e:I

    .line 352
    .line 353
    iget v6, v2, Lcom/kousei/framework/g9;->f:I

    .line 354
    .line 355
    iput v6, v1, Lcom/kousei/framework/f9;->f:I

    .line 356
    .line 357
    iget v2, v2, Lcom/kousei/framework/jj;->d:I

    .line 358
    .line 359
    iput v2, v1, Lcom/kousei/framework/jj;->d:I

    .line 360
    .line 361
    new-instance v2, Lcom/kousei/framework/g9;

    .line 362
    .line 363
    invoke-direct {v2, v1}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 364
    .line 365
    .line 366
    move-object/from16 v1, v16

    .line 367
    .line 368
    const/4 v6, 0x0

    .line 369
    goto/16 :goto_9c

    .line 370
    .line 371
    :cond_172
    move-object/from16 v16, v1

    .line 372
    .line 373
    invoke-virtual {v9, v11}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 374
    .line 375
    .line 376
    add-int/lit8 v3, v3, 0x1

    .line 377
    .line 378
    move-object/from16 v1, v16

    .line 379
    .line 380
    const/4 v6, 0x0

    .line 381
    goto/16 :goto_26

    .line 382
    .line 383
    :cond_17e
    invoke-virtual {v9}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    .line 384
    .line 385
    .line 386
    move-result-object v0

    .line 387
    check-cast v0, Lcom/kousei/framework/sj;

    .line 388
    .line 389
    return-void
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

.method public final b([B[BLcom/kousei/framework/rc;)V
    .registers 24

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
    iget-wide v4, v3, Lcom/kousei/framework/jj;->b:J

    .line 10
    .line 11
    iget v6, v3, Lcom/kousei/framework/jj;->a:I

    .line 12
    .line 13
    iget v7, v0, Lcom/kousei/framework/z1;->S:I

    .line 14
    .line 15
    iget v8, v0, Lcom/kousei/framework/z1;->T:I

    .line 16
    .line 17
    const/4 v9, 0x1

    .line 18
    sub-int/2addr v8, v9

    .line 19
    if-gt v7, v8, :cond_2ee

    .line 20
    .line 21
    const/4 v8, 0x0

    .line 22
    move v10, v8

    .line 23
    :goto_16
    iget v11, v0, Lcom/kousei/framework/z1;->L:I

    .line 24
    .line 25
    if-ge v10, v11, :cond_23

    .line 26
    .line 27
    shr-int v12, v7, v10

    .line 28
    .line 29
    and-int/2addr v12, v9

    .line 30
    if-nez v12, :cond_20

    .line 31
    .line 32
    goto :goto_24

    .line 33
    :cond_20
    add-int/lit8 v10, v10, 0x1

    .line 34
    .line 35
    goto :goto_16

    .line 36
    :cond_23
    move v10, v8

    .line 37
    :goto_24
    iget v7, v0, Lcom/kousei/framework/z1;->S:I

    .line 38
    .line 39
    add-int/lit8 v12, v10, 0x1

    .line 40
    .line 41
    shr-int/2addr v7, v12

    .line 42
    and-int/2addr v7, v9

    .line 43
    iget-object v12, v0, Lcom/kousei/framework/z1;->R:Ljava/util/TreeMap;

    .line 44
    .line 45
    iget-object v13, v0, Lcom/kousei/framework/z1;->O:Ljava/util/ArrayList;

    .line 46
    .line 47
    if-nez v7, :cond_41

    .line 48
    .line 49
    add-int/lit8 v7, v11, -0x1

    .line 50
    .line 51
    if-ge v10, v7, :cond_41

    .line 52
    .line 53
    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 54
    .line 55
    .line 56
    move-result-object v7

    .line 57
    invoke-virtual {v13, v10}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 58
    .line 59
    .line 60
    move-result-object v14

    .line 61
    check-cast v14, Lcom/kousei/framework/sj;

    .line 62
    .line 63
    invoke-virtual {v12, v7, v14}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 64
    .line 65
    .line 66
    :cond_41
    iget-object v14, v0, Lcom/kousei/framework/z1;->M:Ljava/util/ArrayList;

    .line 67
    .line 68
    iget v15, v0, Lcom/kousei/framework/z1;->N:I

    .line 69
    .line 70
    iget-object v7, v0, Lcom/kousei/framework/z1;->K:Lcom/kousei/framework/i7;

    .line 71
    .line 72
    if-nez v10, :cond_94

    .line 73
    .line 74
    new-instance v10, Lcom/kousei/framework/ya;

    .line 75
    .line 76
    invoke-direct {v10, v9}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 77
    .line 78
    .line 79
    iput v6, v10, Lcom/kousei/framework/jj;->c:I

    .line 80
    .line 81
    iput-wide v4, v10, Lcom/kousei/framework/jj;->b:J

    .line 82
    .line 83
    iget v12, v0, Lcom/kousei/framework/z1;->S:I

    .line 84
    .line 85
    iput v12, v10, Lcom/kousei/framework/ya;->e:I

    .line 86
    .line 87
    iget v12, v3, Lcom/kousei/framework/rc;->f:I

    .line 88
    .line 89
    iput v12, v10, Lcom/kousei/framework/ya;->f:I

    .line 90
    .line 91
    iget v12, v3, Lcom/kousei/framework/rc;->g:I

    .line 92
    .line 93
    iput v12, v10, Lcom/kousei/framework/ya;->g:I

    .line 94
    .line 95
    iget v3, v3, Lcom/kousei/framework/jj;->d:I

    .line 96
    .line 97
    iput v3, v10, Lcom/kousei/framework/jj;->d:I

    .line 98
    .line 99
    new-instance v3, Lcom/kousei/framework/rc;

    .line 100
    .line 101
    invoke-direct {v3, v10}, Lcom/kousei/framework/rc;-><init>(Lcom/kousei/framework/ya;)V

    .line 102
    .line 103
    .line 104
    invoke-virtual {v7, v2, v3}, Lcom/kousei/framework/i7;->c([BLcom/kousei/framework/rc;)[B

    .line 105
    .line 106
    .line 107
    move-result-object v10

    .line 108
    invoke-virtual {v7, v10, v1}, Lcom/kousei/framework/i7;->d([B[B)V

    .line 109
    .line 110
    .line 111
    invoke-virtual {v7, v3}, Lcom/kousei/framework/i7;->b(Lcom/kousei/framework/rc;)Lcom/kousei/framework/y;

    .line 112
    .line 113
    .line 114
    move-result-object v10

    .line 115
    new-instance v12, Lcom/kousei/framework/ya;

    .line 116
    .line 117
    invoke-direct {v12, v8}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 118
    .line 119
    .line 120
    iput v6, v12, Lcom/kousei/framework/jj;->c:I

    .line 121
    .line 122
    iput-wide v4, v12, Lcom/kousei/framework/jj;->b:J

    .line 123
    .line 124
    iget v4, v0, Lcom/kousei/framework/z1;->S:I

    .line 125
    .line 126
    iput v4, v12, Lcom/kousei/framework/ya;->e:I

    .line 127
    .line 128
    iput v8, v12, Lcom/kousei/framework/ya;->f:I

    .line 129
    .line 130
    iput v8, v12, Lcom/kousei/framework/ya;->g:I

    .line 131
    .line 132
    iput v8, v12, Lcom/kousei/framework/jj;->d:I

    .line 133
    .line 134
    new-instance v4, Lcom/kousei/framework/za;

    .line 135
    .line 136
    invoke-direct {v4, v12}, Lcom/kousei/framework/za;-><init>(Lcom/kousei/framework/ya;)V

    .line 137
    .line 138
    .line 139
    invoke-static {v7, v10, v4}, Lcom/kousei/framework/xc;->M(Lcom/kousei/framework/i7;Lcom/kousei/framework/y;Lcom/kousei/framework/za;)Lcom/kousei/framework/sj;

    .line 140
    .line 141
    .line 142
    move-result-object v4

    .line 143
    invoke-virtual {v13, v8, v4}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 144
    .line 145
    .line 146
    :goto_91
    const/4 v10, 0x0

    .line 147
    goto/16 :goto_144

    .line 148
    .line 149
    :cond_94
    move/from16 v16, v9

    .line 150
    .line 151
    new-instance v9, Lcom/kousei/framework/f9;

    .line 152
    .line 153
    invoke-direct {v9}, Lcom/kousei/framework/f9;-><init>()V

    .line 154
    .line 155
    .line 156
    iput v6, v9, Lcom/kousei/framework/jj;->c:I

    .line 157
    .line 158
    iput-wide v4, v9, Lcom/kousei/framework/jj;->b:J

    .line 159
    .line 160
    add-int/lit8 v4, v10, -0x1

    .line 161
    .line 162
    iput v4, v9, Lcom/kousei/framework/f9;->e:I

    .line 163
    .line 164
    iget v5, v0, Lcom/kousei/framework/z1;->S:I

    .line 165
    .line 166
    shr-int/2addr v5, v10

    .line 167
    iput v5, v9, Lcom/kousei/framework/f9;->f:I

    .line 168
    .line 169
    iput v8, v9, Lcom/kousei/framework/jj;->d:I

    .line 170
    .line 171
    new-instance v5, Lcom/kousei/framework/g9;

    .line 172
    .line 173
    invoke-direct {v5, v9}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 174
    .line 175
    .line 176
    invoke-virtual {v7, v2, v3}, Lcom/kousei/framework/i7;->c([BLcom/kousei/framework/rc;)[B

    .line 177
    .line 178
    .line 179
    move-result-object v6

    .line 180
    invoke-virtual {v7, v6, v1}, Lcom/kousei/framework/i7;->d([B[B)V

    .line 181
    .line 182
    .line 183
    invoke-virtual {v13, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 184
    .line 185
    .line 186
    move-result-object v6

    .line 187
    check-cast v6, Lcom/kousei/framework/sj;

    .line 188
    .line 189
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 190
    .line 191
    .line 192
    move-result-object v9

    .line 193
    invoke-virtual {v12, v9}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 194
    .line 195
    .line 196
    move-result-object v9

    .line 197
    check-cast v9, Lcom/kousei/framework/sj;

    .line 198
    .line 199
    invoke-static {v7, v6, v9, v5}, Lcom/kousei/framework/xc;->c0(Lcom/kousei/framework/i7;Lcom/kousei/framework/sj;Lcom/kousei/framework/sj;Lcom/kousei/framework/jj;)Lcom/kousei/framework/sj;

    .line 200
    .line 201
    .line 202
    move-result-object v5

    .line 203
    new-instance v6, Lcom/kousei/framework/sj;

    .line 204
    .line 205
    iget v9, v5, Lcom/kousei/framework/sj;->K:I

    .line 206
    .line 207
    add-int/lit8 v9, v9, 0x1

    .line 208
    .line 209
    iget-object v5, v5, Lcom/kousei/framework/sj;->L:[B

    .line 210
    .line 211
    invoke-static {v5}, Lcom/kousei/framework/xc;->g([B)[B

    .line 212
    .line 213
    .line 214
    move-result-object v5

    .line 215
    invoke-direct {v6, v9, v5}, Lcom/kousei/framework/sj;-><init>(I[B)V

    .line 216
    .line 217
    .line 218
    invoke-virtual {v13, v10, v6}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 219
    .line 220
    .line 221
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 222
    .line 223
    .line 224
    move-result-object v4

    .line 225
    invoke-virtual {v12, v4}, Ljava/util/TreeMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 226
    .line 227
    .line 228
    move v4, v8

    .line 229
    :goto_e4
    if-ge v4, v10, :cond_10c

    .line 230
    .line 231
    sub-int v5, v11, v15

    .line 232
    .line 233
    if-ge v4, v5, :cond_f6

    .line 234
    .line 235
    invoke-virtual {v14, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 236
    .line 237
    .line 238
    move-result-object v5

    .line 239
    check-cast v5, Lcom/kousei/framework/b2;

    .line 240
    .line 241
    iget-object v5, v5, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 242
    .line 243
    :goto_f2
    invoke-virtual {v13, v4, v5}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 244
    .line 245
    .line 246
    goto :goto_109

    .line 247
    :cond_f6
    iget-object v5, v0, Lcom/kousei/framework/z1;->P:Ljava/util/TreeMap;

    .line 248
    .line 249
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 250
    .line 251
    .line 252
    move-result-object v6

    .line 253
    invoke-virtual {v5, v6}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 254
    .line 255
    .line 256
    move-result-object v5

    .line 257
    check-cast v5, Ljava/util/LinkedList;

    .line 258
    .line 259
    invoke-virtual {v5}, Ljava/util/LinkedList;->removeFirst()Ljava/lang/Object;

    .line 260
    .line 261
    .line 262
    move-result-object v5

    .line 263
    check-cast v5, Lcom/kousei/framework/sj;

    .line 264
    .line 265
    goto :goto_f2

    .line 266
    :goto_109
    add-int/lit8 v4, v4, 0x1

    .line 267
    .line 268
    goto :goto_e4

    .line 269
    :cond_10c
    sub-int v4, v11, v15

    .line 270
    .line 271
    invoke-static {v10, v4}, Ljava/lang/Math;->min(II)I

    .line 272
    .line 273
    .line 274
    move-result v4

    .line 275
    move v5, v8

    .line 276
    :goto_113
    if-ge v5, v4, :cond_140

    .line 277
    .line 278
    iget v6, v0, Lcom/kousei/framework/z1;->S:I

    .line 279
    .line 280
    add-int/lit8 v6, v6, 0x1

    .line 281
    .line 282
    shl-int v9, v16, v5

    .line 283
    .line 284
    mul-int/lit8 v9, v9, 0x3

    .line 285
    .line 286
    add-int/2addr v9, v6

    .line 287
    shl-int v6, v16, v11

    .line 288
    .line 289
    if-ge v9, v6, :cond_138

    .line 290
    .line 291
    invoke-virtual {v14, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 292
    .line 293
    .line 294
    move-result-object v6

    .line 295
    check-cast v6, Lcom/kousei/framework/b2;

    .line 296
    .line 297
    const/4 v10, 0x0

    .line 298
    iput-object v10, v6, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 299
    .line 300
    iget v12, v6, Lcom/kousei/framework/b2;->L:I

    .line 301
    .line 302
    iput v12, v6, Lcom/kousei/framework/b2;->M:I

    .line 303
    .line 304
    iput v9, v6, Lcom/kousei/framework/b2;->N:I

    .line 305
    .line 306
    move/from16 v9, v16

    .line 307
    .line 308
    iput-boolean v9, v6, Lcom/kousei/framework/b2;->O:Z

    .line 309
    .line 310
    iput-boolean v8, v6, Lcom/kousei/framework/b2;->P:Z

    .line 311
    .line 312
    goto :goto_13b

    .line 313
    :cond_138
    move/from16 v9, v16

    .line 314
    .line 315
    const/4 v10, 0x0

    .line 316
    :goto_13b
    add-int/lit8 v5, v5, 0x1

    .line 317
    .line 318
    move/from16 v16, v9

    .line 319
    .line 320
    goto :goto_113

    .line 321
    :cond_140
    move/from16 v9, v16

    .line 322
    .line 323
    goto/16 :goto_91

    .line 324
    .line 325
    :goto_144
    move v4, v8

    .line 326
    :goto_145
    sub-int v5, v11, v15

    .line 327
    .line 328
    shr-int/2addr v5, v9

    .line 329
    if-ge v4, v5, :cond_2e5

    .line 330
    .line 331
    invoke-virtual {v14}, Ljava/util/ArrayList;->size()I

    .line 332
    .line 333
    .line 334
    move-result v5

    .line 335
    move v9, v8

    .line 336
    move-object v6, v10

    .line 337
    :goto_150
    if-ge v9, v5, :cond_184

    .line 338
    .line 339
    invoke-virtual {v14, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 340
    .line 341
    .line 342
    move-result-object v12

    .line 343
    add-int/lit8 v9, v9, 0x1

    .line 344
    .line 345
    check-cast v12, Lcom/kousei/framework/b2;

    .line 346
    .line 347
    iget-boolean v13, v12, Lcom/kousei/framework/b2;->P:Z

    .line 348
    .line 349
    if-nez v13, :cond_171

    .line 350
    .line 351
    iget-boolean v13, v12, Lcom/kousei/framework/b2;->O:Z

    .line 352
    .line 353
    if-nez v13, :cond_163

    .line 354
    .line 355
    goto :goto_171

    .line 356
    :cond_163
    if-nez v6, :cond_166

    .line 357
    .line 358
    goto :goto_170

    .line 359
    :cond_166
    invoke-virtual {v12}, Lcom/kousei/framework/b2;->b()I

    .line 360
    .line 361
    .line 362
    move-result v13

    .line 363
    invoke-virtual {v6}, Lcom/kousei/framework/b2;->b()I

    .line 364
    .line 365
    .line 366
    move-result v10

    .line 367
    if-ge v13, v10, :cond_173

    .line 368
    .line 369
    :goto_170
    move-object v6, v12

    .line 370
    :cond_171
    :goto_171
    const/4 v10, 0x0

    .line 371
    goto :goto_150

    .line 372
    :cond_173
    invoke-virtual {v12}, Lcom/kousei/framework/b2;->b()I

    .line 373
    .line 374
    .line 375
    move-result v10

    .line 376
    invoke-virtual {v6}, Lcom/kousei/framework/b2;->b()I

    .line 377
    .line 378
    .line 379
    move-result v13

    .line 380
    if-ne v10, v13, :cond_171

    .line 381
    .line 382
    iget v10, v12, Lcom/kousei/framework/b2;->N:I

    .line 383
    .line 384
    iget v13, v6, Lcom/kousei/framework/b2;->N:I

    .line 385
    .line 386
    if-ge v10, v13, :cond_171

    .line 387
    .line 388
    goto :goto_170

    .line 389
    :cond_184
    if-eqz v6, :cond_2d0

    .line 390
    .line 391
    iget v5, v6, Lcom/kousei/framework/b2;->L:I

    .line 392
    .line 393
    iget-boolean v9, v6, Lcom/kousei/framework/b2;->P:Z

    .line 394
    .line 395
    if-nez v9, :cond_2ca

    .line 396
    .line 397
    iget-boolean v9, v6, Lcom/kousei/framework/b2;->O:Z

    .line 398
    .line 399
    if-eqz v9, :cond_2ca

    .line 400
    .line 401
    new-instance v9, Lcom/kousei/framework/ya;

    .line 402
    .line 403
    const/4 v10, 0x1

    .line 404
    invoke-direct {v9, v10}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 405
    .line 406
    .line 407
    iget v10, v3, Lcom/kousei/framework/jj;->a:I

    .line 408
    .line 409
    iput v10, v9, Lcom/kousei/framework/jj;->c:I

    .line 410
    .line 411
    iget-wide v12, v3, Lcom/kousei/framework/jj;->b:J

    .line 412
    .line 413
    iput-wide v12, v9, Lcom/kousei/framework/jj;->b:J

    .line 414
    .line 415
    iget v10, v6, Lcom/kousei/framework/b2;->N:I

    .line 416
    .line 417
    iput v10, v9, Lcom/kousei/framework/ya;->e:I

    .line 418
    .line 419
    iget v12, v3, Lcom/kousei/framework/rc;->f:I

    .line 420
    .line 421
    iput v12, v9, Lcom/kousei/framework/ya;->f:I

    .line 422
    .line 423
    iget v12, v3, Lcom/kousei/framework/rc;->g:I

    .line 424
    .line 425
    iput v12, v9, Lcom/kousei/framework/ya;->g:I

    .line 426
    .line 427
    iget v12, v3, Lcom/kousei/framework/jj;->d:I

    .line 428
    .line 429
    iput v12, v9, Lcom/kousei/framework/jj;->d:I

    .line 430
    .line 431
    new-instance v12, Lcom/kousei/framework/rc;

    .line 432
    .line 433
    invoke-direct {v12, v9}, Lcom/kousei/framework/rc;-><init>(Lcom/kousei/framework/ya;)V

    .line 434
    .line 435
    .line 436
    move-object v9, v3

    .line 437
    move v13, v4

    .line 438
    iget-wide v3, v12, Lcom/kousei/framework/jj;->b:J

    .line 439
    .line 440
    move-object/from16 p3, v9

    .line 441
    .line 442
    new-instance v9, Lcom/kousei/framework/ya;

    .line 443
    .line 444
    invoke-direct {v9, v8}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 445
    .line 446
    .line 447
    iget v8, v12, Lcom/kousei/framework/jj;->a:I

    .line 448
    .line 449
    iput v8, v9, Lcom/kousei/framework/jj;->c:I

    .line 450
    .line 451
    iput-wide v3, v9, Lcom/kousei/framework/jj;->b:J

    .line 452
    .line 453
    iput v10, v9, Lcom/kousei/framework/ya;->e:I

    .line 454
    .line 455
    move/from16 v17, v11

    .line 456
    .line 457
    new-instance v11, Lcom/kousei/framework/za;

    .line 458
    .line 459
    invoke-direct {v11, v9}, Lcom/kousei/framework/za;-><init>(Lcom/kousei/framework/ya;)V

    .line 460
    .line 461
    .line 462
    new-instance v9, Lcom/kousei/framework/f9;

    .line 463
    .line 464
    invoke-direct {v9}, Lcom/kousei/framework/f9;-><init>()V

    .line 465
    .line 466
    .line 467
    iput v8, v9, Lcom/kousei/framework/jj;->c:I

    .line 468
    .line 469
    iput-wide v3, v9, Lcom/kousei/framework/jj;->b:J

    .line 470
    .line 471
    iput v10, v9, Lcom/kousei/framework/f9;->f:I

    .line 472
    .line 473
    new-instance v3, Lcom/kousei/framework/g9;

    .line 474
    .line 475
    invoke-direct {v3, v9}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 476
    .line 477
    .line 478
    invoke-virtual {v7, v2, v12}, Lcom/kousei/framework/i7;->c([BLcom/kousei/framework/rc;)[B

    .line 479
    .line 480
    .line 481
    move-result-object v4

    .line 482
    invoke-virtual {v7, v4, v1}, Lcom/kousei/framework/i7;->d([B[B)V

    .line 483
    .line 484
    .line 485
    invoke-virtual {v7, v12}, Lcom/kousei/framework/i7;->b(Lcom/kousei/framework/rc;)Lcom/kousei/framework/y;

    .line 486
    .line 487
    .line 488
    move-result-object v4

    .line 489
    invoke-static {v7, v4, v11}, Lcom/kousei/framework/xc;->M(Lcom/kousei/framework/i7;Lcom/kousei/framework/y;Lcom/kousei/framework/za;)Lcom/kousei/framework/sj;

    .line 490
    .line 491
    .line 492
    move-result-object v4

    .line 493
    :goto_1ec
    iget v8, v3, Lcom/kousei/framework/jj;->d:I

    .line 494
    .line 495
    iget-wide v9, v3, Lcom/kousei/framework/jj;->b:J

    .line 496
    .line 497
    iget-object v11, v0, Lcom/kousei/framework/z1;->Q:Ljava/util/Stack;

    .line 498
    .line 499
    invoke-virtual {v11}, Ljava/util/AbstractCollection;->isEmpty()Z

    .line 500
    .line 501
    .line 502
    move-result v12

    .line 503
    iget v1, v3, Lcom/kousei/framework/g9;->f:I

    .line 504
    .line 505
    move/from16 v18, v1

    .line 506
    .line 507
    iget v1, v3, Lcom/kousei/framework/g9;->e:I

    .line 508
    .line 509
    iget v3, v3, Lcom/kousei/framework/jj;->a:I

    .line 510
    .line 511
    if-nez v12, :cond_26f

    .line 512
    .line 513
    invoke-virtual {v11}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    .line 514
    .line 515
    .line 516
    move-result-object v12

    .line 517
    check-cast v12, Lcom/kousei/framework/sj;

    .line 518
    .line 519
    iget v12, v12, Lcom/kousei/framework/sj;->K:I

    .line 520
    .line 521
    iget v2, v4, Lcom/kousei/framework/sj;->K:I

    .line 522
    .line 523
    if-ne v12, v2, :cond_26f

    .line 524
    .line 525
    invoke-virtual {v11}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    .line 526
    .line 527
    .line 528
    move-result-object v2

    .line 529
    check-cast v2, Lcom/kousei/framework/sj;

    .line 530
    .line 531
    iget v2, v2, Lcom/kousei/framework/sj;->K:I

    .line 532
    .line 533
    if-eq v2, v5, :cond_26f

    .line 534
    .line 535
    new-instance v2, Lcom/kousei/framework/f9;

    .line 536
    .line 537
    invoke-direct {v2}, Lcom/kousei/framework/f9;-><init>()V

    .line 538
    .line 539
    .line 540
    iput v3, v2, Lcom/kousei/framework/jj;->c:I

    .line 541
    .line 542
    iput-wide v9, v2, Lcom/kousei/framework/jj;->b:J

    .line 543
    .line 544
    iput v1, v2, Lcom/kousei/framework/f9;->e:I

    .line 545
    .line 546
    add-int/lit8 v1, v18, -0x1

    .line 547
    .line 548
    div-int/lit8 v1, v1, 0x2

    .line 549
    .line 550
    iput v1, v2, Lcom/kousei/framework/f9;->f:I

    .line 551
    .line 552
    iput v8, v2, Lcom/kousei/framework/jj;->d:I

    .line 553
    .line 554
    new-instance v1, Lcom/kousei/framework/g9;

    .line 555
    .line 556
    invoke-direct {v1, v2}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 557
    .line 558
    .line 559
    invoke-virtual {v11}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    .line 560
    .line 561
    .line 562
    move-result-object v2

    .line 563
    check-cast v2, Lcom/kousei/framework/sj;

    .line 564
    .line 565
    invoke-static {v7, v2, v4, v1}, Lcom/kousei/framework/xc;->c0(Lcom/kousei/framework/i7;Lcom/kousei/framework/sj;Lcom/kousei/framework/sj;Lcom/kousei/framework/jj;)Lcom/kousei/framework/sj;

    .line 566
    .line 567
    .line 568
    move-result-object v2

    .line 569
    new-instance v4, Lcom/kousei/framework/sj;

    .line 570
    .line 571
    iget v3, v2, Lcom/kousei/framework/sj;->K:I

    .line 572
    .line 573
    const/16 v16, 0x1

    .line 574
    .line 575
    add-int/lit8 v3, v3, 0x1

    .line 576
    .line 577
    iget-object v2, v2, Lcom/kousei/framework/sj;->L:[B

    .line 578
    .line 579
    invoke-static {v2}, Lcom/kousei/framework/xc;->g([B)[B

    .line 580
    .line 581
    .line 582
    move-result-object v2

    .line 583
    invoke-direct {v4, v3, v2}, Lcom/kousei/framework/sj;-><init>(I[B)V

    .line 584
    .line 585
    .line 586
    new-instance v2, Lcom/kousei/framework/f9;

    .line 587
    .line 588
    invoke-direct {v2}, Lcom/kousei/framework/f9;-><init>()V

    .line 589
    .line 590
    .line 591
    iget v3, v1, Lcom/kousei/framework/jj;->a:I

    .line 592
    .line 593
    iput v3, v2, Lcom/kousei/framework/jj;->c:I

    .line 594
    .line 595
    iget-wide v8, v1, Lcom/kousei/framework/jj;->b:J

    .line 596
    .line 597
    iput-wide v8, v2, Lcom/kousei/framework/jj;->b:J

    .line 598
    .line 599
    iget v3, v1, Lcom/kousei/framework/g9;->e:I

    .line 600
    .line 601
    add-int/lit8 v3, v3, 0x1

    .line 602
    .line 603
    iput v3, v2, Lcom/kousei/framework/f9;->e:I

    .line 604
    .line 605
    iget v3, v1, Lcom/kousei/framework/g9;->f:I

    .line 606
    .line 607
    iput v3, v2, Lcom/kousei/framework/f9;->f:I

    .line 608
    .line 609
    iget v1, v1, Lcom/kousei/framework/jj;->d:I

    .line 610
    .line 611
    iput v1, v2, Lcom/kousei/framework/jj;->d:I

    .line 612
    .line 613
    new-instance v3, Lcom/kousei/framework/g9;

    .line 614
    .line 615
    invoke-direct {v3, v2}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 616
    .line 617
    .line 618
    move-object/from16 v1, p1

    .line 619
    .line 620
    move-object/from16 v2, p2

    .line 621
    .line 622
    goto/16 :goto_1ec

    .line 623
    .line 624
    :cond_26f
    iget-object v2, v6, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 625
    .line 626
    if-nez v2, :cond_278

    .line 627
    .line 628
    iput-object v4, v6, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 629
    .line 630
    move/from16 v19, v13

    .line 631
    .line 632
    goto :goto_2b5

    .line 633
    :cond_278
    iget v12, v2, Lcom/kousei/framework/sj;->K:I

    .line 634
    .line 635
    move/from16 v19, v13

    .line 636
    .line 637
    iget v13, v4, Lcom/kousei/framework/sj;->K:I

    .line 638
    .line 639
    if-ne v12, v13, :cond_2b2

    .line 640
    .line 641
    new-instance v11, Lcom/kousei/framework/f9;

    .line 642
    .line 643
    invoke-direct {v11}, Lcom/kousei/framework/f9;-><init>()V

    .line 644
    .line 645
    .line 646
    iput v3, v11, Lcom/kousei/framework/jj;->c:I

    .line 647
    .line 648
    iput-wide v9, v11, Lcom/kousei/framework/jj;->b:J

    .line 649
    .line 650
    iput v1, v11, Lcom/kousei/framework/f9;->e:I

    .line 651
    .line 652
    add-int/lit8 v1, v18, -0x1

    .line 653
    .line 654
    div-int/lit8 v1, v1, 0x2

    .line 655
    .line 656
    iput v1, v11, Lcom/kousei/framework/f9;->f:I

    .line 657
    .line 658
    iput v8, v11, Lcom/kousei/framework/jj;->d:I

    .line 659
    .line 660
    new-instance v1, Lcom/kousei/framework/g9;

    .line 661
    .line 662
    invoke-direct {v1, v11}, Lcom/kousei/framework/g9;-><init>(Lcom/kousei/framework/f9;)V

    .line 663
    .line 664
    .line 665
    invoke-static {v7, v2, v4, v1}, Lcom/kousei/framework/xc;->c0(Lcom/kousei/framework/i7;Lcom/kousei/framework/sj;Lcom/kousei/framework/sj;Lcom/kousei/framework/jj;)Lcom/kousei/framework/sj;

    .line 666
    .line 667
    .line 668
    move-result-object v1

    .line 669
    new-instance v4, Lcom/kousei/framework/sj;

    .line 670
    .line 671
    iget-object v2, v6, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 672
    .line 673
    iget v2, v2, Lcom/kousei/framework/sj;->K:I

    .line 674
    .line 675
    const/16 v16, 0x1

    .line 676
    .line 677
    add-int/lit8 v2, v2, 0x1

    .line 678
    .line 679
    iget-object v1, v1, Lcom/kousei/framework/sj;->L:[B

    .line 680
    .line 681
    invoke-static {v1}, Lcom/kousei/framework/xc;->g([B)[B

    .line 682
    .line 683
    .line 684
    move-result-object v1

    .line 685
    invoke-direct {v4, v2, v1}, Lcom/kousei/framework/sj;-><init>(I[B)V

    .line 686
    .line 687
    .line 688
    iput-object v4, v6, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 689
    .line 690
    goto :goto_2b5

    .line 691
    :cond_2b2
    invoke-virtual {v11, v4}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 692
    .line 693
    .line 694
    :goto_2b5
    iget-object v1, v6, Lcom/kousei/framework/b2;->K:Lcom/kousei/framework/sj;

    .line 695
    .line 696
    iget v1, v1, Lcom/kousei/framework/sj;->K:I

    .line 697
    .line 698
    if-ne v1, v5, :cond_2bf

    .line 699
    .line 700
    const/4 v9, 0x1

    .line 701
    iput-boolean v9, v6, Lcom/kousei/framework/b2;->P:Z

    .line 702
    .line 703
    goto :goto_2d6

    .line 704
    :cond_2bf
    const/4 v9, 0x1

    .line 705
    iget v1, v4, Lcom/kousei/framework/sj;->K:I

    .line 706
    .line 707
    iput v1, v6, Lcom/kousei/framework/b2;->M:I

    .line 708
    .line 709
    iget v1, v6, Lcom/kousei/framework/b2;->N:I

    .line 710
    .line 711
    add-int/2addr v1, v9

    .line 712
    iput v1, v6, Lcom/kousei/framework/b2;->N:I

    .line 713
    .line 714
    goto :goto_2d6

    .line 715
    :cond_2ca
    const-string v0, "finished or not initialized"

    .line 716
    .line 717
    invoke-static {v0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 718
    .line 719
    .line 720
    return-void

    .line 721
    :cond_2d0
    move-object/from16 p3, v3

    .line 722
    .line 723
    move/from16 v19, v4

    .line 724
    .line 725
    move/from16 v17, v11

    .line 726
    .line 727
    :goto_2d6
    add-int/lit8 v4, v19, 0x1

    .line 728
    .line 729
    move-object/from16 v1, p1

    .line 730
    .line 731
    move-object/from16 v2, p2

    .line 732
    .line 733
    move-object/from16 v3, p3

    .line 734
    .line 735
    move/from16 v11, v17

    .line 736
    .line 737
    const/4 v8, 0x0

    .line 738
    const/4 v9, 0x1

    .line 739
    const/4 v10, 0x0

    .line 740
    goto/16 :goto_145

    .line 741
    .line 742
    :cond_2e5
    iget v1, v0, Lcom/kousei/framework/z1;->S:I

    .line 743
    .line 744
    const/16 v16, 0x1

    .line 745
    .line 746
    add-int/lit8 v1, v1, 0x1

    .line 747
    .line 748
    iput v1, v0, Lcom/kousei/framework/z1;->S:I

    .line 749
    .line 750
    return-void

    .line 751
    :cond_2ee
    const-string v0, "index out of bounds"

    .line 752
    .line 753
    invoke-static {v0}, Lcom/kousei/framework/f;->m(Ljava/lang/String;)V

    .line 754
    .line 755
    .line 756
    return-void
    .line 757
    .line 758
    .line 759
    .line 760
    .line 761
    .line 762
    .line 763
    .line 764
    .line 765
    .line 766
    .line 767
    .line 768
    .line 769
    .line 770
    .line 771
    .line 772
    .line 773
    .line 774
    .line 775
    .line 776
    .line 777
    .line 778
    .line 779
    .line 780
    .line 781
    .line 782
    .line 783
    .line 784
    .line 785
    .line 786
    .line 787
    .line 788
    .line 789
    .line 790
    .line 791
    .line 792
    .line 793
    .line 794
    .line 795
    .line 796
    .line 797
    .line 798
    .line 799
    .line 800
    .line 801
    .line 802
    .line 803
    .line 804
    .line 805
    .line 806
    .line 807
    .line 808
    .line 809
    .line 810
    .line 811
    .line 812
    .line 813
    .line 814
    .line 815
    .line 816
    .line 817
    .line 818
    .line 819
    .line 820
    .line 821
    .line 822
    .line 823
    .line 824
    .line 825
    .line 826
    .line 827
    .line 828
    .line 829
    .line 830
    .line 831
    .line 832
    .line 833
    .line 834
    .line 835
    .line 836
    .line 837
    .line 838
    .line 839
    .line 840
    .line 841
    .line 842
    .line 843
    .line 844
    .line 845
    .line 846
    .line 847
    .line 848
    .line 849
    .line 850
    .line 851
    .line 852
    .line 853
    .line 854
    .line 855
    .line 856
    .line 857
    .line 858
    .line 859
    .line 860
    .line 861
    .line 862
    .line 863
    .line 864
    .line 865
    .line 866
    .line 867
    .line 868
    .line 869
    .line 870
    .line 871
    .line 872
    .line 873
    .line 874
    .line 875
    .line 876
    .line 877
    .line 878
    .line 879
    .line 880
    .line 881
    .line 882
    .line 883
    .line 884
    .line 885
    .line 886
    .line 887
    .line 888
    .line 889
    .line 890
    .line 891
    .line 892
    .line 893
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
