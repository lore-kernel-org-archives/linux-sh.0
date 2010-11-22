From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Nov 2010 23:15:15 +0000
Subject: [patch v4 1/2] ARM: Add zboot support for SuperH Mobile ARM
Message-Id: <20101122231759.865310149@vergenet.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20101122231514.766413220@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

When CONFIG_ZBOOT_ROM is selected, the resulting zImage file will be small
boot loader and may be burned to rom or flash.

This is the non-board-specific framework portion of this patch-set.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

v2:
* As suggested by Magnus Damm; Implemented by Simon Horman
  - Initialise atags in framework and pass atags to kernel

v3:
* As suggested by Magnus Damm; Implemented by Simon Horman
  - Initialise atags directly rather than using assembly

Index: linux-2.6-arm/arch/arm/boot/compressed/Makefile
=================================--- linux-2.6-arm.orig/arch/arm/boot/compressed/Makefile	2010-10-14 16:47:47.000000000 +0900
+++ linux-2.6-arm/arch/arm/boot/compressed/Makefile	2010-10-14 16:47:53.000000000 +0900
@@ -45,6 +45,10 @@ else
 endif
 endif
 
+ifeq ($(CONFIG_ARCH_SHMOBILE),y)
+OBJS		+= head-shmobile.o
+endif
+
 #
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
Index: linux-2.6-arm/arch/arm/boot/compressed/head-shmobile.S
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-arm/arch/arm/boot/compressed/head-shmobile.S	2010-10-14 16:57:54.000000000 +0900
@@ -0,0 +1,53 @@
+/*
+ * The head-file for SH-Mobile ARM platforms
+ *
+ * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ * Simon Horman <horms@verge.net.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef CONFIG_ZBOOT_ROM
+
+	.section	".start", "ax"
+
+	/* load board-specific initialization code */
+#include <mach/zboot.h>
+
+	b	1f
+__atags:@ tag #1
+	.long	12			@ tag->hdr.size = tag_size(tag_core);
+	.long	0x54410001		@ tag->hdr.tag = ATAG_CORE;
+	.long   0			@ tag->u.core.flags = 0;
+	.long	0			@ tag->u.core.pagesize = 0;
+	.long	0			@ tag->u.core.rootdev = 0;
+	@ tag #2
+	.long	8			@ tag->hdr.size = tag_size(tag_mem32);
+	.long	0x54410002		@ tag->hdr.tag = ATAG_MEM;
+	.long	CONFIG_MEMORY_SIZE	@ tag->u.mem.size = CONFIG_MEMORY_SIZE;
+	.long	CONFIG_MEMORY_START	@ @ tag->u.mem.start = CONFIG_MEMORY_START;
+	@ tag #3
+	.long	0			@ tag->hdr.size = 0
+	.long	0			@ tag->hdr.tag = ATAG_NONE;
+1:
+
+	/* Set board ID necessary for boot */
+	ldr	r7, 1f				@ Set machine type register
+	adr	r8, __atags			@ Set atag register
+	b	2f
+
+1 :	.long MACH_TYPE
+2 :
+
+#endif /* CONFIG_ZBOOT_ROM */
Index: linux-2.6-arm/arch/arm/mach-shmobile/include/mach/zboot.h
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-shmobile/include/mach/zboot.h	2010-10-14 16:55:20.000000000 +0900
@@ -0,0 +1,12 @@
+#ifndef ZBOOT_H
+#define ZBOOT_H
+
+/**************************************************
+ *
+ *		board specific settings
+ *
+ **************************************************/
+
+#error "unsupported board."
+
+#endif /* ZBOOT_H */

