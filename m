From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 29 Jun 2016 13:40:51 +0000
Subject: [PATCH v4 06/22] sh: FDT address save before bank change
Message-Id: <1467207667-15768-7-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

SH3/4 have register bank of R0-R7.
Preset FDT address assigned bank depend on boot loader.
Before setting a bank because we don't depend on a boot loader, it's evacuated.

Changes v4
none

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/head_32.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 974bc15..ef44fe8 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -58,6 +58,9 @@ ENTRY(empty_zero_page)
  *
  */
 ENTRY(_stext)
+#ifdef CONFIG_OF
+	mov	r4, r12		! Store device tree blob pointer
+#endif
 	!			Initialize Status Register
 	mov.l	1f, r0		! MD=1, RB=0, BL=0, IMASK=0xF
 	ldc	r0, sr
@@ -67,10 +70,6 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF
-	mov	r4, r12		! Store device tree blob pointer in r12
-#endif
-	
 	/*
 	 * Prefetch if possible to reduce cache miss penalty.
 	 *
-- 
2.7.0

