From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 26 Nov 2009 11:34:31 +0000
Subject: [PATCH 1/2 v2] sh: mach-ecovec24: modify memory area calculation bug
Message-Id: <u4ooho6yg.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This operation expect to jump to cached area, but "mova" command will
get un-cached area in this case.
This patch change it un-cached area to cached area

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
I think this patch is for 2.6.33

 arch/sh/include/mach-ecovec24/mach/romimage.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/mach-ecovec24/mach/romimage.h b/arch/sh/include/mach-ecovec24/mach/romimage.h
index 1c8787e..6c670af 100644
--- a/arch/sh/include/mach-ecovec24/mach/romimage.h
+++ b/arch/sh/include/mach-ecovec24/mach/romimage.h
@@ -3,6 +3,7 @@
  * the assembly code is the first code to be executed in the romImage
  */
 
+#include <cpu/addrspace.h>
 #include <asm/romimage-macros.h>
 #include "partner-jet-setup.txt"
 
@@ -11,10 +12,13 @@
 	icbi	@r0
 
 	/* jump to cached area */
-	mova	2f, r0
+	mov.l	2f, r1
+	mova	3f, r0
+	sub	r1, r0
 	jmp	@r0
 	nop
 
 	.align 2
 1 :	.long 0xa8000000
-2 :
+2 :	.long P2SEG - P1SEG /* cached_to_uncached */
+3 :
-- 
1.6.3.3

