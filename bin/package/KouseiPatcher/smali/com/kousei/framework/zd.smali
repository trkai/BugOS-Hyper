.class public final Lcom/kousei/framework/zd;
.super Lcom/kousei/framework/s;


# instance fields
.field public K:Ljava/math/BigInteger;

.field public L:Ljava/math/BigInteger;

.field public M:Ljava/math/BigInteger;

.field public N:Ljava/math/BigInteger;

.field public O:Ljava/math/BigInteger;

.field public P:Ljava/math/BigInteger;

.field public Q:Ljava/math/BigInteger;

.field public R:Ljava/math/BigInteger;

.field public S:Ljava/math/BigInteger;

.field public T:Lcom/kousei/framework/d0;


# direct methods
.method public static h(Lcom/kousei/framework/a0;)Lcom/kousei/framework/zd;
    .registers 6

    .line 1
    const/4 v0, 0x0

    .line 2
    if-eqz p0, :cond_9b

    .line 3
    .line 4
    new-instance v1, Lcom/kousei/framework/zd;

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
    iput-object v0, v1, Lcom/kousei/framework/zd;->T:Lcom/kousei/framework/d0;

    .line 14
    .line 15
    invoke-virtual {p0}, Lcom/kousei/framework/d0;->u()Ljava/util/Enumeration;

    .line 16
    .line 17
    .line 18
    move-result-object p0

    .line 19
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 20
    .line 21
    .line 22
    move-result-object v2

    .line 23
    check-cast v2, Lcom/kousei/framework/q;

    .line 24
    .line 25
    invoke-virtual {v2}, Lcom/kousei/framework/q;->w()I

    .line 26
    .line 27
    .line 28
    move-result v3

    .line 29
    if-ltz v3, :cond_96

    .line 30
    .line 31
    const/4 v4, 0x1

    .line 32
    if-gt v3, v4, :cond_96

    .line 33
    .line 34
    invoke-virtual {v2}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 35
    .line 36
    .line 37
    move-result-object v0

    .line 38
    iput-object v0, v1, Lcom/kousei/framework/zd;->K:Ljava/math/BigInteger;

    .line 39
    .line 40
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 41
    .line 42
    .line 43
    move-result-object v0

    .line 44
    check-cast v0, Lcom/kousei/framework/q;

    .line 45
    .line 46
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 47
    .line 48
    .line 49
    move-result-object v0

    .line 50
    iput-object v0, v1, Lcom/kousei/framework/zd;->L:Ljava/math/BigInteger;

    .line 51
    .line 52
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 53
    .line 54
    .line 55
    move-result-object v0

    .line 56
    check-cast v0, Lcom/kousei/framework/q;

    .line 57
    .line 58
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 59
    .line 60
    .line 61
    move-result-object v0

    .line 62
    iput-object v0, v1, Lcom/kousei/framework/zd;->M:Ljava/math/BigInteger;

    .line 63
    .line 64
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 65
    .line 66
    .line 67
    move-result-object v0

    .line 68
    check-cast v0, Lcom/kousei/framework/q;

    .line 69
    .line 70
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 71
    .line 72
    .line 73
    move-result-object v0

    .line 74
    iput-object v0, v1, Lcom/kousei/framework/zd;->N:Ljava/math/BigInteger;

    .line 75
    .line 76
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 77
    .line 78
    .line 79
    move-result-object v0

    .line 80
    check-cast v0, Lcom/kousei/framework/q;

    .line 81
    .line 82
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 83
    .line 84
    .line 85
    move-result-object v0

    .line 86
    iput-object v0, v1, Lcom/kousei/framework/zd;->O:Ljava/math/BigInteger;

    .line 87
    .line 88
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 89
    .line 90
    .line 91
    move-result-object v0

    .line 92
    check-cast v0, Lcom/kousei/framework/q;

    .line 93
    .line 94
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 95
    .line 96
    .line 97
    move-result-object v0

    .line 98
    iput-object v0, v1, Lcom/kousei/framework/zd;->P:Ljava/math/BigInteger;

    .line 99
    .line 100
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 101
    .line 102
    .line 103
    move-result-object v0

    .line 104
    check-cast v0, Lcom/kousei/framework/q;

    .line 105
    .line 106
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 107
    .line 108
    .line 109
    move-result-object v0

    .line 110
    iput-object v0, v1, Lcom/kousei/framework/zd;->Q:Ljava/math/BigInteger;

    .line 111
    .line 112
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 113
    .line 114
    .line 115
    move-result-object v0

    .line 116
    check-cast v0, Lcom/kousei/framework/q;

    .line 117
    .line 118
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 119
    .line 120
    .line 121
    move-result-object v0

    .line 122
    iput-object v0, v1, Lcom/kousei/framework/zd;->R:Ljava/math/BigInteger;

    .line 123
    .line 124
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 125
    .line 126
    .line 127
    move-result-object v0

    .line 128
    check-cast v0, Lcom/kousei/framework/q;

    .line 129
    .line 130
    invoke-virtual {v0}, Lcom/kousei/framework/q;->s()Ljava/math/BigInteger;

    .line 131
    .line 132
    .line 133
    move-result-object v0

    .line 134
    iput-object v0, v1, Lcom/kousei/framework/zd;->S:Ljava/math/BigInteger;

    .line 135
    .line 136
    invoke-interface {p0}, Ljava/util/Enumeration;->hasMoreElements()Z

    .line 137
    .line 138
    .line 139
    move-result v0

    .line 140
    if-eqz v0, :cond_95

    .line 141
    .line 142
    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    .line 143
    .line 144
    .line 145
    move-result-object p0

    .line 146
    check-cast p0, Lcom/kousei/framework/d0;

    .line 147
    .line 148
    iput-object p0, v1, Lcom/kousei/framework/zd;->T:Lcom/kousei/framework/d0;

    .line 149
    .line 150
    :cond_95
    return-object v1

    .line 151
    :cond_96
    const-string p0, "wrong version for RSA private key"

    .line 152
    .line 153
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 154
    .line 155
    .line 156
    :cond_9b
    return-object v0
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
    const/16 v1, 0xa

    .line 4
    .line 5
    invoke-direct {v0, v1}, Lcom/kousei/framework/l;-><init>(I)V

    .line 6
    .line 7
    .line 8
    new-instance v1, Lcom/kousei/framework/q;

    .line 9
    .line 10
    iget-object v2, p0, Lcom/kousei/framework/zd;->K:Ljava/math/BigInteger;

    .line 11
    .line 12
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 13
    .line 14
    .line 15
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 16
    .line 17
    .line 18
    new-instance v1, Lcom/kousei/framework/q;

    .line 19
    .line 20
    iget-object v2, p0, Lcom/kousei/framework/zd;->L:Ljava/math/BigInteger;

    .line 21
    .line 22
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 23
    .line 24
    .line 25
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 26
    .line 27
    .line 28
    new-instance v1, Lcom/kousei/framework/q;

    .line 29
    .line 30
    iget-object v2, p0, Lcom/kousei/framework/zd;->M:Ljava/math/BigInteger;

    .line 31
    .line 32
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 33
    .line 34
    .line 35
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 36
    .line 37
    .line 38
    new-instance v1, Lcom/kousei/framework/q;

    .line 39
    .line 40
    iget-object v2, p0, Lcom/kousei/framework/zd;->N:Ljava/math/BigInteger;

    .line 41
    .line 42
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 43
    .line 44
    .line 45
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 46
    .line 47
    .line 48
    new-instance v1, Lcom/kousei/framework/q;

    .line 49
    .line 50
    iget-object v2, p0, Lcom/kousei/framework/zd;->O:Ljava/math/BigInteger;

    .line 51
    .line 52
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 53
    .line 54
    .line 55
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 56
    .line 57
    .line 58
    new-instance v1, Lcom/kousei/framework/q;

    .line 59
    .line 60
    iget-object v2, p0, Lcom/kousei/framework/zd;->P:Ljava/math/BigInteger;

    .line 61
    .line 62
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 63
    .line 64
    .line 65
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 66
    .line 67
    .line 68
    new-instance v1, Lcom/kousei/framework/q;

    .line 69
    .line 70
    iget-object v2, p0, Lcom/kousei/framework/zd;->Q:Ljava/math/BigInteger;

    .line 71
    .line 72
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 73
    .line 74
    .line 75
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 76
    .line 77
    .line 78
    new-instance v1, Lcom/kousei/framework/q;

    .line 79
    .line 80
    iget-object v2, p0, Lcom/kousei/framework/zd;->R:Ljava/math/BigInteger;

    .line 81
    .line 82
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 83
    .line 84
    .line 85
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 86
    .line 87
    .line 88
    new-instance v1, Lcom/kousei/framework/q;

    .line 89
    .line 90
    iget-object v2, p0, Lcom/kousei/framework/zd;->S:Ljava/math/BigInteger;

    .line 91
    .line 92
    invoke-direct {v1, v2}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 93
    .line 94
    .line 95
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 96
    .line 97
    .line 98
    iget-object p0, p0, Lcom/kousei/framework/zd;->T:Lcom/kousei/framework/d0;

    .line 99
    .line 100
    if-eqz p0, :cond_68

    .line 101
    .line 102
    invoke-virtual {v0, p0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 103
    .line 104
    .line 105
    :cond_68
    new-instance p0, Lcom/kousei/framework/r4;

    .line 106
    .line 107
    const/4 v1, 0x0

    .line 108
    invoke-direct {p0, v0, v1}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 109
    .line 110
    .line 111
    const/4 v0, -0x1

    .line 112
    iput v0, p0, Lcom/kousei/framework/r4;->N:I

    .line 113
    .line 114
    return-object p0
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
