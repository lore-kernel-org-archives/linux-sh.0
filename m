From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:27 +0000
Subject: [PATCH v5 07/22] sh: Passing FDT address on zImage
Message-Id: <1467564402-2649-8-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/compressed/head_32.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index 3e15032..a980c48 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -11,10 +11,11 @@
 
 	.global	startup
 startup:
+	/* Save FDT address */
+	mov	r4, r13
 	/* Load initial status register */
 	mov.l   init_sr, r1
 	ldc     r1, sr
-
 	/* Move myself to proper location if necessary */
 	mova	1f, r0
 	mov.l	1f, r2
@@ -83,7 +84,7 @@ l1:
 	/* Jump to the start of the decompressed kernel */
 	mov.l	kernel_start_addr, r0
 	jmp	@r0
-	nop
+	 mov	r13,r4
 	
 	.align	2
 bss_start_addr:
-- 
2.7.0

