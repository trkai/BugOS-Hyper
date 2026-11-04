.class public final Lcom/kousei/framework/uj;
.super Lcom/kousei/framework/s;


# instance fields
.field public final K:I

.field public final L:I

.field public final M:[B

.field public final N:[B

.field public final O:[B

.field public final P:[B

.field public final Q:I

.field public final R:[B


# direct methods
.method public constructor <init>(I[B[B[B[B[B)V
    .registers 8

    .line 239
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 240
    iput v0, p0, Lcom/kousei/framework/uj;->K:I

    iput p1, p0, Lcom/kousei/framework/uj;->L:I

    invoke-static {p2}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->M:[B

    invoke-static {p3}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->N:[B

    invoke-static {p4}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->O:[B

    invoke-static {p5}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->P:[B

    invoke-static {p6}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->R:[B

    const/4 p1, -0x1

    iput p1, p0, Lcom/kousei/framework/uj;->Q:I

    return-void
.end method

.method public constructor <init>(I[B[B[B[B[BI)V
    .registers 9

    .line 237
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    .line 238
    iput v0, p0, Lcom/kousei/framework/uj;->K:I

    iput p1, p0, Lcom/kousei/framework/uj;->L:I

    invoke-static {p2}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->M:[B

    invoke-static {p3}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->N:[B

    invoke-static {p4}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->O:[B

    invoke-static {p5}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->P:[B

    invoke-static {p6}, Lcom/kousei/framework/i0;->J([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/kousei/framework/uj;->R:[B

    iput p7, p0, Lcom/kousei/framework/uj;->Q:I

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
    iput v1, p0, Lcom/kousei/framework/uj;->K:I

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
    invoke-virtual {v6}, Lcom/kousei/framework/q;->w()I

    .line 78
    .line 79
    .line 80
    move-result v6

    .line 81
    iput v6, p0, Lcom/kousei/framework/uj;->L:I

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
    iput-object v6, p0, Lcom/kousei/framework/uj;->M:[B

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
    iput-object v6, p0, Lcom/kousei/framework/uj;->N:[B

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
    iput-object v6, p0, Lcom/kousei/framework/uj;->O:[B

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
    iput-object v6, p0, Lcom/kousei/framework/uj;->P:[B

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
    invoke-virtual {v0}, Lcom/kousei/framework/q;->w()I

    .line 177
    .line 178
    .line 179
    move-result v0

    .line 180
    :goto_b3
    iput v0, p0, Lcom/kousei/framework/uj;->Q:I

    .line 181
    .line 182
    goto :goto_c4

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
    if-ne v0, v8, :cond_e6

    .line 194
    .line 195
    const/4 v0, -0x1

    .line 196
    goto :goto_b3

    .line 197
    :goto_c4
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 198
    .line 199
    .line 200
    move-result v0

    .line 201
    if-ne v0, v2, :cond_e3

    .line 202
    .line 203
    invoke-virtual {p1, v5}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 204
    .line 205
    .line 206
    move-result-object p1

    .line 207
    invoke-static {p1}, Lcom/kousei/framework/k2;->r(Ljava/lang/Object;)Lcom/kousei/framework/k2;

    .line 208
    .line 209
    .line 210
    move-result-object p1

    .line 211
    sget-object v0, Lcom/kousei/framework/w;->L:Lcom/kousei/framework/e;

    .line 212
    .line 213
    invoke-virtual {v0, p1, v4}, Lcom/kousei/framework/e;->d(Lcom/kousei/framework/k2;Z)Lcom/kousei/framework/a0;

    .line 214
    .line 215
    .line 216
    move-result-object p1

    .line 217
    check-cast p1, Lcom/kousei/framework/w;

    .line 218
    .line 219
    iget-object p1, p1, Lcom/kousei/framework/w;->K:[B

    .line 220
    .line 221
    invoke-static {p1}, Lcom/kousei/framework/i0;->J([B)[B

    .line 222
    .line 223
    .line 224
    move-result-object p1

    .line 225
    iput-object p1, p0, Lcom/kousei/framework/uj;->R:[B

    .line 226
    .line 227
    return-void

    .line 228
    :cond_e3
    iput-object v3, p0, Lcom/kousei/framework/uj;->R:[B

    .line 229
    .line 230
    return-void

    .line 231
    :cond_e6
    const-string p0, "keySeq should be 5 or 6 in length"

    .line 232
    .line 233
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 234
    .line 235
    .line 236
    throw v3
    .line 237
    .line 238
    .line 239
    .line 240
    .line 241
    .line 242
.end method


# virtual methods
.method public final b()Lcom/kousei/framework/a0;
    .registers 7

    .line 1
    new-instance v0, Lcom/kousei/framework/l;

    .line 2
    .line 3
    const/4 v1, 0x3

    .line 4
    invoke-direct {v0, v1}, Lcom/kousei/framework/l;-><init>(I)V

    .line 5
    .line 6
    .line 7
    iget v1, p0, Lcom/kousei/framework/uj;->Q:I

    .line 8
    .line 9
    if-ltz v1, :cond_10

    .line 10
    .line 11
    sget-object v2, Lcom/kousei/framework/q;->P:Lcom/kousei/framework/q;

    .line 12
    .line 13
    :goto_c
    invoke-virtual {v0, v2}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 14
    .line 15
    .line 16
    goto :goto_13

    .line 17
    :cond_10
    sget-object v2, Lcom/kousei/framework/q;->O:Lcom/kousei/framework/q;

    .line 18
    .line 19
    goto :goto_c

    .line 20
    :goto_13
    new-instance v2, Lcom/kousei/framework/l;

    .line 21
    .line 22
    invoke-direct {v2}, Lcom/kousei/framework/l;-><init>()V

    .line 23
    .line 24
    .line 25
    iget v3, p0, Lcom/kousei/framework/uj;->L:I

    .line 26
    .line 27
    invoke-static {v3}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 28
    .line 29
    .line 30
    move-result-object v3

    .line 31
    invoke-virtual {v2, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 32
    .line 33
    .line 34
    new-instance v3, Lcom/kousei/framework/o4;

    .line 35
    .line 36
    iget-object v4, p0, Lcom/kousei/framework/uj;->M:[B

    .line 37
    .line 38
    invoke-direct {v3, v4}, Lcom/kousei/framework/w;-><init>([B)V

    .line 39
    .line 40
    .line 41
    invoke-virtual {v2, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 42
    .line 43
    .line 44
    new-instance v3, Lcom/kousei/framework/o4;

    .line 45
    .line 46
    iget-object v4, p0, Lcom/kousei/framework/uj;->N:[B

    .line 47
    .line 48
    invoke-direct {v3, v4}, Lcom/kousei/framework/w;-><init>([B)V

    .line 49
    .line 50
    .line 51
    invoke-virtual {v2, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 52
    .line 53
    .line 54
    new-instance v3, Lcom/kousei/framework/o4;

    .line 55
    .line 56
    iget-object v4, p0, Lcom/kousei/framework/uj;->O:[B

    .line 57
    .line 58
    invoke-direct {v3, v4}, Lcom/kousei/framework/w;-><init>([B)V

    .line 59
    .line 60
    .line 61
    invoke-virtual {v2, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 62
    .line 63
    .line 64
    new-instance v3, Lcom/kousei/framework/o4;

    .line 65
    .line 66
    iget-object v4, p0, Lcom/kousei/framework/uj;->P:[B

    .line 67
    .line 68
    invoke-direct {v3, v4}, Lcom/kousei/framework/w;-><init>([B)V

    .line 69
    .line 70
    .line 71
    invoke-virtual {v2, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 72
    .line 73
    .line 74
    const/4 v3, 0x0

    .line 75
    if-ltz v1, :cond_59

    .line 76
    .line 77
    new-instance v4, Lcom/kousei/framework/k2;

    .line 78
    .line 79
    invoke-static {v1}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 80
    .line 81
    .line 82
    move-result-object v1

    .line 83
    const/4 v5, 0x1

    .line 84
    invoke-direct {v4, v3, v3, v1, v5}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 85
    .line 86
    .line 87
    invoke-virtual {v2, v4}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 88
    .line 89
    .line 90
    :cond_59
    new-instance v1, Lcom/kousei/framework/r4;

    .line 91
    .line 92
    const/4 v4, 0x0

    .line 93
    invoke-direct {v1, v2, v4}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 94
    .line 95
    .line 96
    const/4 v2, -0x1

    .line 97
    iput v2, v1, Lcom/kousei/framework/r4;->N:I

    .line 98
    .line 99
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 100
    .line 101
    .line 102
    new-instance v1, Lcom/kousei/framework/k2;

    .line 103
    .line 104
    new-instance v4, Lcom/kousei/framework/o4;

    .line 105
    .line 106
    iget-object p0, p0, Lcom/kousei/framework/uj;->R:[B

    .line 107
    .line 108
    invoke-direct {v4, p0}, Lcom/kousei/framework/w;-><init>([B)V

    .line 109
    .line 110
    .line 111
    const/4 p0, 0x1

    .line 112
    const/4 v5, 0x1

    .line 113
    invoke-direct {v1, v5, v3, v4, p0}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 114
    .line 115
    .line 116
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 117
    .line 118
    .line 119
    new-instance p0, Lcom/kousei/framework/r4;

    .line 120
    .line 121
    const/4 v1, 0x0

    .line 122
    invoke-direct {p0, v0, v1}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 123
    .line 124
    .line 125
    iput v2, p0, Lcom/kousei/framework/r4;->N:I

    .line 126
    .line 127
    return-object p0
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
