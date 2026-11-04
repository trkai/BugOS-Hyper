.class public interface abstract Lcom/kousei/framework/ie;
.super Ljava/lang/Object;


# static fields
.field public static final a:Lcom/kousei/framework/v;

.field public static final b:Lcom/kousei/framework/v;

.field public static final c:Lcom/kousei/framework/v;

.field public static final d:Lcom/kousei/framework/v;


# direct methods
.method static constructor <clinit>()V
    .registers 6

    .line 1
    new-instance v0, Lcom/kousei/framework/v;

    .line 2
    .line 3
    const-string v1, "1.2.643.7"

    .line 4
    .line 5
    invoke-direct {v0, v1}, Lcom/kousei/framework/v;-><init>(Ljava/lang/String;)V

    .line 6
    .line 7
    .line 8
    const-string v1, "1"

    .line 9
    .line 10
    invoke-virtual {v0, v1}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    const-string v2, "1.2.2"

    .line 15
    .line 16
    invoke-virtual {v0, v2}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 17
    .line 18
    .line 19
    move-result-object v2

    .line 20
    sput-object v2, Lcom/kousei/framework/ie;->a:Lcom/kousei/framework/v;

    .line 21
    .line 22
    const-string v2, "1.2.3"

    .line 23
    .line 24
    invoke-virtual {v0, v2}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 25
    .line 26
    .line 27
    move-result-object v2

    .line 28
    sput-object v2, Lcom/kousei/framework/ie;->b:Lcom/kousei/framework/v;

    .line 29
    .line 30
    const-string v2, "1.1.1"

    .line 31
    .line 32
    const-string v3, "1.1.2"

    .line 33
    .line 34
    const-string v4, "1.4.1"

    .line 35
    .line 36
    const-string v5, "1.4.2"

    .line 37
    .line 38
    invoke-static {v0, v4, v5, v2, v3}, Lcom/kousei/framework/k1;->g(Lcom/kousei/framework/v;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    .line 40
    .line 41
    const-string v2, "1.3.2"

    .line 42
    .line 43
    invoke-virtual {v0, v2}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 44
    .line 45
    .line 46
    move-result-object v2

    .line 47
    sput-object v2, Lcom/kousei/framework/ie;->c:Lcom/kousei/framework/v;

    .line 48
    .line 49
    const-string v2, "1.3.3"

    .line 50
    .line 51
    invoke-virtual {v0, v2}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 52
    .line 53
    .line 54
    move-result-object v2

    .line 55
    sput-object v2, Lcom/kousei/framework/ie;->d:Lcom/kousei/framework/v;

    .line 56
    .line 57
    const-string v2, "1.6"

    .line 58
    .line 59
    invoke-virtual {v0, v2}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 60
    .line 61
    .line 62
    move-result-object v2

    .line 63
    invoke-virtual {v2, v1}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 64
    .line 65
    .line 66
    const-string v3, "2"

    .line 67
    .line 68
    invoke-virtual {v2, v3}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 69
    .line 70
    .line 71
    const-string v2, "2.1.1"

    .line 72
    .line 73
    invoke-virtual {v0, v2}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 74
    .line 75
    .line 76
    move-result-object v2

    .line 77
    const-string v4, "4"

    .line 78
    .line 79
    const-string v5, "3"

    .line 80
    .line 81
    invoke-static {v2, v1, v3, v5, v4}, Lcom/kousei/framework/k1;->g(Lcom/kousei/framework/v;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 82
    .line 83
    .line 84
    const-string v2, "2.1.2"

    .line 85
    .line 86
    invoke-virtual {v0, v2}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 87
    .line 88
    .line 89
    move-result-object v2

    .line 90
    invoke-virtual {v2, v1}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 91
    .line 92
    .line 93
    invoke-virtual {v2, v3}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 94
    .line 95
    .line 96
    invoke-virtual {v2, v5}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 97
    .line 98
    .line 99
    const-string v1, "2.5.1.1"

    .line 100
    .line 101
    invoke-virtual {v0, v1}, Lcom/kousei/framework/v;->q(Ljava/lang/String;)Lcom/kousei/framework/v;

    .line 102
    .line 103
    .line 104
    return-void
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
