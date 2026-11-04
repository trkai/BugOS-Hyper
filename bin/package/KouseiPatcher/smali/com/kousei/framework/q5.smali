.class public final Lcom/kousei/framework/q5;
.super Lcom/kousei/framework/s;


# instance fields
.field public K:Ljava/math/BigInteger;

.field public L:Lcom/kousei/framework/p5;

.field public M:Lcom/kousei/framework/q;

.field public N:Lcom/kousei/framework/w;

.field public O:Lcom/kousei/framework/q;

.field public P:Lcom/kousei/framework/w;


# virtual methods
.method public final b()Lcom/kousei/framework/a0;
    .registers 7

    .line 1
    new-instance v0, Lcom/kousei/framework/l;

    .line 2
    .line 3
    const/4 v1, 0x6

    .line 4
    invoke-direct {v0, v1}, Lcom/kousei/framework/l;-><init>(I)V

    .line 5
    .line 6
    .line 7
    iget-object v1, p0, Lcom/kousei/framework/q5;->K:Ljava/math/BigInteger;

    .line 8
    .line 9
    const-wide/16 v2, 0x0

    .line 10
    .line 11
    invoke-static {v2, v3}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    .line 12
    .line 13
    .line 14
    move-result-object v2

    .line 15
    invoke-virtual {v1, v2}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    .line 16
    .line 17
    .line 18
    move-result v2

    .line 19
    if-eqz v2, :cond_24

    .line 20
    .line 21
    new-instance v2, Lcom/kousei/framework/k2;

    .line 22
    .line 23
    new-instance v3, Lcom/kousei/framework/q;

    .line 24
    .line 25
    invoke-direct {v3, v1}, Lcom/kousei/framework/q;-><init>(Ljava/math/BigInteger;)V

    .line 26
    .line 27
    .line 28
    const/4 v1, 0x1

    .line 29
    const/4 v4, 0x1

    .line 30
    const/4 v5, 0x0

    .line 31
    invoke-direct {v2, v4, v5, v3, v1}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 32
    .line 33
    .line 34
    invoke-virtual {v0, v2}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 35
    .line 36
    .line 37
    :cond_24
    iget-object v1, p0, Lcom/kousei/framework/q5;->L:Lcom/kousei/framework/p5;

    .line 38
    .line 39
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 40
    .line 41
    .line 42
    iget-object v1, p0, Lcom/kousei/framework/q5;->M:Lcom/kousei/framework/q;

    .line 43
    .line 44
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 45
    .line 46
    .line 47
    iget-object v1, p0, Lcom/kousei/framework/q5;->N:Lcom/kousei/framework/w;

    .line 48
    .line 49
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 50
    .line 51
    .line 52
    iget-object v1, p0, Lcom/kousei/framework/q5;->O:Lcom/kousei/framework/q;

    .line 53
    .line 54
    invoke-virtual {v0, v1}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 55
    .line 56
    .line 57
    iget-object p0, p0, Lcom/kousei/framework/q5;->P:Lcom/kousei/framework/w;

    .line 58
    .line 59
    invoke-virtual {v0, p0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 60
    .line 61
    .line 62
    new-instance p0, Lcom/kousei/framework/r4;

    .line 63
    .line 64
    const/4 v1, 0x0

    .line 65
    invoke-direct {p0, v0, v1}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 66
    .line 67
    .line 68
    const/4 v0, -0x1

    .line 69
    iput v0, p0, Lcom/kousei/framework/r4;->N:I

    .line 70
    .line 71
    return-object p0
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
