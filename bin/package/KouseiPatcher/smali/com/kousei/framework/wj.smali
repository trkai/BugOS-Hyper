.class public final Lcom/kousei/framework/wj;
.super Lcom/kousei/framework/hf;

# interfaces
.implements Lcom/kousei/framework/y7;


# instance fields
.field public final M:Lcom/kousei/framework/tj;

.field public final N:[B

.field public final O:[B

.field public final P:[B

.field public final Q:[B

.field public volatile R:Lcom/kousei/framework/z1;


# direct methods
.method public constructor <init>(Lcom/kousei/framework/vj;)V
    .registers 13

    .line 1
    iget-object v0, p1, Lcom/kousei/framework/vj;->a:Lcom/kousei/framework/tj;

    .line 2
    .line 3
    iget-object v1, v0, Lcom/kousei/framework/tj;->e:Ljava/lang/String;

    .line 4
    .line 5
    const/4 v2, 0x1

    .line 6
    invoke-direct {p0, v1, v2}, Lcom/kousei/framework/hf;-><init>(Ljava/lang/String;Z)V

    .line 7
    .line 8
    .line 9
    iput-object v0, p0, Lcom/kousei/framework/wj;->M:Lcom/kousei/framework/tj;

    .line 10
    .line 11
    iget v1, v0, Lcom/kousei/framework/tj;->f:I

    .line 12
    .line 13
    iget-object v3, p1, Lcom/kousei/framework/vj;->d:[B

    .line 14
    .line 15
    const/4 v4, 0x0

    .line 16
    if-eqz v3, :cond_1d

    .line 17
    .line 18
    array-length v5, v3

    .line 19
    if-ne v5, v1, :cond_17

    .line 20
    .line 21
    iput-object v3, p0, Lcom/kousei/framework/wj;->N:[B

    .line 22
    .line 23
    goto :goto_21

    .line 24
    :cond_17
    const-string p0, "size of secretKeySeed needs to be equal size of digest"

    .line 25
    .line 26
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 27
    .line 28
    .line 29
    throw v4

    .line 30
    :cond_1d
    new-array v5, v1, [B

    .line 31
    .line 32
    iput-object v5, p0, Lcom/kousei/framework/wj;->N:[B

    .line 33
    .line 34
    :goto_21
    iget-object v5, p1, Lcom/kousei/framework/vj;->e:[B

    .line 35
    .line 36
    if-eqz v5, :cond_31

    .line 37
    .line 38
    array-length v6, v5

    .line 39
    if-ne v6, v1, :cond_2b

    .line 40
    .line 41
    iput-object v5, p0, Lcom/kousei/framework/wj;->O:[B

    .line 42
    .line 43
    goto :goto_35

    .line 44
    :cond_2b
    const-string p0, "size of secretKeyPRF needs to be equal size of digest"

    .line 45
    .line 46
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 47
    .line 48
    .line 49
    throw v4

    .line 50
    :cond_31
    new-array v5, v1, [B

    .line 51
    .line 52
    iput-object v5, p0, Lcom/kousei/framework/wj;->O:[B

    .line 53
    .line 54
    :goto_35
    iget-object v5, p1, Lcom/kousei/framework/vj;->f:[B

    .line 55
    .line 56
    if-eqz v5, :cond_45

    .line 57
    .line 58
    array-length v6, v5

    .line 59
    if-ne v6, v1, :cond_3f

    .line 60
    .line 61
    iput-object v5, p0, Lcom/kousei/framework/wj;->P:[B

    .line 62
    .line 63
    goto :goto_49

    .line 64
    :cond_3f
    const-string p0, "size of publicSeed needs to be equal size of digest"

    .line 65
    .line 66
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 67
    .line 68
    .line 69
    throw v4

    .line 70
    :cond_45
    new-array v6, v1, [B

    .line 71
    .line 72
    iput-object v6, p0, Lcom/kousei/framework/wj;->P:[B

    .line 73
    .line 74
    :goto_49
    iget-object v6, p1, Lcom/kousei/framework/vj;->g:[B

    .line 75
    .line 76
    if-eqz v6, :cond_59

    .line 77
    .line 78
    array-length v7, v6

    .line 79
    if-ne v7, v1, :cond_53

    .line 80
    .line 81
    iput-object v6, p0, Lcom/kousei/framework/wj;->Q:[B

    .line 82
    .line 83
    goto :goto_5d

    .line 84
    :cond_53
    const-string p0, "size of root needs to be equal size of digest"

    .line 85
    .line 86
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 87
    .line 88
    .line 89
    throw v4

    .line 90
    :cond_59
    new-array v1, v1, [B

    .line 91
    .line 92
    iput-object v1, p0, Lcom/kousei/framework/wj;->Q:[B

    .line 93
    .line 94
    :goto_5d
    iget-object v1, p1, Lcom/kousei/framework/vj;->h:Lcom/kousei/framework/z1;

    .line 95
    .line 96
    if-eqz v1, :cond_64

    .line 97
    .line 98
    :cond_61
    iput-object v1, p0, Lcom/kousei/framework/wj;->R:Lcom/kousei/framework/z1;

    .line 99
    .line 100
    goto :goto_8e

    .line 101
    :cond_64
    new-instance v1, Lcom/kousei/framework/z1;

    .line 102
    .line 103
    new-instance v6, Lcom/kousei/framework/ya;

    .line 104
    .line 105
    invoke-direct {v6, v2}, Lcom/kousei/framework/ya;-><init>(I)V

    .line 106
    .line 107
    .line 108
    new-instance v7, Lcom/kousei/framework/rc;

    .line 109
    .line 110
    invoke-direct {v7, v6}, Lcom/kousei/framework/rc;-><init>(Lcom/kousei/framework/ya;)V

    .line 111
    .line 112
    .line 113
    iget v6, p1, Lcom/kousei/framework/vj;->b:I

    .line 114
    .line 115
    new-instance v8, Lcom/kousei/framework/i7;

    .line 116
    .line 117
    iget-object v9, v0, Lcom/kousei/framework/tj;->g:Lcom/kousei/framework/ri;

    .line 118
    .line 119
    invoke-direct {v8, v9}, Lcom/kousei/framework/i7;-><init>(Lcom/kousei/framework/ri;)V

    .line 120
    .line 121
    .line 122
    iget v9, v0, Lcom/kousei/framework/tj;->b:I

    .line 123
    .line 124
    iget v0, v0, Lcom/kousei/framework/tj;->c:I

    .line 125
    .line 126
    shl-int v10, v2, v9

    .line 127
    .line 128
    sub-int/2addr v10, v2

    .line 129
    invoke-direct {v1, v8, v9, v0, v10}, Lcom/kousei/framework/z1;-><init>(Lcom/kousei/framework/i7;III)V

    .line 130
    .line 131
    .line 132
    invoke-virtual {v1, v5, v3, v7}, Lcom/kousei/framework/z1;->a([B[BLcom/kousei/framework/rc;)V

    .line 133
    .line 134
    .line 135
    :goto_86
    iget v0, v1, Lcom/kousei/framework/z1;->S:I

    .line 136
    .line 137
    if-ge v0, v6, :cond_61

    .line 138
    .line 139
    invoke-virtual {v1, v5, v3, v7}, Lcom/kousei/framework/z1;->b([B[BLcom/kousei/framework/rc;)V

    .line 140
    .line 141
    .line 142
    goto :goto_86

    .line 143
    :goto_8e
    iget p1, p1, Lcom/kousei/framework/vj;->c:I

    .line 144
    .line 145
    if-ltz p1, :cond_9f

    .line 146
    .line 147
    iget-object p0, p0, Lcom/kousei/framework/wj;->R:Lcom/kousei/framework/z1;

    .line 148
    .line 149
    iget p0, p0, Lcom/kousei/framework/z1;->T:I

    .line 150
    .line 151
    if-ne p1, p0, :cond_99

    .line 152
    .line 153
    goto :goto_9f

    .line 154
    :cond_99
    const-string p0, "maxIndex set but not reflected in state"

    .line 155
    .line 156
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 157
    .line 158
    .line 159
    throw v4

    .line 160
    :cond_9f
    :goto_9f
    return-void
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


# virtual methods
.method public final a()[B
    .registers 8

    .line 1
    const-string v0, "error serializing bds state: "

    .line 2
    .line 3
    monitor-enter p0

    .line 4
    :try_start_3
    iget-object v1, p0, Lcom/kousei/framework/wj;->M:Lcom/kousei/framework/tj;

    .line 5
    .line 6
    iget v1, v1, Lcom/kousei/framework/tj;->f:I

    .line 7
    .line 8
    add-int/lit8 v2, v1, 0x4

    .line 9
    .line 10
    add-int v3, v2, v1

    .line 11
    .line 12
    add-int v4, v3, v1

    .line 13
    .line 14
    add-int/2addr v1, v4

    .line 15
    new-array v1, v1, [B

    .line 16
    .line 17
    iget-object v5, p0, Lcom/kousei/framework/wj;->R:Lcom/kousei/framework/z1;

    .line 18
    .line 19
    iget v5, v5, Lcom/kousei/framework/z1;->S:I

    .line 20
    .line 21
    const/4 v6, 0x0

    .line 22
    invoke-static {v1, v5, v6}, Lcom/kousei/framework/i0;->m1([BII)V

    .line 23
    .line 24
    .line 25
    iget-object v5, p0, Lcom/kousei/framework/wj;->N:[B

    .line 26
    .line 27
    const/4 v6, 0x4

    .line 28
    invoke-static {v6, v1, v5}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 29
    .line 30
    .line 31
    iget-object v5, p0, Lcom/kousei/framework/wj;->O:[B

    .line 32
    .line 33
    invoke-static {v2, v1, v5}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 34
    .line 35
    .line 36
    iget-object v2, p0, Lcom/kousei/framework/wj;->P:[B

    .line 37
    .line 38
    invoke-static {v3, v1, v2}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 39
    .line 40
    .line 41
    iget-object v2, p0, Lcom/kousei/framework/wj;->Q:[B

    .line 42
    .line 43
    invoke-static {v4, v1, v2}, Lcom/kousei/framework/xc;->k(I[B[B)V
    :try_end_2d
    .catchall {:try_start_3 .. :try_end_2d} :catchall_49

    .line 44
    .line 45
    .line 46
    :try_start_2d
    iget-object v2, p0, Lcom/kousei/framework/wj;->R:Lcom/kousei/framework/z1;

    .line 47
    .line 48
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    .line 49
    .line 50
    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 51
    .line 52
    .line 53
    new-instance v4, Ljava/io/ObjectOutputStream;

    .line 54
    .line 55
    invoke-direct {v4, v3}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 56
    .line 57
    .line 58
    invoke-virtual {v4, v2}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    .line 59
    .line 60
    .line 61
    invoke-virtual {v4}, Ljava/io/ObjectOutputStream;->flush()V

    .line 62
    .line 63
    .line 64
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    .line 65
    .line 66
    .line 67
    move-result-object v0
    :try_end_43
    .catch Ljava/io/IOException; {:try_start_2d .. :try_end_43} :catch_4b
    .catchall {:try_start_2d .. :try_end_43} :catchall_49

    .line 68
    :try_start_43
    invoke-static {v1, v0}, Lcom/kousei/framework/i0;->M([B[B)[B

    .line 69
    .line 70
    .line 71
    move-result-object v0

    .line 72
    monitor-exit p0

    .line 73
    return-object v0

    .line 74
    :catchall_49
    move-exception v0

    .line 75
    goto :goto_62

    .line 76
    :catch_4b
    move-exception v1

    .line 77
    new-instance v2, Ljava/lang/RuntimeException;

    .line 78
    .line 79
    new-instance v3, Ljava/lang/StringBuilder;

    .line 80
    .line 81
    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 82
    .line 83
    .line 84
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    .line 85
    .line 86
    .line 87
    move-result-object v0

    .line 88
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 89
    .line 90
    .line 91
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 92
    .line 93
    .line 94
    move-result-object v0

    .line 95
    invoke-direct {v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 96
    .line 97
    .line 98
    throw v2

    .line 99
    :goto_62
    monitor-exit p0
    :try_end_63
    .catchall {:try_start_43 .. :try_end_63} :catchall_49

    .line 100
    throw v0
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

.method public final getEncoded()[B
    .registers 2

    .line 1
    monitor-enter p0

    .line 2
    :try_start_1
    invoke-virtual {p0}, Lcom/kousei/framework/wj;->a()[B

    .line 3
    .line 4
    .line 5
    move-result-object v0

    .line 6
    monitor-exit p0

    .line 7
    return-object v0

    .line 8
    :catchall_7
    move-exception v0

    .line 9
    monitor-exit p0
    :try_end_9
    .catchall {:try_start_1 .. :try_end_9} :catchall_7

    .line 10
    throw v0
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
