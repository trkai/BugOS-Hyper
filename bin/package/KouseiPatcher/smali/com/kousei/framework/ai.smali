.class public final Lcom/kousei/framework/ai;
.super Lcom/kousei/framework/s;


# instance fields
.field public K:Lcom/kousei/framework/d0;

.field public L:Lcom/kousei/framework/q;

.field public M:Lcom/kousei/framework/q;

.field public N:Lcom/kousei/framework/k0;

.field public O:Lcom/kousei/framework/wi;

.field public P:Lcom/kousei/framework/ni;

.field public Q:Lcom/kousei/framework/wi;

.field public R:Lcom/kousei/framework/xh;

.field public S:Lcom/kousei/framework/g;

.field public T:Lcom/kousei/framework/g;

.field public U:Lcom/kousei/framework/b8;


# virtual methods
.method public final b()Lcom/kousei/framework/a0;
    .registers 8

    .line 1
    iget-object v0, p0, Lcom/kousei/framework/ai;->L:Lcom/kousei/framework/q;

    .line 2
    .line 3
    iget-object v1, p0, Lcom/kousei/framework/ai;->K:Lcom/kousei/framework/d0;

    .line 4
    .line 5
    if-eqz v1, :cond_15

    .line 6
    .line 7
    const-string v2, "org.bouncycastle.x509.allow_non-der_tbscert"

    .line 8
    .line 9
    invoke-static {v2}, Lcom/kousei/framework/md;->b(Ljava/lang/String;)Ljava/lang/String;

    .line 10
    .line 11
    .line 12
    move-result-object v3

    .line 13
    if-eqz v3, :cond_14

    .line 14
    .line 15
    invoke-static {v2}, Lcom/kousei/framework/md;->c(Ljava/lang/String;)Z

    .line 16
    .line 17
    .line 18
    move-result v2

    .line 19
    if-eqz v2, :cond_15

    .line 20
    .line 21
    :cond_14
    return-object v1

    .line 22
    :cond_15
    new-instance v1, Lcom/kousei/framework/l;

    .line 23
    .line 24
    const/16 v2, 0xa

    .line 25
    .line 26
    invoke-direct {v1, v2}, Lcom/kousei/framework/l;-><init>(I)V

    .line 27
    .line 28
    .line 29
    const/4 v2, 0x0

    .line 30
    invoke-virtual {v0, v2}, Lcom/kousei/framework/q;->t(I)Z

    .line 31
    .line 32
    .line 33
    move-result v3

    .line 34
    const/4 v4, 0x1

    .line 35
    if-nez v3, :cond_2d

    .line 36
    .line 37
    new-instance v3, Lcom/kousei/framework/k2;

    .line 38
    .line 39
    const/4 v5, 0x1

    .line 40
    invoke-direct {v3, v4, v2, v0, v5}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 41
    .line 42
    .line 43
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 44
    .line 45
    .line 46
    :cond_2d
    iget-object v0, p0, Lcom/kousei/framework/ai;->M:Lcom/kousei/framework/q;

    .line 47
    .line 48
    invoke-virtual {v1, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 49
    .line 50
    .line 51
    iget-object v0, p0, Lcom/kousei/framework/ai;->N:Lcom/kousei/framework/k0;

    .line 52
    .line 53
    invoke-virtual {v1, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 54
    .line 55
    .line 56
    iget-object v0, p0, Lcom/kousei/framework/ai;->O:Lcom/kousei/framework/wi;

    .line 57
    .line 58
    invoke-virtual {v1, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 59
    .line 60
    .line 61
    iget-object v0, p0, Lcom/kousei/framework/ai;->P:Lcom/kousei/framework/ni;

    .line 62
    .line 63
    invoke-virtual {v1, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 64
    .line 65
    .line 66
    iget-object v0, p0, Lcom/kousei/framework/ai;->Q:Lcom/kousei/framework/wi;

    .line 67
    .line 68
    invoke-virtual {v1, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 69
    .line 70
    .line 71
    iget-object v0, p0, Lcom/kousei/framework/ai;->R:Lcom/kousei/framework/xh;

    .line 72
    .line 73
    invoke-virtual {v1, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 74
    .line 75
    .line 76
    iget-object v0, p0, Lcom/kousei/framework/ai;->S:Lcom/kousei/framework/g;

    .line 77
    .line 78
    if-eqz v0, :cond_58

    .line 79
    .line 80
    new-instance v3, Lcom/kousei/framework/k2;

    .line 81
    .line 82
    const/4 v5, 0x1

    .line 83
    invoke-direct {v3, v2, v4, v0, v5}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 84
    .line 85
    .line 86
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 87
    .line 88
    .line 89
    :cond_58
    iget-object v0, p0, Lcom/kousei/framework/ai;->T:Lcom/kousei/framework/g;

    .line 90
    .line 91
    if-eqz v0, :cond_66

    .line 92
    .line 93
    new-instance v3, Lcom/kousei/framework/k2;

    .line 94
    .line 95
    const/4 v5, 0x2

    .line 96
    const/4 v6, 0x1

    .line 97
    invoke-direct {v3, v2, v5, v0, v6}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 98
    .line 99
    .line 100
    invoke-virtual {v1, v3}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 101
    .line 102
    .line 103
    :cond_66
    iget-object p0, p0, Lcom/kousei/framework/ai;->U:Lcom/kousei/framework/b8;

    .line 104
    .line 105
    if-eqz p0, :cond_74

    .line 106
    .line 107
    new-instance v0, Lcom/kousei/framework/k2;

    .line 108
    .line 109
    const/4 v2, 0x3

    .line 110
    const/4 v3, 0x1

    .line 111
    invoke-direct {v0, v4, v2, p0, v3}, Lcom/kousei/framework/k2;-><init>(ZILcom/kousei/framework/k;I)V

    .line 112
    .line 113
    .line 114
    invoke-virtual {v1, v0}, Lcom/kousei/framework/l;->a(Lcom/kousei/framework/k;)V

    .line 115
    .line 116
    .line 117
    :cond_74
    new-instance p0, Lcom/kousei/framework/r4;

    .line 118
    .line 119
    const/4 v0, 0x0

    .line 120
    invoke-direct {p0, v1, v0}, Lcom/kousei/framework/r4;-><init>(Lcom/kousei/framework/l;Z)V

    .line 121
    .line 122
    .line 123
    const/4 v0, -0x1

    .line 124
    iput v0, p0, Lcom/kousei/framework/r4;->N:I

    .line 125
    .line 126
    return-object p0
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
