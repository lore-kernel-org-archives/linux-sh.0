From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat, 20 Jun 2015 05:11:51 +0000
Subject: [PATCH] sh: New gcc support
Message-Id: <1434777111-22908-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

New gcc (4.8 or later) used new shift helper functions.
So we need added new helper to private libgcc.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/sh_ksyms_32.c |  3 +++
 arch/sh/lib/ashlsi3.S        | 35 ++++++++++++++++++++++++++---------
 arch/sh/lib/ashrsi3.S        | 33 ++++++++++++++++++++++++---------
 arch/sh/lib/lshrsi3.S        | 34 +++++++++++++++++++++++++---------
 4 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index d77f2f6..0b30b9d 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -34,6 +34,9 @@ DECLARE_EXPORT(__sdivsi3);
 DECLARE_EXPORT(__lshrsi3);
 DECLARE_EXPORT(__ashrsi3);
 DECLARE_EXPORT(__ashlsi3);
+DECLARE_EXPORT(__lshrsi3_r0);
+DECLARE_EXPORT(__ashrsi3_r0);
+DECLARE_EXPORT(__ashlsi3_r0);
 DECLARE_EXPORT(__ashiftrt_r4_6);
 DECLARE_EXPORT(__ashiftrt_r4_7);
 DECLARE_EXPORT(__ashiftrt_r4_8);
diff --git a/arch/sh/lib/ashlsi3.S b/arch/sh/lib/ashlsi3.S
index bd47e9b..70a6434 100644
--- a/arch/sh/lib/ashlsi3.S
+++ b/arch/sh/lib/ashlsi3.S
@@ -54,21 +54,38 @@ Boston, MA 02110-1301, USA.  */
 !
 ! (none)
 !
+! __ashlsi3_r0
+!
+! Entry:
+!
+! r4: Value to shift
+! r0: Shifts
+!
+! Exit:
+!
+! r0: Result
+!
+! Destroys:
+!
+! (none)
+
+
 	.global	__ashlsi3
+	.global	__ashlsi3_r0
 	
 	.align	2
 __ashlsi3:
-	mov	#31,r0
-	and	r0,r5
+	mov	r5,r0
+	.align	2
+__ashlsi3_r0:
+	and	#31,r0
+	mov.l	r4,@-r15
+	mov	r0,r4
 	mova	ashlsi3_table,r0
-	mov.b	@(r0,r5),r5
-#ifdef __sh1__
-	add	r5,r0
+	mov.b	@(r0,r4),r4
+	add	r4,r0
 	jmp	@r0
-#else
-	braf	r5
-#endif
-	mov	r4,r0
+	mov.l	@r15+,r0
 
 	.align	2
 ashlsi3_table:
diff --git a/arch/sh/lib/ashrsi3.S b/arch/sh/lib/ashrsi3.S
index 6f3cf46..602599d 100644
--- a/arch/sh/lib/ashrsi3.S
+++ b/arch/sh/lib/ashrsi3.S
@@ -54,22 +54,37 @@ Boston, MA 02110-1301, USA.  */
 !
 ! (none)
 !
+! __ashrsi3_r0
+!
+! Entry:
+!
+! r4: Value to shift
+! r0: Shifts
+!
+! Exit:
+!
+! r0: Result
+!
+! Destroys:
+!
+! (none)
 
 	.global	__ashrsi3
+	.global	__ashrsi3_r0
 	
 	.align	2
 __ashrsi3:
-	mov	#31,r0
-	and	r0,r5
+	mov	r5,r0
+	.align	2
+__ashrsi3_r0:
+	and	#31,r0
+	mov.l	r4,@-r15
+	mov	r0,r4
 	mova	ashrsi3_table,r0
-	mov.b	@(r0,r5),r5
-#ifdef __sh1__
-	add	r5,r0
+	mov.b	@(r0,r4),r4
+	add	r4,r0
 	jmp	@r0
-#else
-	braf	r5
-#endif
-	mov	r4,r0
+	mov.l	@r15+,r0
 
 	.align	2
 ashrsi3_table:
diff --git a/arch/sh/lib/lshrsi3.S b/arch/sh/lib/lshrsi3.S
index 1e7aaa5..f2a6959 100644
--- a/arch/sh/lib/lshrsi3.S
+++ b/arch/sh/lib/lshrsi3.S
@@ -54,21 +54,37 @@ Boston, MA 02110-1301, USA.  */
 !
 ! (none)
 !
+! __lshrsi3_r0
+!
+! Entry:
+!
+! r0: Value to shift
+! r5: Shifts
+!
+! Exit:
+!
+! r0: Result
+!
+! Destroys:
+!
+! (none)
+!
 	.global	__lshrsi3
+	.global	__lshrsi3_r0
 	
 	.align	2
 __lshrsi3:
-	mov	#31,r0
-	and	r0,r5
+	mov	r5,r0
+	.align	2
+__lshrsi3_r0:
+	and	#31,r0
+	mov.l	r4,@-r15
+	mov	r0,r4
 	mova	lshrsi3_table,r0
-	mov.b	@(r0,r5),r5
-#ifdef __sh1__
-	add	r5,r0
+	mov.b	@(r0,r4),r4
+	add	r4,r0
 	jmp	@r0
-#else
-	braf	r5
-#endif
-	mov	r4,r0
+	mov.l	@r15+,r0
 
 	.align	2
 lshrsi3_table:
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
