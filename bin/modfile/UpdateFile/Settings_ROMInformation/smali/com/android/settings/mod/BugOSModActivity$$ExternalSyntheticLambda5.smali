.class public final synthetic Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/android/settings/mod/BugOSModActivity;

.field public final synthetic f$1:Ljava/io/File;


# direct methods
.method public synthetic constructor <init>(Lcom/android/settings/mod/BugOSModActivity;Ljava/io/File;)V
    .registers 3

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;->f$0:Lcom/android/settings/mod/BugOSModActivity;

    iput-object p2, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;->f$1:Ljava/io/File;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 3

    .line 0
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;->f$0:Lcom/android/settings/mod/BugOSModActivity;

    iget-object v1, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda5;->f$1:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/android/settings/mod/BugOSModActivity;->$r8$lambda$ZZh3Ab1sFzC9DK1LVdzQC1yTy2I(Lcom/android/settings/mod/BugOSModActivity;Ljava/io/File;)V

    return-void
.end method
