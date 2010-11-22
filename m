From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Nov 2010 23:15:16 +0000
Subject: [patch v4 2/2] ARM: mach-shmobile: Add zboot support for SuperH Mobile ARM
Message-Id: <20101122231800.057808011@vergenet.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20101122231514.766413220@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

When CONFIG_ZBOOT_ROM is selected, the resulting zImage file will be small
boot loader and may be burned to rom or flash.

This is the board-specific portion of this patch-set.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

v2:
* As suggested by Magnus Damm; Implemented by Simon Horman
  - Initialise atags in framework and pass atags to kernel.
    This removes the need for board-specific fixup code.

Index: linux-2.6-arm/arch/arm/mach-shmobile/board-ap4evb.c
=================================--- linux-2.6-arm.orig/arch/arm/mach-shmobile/board-ap4evb.c	2010-11-23 08:13:38.000000000 +0900
+++ linux-2.6-arm/arch/arm/mach-shmobile/board-ap4evb.c	2010-11-23 08:14:08.000000000 +0900
@@ -61,6 +61,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/setup.h>
 
 /*
  * Address	Interface		BusWidth	note
Index: linux-2.6-arm/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt	2010-11-23 08:14:08.000000000 +0900
@@ -0,0 +1,87 @@
+LIST "partner-jet-setup.txt"
+LIST "(C) Copyright 2010 Renesas Solutions Corp"
+LIST "Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>"
+
+LIST "RWT Setting"
+EW 0xE6020004, 0xA500
+EW 0xE6030004, 0xA500
+
+DD 0x01001000, 0x01001000
+
+LIST "GPIO Setting"
+EB 0xE6051013, 0xA2
+
+LIST "CPG"
+ED 0xE6150080, 0x00000180
+ED 0xE61500C0, 0x00000002
+
+WAIT 1, 0xFE40009C
+
+LIST "FRQCR"
+ED 0xE6150000, 0x2D1305C3
+ED 0xE61500E0, 0x9E40358E
+ED 0xE6150004, 0x80331050
+
+WAIT 1, 0xFE40009C
+
+ED 0xE61500E4, 0x00002000
+
+WAIT 1, 0xFE40009C
+
+LIST "PLL"
+ED 0xE6150028, 0x00004000
+
+WAIT 1, 0xFE40009C
+
+ED 0xE615002C, 0x93000040
+
+WAIT 1, 0xFE40009C
+
+LIST "BSC"
+ED 0xFEC10000, 0x00E0001B
+
+LIST "SBSC1"
+ED 0xFE400354, 0x01AD8000
+ED 0xFE400354, 0x01AD8001
+
+WAIT 5, 0xFE40009C
+
+ED 0xFE400008, 0xBCC90151
+ED 0xFE400040, 0x41774113
+ED 0xFE400044, 0x2712E229
+ED 0xFE400048, 0x20C18505
+ED 0xFE40004C, 0x00110209
+ED 0xFE400010, 0x00000087
+
+WAIT 10, 0xFE40009C
+
+ED 0xFE400084, 0x0000003F
+EB 0xFE500000, 0x00
+
+WAIT 5, 0xFE40009C
+
+ED 0xFE400084, 0x0000FF0A
+EB 0xFE500000, 0x00
+
+WAIT 1, 0xFE40009C
+
+ED 0xFE400084, 0x00002201
+EB 0xFE500000, 0x00
+ED 0xFE400084, 0x00000302
+EB 0xFE500000, 0x00
+EB 0xFE5C0000, 0x00
+ED 0xFE400008, 0xBCC90159
+ED 0xFE40008C, 0x88800004
+ED 0xFE400094, 0x00000004
+ED 0xFE400028, 0xA55A0032
+ED 0xFE40002C, 0xA55A000C
+ED 0xFE400020, 0xA55A2048
+ED 0xFE400008, 0xBCC90959
+
+LIST "Change CPGA setting"
+ED 0xE61500E0, 0x9E40352E
+ED 0xE6150004, 0x80331050
+
+WAIT 1, 0xFE40009C
+
+ED 0xE6150354, 0x00000002
Index: linux-2.6-arm/arch/arm/mach-shmobile/include/mach/zboot_macros.h
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-shmobile/include/mach/zboot_macros.h	2010-11-23 08:14:08.000000000 +0900
@@ -0,0 +1,65 @@
+#ifndef __ZBOOT_MACRO_H
+#define __ZBOOT_MACRO_H
+
+/* The LIST command is used to include comments in the script */
+.macro	LIST comment
+.endm
+
+/* The ED command is used to write a 32-bit word */
+.macro ED, addr, data
+	LDR	r0, 1f
+	LDR	r1, 2f
+	STR	r1, [r0]
+	B	3f
+1 :	.long	\addr
+2 :	.long	\data
+3 :
+.endm
+
+/* The EW command is used to write a 16-bit word */
+.macro EW, addr, data
+	LDR	r0, 1f
+	LDR	r1, 2f
+	STRH	r1, [r0]
+	B	3f
+1 :	.long	\addr
+2 :	.long	\data
+3 :
+.endm
+
+/* The EB command is used to write an 8-bit word */
+.macro EB, addr, data
+	LDR	r0, 1f
+	LDR	r1, 2f
+	STRB	r1, [r0]
+	B	3f
+1 :	.long	\addr
+2 :	.long	\data
+3 :
+.endm
+
+/* The WAIT command is used to delay the execution */
+.macro  WAIT, time, reg
+	LDR	r1, 1f
+	LDR	r0, 2f
+	STR	r0, [r1]
+10 :
+	LDR	r0, [r1]
+	CMP	r0, #0x00000000
+	BNE	10b
+	NOP
+	B	3f
+1 :	.long	\reg
+2 :	.long	\time * 100
+3 :
+.endm
+
+/* The DD command is used to read a 32-bit word */
+.macro  DD, start, end
+	LDR	r1, 1f
+	B	2f
+1 :	.long	\start
+2 :
+.endm
+
+#endif /* __ZBOOT_MACRO_H */
Index: linux-2.6-arm/arch/arm/mach-shmobile/include/mach/zboot.h
=================================--- linux-2.6-arm.orig/arch/arm/mach-shmobile/include/mach/zboot.h	2010-11-23 08:14:06.000000000 +0900
+++ linux-2.6-arm/arch/arm/mach-shmobile/include/mach/zboot.h	2010-11-23 08:14:45.000000000 +0900
@@ -1,12 +1,20 @@
 #ifndef ZBOOT_H
 #define ZBOOT_H
 
+#include <asm/mach-types.h>
+#include <mach/zboot_macros.h>
+
 /**************************************************
  *
  *		board specific settings
  *
  **************************************************/
 
+#ifdef CONFIG_MACH_AP4EVB
+#define MACH_TYPE	MACH_TYPE_AP4EVB
+#include "mach/head-ap4evb.txt"
+#else
 #error "unsupported board."
+#endif
 
 #endif /* ZBOOT_H */

