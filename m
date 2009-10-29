From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:51:40 +0000
Subject: [PATCH 01/07] sh: Rename romimage-macros.h to partner-jet-macros.h
Message-Id: <20091029105140.29078.90079.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Since we will use the macros outside of romimage, rename the
file <asm/romimage-macros.h> to <asm/partner-jet-macros.h>.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/partner-jet-macros.h      |   73 +++++++++++++++++++++++++
 arch/sh/include/asm/romimage-macros.h         |   73 -------------------------
 arch/sh/include/mach-ecovec24/mach/romimage.h |    2 
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |    2 
 4 files changed, 75 insertions(+), 75 deletions(-)

--- /dev/null
+++ work/arch/sh/include/asm/partner-jet-macros.h	2009-10-28 18:02:15.000000000 +0900
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
--- 0001/arch/sh/include/asm/romimage-macros.h
+++ /dev/null	2009-10-26 09:40:59.257024378 +0900
@@ -1,73 +0,0 @@
-#ifndef __ROMIMAGE_MACRO_H
-#define __ROMIMAGE_MACRO_H
-
-/* The LIST command is used to include comments in the script */
-.macro	LIST comment
-.endm
-
-/* The ED command is used to write a 32-bit word */
-.macro  ED, addr, data
-	mov.l 1f, r1
-	mov.l 2f, r0
-	mov.l r0, @r1
-	bra 3f
-	 nop
-	.align 2
-1 :	.long \addr
-2 :	.long \data
-3 :
-.endm
-
-/* The EW command is used to write a 16-bit word */
-.macro  EW, addr, data
-	mov.l 1f, r1
-	mov.l 2f, r0
-	mov.w r0, @r1
-	bra 3f
-	 nop
-	.align 2
-1 :	.long \addr
-2 :	.long \data
-3 :
-.endm
-
-/* The EB command is used to write an 8-bit word */
-.macro  EB, addr, data
-	mov.l 1f, r1
-	mov.l 2f, r0
-	mov.b r0, @r1
-	bra 3f
-	 nop
-	.align 2
-1 :	.long \addr
-2 :	.long \data
-3 :
-.endm
-
-/* The WAIT command is used to delay the execution */
-.macro  WAIT, time
-	mov.l  2f, r3
-1 :
-	nop
-	tst     r3, r3
-	bf/s    1b
-	dt      r3
-	bra	3f
-	 nop
-	.align 2
-2 :	.long \time * 100
-3 :
-.endm
-
-/* The DD command is used to read a 32-bit word */
-.macro  DD, addr, addr2, nr
-	mov.l 1f, r1
-	mov.l @r1, r0
-	bra 2f
-	 nop
-	.align 2
-1 :	.long \addr
-2 :
-.endm
-
-#endif /* __ROMIMAGE_MACRO_H */
--- 0001/arch/sh/include/mach-ecovec24/mach/romimage.h
+++ work/arch/sh/include/mach-ecovec24/mach/romimage.h	2009-10-29 12:53:15.000000000 +0900
@@ -3,7 +3,7 @@
  * the assembly code is the first code to be executed in the romImage
  */
 
-#include <asm/romimage-macros.h>
+#include <asm/partner-jet-macros.h>
 #include "partner-jet-setup.txt"
 
 	/* execute icbi after enabling cache */
--- 0001/arch/sh/include/mach-kfr2r09/mach/romimage.h
+++ work/arch/sh/include/mach-kfr2r09/mach/romimage.h	2009-10-29 12:53:01.000000000 +0900
@@ -3,7 +3,7 @@
  * the assembly code is the first code to be executed in the romImage
  */
 
-#include <asm/romimage-macros.h>
+#include <asm/partner-jet-macros.h>
 #include "partner-jet-setup.txt"
 
 	/* execute icbi after enabling cache */
