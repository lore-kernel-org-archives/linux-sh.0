From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 10 Sep 2009 01:39:52 +0000
Subject: [PATCH 1/6] sh: add romimage-macros.h
Message-Id: <uskevy3vb.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

romimage macros which are used in kfr2r09 is very useful for other board.
This patch divides kfr2r09's romimage.h into
romimage-macros and partner-jet-setup.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/include/asm/romimage-macros.h        |   73 ++++++++++++++++++++++++++
 arch/sh/include/mach-kfr2r09/mach/romimage.h |   70 +------------------------
 2 files changed, 74 insertions(+), 69 deletions(-)
 create mode 100644 arch/sh/include/asm/romimage-macros.h

diff --git a/arch/sh/include/asm/romimage-macros.h b/arch/sh/include/asm/romimage-macros.h
new file mode 100644
index 0000000..ae17a15
--- /dev/null
+++ b/arch/sh/include/asm/romimage-macros.h
@@ -0,0 +1,73 @@
+#ifndef __ROMIMAGE_MACRO_H
+#define __ROMIMAGE_MACRO_H
+
+/* The LIST command is used to include comments in the script */
+.macro	LIST comment
+.endm
+
+/* The ED command is used to write a 32-bit word */
+.macro  ED, addr, data
+	mov.l 1f, r1
+	mov.l 2f, r0
+	mov.l r0, @r1
+	bra 3f
+	 nop
+	.align 2
+1 :	.long \addr
+2 :	.long \data
+3 :
+.endm
+
+/* The EW command is used to write a 16-bit word */
+.macro  EW, addr, data
+	mov.l 1f, r1
+	mov.l 2f, r0
+	mov.w r0, @r1
+	bra 3f
+	 nop
+	.align 2
+1 :	.long \addr
+2 :	.long \data
+3 :
+.endm
+
+/* The EB command is used to write an 8-bit word */
+.macro  EB, addr, data
+	mov.l 1f, r1
+	mov.l 2f, r0
+	mov.b r0, @r1
+	bra 3f
+	 nop
+	.align 2
+1 :	.long \addr
+2 :	.long \data
+3 :
+.endm
+
+/* The WAIT command is used to delay the execution */
+.macro  WAIT, time
+	mov.l  2f, r3
+1 :
+	nop
+	tst     r3, r3
+	bf/s    1b
+	dt      r3
+	bra	3f
+	 nop
+	.align 2
+2 :	.long \time * 100
+3 :
+.endm
+
+/* The DD command is used to read a 32-bit word */
+.macro  DD, addr, addr2, nr
+	mov.l 1f, r1
+	mov.l @r1, r0
+	bra 2f
+	 nop
+	.align 2
+1 :	.long \addr
+2 :
+.endm
+
+#endif /* __ROMIMAGE_MACRO_H */
diff --git a/arch/sh/include/mach-kfr2r09/mach/romimage.h b/arch/sh/include/mach-kfr2r09/mach/romimage.h
index 39ee794..a110823 100644
--- a/arch/sh/include/mach-kfr2r09/mach/romimage.h
+++ b/arch/sh/include/mach-kfr2r09/mach/romimage.h
@@ -3,75 +3,7 @@
  * the assembly code is the first code to be executed in the romImage
  */
 
-/* The LIST command is used to include comments in the script */
-.macro	LIST comment
-.endm
-
-/* The ED command is used to write a 32-bit word */
-.macro  ED, addr, data
-        mov.l 1f ,r1
-        mov.l 2f ,r0
-        mov.l r0, @r1
-	bra 3f
-	 nop
-	.align 2
-1:	.long \addr
-2:	.long \data
-3:
-.endm
-
-/* The EW command is used to write a 16-bit word */
-.macro  EW, addr, data
-        mov.l 1f ,r1
-        mov.l 2f ,r0
-        mov.w r0, @r1
-	bra 3f
-	 nop
-	.align 2
-1:	.long \addr
-2:	.long \data
-3:
-.endm
-
-/* The EB command is used to write an 8-bit word */
-.macro  EB, addr, data
-        mov.l 1f ,r1
-        mov.l 2f ,r0
-        mov.b r0, @r1
-	bra 3f
-	 nop
-	.align 2
-1:	.long \addr
-2:	.long \data
-3:
-.endm
-
-/* The WAIT command is used to delay the execution */
-.macro  WAIT, time
-        mov.l  2f ,r3
-1:
-        nop
-        tst     r3, r3
-        bf/s    1b
-         dt      r3
-	bra	3f
-	 nop
-	.align 2
-2:	.long \time * 100
-3:
-.endm
-
-/* The DD command is used to read a 32-bit word */
-.macro  DD, addr, addr2, nr
-        mov.l 1f ,r1
-        mov.l @r1, r0
-	bra 2f
-	 nop
-	.align 2
-1:	.long \addr
-2:
-.endm
-
+#include <asm/romimage-macros.h>
 #include "partner-jet-setup.txt"
 
 	/* execute icbi after enabling cache */
-- 
1.6.0.4

