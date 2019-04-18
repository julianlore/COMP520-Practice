.class public Tree
.super java/lang/Object
.field protected rings I

.method public height(I)Ljava/lang/Integer;
        .limit stack 3
        .limit locals 4

       iconst_0 ;                                   [0]
       istore_2 ;                                   []
       iconst_0 ;                                   [0]
       istore_3 ;                                   []

while:
       iload_2 ;                                    [i]
       iload_1 ;                                    [i; mix]
       if_icmpge end ;                              []
       iload_3 ;                                    [height]
       iconst_2 ;                                   [height; 2]
       isub ;                                       [height - 2]
       aload_0 ;                                    [height - 2; this]
       getfield Tree.rings I ;                      [height - 2; rings]
       imul ;                                       [(height - 2) * rings]
       istore_3 ;                                   []
       iinc 2 1 ;                                   []
       goto while ;                                 []

end:
       new java/lang/Integer ;                      [o]
       dup ;                                        [o; o]
       iload_3 ;                                    [o; o; height]
       invokespecial java/lang/Integer/<init>(I)V ; [o]
       areturn ;                                    []
.end method

;; Below is for testing only
.method public <init>()V
        .limit stack 1
        .limit locals 1
        aload_0
        invokespecial java/lang/Object/<init>()V
        return
.end method

.method public static main([Ljava/lang/String;)V
    .limit stack 3
    .limit locals 2
    new Tree
    dup
    invokespecial Tree/<init>()V
    astore_1
    getstatic java/lang/System/out Ljava/io/PrintStream;
    aload_1
    bipush 23
    invokevirtual Tree/height(I)Ljava/lang/Integer;
    invokevirtual java/io/PrintStream/println(Ljava/lang/Object;)V
    return
.end method