From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 06 Aug 2018 02:23:25 +0000
Subject: [PATCH 02/13] sh: drivers: convert to SPDX identifiers
Message-Id: <871sbcp7be.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874lg8p7d2.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874lg8p7d2.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

As original license mentioned, it is GPL-2.0 in SPDX.
Then, MODULE_LICENSE() should be "GPL v2" instead of "GPL".
See ${LINUX}/include/linux/module.h

	"GPL"		[GNU Public License v2 or later]
	"GPL v2"	[GNU Public License v2]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/drivers/dma/Makefile             | 1 +
 arch/sh/drivers/dma/dma-api.c            | 7 ++-----
 arch/sh/drivers/dma/dma-g2.c             | 7 ++-----
 arch/sh/drivers/dma/dma-pvr2.c           | 7 ++-----
 arch/sh/drivers/dma/dma-sh.c             | 7 ++-----
 arch/sh/drivers/dma/dma-sysfs.c          | 5 +----
 arch/sh/drivers/dma/dmabrg.c             | 3 +--
 arch/sh/drivers/heartbeat.c              | 5 +----
 arch/sh/drivers/pci/fixups-dreamcast.c   | 5 +----
 arch/sh/drivers/pci/fixups-landisk.c     | 4 +---
 arch/sh/drivers/pci/fixups-r7780rp.c     | 5 +----
 arch/sh/drivers/pci/fixups-rts7751r2d.c  | 5 +----
 arch/sh/drivers/pci/fixups-sdk7780.c     | 5 +----
 arch/sh/drivers/pci/fixups-sdk7786.c     | 5 +----
 arch/sh/drivers/pci/fixups-snapgear.c    | 4 +---
 arch/sh/drivers/pci/fixups-titan.c       | 4 +---
 arch/sh/drivers/pci/ops-dreamcast.c      | 5 +----
 arch/sh/drivers/pci/ops-sh4.c            | 5 +----
 arch/sh/drivers/pci/ops-sh5.c            | 4 +---
 arch/sh/drivers/pci/ops-sh7786.c         | 5 +----
 arch/sh/drivers/pci/pci-dreamcast.c      | 5 +----
 arch/sh/drivers/pci/pci-sh5.c            | 4 +---
 arch/sh/drivers/pci/pci-sh5.h            | 6 ++----
 arch/sh/drivers/pci/pci-sh7751.c         | 5 +----
 arch/sh/drivers/pci/pci-sh7751.h         | 7 ++-----
 arch/sh/drivers/pci/pci-sh7780.c         | 5 +----
 arch/sh/drivers/pci/pci-sh7780.h         | 7 ++-----
 arch/sh/drivers/pci/pci.c                | 5 +----
 arch/sh/drivers/pci/pcie-sh7786.c        | 5 +----
 arch/sh/drivers/pci/pcie-sh7786.h        | 7 ++-----
 arch/sh/drivers/push-switch.c            | 5 +----
 arch/sh/drivers/superhyway/Makefile      | 1 +
 arch/sh/drivers/superhyway/ops-sh4-202.c | 5 +----
 33 files changed, 41 insertions(+), 124 deletions(-)

diff --git a/arch/sh/drivers/dma/Makefile b/arch/sh/drivers/dma/Makefile
index d88c948..d2fdd56 100644
--- a/arch/sh/drivers/dma/Makefile
+++ b/arch/sh/drivers/dma/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SuperH DMA specific kernel interface routines under Linux.
 #
diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index b05be59..ab91704 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-api.c
  *
  * SuperH-specific DMA management API
  *
  * Copyright (C) 2003, 2004, 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/module.h>
@@ -417,4 +414,4 @@ subsys_initcall(dma_api_init);
 
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("DMA API for SuperH");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-g2.c b/arch/sh/drivers/dma/dma-g2.c
index e1ab6eb..52a8ae5 100644
--- a/arch/sh/drivers/dma/dma-g2.c
+++ b/arch/sh/drivers/dma/dma-g2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-g2.c
  *
  * G2 bus DMA support
  *
  * Copyright (C) 2003 - 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -197,4 +194,4 @@ module_exit(g2_dma_exit);
 
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("G2 bus DMA driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.c
index 706a343..b5dbd1f 100644
--- a/arch/sh/drivers/dma/dma-pvr2.c
+++ b/arch/sh/drivers/dma/dma-pvr2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-pvr2.c
  *
  * NEC PowerVR 2 (Dreamcast) DMA support
  *
  * Copyright (C) 2003, 2004  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -105,4 +102,4 @@ module_exit(pvr2_dma_exit);
 
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("NEC PowerVR 2 DMA driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index afde2a7..96c626c 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-sh.c
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2000 Takashi YOSHII
  * Copyright (C) 2003, 2004 Paul Mundt
  * Copyright (C) 2005 Andriy Skulysh
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -414,4 +411,4 @@ module_exit(sh_dmac_exit);
 
 MODULE_AUTHOR("Takashi YOSHII, Paul Mundt, Andriy Skulysh");
 MODULE_DESCRIPTION("SuperH On-Chip DMAC Support");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 4b15fed..8ef3181 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-sysfs.c
  *
  * sysfs interface for SH DMA API
  *
  * Copyright (C) 2004 - 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/drivers/dma/dmabrg.c b/arch/sh/drivers/dma/dmabrg.c
index e5a57a1..5b2c1fd 100644
--- a/arch/sh/drivers/dma/dmabrg.c
+++ b/arch/sh/drivers/dma/dmabrg.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7760 DMABRG IRQ handling
  *
  * (c) 2007 MSC Vertriebsges.m.b.H, Manuel Lauss <mlau@msc-ge.com>
- *  licensed under the GPLv2.
- *
  */
 
 #include <linux/interrupt.h>
diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index e8af2ff..cf2fccc 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic heartbeat driver for regular LED banks
  *
@@ -13,10 +14,6 @@
  * traditionally used for strobing the load average. This use case is
  * handled by this driver, rather than giving each LED bit position its
  * own struct device.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index 48aaefd..dfdbd05 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-dreamcast.c
  *
@@ -9,10 +10,6 @@
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
  *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/fixups-landisk.c b/arch/sh/drivers/pci/fixups-landisk.c
index db5b40a..53fa2fc 100644
--- a/arch/sh/drivers/pci/fixups-landisk.c
+++ b/arch/sh/drivers/pci/fixups-landisk.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-landisk.c
  *
@@ -5,9 +6,6 @@
  *
  * Copyright (C) 2006 kogiidena
  * Copyright (C) 2010 Nobuhiro Iwamatsu
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/sh/drivers/pci/fixups-r7780rp.c b/arch/sh/drivers/pci/fixups-r7780rp.c
index 2c9b58f..3c9139c 100644
--- a/arch/sh/drivers/pci/fixups-r7780rp.c
+++ b/arch/sh/drivers/pci/fixups-r7780rp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-r7780rp.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2003  Lineo uSolutions, Inc.
  * Copyright (C) 2004 - 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/pci.h>
 #include <linux/io.h>
diff --git a/arch/sh/drivers/pci/fixups-rts7751r2d.c b/arch/sh/drivers/pci/fixups-rts7751r2d.c
index 358ac10..3f0a6fe 100644
--- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
+++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-rts7751r2d.c
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2003  Lineo uSolutions, Inc.
  * Copyright (C) 2004  Paul Mundt
  * Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/pci.h>
 #include <mach/lboxre2.h>
diff --git a/arch/sh/drivers/pci/fixups-sdk7780.c b/arch/sh/drivers/pci/fixups-sdk7780.c
index 24e96df..c306040 100644
--- a/arch/sh/drivers/pci/fixups-sdk7780.c
+++ b/arch/sh/drivers/pci/fixups-sdk7780.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-sdk7780.c
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2003  Lineo uSolutions, Inc.
  * Copyright (C) 2004 - 2006  Paul Mundt
  * Copyright (C) 2006  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/pci.h>
 #include <linux/io.h>
diff --git a/arch/sh/drivers/pci/fixups-sdk7786.c b/arch/sh/drivers/pci/fixups-sdk7786.c
index 36eb6fc..8cbfa531 100644
--- a/arch/sh/drivers/pci/fixups-sdk7786.c
+++ b/arch/sh/drivers/pci/fixups-sdk7786.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA PCIe mux handling
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) "PCI: " fmt
 
diff --git a/arch/sh/drivers/pci/fixups-snapgear.c b/arch/sh/drivers/pci/fixups-snapgear.c
index a931e59..317225c 100644
--- a/arch/sh/drivers/pci/fixups-snapgear.c
+++ b/arch/sh/drivers/pci/fixups-snapgear.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/ops-snapgear.c
  *
@@ -7,9 +8,6 @@
  *
  * Highly leveraged from pci-bigsur.c, written by Dustin McIntire.
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * PCI initialization for the SnapGear boards
  */
 #include <linux/kernel.h>
diff --git a/arch/sh/drivers/pci/fixups-titan.c b/arch/sh/drivers/pci/fixups-titan.c
index a9d563e..b5bb65c 100644
--- a/arch/sh/drivers/pci/fixups-titan.c
+++ b/arch/sh/drivers/pci/fixups-titan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/ops-titan.c
  *
@@ -6,9 +7,6 @@
  * Modified from ops-snapgear.c written by  David McCullough
  * Highly leveraged from pci-bigsur.c, written by Dustin McIntire.
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * PCI initialization for the Titan boards
  */
 #include <linux/kernel.h>
diff --git a/arch/sh/drivers/pci/ops-dreamcast.c b/arch/sh/drivers/pci/ops-dreamcast.c
index 16e0a1b..517a8a97 100644
--- a/arch/sh/drivers/pci/ops-dreamcast.c
+++ b/arch/sh/drivers/pci/ops-dreamcast.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * PCI operations for the Sega Dreamcast
  *
  * Copyright (C) 2001, 2002  M. R. Brown
  * Copyright (C) 2002, 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/ops-sh4.c b/arch/sh/drivers/pci/ops-sh4.c
index b623420..a205be3 100644
--- a/arch/sh/drivers/pci/ops-sh4.c
+++ b/arch/sh/drivers/pci/ops-sh4.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic SH-4 / SH-4A PCIC operations (SH7751, SH7780).
  *
  * Copyright (C) 2002 - 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License v2. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/pci.h>
 #include <linux/io.h>
diff --git a/arch/sh/drivers/pci/ops-sh5.c b/arch/sh/drivers/pci/ops-sh5.c
index 4536194..9fbaf72 100644
--- a/arch/sh/drivers/pci/ops-sh5.c
+++ b/arch/sh/drivers/pci/ops-sh5.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Support functions for the SH5 PCI hardware.
  *
  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  * Copyright (C) 2003, 2004 Paul Mundt
  * Copyright (C) 2004 Richard Curnow
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/kernel.h>
 #include <linux/rwsem.h>
diff --git a/arch/sh/drivers/pci/ops-sh7786.c b/arch/sh/drivers/pci/ops-sh7786.c
index 1284210..a10f9f4 100644
--- a/arch/sh/drivers/pci/ops-sh7786.c
+++ b/arch/sh/drivers/pci/ops-sh7786.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic SH7786 PCI-Express operations.
  *
  *  Copyright (C) 2009 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License v2. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/drivers/pci/pci-dreamcast.c b/arch/sh/drivers/pci/pci-dreamcast.c
index 6336941..4cff2a8 100644
--- a/arch/sh/drivers/pci/pci-dreamcast.c
+++ b/arch/sh/drivers/pci/pci-dreamcast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * PCI support for the Sega Dreamcast
  *
@@ -7,10 +8,6 @@
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
  *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/pci-sh5.c b/arch/sh/drivers/pci/pci-sh5.c
index 8229114c..49303fa 100644
--- a/arch/sh/drivers/pci/pci-sh5.c
+++ b/arch/sh/drivers/pci/pci-sh5.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  * Copyright (C) 2003, 2004 Paul Mundt
  * Copyright (C) 2004 Richard Curnow
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * Support functions for the SH5 PCI hardware.
  */
 
diff --git a/arch/sh/drivers/pci/pci-sh5.h b/arch/sh/drivers/pci/pci-sh5.h
index 3f01dec..91348af 100644
--- a/arch/sh/drivers/pci/pci-sh5.h
+++ b/arch/sh/drivers/pci/pci-sh5.h
@@ -1,8 +1,6 @@
-/*
- * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
+/* SPDX-License-Identifier: GPL-2.0
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
+ * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  *
  * Definitions for the SH5 PCI hardware.
  */
diff --git a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7751.c
index 86adb1e..1b9e5ca 100644
--- a/arch/sh/drivers/pci/pci-sh7751.c
+++ b/arch/sh/drivers/pci/pci-sh7751.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Low-Level PCI Support for the SH7751
  *
@@ -5,10 +6,6 @@
  *  Copyright (C) 2001  Dustin McIntire
  *
  *  With cleanup by Paul van Gool <pvangool@mimotech.com>, 2003.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/pci.h>
diff --git a/arch/sh/drivers/pci/pci-sh7751.h b/arch/sh/drivers/pci/pci-sh7751.h
index 5ede38c..d1951e5 100644
--- a/arch/sh/drivers/pci/pci-sh7751.h
+++ b/arch/sh/drivers/pci/pci-sh7751.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *	Low-Level PCI Support for SH7751 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
  *  Paul Mundt (lethal@linux-sh.org) (c) 2003
- *
- *  May be copied or modified under the terms of the GNU General Public
- *  License.  See linux/COPYING for more information.
- *
  */
 
 #ifndef _PCI_SH7751_H_
diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index 5a6dab6..3fd0f39 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Low-Level PCI Support for the SH7780
  *
  *  Copyright (C) 2005 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/types.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/drivers/pci/pci-sh7780.h
index 1742e2c..e2ac770 100644
--- a/arch/sh/drivers/pci/pci-sh7780.h
+++ b/arch/sh/drivers/pci/pci-sh7780.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *	Low-Level PCI Support for SH7780 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
  *  Paul Mundt (lethal@linux-sh.org) (c) 2003
- *
- *  May be copied or modified under the terms of the GNU General Public
- *  License.  See linux/COPYING for more information.
- *
  */
 
 #ifndef _PCI_SH7780_H_
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index e5b7437..eadc56d 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * New-style PCI core.
  *
@@ -6,10 +7,6 @@
  *
  * Modelled after arch/mips/pci/pci.c:
  *  Copyright (C) 2003, 04 Ralf Baechle (ralf@linux-mips.org)
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 3d81a8b..a58b77c 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Low-Level PCI Express Support for the SH7786
  *
  *  Copyright (C) 2009 - 2011  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) "PCI: " fmt
 
diff --git a/arch/sh/drivers/pci/pcie-sh7786.h b/arch/sh/drivers/pci/pcie-sh7786.h
index 4a6ff55..ffe3836 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.h
+++ b/arch/sh/drivers/pci/pcie-sh7786.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * SH7786 PCI-Express controller definitions.
  *
  * Copyright (C) 2008, 2009 Renesas Technology Corp.
  * All rights reserved.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __PCI_SH7786_H
 #define __PCI_SH7786_H
diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index 762bc56..2813140 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic push-switch framework
  *
  * Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/arch/sh/drivers/superhyway/Makefile b/arch/sh/drivers/superhyway/Makefile
index 5b8e0c7..aa6e326 100644
--- a/arch/sh/drivers/superhyway/Makefile
+++ b/arch/sh/drivers/superhyway/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SuperHyway specific kernel interface routines under Linux.
 #
diff --git a/arch/sh/drivers/superhyway/ops-sh4-202.c b/arch/sh/drivers/superhyway/ops-sh4-202.c
index 6da62e9..4901422 100644
--- a/arch/sh/drivers/superhyway/ops-sh4-202.c
+++ b/arch/sh/drivers/superhyway/ops-sh4-202.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/superhyway/ops-sh4-202.c
  *
  * SuperHyway bus support for SH4-202
  *
  * Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU
- * General Public License.  See the file "COPYING" in the main
- * directory of this archive for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.7.4

