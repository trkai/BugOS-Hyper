.class public final Lcom/kousei/framework/rj;
.super Lcom/kousei/framework/hf;

# interfaces
.implements Lcom/kousei/framework/y7;


# instance fields
.field public final M:Lcom/kousei/framework/mj;

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
    check-cast v0, Lcom/kousei/framework/mj;

    .line 4
    .line 5
    iget-object v1, v0, Lcom/kousei/framework/mj;->b:Lcom/kousei/framework/tj;

    .line 6
    .line 7
    iget-object v2, v1, Lcom/kousei/framework/tj;->e:Ljava/lang/String;

    .line 8
    .line 9
    const/4 v3, 0x0

    .line 10
    invoke-direct {p0, v2, v3}, Lcom/kousei/framework/hf;-><init>(Ljava/lang/String;Z)V

    .line 11
    .line 12
    .line 13
    iput-object v0, p0, Lcom/kousei/framework/rj;->M:Lcom/kousei/framework/mj;

    .line 14
    .line 15
    iget v1, v1, Lcom/kousei/framework/tj;->f:I

    .line 16
    .line 17
    iget-object v2, p1, Lcom/kousei/framework/i7;->d:Ljava/lang/Object;

    .line 18
    .line 19
    check-cast v2, [B

    .line 20
    .line 21
    const/4 v4, 0x0

    .line 22
    if-eqz v2, :cond_4c

    .line 23
    .line 24
    array-length p1, v2

    .line 25
    add-int v0, v1, v1

    .line 26
    .line 27
    if-ne p1, v0, :cond_2b

    .line 28
    .line 29
    iput v3, p0, Lcom/kousei/framework/rj;->N:I

    .line 30
    .line 31
    invoke-static {v2, v3, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 32
    .line 33
    .line 34
    move-result-object p1

    .line 35
    iput-object p1, p0, Lcom/kousei/framework/rj;->O:[B

    .line 36
    .line 37
    invoke-static {v2, v1, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 38
    .line 39
    .line 40
    move-result-object p1

    .line 41
    iput-object p1, p0, Lcom/kousei/framework/rj;->P:[B

    .line 42
    .line 43
    return-void

    .line 44
    :cond_2b
    array-length p1, v2

    .line 45
    add-int/lit8 v0, v1, 0x4

    .line 46
    .line 47
    add-int v5, v0, v1

    .line 48
    .line 49
    if-ne p1, v5, :cond_46

    .line 50
    .line 51
    invoke-static {v3, v2}, Lcom/kousei/framework/i0;->C(I[B)I

    .line 52
    .line 53
    .line 54
    move-result p1

    .line 55
    iput p1, p0, Lcom/kousei/framework/rj;->N:I

    .line 56
    .line 57
    const/4 p1, 0x4

    .line 58
    invoke-static {v2, p1, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 59
    .line 60
    .line 61
    move-result-object p1

    .line 62
    iput-object p1, p0, Lcom/kousei/framework/rj;->O:[B

    .line 63
    .line 64
    invoke-static {v2, v0, v1}, Lcom/kousei/framework/xc;->p([BII)[B

    .line 65
    .line 66
    .line 67
    move-result-object p1

    .line 68
    iput-object p1, p0, Lcom/kousei/framework/rj;->P:[B

    .line 69
    .line 70
    return-void

    .line 71
    :cond_46
    const-string p0, "public key has wrong size"

    .line 72
    .line 73
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 74
    .line 75
    .line 76
    throw v4

    .line 77
    :cond_4c
    iget-object v0, v0, Lcom/kousei/framework/mj;->a:Lcom/kousei/framework/w5;

    .line 78
    .line 79
    if-eqz v0, :cond_55

    .line 80
    .line 81
    iget v0, v0, Lcom/kousei/framework/w5;->a:I

    .line 82
    .line 83
    iput v0, p0, Lcom/kousei/framework/rj;->N:I

    .line 84
    .line 85
    goto :goto_57

    .line 86
    :cond_55
    iput v3, p0, Lcom/kousei/framework/rj;->N:I

    .line 87
    .line 88
    :goto_57
    iget-object v0, p1, Lcom/kousei/framework/i7;->b:Ljava/lang/Object;

    .line 89
    .line 90
    check-cast v0, [B

    .line 91
    .line 92
    if-eqz v0, :cond_69

    .line 93
    .line 94
    array-length v2, v0

    .line 95
    if-ne v2, v1, :cond_63

    .line 96
    .line 97
    iput-object v0, p0, Lcom/kousei/framework/rj;->O:[B

    .line 98
    .line 99
    goto :goto_6d

    .line 100
    :cond_63
    const-string p0, "length of root must be equal to length of digest"

    .line 101
    .line 102
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 103
    .line 104
    .line 105
    throw v4

    .line 106
    :cond_69
    new-array v0, v1, [B

    .line 107
    .line 108
    iput-object v0, p0, Lcom/kousei/framework/rj;->O:[B

    .line 109
    .line 110
    :goto_6d
    iget-object p1, p1, Lcom/kousei/framework/i7;->c:Ljava/lang/Object;

    .line 111
    .line 112
    check-cast p1, [B

    .line 113
    .line 114
    if-eqz p1, :cond_7f

    .line 115
    .line 116
    array-length v0, p1

    .line 117
    if-ne v0, v1, :cond_79

    .line 118
    .line 119
    iput-object p1, p0, Lcom/kousei/framework/rj;->P:[B

    .line 120
    .line 121
    return-void

    .line 122
    :cond_79
    const-string p0, "length of publicSeed must be equal to length of digest"

    .line 123
    .line 124
    invoke-static {p0}, Lcom/kousei/framework/f;->k(Ljava/lang/String;)V

    .line 125
    .line 126
    .line 127
    throw v4

    .line 128
    :cond_7f
    new-array p1, v1, [B

    .line 129
    .line 130
    iput-object p1, p0, Lcom/kousei/framework/rj;->P:[B

    .line 131
    .line 132
    return-void
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
.method public final a()[B
    .registers 5

    .line 1
    iget-object v0, p0, Lcom/kousei/framework/rj;->M:Lcom/kousei/framework/mj;

    .line 2
    .line 3
    iget-object v0, v0, Lcom/kousei/framework/mj;->b:Lcom/kousei/framework/tj;

    .line 4
    .line 5
    iget v0, v0, Lcom/kousei/framework/tj;->f:I

    .line 6
    .line 7
    const/4 v1, 0x0

    .line 8
    iget v2, p0, Lcom/kousei/framework/rj;->N:I

    .line 9
    .line 10
    if-eqz v2, :cond_15

    .line 11
    .line 12
    add-int/lit8 v3, v0, 0x4

    .line 13
    .line 14
    add-int/2addr v3, v0

    .line 15
    new-array v3, v3, [B

    .line 16
    .line 17
    invoke-static {v3, v2, v1}, Lcom/kousei/framework/i0;->m1([BII)V

    .line 18
    .line 19
    .line 20
    const/4 v1, 0x4

    .line 21
    goto :goto_19

    .line 22
    :cond_15
    add-int v2, v0, v0

    .line 23
    .line 24
    new-array v3, v2, [B

    .line 25
    .line 26
    :goto_19
    iget-object v2, p0, Lcom/kousei/framework/rj;->O:[B

    .line 27
    .line 28
    invoke-static {v1, v3, v2}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 29
    .line 30
    .line 31
    add-int/2addr v1, v0

    .line 32
    iget-object p0, p0, Lcom/kousei/framework/rj;->P:[B

    .line 33
    .line 34
    invoke-static {v1, v3, p0}, Lcom/kousei/framework/xc;->k(I[B[B)V

    .line 35
    .line 36
    .line 37
    return-object v3
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

.method public final getEncoded()[B
    .registers 1

    .line 1
    invoke-virtual {p0}, Lcom/kousei/framework/rj;->a()[B

    .line 2
    .line 3
    .line 4
    move-result-object p0

    .line 5
    return-object p0
    .line 6
    .line 7
    .line 8
    .line 9
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
