.class public abstract Lcom/kousei/framework/di;
.super Ljava/lang/Object;
.source "r8-map-id-ab9d9a36b7cfe29bbfb78ee9a77c1feaf549e881397fc2be336a306d7a6faedf"


# direct methods
.method private static constructor <clinit>()V
    .registers 2

    .line 1
    const-wide v0, -0x64e8df5b40d7L

    .line 2
    .line 3
    .line 4
    .line 5
    .line 6
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 7
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

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .registers 7

    .line 1
    if-nez p1, :cond_4

    .line 2
    .line 3
    goto/16 :goto_169

    .line 4
    .line 5
    :cond_4
    const-wide v0, -0x66e7df5b40d7L

    .line 6
    .line 7
    .line 8
    .line 9
    .line 10
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 15
    .line 16
    .line 17
    move-result v0

    .line 18
    if-nez v0, :cond_33

    .line 19
    .line 20
    const-wide v0, -0x66c1df5b40d7L

    .line 21
    .line 22
    .line 23
    .line 24
    .line 25
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 26
    .line 27
    .line 28
    move-result-object v0

    .line 29
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 30
    .line 31
    .line 32
    move-result v0

    .line 33
    if-nez v0, :cond_33

    .line 34
    .line 35
    const-wide v0, -0x66a9df5b40d7L

    .line 36
    .line 37
    .line 38
    .line 39
    .line 40
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 41
    .line 42
    .line 43
    move-result-object v0

    .line 44
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 45
    .line 46
    .line 47
    move-result v0

    .line 48
    if-nez v0, :cond_33

    .line 49
    .line 50
    goto/16 :goto_169

    .line 51
    .line 52
    :cond_33
    const/4 v0, 0x0

    .line 53
    if-eqz p0, :cond_3b

    .line 54
    .line 55
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    .line 56
    .line 57
    .line 58
    move-result-object p0

    .line 59
    goto :goto_62

    .line 60
    :cond_3b
    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;

    .line 61
    .line 62
    .line 63
    move-result-object p0

    .line 64
    if-nez p0, :cond_5a

    .line 65
    .line 66
    invoke-static {}, Landroid/app/ActivityThread;->currentActivityThread()Landroid/app/ActivityThread;

    .line 67
    .line 68
    .line 69
    move-result-object v1

    .line 70
    if-eqz v1, :cond_5a

    .line 71
    .line 72
    :try_start_47
    invoke-virtual {v1}, Landroid/app/ActivityThread;->getSystemContext()Landroid/app/ContextImpl;

    .line 73
    .line 74
    .line 75
    move-result-object p0

    .line 76
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    .line 77
    .line 78
    .line 79
    move-result v2

    .line 80
    if-nez v2, :cond_5a

    .line 81
    .line 82
    invoke-virtual {p0, p1, v0}, Landroid/content/Context;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    .line 83
    .line 84
    .line 85
    move-result-object p0
    :try_end_55
    .catch Ljava/lang/Exception; {:try_start_47 .. :try_end_55} :catch_56

    .line 86
    goto :goto_5a

    .line 87
    :catch_56
    invoke-virtual {v1}, Landroid/app/ActivityThread;->getSystemContext()Landroid/app/ContextImpl;

    .line 88
    .line 89
    .line 90
    move-result-object p0

    .line 91
    :cond_5a
    :goto_5a
    if-nez p0, :cond_5e

    .line 92
    .line 93
    const/4 p0, 0x0

    .line 94
    goto :goto_62

    .line 95
    :cond_5e
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    .line 96
    .line 97
    .line 98
    move-result-object p0

    .line 99
    :goto_62
    if-nez p0, :cond_75

    .line 100
    .line 101
    const-wide p0, -0x6691df5b40d7L

    .line 102
    .line 103
    .line 104
    .line 105
    .line 106
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 107
    .line 108
    .line 109
    const-wide p0, -0x6662df5b40d7L

    .line 110
    .line 111
    .line 112
    .line 113
    .line 114
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 115
    .line 116
    .line 117
    return-void

    .line 118
    :cond_75
    const-wide v1, -0x665adf5b40d7L

    .line 119
    .line 120
    .line 121
    .line 122
    .line 123
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 124
    .line 125
    .line 126
    move-result-object v1

    .line 127
    invoke-static {p0, v1, v0}, Lcom/kousei/framework/KaoriosFramework;->getGlobalInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    .line 128
    .line 129
    .line 130
    move-result p0

    .line 131
    const/4 v1, 0x1

    .line 132
    if-eq p0, v1, :cond_96

    .line 133
    .line 134
    const-wide p0, -0x6628df5b40d7L

    .line 135
    .line 136
    .line 137
    .line 138
    .line 139
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 140
    .line 141
    .line 142
    const-wide p0, -0x6639df5b40d7L

    .line 143
    .line 144
    .line 145
    .line 146
    .line 147
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 148
    .line 149
    .line 150
    return-void

    .line 151
    :cond_96
    new-instance p0, Ljava/lang/StringBuilder;

    .line 152
    .line 153
    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    .line 154
    .line 155
    .line 156
    const-wide v1, -0x6610df5b40d7L

    .line 157
    .line 158
    .line 159
    .line 160
    .line 161
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 162
    .line 163
    .line 164
    move-result-object v1

    .line 165
    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 166
    .line 167
    .line 168
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 169
    .line 170
    .line 171
    const-wide v1, -0x67e4df5b40d7L

    .line 172
    .line 173
    .line 174
    .line 175
    .line 176
    invoke-static {v1, v2}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 177
    .line 178
    .line 179
    move-result-object p1

    .line 180
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 181
    .line 182
    .line 183
    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 184
    .line 185
    .line 186
    move-result-object p0

    .line 187
    new-instance p1, Ljava/io/File;

    .line 188
    .line 189
    invoke-direct {p1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 190
    .line 191
    .line 192
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    .line 193
    .line 194
    .line 195
    move-result p0

    .line 196
    if-nez p0, :cond_d6

    .line 197
    .line 198
    const-wide p0, -0x67f9df5b40d7L

    .line 199
    .line 200
    .line 201
    .line 202
    .line 203
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 204
    .line 205
    .line 206
    const-wide p0, -0x67cadf5b40d7L

    .line 207
    .line 208
    .line 209
    .line 210
    .line 211
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 212
    .line 213
    .line 214
    return-void

    .line 215
    :cond_d6
    :try_start_d6
    invoke-virtual {p1}, Ljava/io/File;->length()J

    .line 216
    .line 217
    .line 218
    move-result-wide v1

    .line 219
    long-to-int p0, v1

    .line 220
    new-array p0, p0, [B

    .line 221
    .line 222
    new-instance v1, Ljava/io/FileInputStream;

    .line 223
    .line 224
    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_e2
    .catch Ljava/io/IOException; {:try_start_d6 .. :try_end_e2} :catch_153

    .line 225
    .line 226
    .line 227
    :try_start_e2
    invoke-virtual {v1, p0}, Ljava/io/FileInputStream;->read([B)I
    :try_end_e5
    .catchall {:try_start_e2 .. :try_end_e5} :catchall_149

    .line 228
    .line 229
    .line 230
    :try_start_e5
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V

    .line 231
    .line 232
    .line 233
    new-instance v1, Ljava/lang/String;

    .line 234
    .line 235
    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 236
    .line 237
    invoke-direct {v1, p0, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 238
    .line 239
    .line 240
    const-wide v3, -0x67aedf5b40d7L

    .line 241
    .line 242
    .line 243
    .line 244
    .line 245
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 246
    .line 247
    .line 248
    move-result-object p0

    .line 249
    const-wide v3, -0x67b8df5b40d7L

    .line 250
    .line 251
    .line 252
    .line 253
    .line 254
    invoke-static {v3, v4}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 255
    .line 256
    .line 257
    move-result-object v3

    .line 258
    invoke-virtual {v1, p0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    .line 259
    .line 260
    .line 261
    move-result v4

    .line 262
    if-eqz v4, :cond_138

    .line 263
    .line 264
    invoke-virtual {v1, p0, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    .line 265
    .line 266
    .line 267
    move-result-object p0

    .line 268
    new-instance v1, Ljava/io/FileOutputStream;

    .line 269
    .line 270
    invoke-direct {v1, p1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    :try_end_110
    .catch Ljava/io/IOException; {:try_start_e5 .. :try_end_110} :catch_153

    .line 271
    .line 272
    .line 273
    :try_start_110
    invoke-virtual {p0, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    .line 274
    .line 275
    .line 276
    move-result-object p0

    .line 277
    invoke-virtual {v1, p0}, Ljava/io/FileOutputStream;->write([B)V

    .line 278
    .line 279
    .line 280
    invoke-virtual {v1}, Ljava/io/OutputStream;->flush()V
    :try_end_11a
    .catchall {:try_start_110 .. :try_end_11a} :catchall_12e

    .line 281
    .line 282
    .line 283
    :try_start_11a
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    .line 284
    .line 285
    .line 286
    const-wide p0, -0x6792df5b40d7L

    .line 287
    .line 288
    .line 289
    .line 290
    .line 291
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 292
    .line 293
    .line 294
    const-wide p0, -0x6763df5b40d7L

    .line 295
    .line 296
    .line 297
    .line 298
    .line 299
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;
    :try_end_12d
    .catch Ljava/io/IOException; {:try_start_11a .. :try_end_12d} :catch_153

    .line 300
    .line 301
    .line 302
    goto :goto_169

    .line 303
    :catchall_12e
    move-exception p0

    .line 304
    :try_start_12f
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_132
    .catchall {:try_start_12f .. :try_end_132} :catchall_133

    .line 305
    .line 306
    .line 307
    goto :goto_137

    .line 308
    :catchall_133
    move-exception p1

    .line 309
    :try_start_134
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .line 310
    .line 311
    .line 312
    :goto_137
    throw p0

    .line 313
    :cond_138
    const-wide p0, -0x6741df5b40d7L

    .line 314
    .line 315
    .line 316
    .line 317
    .line 318
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 319
    .line 320
    .line 321
    const-wide p0, -0x6752df5b40d7L

    .line 322
    .line 323
    .line 324
    .line 325
    .line 326
    invoke-static {p0, p1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;
    :try_end_148
    .catch Ljava/io/IOException; {:try_start_134 .. :try_end_148} :catch_153

    .line 327
    .line 328
    .line 329
    goto :goto_169

    .line 330
    :catchall_149
    move-exception p0

    .line 331
    :try_start_14a
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_14d
    .catchall {:try_start_14a .. :try_end_14d} :catchall_14e

    .line 332
    .line 333
    .line 334
    goto :goto_152

    .line 335
    :catchall_14e
    move-exception p1

    .line 336
    :try_start_14f
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .line 337
    .line 338
    .line 339
    :goto_152
    throw p0
    :try_end_153
    .catch Ljava/io/IOException; {:try_start_14f .. :try_end_153} :catch_153

    .line 340
    :catch_153
    move-exception p0

    .line 341
    const-wide v0, -0x6702df5b40d7L

    .line 342
    .line 343
    .line 344
    .line 345
    .line 346
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 347
    .line 348
    .line 349
    move-result-object p1

    .line 350
    const-wide v0, -0x6713df5b40d7L

    .line 351
    .line 352
    .line 353
    .line 354
    .line 355
    invoke-static {v0, v1}, Lcom/kousei/framework/j0;->Q(J)Ljava/lang/String;

    .line 356
    .line 357
    .line 358
    move-result-object v0

    .line 359
    invoke-static {p1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 360
    .line 361
    .line 362
    :goto_169
    return-void
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
