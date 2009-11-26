From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 26 Nov 2009 10:34:52 +0000
Subject: [PATCH 2/2] sh: mach-kfr2r09: modify memory area calculation
Message-Id: <u7htdo9pv.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This operation expect to jump to cached area, but "mova" command will
get un-cached area in this case.
This patch subtract 0x20000000 from it to change un-cached area
to cached area

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
I think this patch is for 2.6.33

 arch/sh/include/mach-kfr2r09/mach/romimage.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sh/include/mach-kfr2r09/mach/romimage.h b/arch/sh/include/mach-kfr2r09/mach/romimage.h
index a110823..076cc94 100644
--- a/arch/sh/include/mach-kfr2r09/mach/romimage.h
+++ b/arch/sh/include/mach-kfr2r09/mach/romimage.h
@@ -11,10 +11,13 @@
 	icbi	@r0
 
 	/* jump to cached area */
-	mova	2f, r0
+	mov.l	2f, r1
+	mova	3f, r0
+	sub	r1, r0
 	jmp	@r0
 	 nop
 
 	.align 2
-1:	.long 0xa8000000
-2:
+1 :	.long 0xa8000000
+2 :	.long 0x20000000 /* 0xA0000000 - 0x80000000 */
+3 :
-- 
1.6.3.3

