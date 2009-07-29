From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Jul 2009 12:55:56 +0000
Subject: [PATCH] sh: kfr2r09 romImage support
Message-Id: <20090729125556.3596.77154.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds romImage support for the kfr2r09 board.

The partner-jet-setup.txt file is converted into assembly code
which becomes the first code to execute from the reset vector.

The file partner-jet-setup.txt can also be used to setup
the hardware using a JTAG debugger so booting from RAM can
be done without burning the code to flash.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/mach-kfr2r09/partner-jet-setup.txt |  134 ++++++++++++++++++++
 arch/sh/include/mach-kfr2r09/romimage.h            |   75 +++++++++++
 2 files changed, 209 insertions(+)

--- /dev/null
+++ work/arch/sh/include/mach-kfr2r09/partner-jet-setup.txt	2009-07-29 20:52:45.000000000 +0900
@@ -0,0 +1,134 @@
+LIST "partner-jet-setup.txt - 20090722 Magnus Damm"
+LIST "set up enough of the kfr2r09 hardware to boot the kernel"
+
+LIST "CONFIG_ZIMAGE_BOOT_LOADER=n (RAM boot)"
+LIST "This script can be used to boot the kernel from RAM via JTAG:"
+LIST "> < partner-jet-setup.txt"
+LIST "> RD zImage, 0xa8800000"
+LIST "> G=0xa8800000"
+
+LIST "CONFIG_ZIMAGE_BOOT_LOADER=y (Flash boot)"
+LIST "Use the following command to burn the zImage to flash via JTAG:"
+LIST "> RD zImage, 0"
+
+LIST "--------------------------------"
+
+LIST "disable watchdog"
+EW 0xa4520004, 0xa507
+
+LIST "select mode for cs5 + cs6"
+ED 0xff800020, 0xa5a50001
+ED 0xfec10000, 0x0000001b
+
+LIST "setup clocks"
+ED 0xa4150004, 0x00000050
+ED 0xa4150000, 0x91053508
+WAIT 1
+ED 0xa4150024, 0x00005000
+
+LIST "setup pins"
+EB 0xa4050120, 0x00
+EB 0xa4050122, 0x00
+EB 0xa4050124, 0x00
+EB 0xa4050126, 0x00
+EB 0xa4050128, 0xA0
+EB 0xa405012A, 0x10
+EB 0xa405012C, 0x00
+EB 0xa405012E, 0x00
+EB 0xa4050130, 0x00
+EB 0xa4050132, 0x00
+EB 0xa4050134, 0x01
+EB 0xa4050136, 0x40
+EB 0xa4050138, 0x00
+EB 0xa405013A, 0x00
+EB 0xa405013C, 0x00
+EB 0xa405013E, 0x20
+EB 0xa4050160, 0x00
+EB 0xa4050162, 0x40
+EB 0xa4050164, 0x03
+EB 0xa4050166, 0x00
+EB 0xa4050168, 0x00
+EB 0xa405016A, 0x00
+EB 0xa405016C, 0x00
+
+EW 0xa405014E, 0x5660
+EW 0xa4050150, 0x0145
+EW 0xa4050152, 0x1550
+EW 0xa4050154, 0x0200
+EW 0xa4050156, 0x0040
+
+EW 0xa4050158, 0x0000
+EW 0xa405015a, 0x0000
+EW 0xa405015c, 0x0000
+EW 0xa405015e, 0x0000
+
+EW 0xa4050180, 0x0000
+EW 0xa4050182, 0x8002
+EW 0xa4050184, 0x0000
+
+EW 0xa405018a, 0x9991
+EW 0xa405018c, 0x8011
+EW 0xa405018e, 0x9550
+
+EW 0xa4050100, 0x0000
+EW 0xa4050102, 0x5540
+EW 0xa4050104, 0x0000
+EW 0xa4050106, 0x0000
+EW 0xa4050108, 0x4550
+EW 0xa405010a, 0x0130
+EW 0xa405010c, 0x0555
+EW 0xa405010e, 0x0000
+EW 0xa4050110, 0x0000
+EW 0xa4050112, 0xAAA8
+EW 0xa4050114, 0x8305
+EW 0xa4050116, 0x10F0
+EW 0xa4050118, 0x0F50
+EW 0xa405011a, 0x0000
+EW 0xa405011c, 0x0000
+EW 0xa405011e, 0x0555
+EW 0xa4050140, 0x0000
+EW 0xa4050142, 0x5141
+EW 0xa4050144, 0x5005
+EW 0xa4050146, 0xAAA9
+EW 0xa4050148, 0xFAA9
+EW 0xa405014a, 0x3000
+EW 0xa405014c, 0x0000
+
+LIST "setup sdram"
+ED 0xFD000108, 0x40000301
+ED 0xFD000020, 0x011B0002
+ED 0xFD000030, 0x03060E02
+ED 0xFD000034, 0x01020102
+ED 0xFD000038, 0x01090406
+ED 0xFD000008, 0x00000004
+ED 0xFD000040, 0x00000001
+ED 0xFD000040, 0x00000000
+ED 0xFD000018, 0x00000001
+
+WAIT 1
+
+ED 0xFD000014, 0x00000002
+ED 0xFD000060, 0x00000032
+ED 0xFD000060, 0x00020000
+ED 0xFD000014, 0x00000004
+ED 0xFD000014, 0x00000004
+ED 0xFD000010, 0x00000001
+ED 0xFD000044, 0x000004AF
+ED 0xFD000048, 0x20CF0037
+
+LIST "read 16 bytes from sdram"
+DD 0xa8000000, 0xa8000000, 1
+DD 0xa8000004, 0xa8000004, 1
+DD 0xa8000008, 0xa8000008, 1
+DD 0xa800000c, 0xa800000c, 1
+
+ED 0xFD000014, 0x00000002
+ED 0xFD000014, 0x00000004
+ED 0xFD000108, 0x40000300
+ED 0xFD000040, 0x00010000
+
+LIST "write to internal ram"
+ED 0xfd8007fc, 0
+
+LIST "setup cache"
+ED 0xff00001c, 0x0000090b
--- /dev/null
+++ work/arch/sh/include/mach-kfr2r09/romimage.h	2009-07-29 20:55:03.000000000 +0900
@@ -0,0 +1,75 @@
+/* kfr2r09 board specific boot code:
+ * converts the "partner-jet-script.txt" script into assembly
+ * the assembly code is the first code to be executed in the zImage
+ */
+
+/* The LIST command is used to include comments in the script */
+.macro	LIST comment
+.endm
+
+/* The ED command is used to write a 32-bit word */
+.macro  ED, addr, data
+        mov.l 1f ,r1
+        mov.l 2f ,r0
+        mov.l r0, @r1
+	bra 3f
+	 nop
+	.align 2
+1:	.long \addr
+2:	.long \data
+3:
+.endm
+
+/* The EW command is used to write a 16-bit word */
+.macro  EW, addr, data
+        mov.l 1f ,r1
+        mov.l 2f ,r0
+        mov.w r0, @r1
+	bra 3f
+	 nop
+	.align 2
+1:	.long \addr
+2:	.long \data
+3:
+.endm
+
+/* The EB command is used to write an 8-bit word */
+.macro  EB, addr, data
+        mov.l 1f ,r1
+        mov.l 2f ,r0
+        mov.b r0, @r1
+	bra 3f
+	 nop
+	.align 2
+1:	.long \addr
+2:	.long \data
+3:
+.endm
+
+/* The WAIT command is used to delay the execution */
+.macro  WAIT, time
+        mov.l  2f ,r3
+1:
+        nop
+        tst     r3, r3
+        bf/s    1b
+         dt      r3
+	bra	3f
+	 nop
+	.align 2
+2:	.long \time * 100
+3:
+.endm
+
+/* The DD command is used to read a 32-bit word */
+.macro  DD, addr, addr2, nr
+        mov.l 1f ,r1
+        mov.l @r1, r0
+	bra 2f
+	 nop
+	.align 2
+1:	.long \addr
+2:
+.endm
+
+#include "partner-jet-setup.txt"
