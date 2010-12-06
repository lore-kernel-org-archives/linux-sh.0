From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Dec 2010 00:12:44 +0000
Subject: [patch 1/3] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Message-Id: <20101206001310.658304531@vergenet.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20101206001243.949375995@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Allow MMCIF_PROGRESS_* to be shared.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6-ap4/arch/sh/boot/romimage/mmcif-sh7724.c
=================================--- linux-2.6-ap4.orig/arch/sh/boot/romimage/mmcif-sh7724.c	2010-12-06 08:59:11.000000000 +0900
+++ linux-2.6-ap4/arch/sh/boot/romimage/mmcif-sh7724.c	2010-12-06 08:59:16.000000000 +0900
@@ -21,9 +21,6 @@
 #define HIZCRC		0xa405015c
 #define DRVCRA		0xa405018a
 
-enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
-       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
-
 /* SH7724 specific MMCIF loader
  *
  * loads the romImage from an MMC card starting from block 512
Index: linux-2.6-ap4/include/linux/mmc/sh_mmcif.h
=================================--- linux-2.6-ap4.orig/include/linux/mmc/sh_mmcif.h	2010-12-06 08:59:11.000000000 +0900
+++ linux-2.6-ap4/include/linux/mmc/sh_mmcif.h	2010-12-06 08:59:16.000000000 +0900
@@ -97,6 +97,9 @@ static inline void sh_mmcif_writel(void
 
 #define SH_MMCIF_BBS 512 /* boot block size */
 
+enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
+       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
+
 static inline void sh_mmcif_boot_cmd_send(void __iomem *base,
 					  unsigned long cmd, unsigned long arg)
 {

