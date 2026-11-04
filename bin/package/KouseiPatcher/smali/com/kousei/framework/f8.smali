.class public final Lcom/kousei/framework/f8;
.super Lcom/kousei/framework/s;


# instance fields
.field public K:I

.field public L:[B

.field public M:[B

.field public N:[B

.field public O:Lcom/kousei/framework/h8;


# direct methods
.method public static h(Lcom/kousei/framework/a0;)Lcom/kousei/framework/f8;
    .registers 6

    .line 1
    const/4 v0, 0x0

    .line 2
    if-eqz p0, :cond_87

    .line 3
    .line 4
    new-instance v1, Lcom/kousei/framework/f8;

    .line 5
    .line 6
    invoke-static {p0}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 7
    .line 8
    .line 9
    move-result-object p0

    .line 10
    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    .line 11
    .line 12
    .line 13
    const/4 v2, 0x0

    .line 14
    invoke-virtual {p0, v2}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 15
    .line 16
    .line 17
    move-result-object v3

    .line 18
    invoke-static {v3}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 19
    .line 20
    .line 21
    move-result-object v3

    .line 22
    invoke-virtual {v3}, Lcom/kousei/framework/q;->w()I

    .line 23
    .line 24
    .line 25
    move-result v3

    .line 26
    iput v3, v1, Lcom/kousei/framework/f8;->K:I

    .line 27
    .line 28
    if-nez v3, :cond_82

    .line 29
    .line 30
    const/4 v3, 0x1

    .line 31
    invoke-virtual {p0, v3}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 32
    .line 33
    .line 34
    move-result-object v3

    .line 35
    invoke-static {v3}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 36
    .line 37
    .line 38
    move-result-object v3

    .line 39
    iget-object v3, v3, Lcom/kousei/framework/w;->K:[B

    .line 40
    .line 41
    invoke-static {v3}, Lcom/kousei/framework/i0;->J([B)[B

    .line 42
    .line 43
    .line 44
    move-result-object v3

    .line 45
    iput-object v3, v1, Lcom/kousei/framework/f8;->L:[B

    .line 46
    .line 47
    const/4 v3, 0x2

    .line 48
    invoke-virtual {p0, v3}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 49
    .line 50
    .line 51
    move-result-object v3

    .line 52
    invoke-static {v3}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 53
    .line 54
    .line 55
    move-result-object v3

    .line 56
    iget-object v3, v3, Lcom/kousei/framework/w;->K:[B

    .line 57
    .line 58
    invoke-static {v3}, Lcom/kousei/framework/i0;->J([B)[B

    .line 59
    .line 60
    .line 61
    move-result-object v3

    .line 62
    iput-object v3, v1, Lcom/kousei/framework/f8;->M:[B

    .line 63
    .line 64
    const/4 v3, 0x3

    .line 65
    invoke-virtual {p0, v3}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 66
    .line 67
    .line 68
    move-result-object v3

    .line 69
    invoke-static {v3}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 70
    .line 71
    .line 72
    move-result-object v3

    .line 73
    iget-object v3, v3, Lcom/kousei/framework/w;->K:[B

    .line 74
    .line 75
    invoke-static {v3}, Lcom/kousei/framework/i0;->J([B)[B

    .line 76
    .line 77
    .line 78
    move-result-object v3

    .line 79
    iput-object v3, v1, Lcom/kousei/framework/f8;->N:[B

    .line 80
    .line 81
    invoke-virtual {p0}, Lcom/kousei/framework/d0;->size()I

    .line 82
    .line 83
    .line 84
    move-result v3

    .line 85
    const/4 v4, 0x5

    .line 86
    if-ne v3, v4, :cond_81

    .line 87
    .line 88
    const/4 v3, 0x4

    .line 89
    invoke-virtual {p0, v3}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 90
    .line 91
    .line 92
    move-result-object p0

    .line 93
    instance-of v3, p0, Lcom/kousei/framework/h8;

    .line 94
    .line 95
    if-eqz v3, :cond_64

    .line 96
    .line 97
    move-object v0, p0

    .line 98
    check-cast v0, Lcom/kousei/framework/h8;

    .line 99
    .line 100
    goto :goto_7f

    .line 101
    :cond_64
    if-eqz p0, :cond_7f

    .line 102
    .line 103
    new-instance v0, Lcom/kousei/framework/h8;

    .line 104
    .line 105
    invoke-static {p0}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 106
    .line 107
    .line 108
    move-result-object p0

    .line 109
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 110
    .line 111
    .line 112
    invoke-virtual {p0, v2}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 113
    .line 114
    .line 115
    move-result-object p0

    .line 116
    invoke-static {p0}, Lcom/kousei/framework/w;->q(Ljava/lang/Object;)Lcom/kousei/framework/w;

    .line 117
    .line 118
    .line 119
    move-result-object p0

    .line 120
    iget-object p0, p0, Lcom/kousei/framework/w;->K:[B

    .line 121
    .line 122
    invoke-static {p0}, Lcom/kousei/framework/i0;->J([B)[B

    .line 123
    .line 124
    .line 125
    move-result-object p0

    .line 126
    iput-object p0, v0, Lcom/kousei/framework/h8;->K:[B

    .line 127
    .line 128
    :cond_7f
    :goto_7f
    iput-object v0, v1, Lcom/kousei/framework/f8;->O:Lcom/kousei/framework/h8;

    .line 129
    .line 130
    :cond_81
    return-object v1

    .line 131
    :cond_82
    const-string p0, "unrecognized version"

    .line 132
    .line 133
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 134
    .line 135
    .line 136
    :cond_87
    return-object v0
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


# virtual methods
.method public final b()Lcom/kousei/framework/a0;
    .registers 4

    .line 1
    new-instance v0, Lcom/kousei/framework/l;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/kousei/framework/l;-><init>()V

    .line 4
    .line 5
    .line 6
    iget v1, p0, Lcom/kousei/framework/f8;->K:I

    .line 7
    .line 8
    invoke-static {v1}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 9
    .line 10
    .line 11
    move-result-object v1

    .line 12
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 13
    .line 14
    .line 15
    new-instance v1, Lcom/kousei/framework/o4;

    .line 16
    .line 17
    iget-object v2, p0, Lcom/kousei/framework/f8;->L:[B

    .line 18
    .line 19
    invoke-direct {v1, v2}, Lcom/kousei/framework/w;-><init>([B)V

    .line 20
    .line 21
    .line 22
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 23
    .line 24
    .line 25
    new-instance v1, Lcom/kousei/framework/o4;

    .line 26
    .line 27
    iget-object v2, p0, Lcom/kousei/framework/f8;->M:[B

    .line 28
    .line 29
    invoke-direct {v1, v2}, Lcom/kousei/framework/w;-><init>([B)V

    .line 30
    .line 31
    .line 32
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 33
    .line 34
    .line 35
    new-instance v1, Lcom/kousei/framework/o4;

    .line 36
    .line 37
    iget-object v2, p0, Lcom/kousei/framework/f8;->N:[B

    .line 38
    .line 39
    invoke-direct {v1, v2}, Lcom/kousei/framework/w;-><init>([B)V

    .line 40
    .line 41
    .line 42
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 43
    .line 44
    .line 45
    iget-object p0, p0, Lcom/kousei/framework/f8;->O:Lcom/kousei/framework/h8;

    .line 46
    .line 47
    if-eqz p0, :cond_3a

    .line 48
    .line 49
    new-instance v1, Lcom/kousei/framework/h8;

    .line 50
    .line 51
    iget-object p0, p0, Lcom/kousei/framework/h8;->K:[B

    .line 52
    .line 53
    invoke-direct {v1, p0}, Lcom/kousei/framework/h8;-><init>([B)V

    .line 54
    .line 55
    .line 56
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 57
    .line 58
    .line 59
    :cond_3a
    new-instance p0, Lcom/kousei/framework/r4;

    .line 60
    .line 61
    const/4 v1, 0x0

    .line 62
    invoke-direct {p0, v0, v1}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 63
    .line 64
    .line 65
    const/4 v0, -0x1

    .line 66
    iput v0, p0, Lcom/kousei/framework/r4;->N:I

    .line 67
    .line 68
    return-object p0
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
