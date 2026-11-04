.class public final Lcom/kousei/framework/nj;
.super Lcom/kousei/framework/s;


# instance fields
.field public final K:I

.field public final L:J

.field public final M:J

.field public final N:[B

.field public final O:[B

.field public final P:[B

.field public final Q:[B

.field public final R:[B


# direct methods
.method public constructor <init>(J[B[B[B[B[B)V
    .registers 9

    .line 240
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 241
    iput v0, p0, Lcom/kousei/framework/nj;->K:I

    iput-wide p1, p0, Lcom/kousei/framework/nj;->L:J

    invoke-static {p3}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->N:[B

    invoke-static {p4}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->O:[B

    invoke-static {p5}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->P:[B

    invoke-static {p6}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->Q:[B

    invoke-static {p7}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->R:[B

    const-wide/16 p1, -0x1

    iput-wide p1, p0, Lcom/kousei/framework/nj;->M:J

    return-void
.end method

.method public constructor <init>(J[B[B[B[B[BJ)V
    .registers 11

    .line 238
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    .line 239
    iput v0, p0, Lcom/kousei/framework/nj;->K:I

    iput-wide p1, p0, Lcom/kousei/framework/nj;->L:J

    invoke-static {p3}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->N:[B

    invoke-static {p4}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->O:[B

    invoke-static {p5}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->P:[B

    invoke-static {p6}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->Q:[B

    invoke-static {p7}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/nj;->R:[B

    iput-wide p8, p0, Lcom/kousei/framework/nj;->M:J

    return-void
.end method

.method public constructor <init>(Lcom/kousei/framework/d0;)V
    .registers 11

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    const/4 v0, 0x0

    .line 5
    invoke-virtual {p1, v0}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 6
    .line 7
    .line 8
    move-result-object v1

    .line 9
    invoke-static {v1}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 10
    .line 11
    .line 12
    move-result-object v1

    .line 13
    invoke-virtual {v1, v0}, Lcom/kousei/framework/q;->t(I)Z

    .line 14
    .line 15
    .line 16
    move-result v2

    .line 17
    const/4 v3, 0x0

    .line 18
    const/4 v4, 0x1

    .line 19
    if-nez v2, :cond_21

    .line 20
    .line 21
    invoke-virtual {v1, v4}, Lcom/kousei/framework/q;->t(I)Z

    .line 22
    .line 23
    .line 24
    move-result v2

    .line 25
    if-eqz v2, :cond_1b

    .line 26
    .line 27
    goto :goto_21

    .line 28
    :cond_1b
    const-string p0, "unknown version of sequence"

    .line 29
    .line 30
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 31
    .line 32
    .line 33
    throw v3

    .line 34
    :cond_21
    :goto_21
    invoke-virtual {v1}, Lcom/kousei/framework/q;->w()I

    .line 35
    .line 36
    .line 37
    move-result v1

    .line 38
    iput v1, p0, Lcom/kousei/framework/nj;->K:I

    .line 39
    .line 40
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 41
    .line 42
    .line 43
    move-result v1

    .line 44
    const/4 v2, 0x3

    .line 45
    const/4 v5, 0x2

    .line 46
    if-eq v1, v5, :cond_3c

    .line 47
    .line 48
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 49
    .line 50
    .line 51
    move-result v1

    .line 52
    if-ne v1, v2, :cond_36

    .line 53
    .line 54
    goto :goto_3c

    .line 55
    :cond_36
    const-string p0, "key sequence wrong size"

    .line 56
    .line 57
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 58
    .line 59
    .line 60
    throw v3

    .line 61
    :cond_3c
    :goto_3c
    invoke-virtual {p1, v4}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 62
    .line 63
    .line 64
    move-result-object v1

    .line 65
    invoke-static {v1}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 66
    .line 67
    .line 68
    move-result-object v1

    .line 69
    invoke-virtual {v1, v0}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 70
    .line 71
    .line 72
    move-result-object v6

    .line 73
    invoke-static {v6}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 74
    .line 75
    .line 76
    move-result-object v6

    .line 77
    invoke-virtual {v6}, Lcom/kousei/framework/q;->y()J

    .line 78
    .line 79
    .line 80
    move-result-wide v6

    .line 81
    iput-wide v6, p0, Lcom/kousei/framework/nj;->L:J

    .line 82
    .line 83
    invoke-virtual {v1, v4}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 84
    .line 85
    .line 86
    move-result-object v6

    .line 87
    invoke-static {v6}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 88
    .line 89
    .line 90
    move-result-object v6

    .line 91
    iget-object v6, v6, Lcom/kousei/framework/w;->K:[B

    .line 92
    .line 93
    invoke-static {v6}, Lcom/kousei/framework/i0;->J([B)[B

    .line 94
    .line 95
    .line 96
    move-result-object v6

    .line 97
    iput-object v6, p0, Lcom/kousei/framework/nj;->N:[B

    .line 98
    .line 99
    invoke-virtual {v1, v5}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 100
    .line 101
    .line 102
    move-result-object v6

    .line 103
    invoke-static {v6}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 104
    .line 105
    .line 106
    move-result-object v6

    .line 107
    iget-object v6, v6, Lcom/kousei/framework/w;->K:[B

    .line 108
    .line 109
    invoke-static {v6}, Lcom/kousei/framework/i0;->J([B)[B

    .line 110
    .line 111
    .line 112
    move-result-object v6

    .line 113
    iput-object v6, p0, Lcom/kousei/framework/nj;->O:[B

    .line 114
    .line 115
    invoke-virtual {v1, v2}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 116
    .line 117
    .line 118
    move-result-object v6

    .line 119
    invoke-static {v6}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 120
    .line 121
    .line 122
    move-result-object v6

    .line 123
    iget-object v6, v6, Lcom/kousei/framework/w;->K:[B

    .line 124
    .line 125
    invoke-static {v6}, Lcom/kousei/framework/i0;->J([B)[B

    .line 126
    .line 127
    .line 128
    move-result-object v6

    .line 129
    iput-object v6, p0, Lcom/kousei/framework/nj;->P:[B

    .line 130
    .line 131
    const/4 v6, 0x4

    .line 132
    invoke-virtual {v1, v6}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 133
    .line 134
    .line 135
    move-result-object v6

    .line 136
    invoke-static {v6}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 137
    .line 138
    .line 139
    move-result-object v6

    .line 140
    iget-object v6, v6, Lcom/kousei/framework/w;->K:[B

    .line 141
    .line 142
    invoke-static {v6}, Lcom/kousei/framework/i0;->J([B)[B

    .line 143
    .line 144
    .line 145
    move-result-object v6

    .line 146
    iput-object v6, p0, Lcom/kousei/framework/nj;->Q:[B

    .line 147
    .line 148
    invoke-virtual {v1}, Lcom/kousei/framework/d0;->size()I

    .line 149
    .line 150
    .line 151
    move-result v6

    .line 152
    const/4 v7, 0x6

    .line 153
    const/4 v8, 0x5

    .line 154
    if-ne v6, v7, :cond_bc

    .line 155
    .line 156
    invoke-virtual {v1, v8}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 157
    .line 158
    .line 159
    move-result-object v1

    .line 160
    invoke-static {v1}, Lcom/kousei/framework/k2;->r(Ljava/lang/Object;)Lcom/kousei/framework/k2;

    .line 161
    .line 162
    .line 163
    move-result-object v1

    .line 164
    iget v6, v1, Lcom/kousei/framework/k2;->M:I

    .line 165
    .line 166
    if-nez v6, :cond_b6

    .line 167
    .line 168
    sget-object v6, Lcom/kousei/framework/q;->M:Lcom/kousei/framework/e;

    .line 169
    .line 170
    invoke-virtual {v6, v1, v0}, Lcom/kousei/framework/e;->d(Lcom/kousei/framework/k2;Z)Lcom/kousei/framework/a0;

    .line 171
    .line 172
    .line 173
    move-result-object v0

    .line 174
    check-cast v0, Lcom/kousei/framework/q;

    .line 175
    .line 176
    invoke-virtual {v0}, Lcom/kousei/framework/q;->y()J

    .line 177
    .line 178
    .line 179
    move-result-wide v0

    .line 180
    :goto_b3
    iput-wide v0, p0, Lcom/kousei/framework/nj;->M:J

    .line 181
    .line 182
    goto :goto_c5

    .line 183
    :cond_b6
    const-string p0, "unknown tag in XMSSPrivateKey"

    .line 184
    .line 185
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 186
    .line 187
    .line 188
    throw v3

    .line 189
    :cond_bc
    invoke-virtual {v1}, Lcom/kousei/framework/d0;->size()I

    .line 190
    .line 191
    .line 192
    move-result v0

    .line 193
    if-ne v0, v8, :cond_e7

    .line 194
    .line 195
    const-wide/16 v0, -0x1

    .line 196
    .line 197
    goto :goto_b3

    .line 198
    :goto_c5
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 199
    .line 200
    .line 201
    move-result v0

    .line 202
    if-ne v0, v2, :cond_e4

    .line 203
    .line 204
    invoke-virtual {p1, v5}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 205
    .line 206
    .line 207
    move-result-object p1

    .line 208
    invoke-static {p1}, Lcom/kousei/framework/k2;->r(Ljava/lang/Object;)Lcom/kousei/framework/k2;

    .line 209
    .line 210
    .line 211
    move-result-object p1

    .line 212
    sget-object v0, Lcom/kousei/framework/w;->L:Lcom/kousei/framework/e;

    .line 213
    .line 214
    invoke-virtual {v0, p1, v4}, Lcom/kousei/framework/e;->d(Lcom/kousei/framework/k2;Z)Lcom/kousei/framework/a0;

    .line 215
    .line 216
    .line 217
    move-result-object p1

    .line 218
    check-cast p1, Lcom/kousei/framework/w;

    .line 219
    .line 220
    iget-object p1, p1, Lcom/kousei/framework/w;->K:[B

    .line 221
    .line 222
    invoke-static {p1}, Lcom/kousei/framework/i0;->J([B)[B

    .line 223
    .line 224
    .line 225
    move-result-object p1

    .line 226
    iput-object p1, p0, Lcom/kousei/framework/nj;->R:[B

    .line 227
    .line 228
    return-void

    .line 229
    :cond_e4
    iput-object v3, p0, Lcom/kousei/framework/nj;->R:[B

    .line 230
    .line 231
    return-void

    .line 232
    :cond_e7
    const-string p0, "keySeq should be 5 or 6 in length"

    .line 233
    .line 234
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 235
    .line 236
    .line 237
    throw v3
    .line 238
    .line 239
    .line 240
    .line 241
    .line 242
.end method


# virtual methods
.method public final b()Lcom/kousei/framework/a0;
    .registers 19

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    new-instance v1, Lcom/kousei/framework/l;

    .line 4
    .line 5
    invoke-direct {v1}, Lcom/kousei/framework/l;-><init>()V

    .line 6
    .line 7
    .line 8
    iget-wide v2, v0, Lcom/kousei/framework/nj;->M:J

    .line 9
    .line 10
    const-wide/16 v4, 0x0

    .line 11
    .line 12
    cmp-long v6, v2, v4

    .line 13
    .line 14
    if-ltz v6, :cond_15

    .line 15
    .line 16
    sget-object v7, Lcom/kousei/framework/q;->P:Lcom/kousei/framework/q;

    .line 17
    .line 18
    :goto_11
    invoke-virtual {v1, v7}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 19
    .line 20
    .line 21
    goto :goto_18

    .line 22
    :cond_15
    sget-object v7, Lcom/kousei/framework/q;->O:Lcom/kousei/framework/q;

    .line 23
    .line 24
    goto :goto_11

    .line 25
    :goto_18
    new-instance v7, Lcom/kousei/framework/l;

    .line 26
    .line 27
    invoke-direct {v7}, Lcom/kousei/framework/l;-><init>()V

    .line 28
    .line 29
    .line 30
    iget-wide v8, v0, Lcom/kousei/framework/nj;->L:J

    .line 31
    .line 32
    cmp-long v4, v8, v4

    .line 33
    .line 34
    const-wide/16 v10, 0x11

    .line 35
    .line 36
    if-ltz v4, :cond_2f

    .line 37
    .line 38
    sget-object v4, Lcom/kousei/framework/q;->N:[Lcom/kousei/framework/q;

    .line 39
    .line 40
    cmp-long v5, v8, v10

    .line 41
    .line 42
    if-gez v5, :cond_2f

    .line 43
    .line 44
    long-to-int v5, v8

    .line 45
    aget-object v4, v4, v5

    .line 46
    .line 47
    goto :goto_34

    .line 48
    :cond_2f
    new-instance v4, Lcom/kousei/framework/q;

    .line 49
    .line 50
    invoke-direct {v4, v8, v9}, Lcom/kousei/framework/q;-><init>(J)V

    .line 51
    .line 52
    .line 53
    :goto_34
    invoke-virtual {v7, v4}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 54
    .line 55
    .line 56
    new-instance v4, Lcom/kousei/framework/o4;

    .line 57
    .line 58
    iget-object v5, v0, Lcom/kousei/framework/nj;->N:[B

    .line 59
    .line 60
    invoke-direct {v4, v5}, Lcom/kousei/framework/w;-><init>([B)V

    .line 61
    .line 62
    .line 63
    invoke-virtual {v7, v4}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 64
    .line 65
    .line 66
    new-instance v4, Lcom/kousei/framework/o4;

    .line 67
    .line 68
    iget-object v5, v0, Lcom/kousei/framework/nj;->O:[B

    .line 69
    .line 70
    invoke-direct {v4, v5}, Lcom/kousei/framework/w;-><init>([B)V

    .line 71
    .line 72
    .line 73
    invoke-virtual {v7, v4}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 74
    .line 75
    .line 76
    new-instance v4, Lcom/kousei/framework/o4;

    .line 77
    .line 78
    iget-object v5, v0, Lcom/kousei/framework/nj;->P:[B

    .line 79
    .line 80
    invoke-direct {v4, v5}, Lcom/kousei/framework/w;-><init>([B)V

    .line 81
    .line 82
    .line 83
    invoke-virtual {v7, v4}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 84
    .line 85
    .line 86
    new-instance v4, Lcom/kousei/framework/o4;

    .line 87
    .line 88
    iget-object v5, v0, Lcom/kousei/framework/nj;->Q:[B

    .line 89
    .line 90
    invoke-direct {v4, v5}, Lcom/kousei/framework/w;-><init>([B)V

    .line 91
    .line 92
    .line 93
    invoke-virtual {v7, v4}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 94
    .line 95
    .line 96
    const/4 v15, 0x0

    .line 97
    if-ltz v6, :cond_84

    .line 98
    .line 99
    new-instance v12, Lcom/kousei/framework/k2;

    .line 100
    .line 101
    if-ltz v6, :cond_72

    .line 102
    .line 103
    sget-object v4, Lcom/kousei/framework/q;->N:[Lcom/kousei/framework/q;

    .line 104
    .line 105
    cmp-long v5, v2, v10

    .line 106
    .line 107
    if-gez v5, :cond_72

    .line 108
    .line 109
    long-to-int v2, v2

    .line 110
    aget-object v2, v4, v2

    .line 111
    .line 112
    move-object/from16 v16, v2

    .line 113
    .line 114
    goto :goto_79

    .line 115
    :cond_72
    new-instance v4, Lcom/kousei/framework/q;

    .line 116
    .line 117
    invoke-direct {v4, v2, v3}, Lcom/kousei/framework/q;-><init>(J)V

    .line 118
    .line 119
    .line 120
    move-object/from16 v16, v4

    .line 121
    .line 122
    :goto_79
    const/4 v13, 0x2

    .line 123
    const/16 v17, 0x1

    .line 124
    .line 125
    const/16 v14, 0x80

    .line 126
    .line 127
    invoke-direct/range {v12 .. v17}, Lcom/kousei/framework/k2;-><init>(IIILcom/kousei/framework/k;I)V

    .line 128
    .line 129
    .line 130
    invoke-virtual {v7, v12}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 131
    .line 132
    .line 133
    :cond_84
    new-instance v2, Lcom/kousei/framework/r4;

    .line 134
    .line 135
    const/4 v3, 0x0

    .line 136
    invoke-direct {v2, v7, v3}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 137
    .line 138
    .line 139
    const/4 v4, -0x1

    .line 140
    iput v4, v2, Lcom/kousei/framework/r4;->N:I

    .line 141
    .line 142
    invoke-virtual {v1, v2}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 143
    .line 144
    .line 145
    new-instance v2, Lcom/kousei/framework/k2;

    .line 146
    .line 147
    new-instance v5, Lcom/kousei/framework/o4;

    .line 148
    .line 149
    iget-object v0, v0, Lcom/kousei/framework/nj;->R:[B

    .line 150
    .line 151
    invoke-direct {v5, v0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 152
    .line 153
    .line 154
    const/4 v0, 0x1

    .line 155
    invoke-direct {v2, v0, v15, v5, v0}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 156
    .line 157
    .line 158
    invoke-virtual {v1, v2}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 159
    .line 160
    .line 161
    new-instance v0, Lcom/kousei/framework/r4;

    .line 162
    .line 163
    invoke-direct {v0, v1, v3}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 164
    .line 165
    .line 166
    iput v4, v0, Lcom/kousei/framework/r4;->N:I

    .line 167
    .line 168
    return-object v0
    .line 169
    .line 170
    .line 171
    .line 172
.end method
