From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Aug 2009 13:59:26 +0000
Subject: [PATCH] sh: jump to p1 during boot on kfr2r09
Message-Id: <20090820135926.24000.72974.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add a P1 jump to the the kfr2r09 romimage code. With this
patch applied the initial zImage assembly code will run
with instruction cache enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/mach-kfr2r09/mach/romimage.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0001/arch/sh/include/mach-kfr2r09/mach/romimage.h
+++ work/arch/sh/include/mach-kfr2r09/mach/romimage.h	2009-08-20 14:22:06.000000000 +0900
@@ -73,3 +73,16 @@
 .endm
 
 #include "partner-jet-setup.txt"
+
+	/* execute icbi after enabling cache */
+	mov.l	1f, r0
+	icbi	@r0
+
+	/* jump to cached area */
+	mova	2f, r0
+	jmp	@r0
+	 nop
+
+	.align 2
+1:	.long 0xa8000000
+2:
