.class public final Lcom/kousei/framework/yj;
.super Lcom/kousei/framework/hf;

# interfaces
.implements Lcom/kousei/framework/y7;


# instance fields
.field public final M:Lcom/kousei/framework/tj;

.field public final N:I

.field public final O:[B

.field public final P:[B


# direct methods
.method public constructor <init>(Lcom/kousei/framework/i7;)V
    .registers 8

    .line 1
    iget-object v0, p1, Lcom/kousei/framework/i7;->a:Ljava/lang/Object;

    .line 2
    .line 3
    check-cast v0, Lcom/kousei/framework/tj;

    .line 4
    .line 5
    iget-object v1, v0, Lcom/kousei/framework/tj;->e:Ljava/lang/String;

    .line 6
    .line 7
    const/4 v2, 0x0

    .line 8
    invoke-direct {p0, v1, v2}, Lcom/kousei/framework/hf;-><init>(Ljava/lang/String;Z)V

    .line 9
    .line 10
    .line 11
    iput-object v0, p0, Lcom/kousei/framework/yj;->M:Lcom/kousei/framework/tj;

    .line 12
    .line 13
    iget v1, v0, Lcom/kousei/framework/tj;->f:I

    .line 14
    .line 15
    iget-object v3, p1, Lcom/kousei/framework/i7;->d:Ljava/lang/Object;

    .line 16
    .line 17
    check-cast v3, [B

    .line 18
    .line 19
    const/4 v4, 0x0

    .line 20
    if-eqz v3, :cond_4a

    .line 21
    .line 22
    array-length p1, v3

    .line 23
    add-int v0, v1, v1

    .line 24
    .line 25
    if-ne p1, v0, :cond_29

    .line 26
    .line 27
    iput v2, p0, Lcom/kousei/framework/yj;->N:I

    .line 28
    .line 29
    invoke-static {v3, v2, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 30
    .line 31
    .line 32
    move-result-object p1

    .line 33
    iput-object p1, p0, Lcom/kousei/framework/yj;->O:[B

    .line 34
    .line 35
    invoke-static {v3, v1, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 36
    .line 37
    .line 38
    move-result-object p1

    .line 39
    iput-object p1, p0, Lcom/kousei/framework/yj;->P:[B

    .line 40
    .line 41
    return-void

    .line 42
    :cond_29
    array-length p1, v3

    .line 43
    add-int/lit8 v0, v1, 0x4

    .line 44
    .line 45
    add-int v5, v0, v1

    .line 46
    .line 47
    if-ne p1, v5, :cond_44

    .line 48
    .line 49
    invoke-static {v2, v3}, Lcom/kousei/framework/i0;->C(I[B)I

    .line 50
    .line 51
    .line 52
    move-result p1

    .line 53
    iput p1, p0, Lcom/kousei/framework/yj;->N:I

    .line 54
    .line 55
    const/4 p1, 0x4

    .line 56
    invoke-static {v3, p1, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 57
    .line 58
    .line 59
    move-result-object p1

    .line 60
    iput-object p1, p0, Lcom/kousei/framework/yj;->O:[B

    .line 61
    .line 62
    invoke-static {v3, v0, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 63
    .line 64
    .line 65
    move-result-object p1

    .line 66
    iput-object p1, p0, Lcom/kousei/framework/yj;->P:[B

    .line 67
    .line 68
    return-void

    .line 69
    :cond_44
    const-string p0, "public key has wrong size"

    .line 70
    .line 71
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 72
    .line 73
    .line 74
    throw v4

    .line 75
    :cond_4a
    iget-object v0, v0, Lcom/kousei/framework/tj;->a:Lcom/kousei/framework/x5;

    .line 76
    .line 77
    if-eqz v0, :cond_53

    .line 78
    .line 79
    iget v0, v0, Lcom/kousei/framework/x5;->a:I

    .line 80
    .line 81
    iput v0, p0, Lcom/kousei/framework/yj;->N:I

    .line 82
    .line 83
    goto :goto_55

    .line 84
    :cond_53
    iput v2, p0, Lcom/kousei/framework/yj;->N:I

    .line 85
    .line 86
    :goto_55
    iget-object v0, p1, Lcom/kousei/framework/i7;->b:Ljava/lang/Object;

    .line 87
    .line 88
    check-cast v0, [B

    .line 89
    .line 90
    if-eqz v0, :cond_67

    .line 91
    .line 92
    array-length v2, v0

    .line 93
    if-ne v2, v1, :cond_61

    .line 94
    .line 95
    iput-object v0, p0, Lcom/kousei/framework/yj;->O:[B

    .line 96
    .line 97
    goto :goto_6b

    .line 98
    :cond_61
    const-string p0, "length of root must be equal to length of digest"

    .line 99
    .line 100
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 101
    .line 102
    .line 103
    throw v4

    .line 104
    :cond_67
    new-array v0, v1, [B

    .line 105
    .line 106
    iput-object v0, p0, Lcom/kousei/framework/yj;->O:[B

    .line 107
    .line 108
    :goto_6b
    iget-object p1, p1, Lcom/kousei/framework/i7;->c:Ljava/lang/Object;

    .line 109
    .line 110
    check-cast p1, [B

    .line 111
    .line 112
    if-eqz p1, :cond_7d

    .line 113
    .line 114
    array-length v0, p1

    .line 115
    if-ne v0, v1, :cond_77

    .line 116
    .line 117
    iput-object p1, p0, Lcom/kousei/framework/yj;->P:[B

    .line 118
    .line 119
    return-void

    .line 120
    :cond_77
    const-string p0, "length of publicSeed must be equal to length of digest"

    .line 121
    .line 122
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 123
    .line 124
    .line 125
    throw v4

    .line 126
    :cond_7d
    new-array p1, v1, [B

    .line 127
    .line 128
    iput-object p1, p0, Lcom/kousei/framework/yj;->P:[B

    .line 129
    .line 130
    return-void
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
.method public final getEncoded()[B
    .registers 5

    .line 1
    iget-object v0, p0, Lcom/kousei/framework/yj;->M:Lcom/kousei/framework/tj;

    .line 2
    .line 3
    iget v0, v0, Lcom/kousei/framework/tj;->f:I

    .line 4
    .line 5
    const/4 v1, 0x0

    .line 6
    iget v2, p0, Lcom/kousei/framework/yj;->N:I

    .line 7
    .line 8
    if-eqz v2, :cond_13

    .line 9
    .line 10
    add-int/lit8 v3, v0, 0x4

    .line 11
    .line 12
    add-int/2addr v3, v0

    .line 13
    new-array v3, v3, [B

    .line 14
    .line 15
    invoke-static {v3, v2, v1}, Lcom/kousei/framework/i0;->m1([BII)V

    .line 16
    .line 17
    .line 18
    const/4 v1, 0x4

    .line 19
    goto :goto_17

    .line 20
    :cond_13
    add-int v2, v0, v0

    .line 21
    .line 22
    new-array v3, v2, [B

    .line 23
    .line 24
    :goto_17
    iget-object v2, p0, Lcom/kousei/framework/yj;->O:[B

    .line 25
    .line 26
    invoke-static {v1, v3, v2}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 27
    .line 28
    .line 29
    add-int/2addr v1, v0

    .line 30
    iget-object p0, p0, Lcom/kousei/framework/yj;->P:[B

    .line 31
    .line 32
    invoke-static {v1, v3, p0}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 33
    .line 34
    .line 35
    return-object v3
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
