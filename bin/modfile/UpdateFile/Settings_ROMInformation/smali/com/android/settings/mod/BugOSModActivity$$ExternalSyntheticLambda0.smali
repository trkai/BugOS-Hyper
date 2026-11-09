.class public final synthetic Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/android/settings/mod/BugOSModActivity;

.field public final synthetic f$1:Z

.field public final synthetic f$2:Ljava/io/File;


# direct methods
.method public synthetic constructor <init>(Lcom/android/settings/mod/BugOSModActivity;ZLjava/io/File;)V
    .registers 4

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;->f$0:Lcom/android/settings/mod/BugOSModActivity;

    iput-boolean p2, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;->f$1:Z

    iput-object p3, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;->f$2:Ljava/io/File;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 4

    .line 0
    iget-object v0, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;->f$0:Lcom/android/settings/mod/BugOSModActivity;

    iget-boolean v1, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;->f$1:Z

    iget-object v2, p0, Lcom/android/settings/mod/BugOSModActivity$$ExternalSyntheticLambda0;->f$2:Ljava/io/File;

    invoke-static {v0, v1, v2}, Lcom/android/settings/mod/BugOSModActivity;->$r8$lambda$UIYBO4j0RUv8LDegv5KpsPvJbBo(Lcom/android/settings/mod/BugOSModActivity;ZLjava/io/File;)V

    return-void
.end method
