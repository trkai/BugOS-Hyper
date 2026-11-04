.class public final Lcom/kousei/framework/pj;
.super Lcom/kousei/framework/hf;

# interfaces
.implements Lcom/kousei/framework/y7;


# instance fields
.field public final M:Lcom/kousei/framework/mj;

.field public final N:[B

.field public final O:[B

.field public final P:[B

.field public final Q:[B

.field public volatile R:J

.field public volatile S:Lcom/kousei/framework/a2;


# direct methods
.method public constructor <init>(Lcom/kousei/framework/oj;)V
    .registers 9

    .line 1
    iget-object v1, p1, Lcom/kousei/framework/oj;->a:Lcom/kousei/framework/mj;

    .line 2
    .line 3
    iget-object v0, v1, Lcom/kousei/framework/mj;->b:Lcom/kousei/framework/tj;

    .line 4
    .line 5
    iget-object v2, v0, Lcom/kousei/framework/tj;->e:Ljava/lang/String;

    .line 6
    .line 7
    const/4 v3, 0x1

    .line 8
    invoke-direct {p0, v2, v3}, Lcom/kousei/framework/hf;-><init>(Ljava/lang/String;Z)V

    .line 9
    .line 10
    .line 11
    iput-object v1, p0, Lcom/kousei/framework/pj;->M:Lcom/kousei/framework/mj;

    .line 12
    .line 13
    iget v0, v0, Lcom/kousei/framework/tj;->f:I

    .line 14
    .line 15
    iget-wide v2, p1, Lcom/kousei/framework/oj;->b:J

    .line 16
    .line 17
    iput-wide v2, p0, Lcom/kousei/framework/pj;->R:J

    .line 18
    .line 19
    iget-object v5, p1, Lcom/kousei/framework/oj;->d:[B

    .line 20
    .line 21
    const/4 v6, 0x0

    .line 22
    if-eqz v5, :cond_23

    .line 23
    .line 24
    array-length v2, v5

    .line 25
    if-ne v2, v0, :cond_1d

    .line 26
    .line 27
    iput-object v5, p0, Lcom/kousei/framework/pj;->N:[B

    .line 28
    .line 29
    goto :goto_27

    .line 30
    :cond_1d
    const-string p0, "size of secretKeySeed needs to be equal size of digest"

    .line 31
    .line 32
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 33
    .line 34
    .line 35
    throw v6

    .line 36
    :cond_23
    new-array v2, v0, [B

    .line 37
    .line 38
    iput-object v2, p0, Lcom/kousei/framework/pj;->N:[B

    .line 39
    .line 40
    :goto_27
    iget-object v2, p1, Lcom/kousei/framework/oj;->e:[B

    .line 41
    .line 42
    if-eqz v2, :cond_37

    .line 43
    .line 44
    array-length v3, v2

    .line 45
    if-ne v3, v0, :cond_31

    .line 46
    .line 47
    iput-object v2, p0, Lcom/kousei/framework/pj;->O:[B

    .line 48
    .line 49
    goto :goto_3b

    .line 50
    :cond_31
    const-string p0, "size of secretKeyPRF needs to be equal size of digest"

    .line 51
    .line 52
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 53
    .line 54
    .line 55
    throw v6

    .line 56
    :cond_37
    new-array v2, v0, [B

    .line 57
    .line 58
    iput-object v2, p0, Lcom/kousei/framework/pj;->O:[B

    .line 59
    .line 60
    :goto_3b
    iget-object v4, p1, Lcom/kousei/framework/oj;->f:[B

    .line 61
    .line 62
    if-eqz v4, :cond_4b

    .line 63
    .line 64
    array-length v2, v4

    .line 65
    if-ne v2, v0, :cond_45

    .line 66
    .line 67
    iput-object v4, p0, Lcom/kousei/framework/pj;->P:[B

    .line 68
    .line 69
    goto :goto_4f

    .line 70
    :cond_45
    const-string p0, "size of publicSeed needs to be equal size of digest"

    .line 71
    .line 72
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 73
    .line 74
    .line 75
    throw v6

    .line 76
    :cond_4b
    new-array v2, v0, [B

    .line 77
    .line 78
    iput-object v2, p0, Lcom/kousei/framework/pj;->P:[B

    .line 79
    .line 80
    :goto_4f
    iget-object v2, p1, Lcom/kousei/framework/oj;->g:[B

    .line 81
    .line 82
    if-eqz v2, :cond_5f

    .line 83
    .line 84
    array-length v3, v2

    .line 85
    if-ne v3, v0, :cond_59

    .line 86
    .line 87
    iput-object v2, p0, Lcom/kousei/framework/pj;->Q:[B

    .line 88
    .line 89
    goto :goto_63

    .line 90
    :cond_59
    const-string p0, "size of root needs to be equal size of digest"

    .line 91
    .line 92
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 93
    .line 94
    .line 95
    throw v6

    .line 96
    :cond_5f
    new-array v0, v0, [B

    .line 97
    .line 98
    iput-object v0, p0, Lcom/kousei/framework/pj;->Q:[B

    .line 99
    .line 100
    :goto_63
    iget-object v0, p1, Lcom/kousei/framework/oj;->h:Lcom/kousei/framework/a2;

    .line 101
    .line 102
    if-eqz v0, :cond_6a

    .line 103
    .line 104
    :goto_67
    iput-object v0, p0, Lcom/kousei/framework/pj;->S:Lcom/kousei/framework/a2;

    .line 105
    .line 106
    goto :goto_8b

    .line 107
    :cond_6a
    iget-wide v2, p1, Lcom/kousei/framework/oj;->b:J

    .line 108
    .line 109
    iget v0, v1, Lcom/kousei/framework/mj;->c:I

    .line 110
    .line 111
    invoke-static {v0, v2, v3}, Lcom/kousei/framework/xc;->L(IJ)Z

    .line 112
    .line 113
    .line 114
    move-result v0

    .line 115
    if-eqz v0, :cond_80

    .line 116
    .line 117
    if-eqz v4, :cond_80

    .line 118
    .line 119
    if-eqz v5, :cond_80

    .line 120
    .line 121
    new-instance v0, Lcom/kousei/framework/a2;

    .line 122
    .line 123
    iget-wide v2, p1, Lcom/kousei/framework/oj;->b:J

    .line 124
    .line 125
    invoke-direct/range {v0 .. v5}, Lcom/kousei/framework/a2;-><init>(Lcom/kousei/framework/mj;J[B[B)V

    .line 126
    .line 127
    .line 128
    goto :goto_67

    .line 129
    :cond_80
    new-instance v0, Lcom/kousei/framework/a2;

    .line 130
    .line 131
    iget-wide v1, p1, Lcom/kousei/framework/oj;->c:J

    .line 132
    .line 133
    const-wide/16 v3, 0x1

    .line 134
    .line 135
    add-long/2addr v1, v3

    .line 136
    invoke-direct {v0, v1, v2}, Lcom/kousei/framework/a2;-><init>(J)V

    .line 137
    .line 138
    .line 139
    goto :goto_67

    .line 140
    :goto_8b
    iget-wide v0, p1, Lcom/kousei/framework/oj;->c:J

    .line 141
    .line 142
    const-wide/16 v2, 0x0

    .line 143
    .line 144
    cmp-long p1, v0, v2

    .line 145
    .line 146
    if-ltz p1, :cond_a2

    .line 147
    .line 148
    iget-object p0, p0, Lcom/kousei/framework/pj;->S:Lcom/kousei/framework/a2;

    .line 149
    .line 150
    iget-wide p0, p0, Lcom/kousei/framework/a2;->L:J

    .line 151
    .line 152
    cmp-long p0, v0, p0

    .line 153
    .line 154
    if-nez p0, :cond_9c

    .line 155
    .line 156
    goto :goto_a2

    .line 157
    :cond_9c
    const-string p0, "maxIndex set but not reflected in state"

    .line 158
    .line 159
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 160
    .line 161
    .line 162
    throw v6

    .line 163
    :cond_a2
    :goto_a2
    return-void
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
    .registers 9

    .line 1
    const-string v0, "error serializing bds state: "

    .line 2
    .line 3
    monitor-enter p0

    .line 4
    :try_start_3
    iget-object v1, p0, Lcom/kousei/framework/pj;->M:Lcom/kousei/framework/mj;

    .line 5
    .line 6
    iget-object v2, v1, Lcom/kousei/framework/mj;->b:Lcom/kousei/framework/tj;

    .line 7
    .line 8
    iget v2, v2, Lcom/kousei/framework/tj;->f:I

    .line 9
    .line 10
    iget v1, v1, Lcom/kousei/framework/mj;->c:I

    .line 11
    .line 12
    add-int/lit8 v1, v1, 0x7

    .line 13
    .line 14
    div-int/lit8 v1, v1, 0x8

    .line 15
    .line 16
    add-int v3, v1, v2

    .line 17
    .line 18
    add-int v4, v3, v2

    .line 19
    .line 20
    add-int v5, v4, v2

    .line 21
    .line 22
    add-int/2addr v2, v5

    .line 23
    new-array v2, v2, [B

    .line 24
    .line 25
    iget-wide v6, p0, Lcom/kousei/framework/pj;->R:J

    .line 26
    .line 27
    invoke-static {v1, v6, v7}, Lcom/kousei/framework/xc;->s0(IJ)[B

    .line 28
    .line 29
    .line 30
    move-result-object v6

    .line 31
    const/4 v7, 0x0

    .line 32
    invoke-static {v7, v2, v6}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 33
    .line 34
    .line 35
    iget-object v6, p0, Lcom/kousei/framework/pj;->N:[B

    .line 36
    .line 37
    invoke-static {v1, v2, v6}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 38
    .line 39
    .line 40
    iget-object v1, p0, Lcom/kousei/framework/pj;->O:[B

    .line 41
    .line 42
    invoke-static {v3, v2, v1}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 43
    .line 44
    .line 45
    iget-object v1, p0, Lcom/kousei/framework/pj;->P:[B

    .line 46
    .line 47
    invoke-static {v4, v2, v1}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 48
    .line 49
    .line 50
    iget-object v1, p0, Lcom/kousei/framework/pj;->Q:[B

    .line 51
    .line 52
    invoke-static {v5, v2, v1}, Lcom/kousei/framework/xc;->k(I[B[B)V
    :try_end_36
    .catchall {:try_start_3 .. :try_end_36} :catchall_52

    .line 53
    .line 54
    .line 55
    :try_start_36
    iget-object v1, p0, Lcom/kousei/framework/pj;->S:Lcom/kousei/framework/a2;

    .line 56
    .line 57
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    .line 58
    .line 59
    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 60
    .line 61
    .line 62
    new-instance v4, Ljava/io/ObjectOutputStream;

    .line 63
    .line 64
    invoke-direct {v4, v3}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 65
    .line 66
    .line 67
    invoke-virtual {v4, v1}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    .line 68
    .line 69
    .line 70
    invoke-virtual {v4}, Ljava/io/ObjectOutputStream;->flush()V

    .line 71
    .line 72
    .line 73
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    .line 74
    .line 75
    .line 76
    move-result-object v1

    .line 77
    invoke-static {v2, v1}, Lcom/kousei/framework/i0;->M([B[B)[B

    .line 78
    .line 79
    .line 80
    move-result-object v0
    :try_end_50
    .catch Ljava/io/IOException; {:try_start_36 .. :try_end_50} :catch_54
    .catchall {:try_start_36 .. :try_end_50} :catchall_52

    .line 81
    :try_start_50
    monitor-exit p0

    .line 82
    return-object v0

    .line 83
    :catchall_52
    move-exception v0

    .line 84
    goto :goto_6b

    .line 85
    :catch_54
    move-exception v1

    .line 86
    new-instance v2, Ljava/lang/IllegalStateException;

    .line 87
    .line 88
    new-instance v3, Ljava/lang/StringBuilder;

    .line 89
    .line 90
    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 91
    .line 92
    .line 93
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    .line 94
    .line 95
    .line 96
    move-result-object v0

    .line 97
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 98
    .line 99
    .line 100
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 101
    .line 102
    .line 103
    move-result-object v0

    .line 104
    invoke-direct {v2, v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 105
    .line 106
    .line 107
    throw v2

    .line 108
    :goto_6b
    monitor-exit p0
    :try_end_6c
    .catchall {:try_start_50 .. :try_end_6c} :catchall_52

    .line 109
    throw v0
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
    invoke-virtual {p0}, Lcom/kousei/framework/pj;->a()[B

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
