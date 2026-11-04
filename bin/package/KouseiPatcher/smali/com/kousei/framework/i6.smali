.class public final Lcom/kousei/framework/i6;
.super Lcom/kousei/framework/s;


# instance fields
.field public final K:Lcom/kousei/framework/q;

.field public final L:Lcom/kousei/framework/q;

.field public final M:Lcom/kousei/framework/q;

.field public final N:Lcom/kousei/framework/q;

.field public final O:Lcom/kousei/framework/mi;


# direct methods
.method public constructor <init>(Lcom/kousei/framework/d0;)V
    .registers 7

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 5
    .line 6
    .line 7
    move-result v0

    .line 8
    const/4 v1, 0x3

    .line 9
    const-string v2, "Bad sequence size: "

    .line 10
    .line 11
    const/4 v3, 0x0

    .line 12
    if-lt v0, v1, :cond_a0

    .line 13
    .line 14
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 15
    .line 16
    .line 17
    move-result v0

    .line 18
    const/4 v1, 0x5

    .line 19
    if-gt v0, v1, :cond_a0

    .line 20
    .line 21
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->u()Ljava/util/Enumeration;

    .line 22
    .line 23
    .line 24
    move-result-object p1

    .line 25
    invoke-interface {p1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 26
    .line 27
    .line 28
    move-result-object v0

    .line 29
    invoke-static {v0}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 30
    .line 31
    .line 32
    move-result-object v0

    .line 33
    iput-object v0, p0, Lcom/kousei/framework/i6;->K:Lcom/kousei/framework/q;

    .line 34
    .line 35
    invoke-interface {p1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 36
    .line 37
    .line 38
    move-result-object v0

    .line 39
    invoke-static {v0}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 40
    .line 41
    .line 42
    move-result-object v0

    .line 43
    iput-object v0, p0, Lcom/kousei/framework/i6;->L:Lcom/kousei/framework/q;

    .line 44
    .line 45
    invoke-interface {p1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 46
    .line 47
    .line 48
    move-result-object v0

    .line 49
    invoke-static {v0}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 50
    .line 51
    .line 52
    move-result-object v0

    .line 53
    iput-object v0, p0, Lcom/kousei/framework/i6;->M:Lcom/kousei/framework/q;

    .line 54
    .line 55
    invoke-interface {p1}, Ljava/util/Enumeration;->hasMoreElements()Z

    .line 56
    .line 57
    .line 58
    move-result v0

    .line 59
    if-eqz v0, :cond_43

    .line 60
    .line 61
    invoke-interface {p1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 62
    .line 63
    .line 64
    move-result-object v0

    .line 65
    check-cast v0, Lcom/kousei/framework/k;

    .line 66
    .line 67
    goto :goto_44

    .line 68
    :cond_43
    move-object v0, v3

    .line 69
    :goto_44
    if-eqz v0, :cond_60

    .line 70
    .line 71
    instance-of v1, v0, Lcom/kousei/framework/q;

    .line 72
    .line 73
    if-eqz v1, :cond_60

    .line 74
    .line 75
    invoke-static {v0}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 76
    .line 77
    .line 78
    move-result-object v0

    .line 79
    iput-object v0, p0, Lcom/kousei/framework/i6;->N:Lcom/kousei/framework/q;

    .line 80
    .line 81
    invoke-interface {p1}, Ljava/util/Enumeration;->hasMoreElements()Z

    .line 82
    .line 83
    .line 84
    move-result v0

    .line 85
    if-eqz v0, :cond_5e

    .line 86
    .line 87
    invoke-interface {p1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 88
    .line 89
    .line 90
    move-result-object p1

    .line 91
    check-cast p1, Lcom/kousei/framework/k;

    .line 92
    .line 93
    move-object v0, p1

    .line 94
    goto :goto_62

    .line 95
    :cond_5e
    move-object v0, v3

    .line 96
    goto :goto_62

    .line 97
    :cond_60
    iput-object v3, p0, Lcom/kousei/framework/i6;->N:Lcom/kousei/framework/q;

    .line 98
    .line 99
    :goto_62
    if-eqz v0, :cond_9d

    .line 100
    .line 101
    invoke-interface {v0}, Lcom/kousei/framework/k;->b()Lcom/kousei/framework/a0;

    .line 102
    .line 103
    .line 104
    move-result-object p1

    .line 105
    if-eqz p1, :cond_9a

    .line 106
    .line 107
    new-instance v0, Lcom/kousei/framework/mi;

    .line 108
    .line 109
    invoke-static {p1}, Lcom/kousei/framework/d0;->s(Ljava/lang/Object;)Lcom/kousei/framework/d0;

    .line 110
    .line 111
    .line 112
    move-result-object p1

    .line 113
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 114
    .line 115
    .line 116
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 117
    .line 118
    .line 119
    move-result v1

    .line 120
    const/4 v4, 0x2

    .line 121
    if-ne v1, v4, :cond_92

    .line 122
    .line 123
    const/4 v1, 0x0

    .line 124
    invoke-virtual {p1, v1}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 125
    .line 126
    .line 127
    move-result-object v1

    .line 128
    invoke-static {v1}, Lcom/kousei/framework/g;->s(Ljava/lang/Object;)Lcom/kousei/framework/g;

    .line 129
    .line 130
    .line 131
    move-result-object v1

    .line 132
    iput-object v1, v0, Lcom/kousei/framework/mi;->K:Lcom/kousei/framework/g;

    .line 133
    .line 134
    const/4 v1, 0x1

    .line 135
    invoke-virtual {p1, v1}, Lcom/kousei/framework/d0;->t(I)Lcom/kousei/framework/k;

    .line 136
    .line 137
    .line 138
    move-result-object p1

    .line 139
    invoke-static {p1}, Lcom/kousei/framework/q;->q(Ljava/lang/Object;)Lcom/kousei/framework/q;

    .line 140
    .line 141
    .line 142
    move-result-object p1

    .line 143
    iput-object p1, v0, Lcom/kousei/framework/mi;->L:Lcom/kousei/framework/q;

    .line 144
    .line 145
    move-object v3, v0

    .line 146
    goto :goto_9a

    .line 147
    :cond_92
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 148
    .line 149
    .line 150
    move-result p0

    .line 151
    invoke-static {p0, v2}, Lcom/kousei/framework/f;->i(ILjava/lang/String;)V

    .line 152
    .line 153
    .line 154
    throw v3

    .line 155
    :cond_9a
    :goto_9a
    iput-object v3, p0, Lcom/kousei/framework/i6;->O:Lcom/kousei/framework/mi;

    .line 156
    .line 157
    return-void

    .line 158
    :cond_9d
    iput-object v3, p0, Lcom/kousei/framework/i6;->O:Lcom/kousei/framework/mi;

    .line 159
    .line 160
    return-void

    .line 161
    :cond_a0
    invoke-virtual {p1}, Lcom/kousei/framework/d0;->size()I

    .line 162
    .line 163
    .line 164
    move-result p0

    .line 165
    invoke-static {p0, v2}, Lcom/kousei/framework/f;->i(ILjava/lang/String;)V

    .line 166
    .line 167
    .line 168
    throw v3
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
    .registers 3

    .line 1
    new-instance v0, Lcom/kousei/framework/l;

    .line 2
    .line 3
    const/4 v1, 0x5

    .line 4
    invoke-direct {v0, v1}, Lcom/kousei/framework/l;-><init>(I)V

    .line 5
    .line 6
    .line 7
    iget-object v1, p0, Lcom/kousei/framework/i6;->K:Lcom/kousei/framework/q;

    .line 8
    .line 9
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 10
    .line 11
    .line 12
    iget-object v1, p0, Lcom/kousei/framework/i6;->L:Lcom/kousei/framework/q;

    .line 13
    .line 14
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 15
    .line 16
    .line 17
    iget-object v1, p0, Lcom/kousei/framework/i6;->M:Lcom/kousei/framework/q;

    .line 18
    .line 19
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 20
    .line 21
    .line 22
    iget-object v1, p0, Lcom/kousei/framework/i6;->N:Lcom/kousei/framework/q;

    .line 23
    .line 24
    if-eqz v1, :cond_1c

    .line 25
    .line 26
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 27
    .line 28
    .line 29
    :cond_1c
    iget-object p0, p0, Lcom/kousei/framework/i6;->O:Lcom/kousei/framework/mi;

    .line 30
    .line 31
    if-eqz p0, :cond_23

    .line 32
    .line 33
    invoke-virtual {v0, p0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 34
    .line 35
    .line 36
    :cond_23
    new-instance p0, Lcom/kousei/framework/r4;

    .line 37
    .line 38
    const/4 v1, 0x0

    .line 39
    invoke-direct {p0, v0, v1}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 40
    .line 41
    .line 42
    const/4 v0, -0x1

    .line 43
    iput v0, p0, Lcom/kousei/framework/r4;->N:I

    .line 44
    .line 45
    return-object p0
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
