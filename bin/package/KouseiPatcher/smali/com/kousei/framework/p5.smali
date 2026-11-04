.class public final Lcom/kousei/framework/p5;
.super Lcom/kousei/framework/s;


# instance fields
.field public K:I

.field public L:I

.field public M:I

.field public N:I


# virtual methods
.method public final b()Lcom/kousei/framework/a0;
    .registers 7

    .line 1
    iget v0, p0, Lcom/kousei/framework/p5;->L:I

    .line 2
    .line 3
    new-instance v1, Lcom/kousei/framework/l;

    .line 4
    .line 5
    const/4 v2, 0x2

    .line 6
    invoke-direct {v1, v2}, Lcom/kousei/framework/l;-><init>(I)V

    .line 7
    .line 8
    .line 9
    iget v2, p0, Lcom/kousei/framework/p5;->K:I

    .line 10
    .line 11
    invoke-static {v2}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 12
    .line 13
    .line 14
    move-result-object v2

    .line 15
    invoke-virtual {v1, v2}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 16
    .line 17
    .line 18
    iget v2, p0, Lcom/kousei/framework/p5;->M:I

    .line 19
    .line 20
    const/4 v3, -0x1

    .line 21
    if-nez v2, :cond_1e

    .line 22
    .line 23
    invoke-static {v0}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 24
    .line 25
    .line 26
    move-result-object p0

    .line 27
    invoke-virtual {v1, p0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 28
    .line 29
    .line 30
    goto :goto_46

    .line 31
    :cond_1e
    new-instance v4, Lcom/kousei/framework/l;

    .line 32
    .line 33
    const/4 v5, 0x3

    .line 34
    invoke-direct {v4, v5}, Lcom/kousei/framework/l;-><init>(I)V

    .line 35
    .line 36
    .line 37
    invoke-static {v0}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 38
    .line 39
    .line 40
    move-result-object v0

    .line 41
    invoke-virtual {v4, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 42
    .line 43
    .line 44
    invoke-static {v2}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 45
    .line 46
    .line 47
    move-result-object v0

    .line 48
    invoke-virtual {v4, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 49
    .line 50
    .line 51
    iget p0, p0, Lcom/kousei/framework/p5;->N:I

    .line 52
    .line 53
    invoke-static {p0}, Lcom/kousei/framework/q;->z(I)Lcom/kousei/framework/q;

    .line 54
    .line 55
    .line 56
    move-result-object p0

    .line 57
    invoke-virtual {v4, p0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 58
    .line 59
    .line 60
    new-instance p0, Lcom/kousei/framework/r4;

    .line 61
    .line 62
    const/4 v0, 0x0

    .line 63
    invoke-direct {p0, v4, v0}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 64
    .line 65
    .line 66
    iput v3, p0, Lcom/kousei/framework/r4;->N:I

    .line 67
    .line 68
    invoke-virtual {v1, p0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 69
    .line 70
    .line 71
    :goto_46
    new-instance p0, Lcom/kousei/framework/r4;

    .line 72
    .line 73
    const/4 v0, 0x0

    .line 74
    invoke-direct {p0, v1, v0}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 75
    .line 76
    .line 77
    iput v3, p0, Lcom/kousei/framework/r4;->N:I

    .line 78
    .line 79
    return-object p0
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
