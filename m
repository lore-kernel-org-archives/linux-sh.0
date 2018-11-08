From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2018 06:16:54 +0000
Subject: [PATCH  resend 01/13] sh: boards: convert to SPDX identifiers
Message-Id: <87in1814bt.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/boards/board-apsh4a3a.c                 |  5 +----
 arch/sh/boards/board-apsh4ad0a.c                |  5 +----
 arch/sh/boards/board-edosk7760.c                | 15 +--------------
 arch/sh/boards/board-espt.c                     |  5 +----
 arch/sh/boards/board-magicpanelr2.c             |  5 +----
 arch/sh/boards/board-sh7757lcr.c                |  5 +----
 arch/sh/boards/board-sh7785lcr.c                |  5 +----
 arch/sh/boards/board-titan.c                    |  5 +----
 arch/sh/boards/board-urquell.c                  |  5 +----
 arch/sh/boards/mach-ap325rxa/Makefile           |  1 +
 arch/sh/boards/mach-ap325rxa/sdram.S            |  7 ++-----
 arch/sh/boards/mach-cayman/Makefile             |  1 +
 arch/sh/boards/mach-cayman/irq.c                |  5 +----
 arch/sh/boards/mach-cayman/panic.c              |  5 +----
 arch/sh/boards/mach-cayman/setup.c              |  5 +----
 arch/sh/boards/mach-dreamcast/Makefile          |  1 +
 arch/sh/boards/mach-dreamcast/irq.c             |  2 +-
 arch/sh/boards/mach-dreamcast/rtc.c             |  4 +---
 arch/sh/boards/mach-dreamcast/setup.c           |  3 +--
 arch/sh/boards/mach-ecovec24/Makefile           |  3 ++-
 arch/sh/boards/mach-ecovec24/sdram.S            |  7 ++-----
 arch/sh/boards/mach-ecovec24/setup.c            |  5 +----
 arch/sh/boards/mach-highlander/irq-r7780mp.c    |  5 +----
 arch/sh/boards/mach-highlander/irq-r7780rp.c    |  5 +----
 arch/sh/boards/mach-highlander/irq-r7785rp.c    |  5 +----
 arch/sh/boards/mach-highlander/pinmux-r7785rp.c |  5 +----
 arch/sh/boards/mach-highlander/psw.c            |  5 +----
 arch/sh/boards/mach-highlander/setup.c          |  5 +----
 arch/sh/boards/mach-hp6xx/Makefile              |  1 +
 arch/sh/boards/mach-hp6xx/hp6xx_apm.c           |  4 +---
 arch/sh/boards/mach-hp6xx/pm.c                  |  4 +---
 arch/sh/boards/mach-hp6xx/pm_wakeup.S           |  8 ++------
 arch/sh/boards/mach-hp6xx/setup.c               |  4 +---
 arch/sh/boards/mach-kfr2r09/Makefile            |  1 +
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c         |  5 +----
 arch/sh/boards/mach-kfr2r09/sdram.S             |  7 ++-----
 arch/sh/boards/mach-landisk/Makefile            |  1 +
 arch/sh/boards/mach-landisk/gio.c               |  6 +-----
 arch/sh/boards/mach-landisk/irq.c               |  5 +----
 arch/sh/boards/mach-landisk/psw.c               |  5 +----
 arch/sh/boards/mach-landisk/setup.c             |  5 +----
 arch/sh/boards/mach-lboxre2/Makefile            |  1 +
 arch/sh/boards/mach-lboxre2/irq.c               |  6 +-----
 arch/sh/boards/mach-lboxre2/setup.c             |  6 +-----
 arch/sh/boards/mach-microdev/Makefile           |  1 +
 arch/sh/boards/mach-microdev/fdc37c93xapm.c     |  5 +----
 arch/sh/boards/mach-microdev/io.c               |  4 +---
 arch/sh/boards/mach-microdev/irq.c              |  4 +---
 arch/sh/boards/mach-microdev/setup.c            |  4 +---
 arch/sh/boards/mach-migor/Makefile              |  1 +
 arch/sh/boards/mach-migor/lcd_qvga.c            |  5 +----
 arch/sh/boards/mach-migor/sdram.S               |  7 ++-----
 arch/sh/boards/mach-r2d/Makefile                |  1 +
 arch/sh/boards/mach-r2d/setup.c                 |  5 +----
 arch/sh/boards/mach-rsk/Makefile                |  1 +
 arch/sh/boards/mach-rsk/devices-rsk7203.c       |  5 +----
 arch/sh/boards/mach-rsk/devices-rsk7264.c       |  5 +----
 arch/sh/boards/mach-rsk/devices-rsk7269.c       |  5 +----
 arch/sh/boards/mach-rsk/setup.c                 |  5 +----
 arch/sh/boards/mach-sdk7780/Makefile            |  1 +
 arch/sh/boards/mach-sdk7780/irq.c               |  5 +----
 arch/sh/boards/mach-sdk7780/setup.c             |  5 +----
 arch/sh/boards/mach-sdk7786/Makefile            |  1 +
 arch/sh/boards/mach-sdk7786/fpga.c              |  5 +----
 arch/sh/boards/mach-sdk7786/gpio.c              |  5 +----
 arch/sh/boards/mach-sdk7786/irq.c               |  5 +----
 arch/sh/boards/mach-sdk7786/nmi.c               |  5 +----
 arch/sh/boards/mach-sdk7786/setup.c             |  5 +----
 arch/sh/boards/mach-sdk7786/sram.c              |  5 +----
 arch/sh/boards/mach-se/7206/Makefile            |  1 +
 arch/sh/boards/mach-se/7343/Makefile            |  1 +
 arch/sh/boards/mach-se/7343/irq.c               |  5 +----
 arch/sh/boards/mach-se/770x/Makefile            |  1 +
 arch/sh/boards/mach-se/7721/Makefile            |  1 +
 arch/sh/boards/mach-se/7721/irq.c               |  5 +----
 arch/sh/boards/mach-se/7721/setup.c             |  6 +-----
 arch/sh/boards/mach-se/7722/Makefile            |  1 +
 arch/sh/boards/mach-se/7722/irq.c               |  5 +----
 arch/sh/boards/mach-se/7722/setup.c             |  6 +-----
 arch/sh/boards/mach-se/7724/Makefile            |  1 +
 arch/sh/boards/mach-se/7724/irq.c               |  5 +----
 arch/sh/boards/mach-se/7724/sdram.S             |  7 ++-----
 arch/sh/boards/mach-se/7751/Makefile            |  1 +
 arch/sh/boards/mach-se/7780/Makefile            |  1 +
 arch/sh/boards/mach-se/7780/irq.c               |  5 +----
 arch/sh/boards/mach-se/7780/setup.c             |  5 +----
 arch/sh/boards/mach-sh03/Makefile               |  1 +
 arch/sh/boards/mach-sh7763rdp/Makefile          |  1 +
 arch/sh/boards/mach-sh7763rdp/irq.c             |  5 +----
 arch/sh/boards/mach-sh7763rdp/setup.c           |  5 +----
 arch/sh/boards/mach-x3proto/Makefile            |  1 +
 arch/sh/boards/mach-x3proto/gpio.c              |  5 +----
 arch/sh/boards/mach-x3proto/ilsel.c             |  5 +----
 arch/sh/boards/mach-x3proto/setup.c             |  5 +----
 arch/sh/boards/of-generic.c                     |  5 +----
 95 files changed, 102 insertions(+), 291 deletions(-)

diff --git a/arch/sh/boards/board-apsh4a3a.c b/arch/sh/boards/board-apsh4a3a.c
index 0a39c24..346eda7 100644
--- a/arch/sh/boards/board-apsh4a3a.c
+++ b/arch/sh/boards/board-apsh4a3a.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ALPHAPROJECT AP-SH4A-3A Support.
  *
  * Copyright (C) 2010 ALPHAPROJECT Co.,Ltd.
  * Copyright (C) 2008  Yoshihiro Shimoda
  * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-apsh4ad0a.c b/arch/sh/boards/board-apsh4ad0a.c
index 92eac3a..4efa9c5 100644
--- a/arch/sh/boards/board-apsh4ad0a.c
+++ b/arch/sh/boards/board-apsh4ad0a.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ALPHAPROJECT AP-SH4AD-0A Support.
  *
  * Copyright (C) 2010 ALPHAPROJECT Co.,Ltd.
  * Copyright (C) 2010  Matt Fleming
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-edosk7760.c b/arch/sh/boards/board-edosk7760.c
index bab5b95..0fbe91c 100644
--- a/arch/sh/boards/board-edosk7760.c
+++ b/arch/sh/boards/board-edosk7760.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Renesas Europe EDOSK7760 Board Support
  *
  * Copyright (C) 2008 SPES Societa' Progettazione Elettronica e Software Ltd.
  * Author: Luca Santini <luca.santini@spesonline.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/board-espt.c b/arch/sh/boards/board-espt.c
index 4d6be53..f478fee 100644
--- a/arch/sh/boards/board-espt.c
+++ b/arch/sh/boards/board-espt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Data Technology Inc. ESPT-GIGA board support
  *
  * Copyright (C) 2008, 2009 Renesas Solutions Corp.
  * Copyright (C) 2008, 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-magicpanelr2.c b/arch/sh/boards/board-magicpanelr2.c
index 2050085..56bd386 100644
--- a/arch/sh/boards/board-magicpanelr2.c
+++ b/arch/sh/boards/board-magicpanelr2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/magicpanel/setup.c
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
  *
  *  Magic Panel Release 2 board setup
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 1bde08d..c32b4c6 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R0P7757LC0012RL Support.
  *
  * Copyright (C) 2009 - 2010  Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 3cba60f..d964c4d 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Corp. R0P7785LC0011RL Support.
  *
  * Copyright (C) 2008  Yoshihiro Shimoda
  * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-titan.c b/arch/sh/boards/board-titan.c
index 94c36c7b..074a848 100644
--- a/arch/sh/boards/board-titan.c
+++ b/arch/sh/boards/board-titan.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/titan/setup.c - Setup for Titan
  *
  *  Copyright (C) 2006  Jamie Lenehan
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/board-urquell.c b/arch/sh/boards/board-urquell.c
index b52abcc..799af57 100644
--- a/arch/sh/boards/board-urquell.c
+++ b/arch/sh/boards/board-urquell.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Corp. SH7786 Urquell Support.
  *
@@ -6,10 +7,6 @@
  *
  * Based on board-sh7785lcr.c
  * Copyright (C) 2008  Yoshihiro Shimoda
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-ap325rxa/Makefile b/arch/sh/boards/mach-ap325rxa/Makefile
index 4cf1774..dba5d0c 100644
--- a/arch/sh/boards/mach-ap325rxa/Makefile
+++ b/arch/sh/boards/mach-ap325rxa/Makefile
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	 := setup.o sdram.o
 
diff --git a/arch/sh/boards/mach-ap325rxa/sdram.S b/arch/sh/boards/mach-ap325rxa/sdram.S
index db24fbe..541c82c 100644
--- a/arch/sh/boards/mach-ap325rxa/sdram.S
+++ b/arch/sh/boards/mach-ap325rxa/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * AP325RXA sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-cayman/Makefile b/arch/sh/boards/mach-cayman/Makefile
index 00fa3ea..775a4be 100644
--- a/arch/sh/boards/mach-cayman/Makefile
+++ b/arch/sh/boards/mach-cayman/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Hitachi Cayman specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/irq.c
index 724e8b7..9108789 100644
--- a/arch/sh/boards/mach-cayman/irq.c
+++ b/arch/sh/boards/mach-cayman/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/mach-cayman/irq.c - SH-5 Cayman Interrupt Support
  *
  * This file handles the board specific parts of the Cayman interrupt system
  *
  * Copyright (C) 2002 Stuart Menefy
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/io.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-cayman/panic.c b/arch/sh/boards/mach-cayman/panic.c
index d1e6730..cfc4631 100644
--- a/arch/sh/boards/mach-cayman/panic.c
+++ b/arch/sh/boards/mach-cayman/panic.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2003  Richard Curnow, SuperH UK Limited
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/sh/boards/mach-cayman/setup.c b/arch/sh/boards/mach-cayman/setup.c
index 9c292c2..4cec147 100644
--- a/arch/sh/boards/mach-cayman/setup.c
+++ b/arch/sh/boards/mach-cayman/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/mach-cayman/setup.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2002  David J. Mckay & Benedict Gaster
  * Copyright (C) 2003 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-dreamcast/Makefile b/arch/sh/boards/mach-dreamcast/Makefile
index 7b97546..8692cb3 100644
--- a/arch/sh/boards/mach-dreamcast/Makefile
+++ b/arch/sh/boards/mach-dreamcast/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Sega Dreamcast specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index 2789647..a929f76 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/dreamcast/irq.c
  *
@@ -6,7 +7,6 @@
  * Copyright (c) 2001, 2002 M. R. Brown <mrbrown@0xd6.org>
  *
  * This file is part of the LinuxDC project (www.linuxdc.org)
- * Released under the terms of the GNU GPL v2.0
  */
 #include <linux/irq.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-dreamcast/rtc.c b/arch/sh/boards/mach-dreamcast/rtc.c
index 061d657..e468dcc 100644
--- a/arch/sh/boards/mach-dreamcast/rtc.c
+++ b/arch/sh/boards/mach-dreamcast/rtc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/dreamcast/rtc.c
  *
@@ -5,9 +6,6 @@
  *
  * Copyright (c) 2001, 2002 M. R. Brown <mrbrown@0xd6.org>
  * Copyright (c) 2002 Paul Mundt <lethal@chaoticdreams.org>
- *
- * Released under the terms of the GNU GPL v2.0.
- *
  */
 
 #include <linux/time.h>
diff --git a/arch/sh/boards/mach-dreamcast/setup.c b/arch/sh/boards/mach-dreamcast/setup.c
index ad1a4db..54bbdb3 100644
--- a/arch/sh/boards/mach-dreamcast/setup.c
+++ b/arch/sh/boards/mach-dreamcast/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/dreamcast/setup.c
  *
@@ -8,8 +9,6 @@
  *
  * This file is part of the LinuxDC project (www.linuxdc.org)
  *
- * Released under the terms of the GNU GPL v2.0.
- *
  * This file originally bore the message (with enclosed-$):
  *	Id: setup_dc.c,v 1.5 2001/05/24 05:09:16 mrbrown Exp
  *	SEGA Dreamcast support
diff --git a/arch/sh/boards/mach-ecovec24/Makefile b/arch/sh/boards/mach-ecovec24/Makefile
index e69bc82..d78d490 100644
--- a/arch/sh/boards/mach-ecovec24/Makefile
+++ b/arch/sh/boards/mach-ecovec24/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the R0P7724LC0011/21RL (EcoVec)
 #
@@ -6,4 +7,4 @@
 # for more details.
 #
 
-obj-y	 := setup.o sdram.o
\ No newline at end of file
+obj-y	 := setup.o sdram.o
diff --git a/arch/sh/boards/mach-ecovec24/sdram.S b/arch/sh/boards/mach-ecovec24/sdram.S
index 3963c6f..d2f2691 100644
--- a/arch/sh/boards/mach-ecovec24/sdram.S
+++ b/arch/sh/boards/mach-ecovec24/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Ecovec24 sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 06a8945..46467f8 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2009 Renesas Solutions Corp.
  *
  * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <asm/clock.h>
 #include <asm/heartbeat.h>
diff --git a/arch/sh/boards/mach-highlander/irq-r7780mp.c b/arch/sh/boards/mach-highlander/irq-r7780mp.c
index 9893fd3..f466373 100644
--- a/arch/sh/boards/mach-highlander/irq-r7780mp.c
+++ b/arch/sh/boards/mach-highlander/irq-r7780mp.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Solutions Highlander R7780MP Support.
  *
  * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
  * Copyright (C) 2006  Paul Mundt
  * Copyright (C) 2007  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-highlander/irq-r7780rp.c b/arch/sh/boards/mach-highlander/irq-r7780rp.c
index 0805b21..c61177e 100644
--- a/arch/sh/boards/mach-highlander/irq-r7780rp.c
+++ b/arch/sh/boards/mach-highlander/irq-r7780rp.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Solutions Highlander R7780RP-1 Support.
  *
  * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
  * Copyright (C) 2006  Paul Mundt
  * Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-highlander/irq-r7785rp.c b/arch/sh/boards/mach-highlander/irq-r7785rp.c
index 558b248..0ebebbe 100644
--- a/arch/sh/boards/mach-highlander/irq-r7785rp.c
+++ b/arch/sh/boards/mach-highlander/irq-r7785rp.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Solutions Highlander R7785RP Support.
  *
  * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
  * Copyright (C) 2006 - 2008  Paul Mundt
  * Copyright (C) 2007  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-highlander/pinmux-r7785rp.c b/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
index c77a2be..703179f 100644
--- a/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
+++ b/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2008 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/gpio.h>
diff --git a/arch/sh/boards/mach-highlander/psw.c b/arch/sh/boards/mach-highlander/psw.c
index 40e2b58..d445c54 100644
--- a/arch/sh/boards/mach-highlander/psw.c
+++ b/arch/sh/boards/mach-highlander/psw.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/renesas/r7780rp/psw.c
  *
  * push switch support for RDBRP-1/RDBREVRP-1 debug boards.
  *
  * Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/io.h>
 #include <linux/module.h>
diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
index 4a52590..533393d 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/renesas/r7780rp/setup.c
  *
@@ -8,10 +9,6 @@
  *
  * This contains support for the R7780RP-1, R7780MP, and R7785RP
  * Highlander modules.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-hp6xx/Makefile b/arch/sh/boards/mach-hp6xx/Makefile
index b312427..4b0fe29 100644
--- a/arch/sh/boards/mach-hp6xx/Makefile
+++ b/arch/sh/boards/mach-hp6xx/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HP6xx specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
index 865d8d6..e5c4c7d 100644
--- a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
+++ b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bios-less APM driver for hp680
  *
  * Copyright 2005 (c) Andriy Skulysh <askulysh@gmail.com>
  * Copyright 2008 (c) Kristoffer Ericson <kristoffer.ericson@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License.
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/boards/mach-hp6xx/pm.c b/arch/sh/boards/mach-hp6xx/pm.c
index 8b50cf7..fe505ec 100644
--- a/arch/sh/boards/mach-hp6xx/pm.c
+++ b/arch/sh/boards/mach-hp6xx/pm.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * hp6x0 Power Management Routines
  *
  * Copyright (c) 2006 Andriy Skulysh <askulsyh@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License.
  */
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/sh/boards/mach-hp6xx/pm_wakeup.S b/arch/sh/boards/mach-hp6xx/pm_wakeup.S
index 4f18d44..0fd4330 100644
--- a/arch/sh/boards/mach-hp6xx/pm_wakeup.S
+++ b/arch/sh/boards/mach-hp6xx/pm_wakeup.S
@@ -1,10 +1,6 @@
-/*
- * Copyright (c) 2006 Andriy Skulysh <askulsyh@gmail.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+/* SPDX-License-Identifier: GPL-2.0
  *
+ * Copyright (c) 2006 Andriy Skulysh <askulsyh@gmail.com>
  */
 
 #include <linux/linkage.h>
diff --git a/arch/sh/boards/mach-hp6xx/setup.c b/arch/sh/boards/mach-hp6xx/setup.c
index 05797b3..2ceead6 100644
--- a/arch/sh/boards/mach-hp6xx/setup.c
+++ b/arch/sh/boards/mach-hp6xx/setup.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/hp6xx/setup.c
  *
  * Copyright (C) 2002 Andriy Skulysh
  * Copyright (C) 2007 Kristoffer Ericson <Kristoffer_e1@hotmail.com>
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * Setup code for HP620/HP660/HP680/HP690 (internal peripherials only)
  */
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-kfr2r09/Makefile b/arch/sh/boards/mach-kfr2r09/Makefile
index 60dd63f..4a4a35a 100644
--- a/arch/sh/boards/mach-kfr2r09/Makefile
+++ b/arch/sh/boards/mach-kfr2r09/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	:= setup.o sdram.o
 ifneq ($(CONFIG_FB_SH_MOBILE_LCDC),)
 obj-y	+=  lcd_wqvga.o
diff --git a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
index 355a78a..f6bbac1 100644
--- a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
+++ b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * KFR2R09 LCD panel support
  *
@@ -5,10 +6,6 @@
  *
  * Register settings based on the out-of-tree t33fb.c driver
  * Copyright (C) 2008 Lineo Solutions, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file COPYING in the main directory of this archive for
- * more details.
  */
 
 #include <linux/delay.h>
diff --git a/arch/sh/boards/mach-kfr2r09/sdram.S b/arch/sh/boards/mach-kfr2r09/sdram.S
index 0c9f55b..f1b8985 100644
--- a/arch/sh/boards/mach-kfr2r09/sdram.S
+++ b/arch/sh/boards/mach-kfr2r09/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * KFR2R09 sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-landisk/Makefile b/arch/sh/boards/mach-landisk/Makefile
index a696b42..6cba041 100644
--- a/arch/sh/boards/mach-landisk/Makefile
+++ b/arch/sh/boards/mach-landisk/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for I-O DATA DEVICE, INC. "LANDISK Series"
 #
diff --git a/arch/sh/boards/mach-landisk/gio.c b/arch/sh/boards/mach-landisk/gio.c
index 32c317f..1c0da99 100644
--- a/arch/sh/boards/mach-landisk/gio.c
+++ b/arch/sh/boards/mach-landisk/gio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/landisk/gio.c - driver for landisk
  *
@@ -6,11 +7,6 @@
  *
  *   Copylight (C) 2006 kogiidena
  *   Copylight (C) 2002 Atom Create Engineering Co., Ltd. *
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-landisk/irq.c b/arch/sh/boards/mach-landisk/irq.c
index c00ace3..29b8b1f 100644
--- a/arch/sh/boards/mach-landisk/irq.c
+++ b/arch/sh/boards/mach-landisk/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-landisk/irq.c
  *
@@ -8,10 +9,6 @@
  *
  * Copyright (C) 2001  Ian da Silva, Jeremy Siegel
  * Based largely on io_se.c.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-landisk/psw.c b/arch/sh/boards/mach-landisk/psw.c
index 5192b1f..e171d9a 100644
--- a/arch/sh/boards/mach-landisk/psw.c
+++ b/arch/sh/boards/mach-landisk/psw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/landisk/psw.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2006-2007  Paul Mundt
  * Copyright (C) 2007  kogiidena
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/io.h>
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index f1147ca..16b4d8b 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/landisk/setup.c
  *
@@ -7,10 +8,6 @@
  * Copyright (C) 2002 Paul Mundt
  * Copylight (C) 2002 Atom Create Engineering Co., Ltd.
  * Copyright (C) 2005-2007 kogiidena
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-lboxre2/Makefile b/arch/sh/boards/mach-lboxre2/Makefile
index e9ed140..0fbd0822 100644
--- a/arch/sh/boards/mach-lboxre2/Makefile
+++ b/arch/sh/boards/mach-lboxre2/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the L-BOX RE2 specific parts of the kernel
 # Copyright (c) 2007 Nobuhiro Iwamatsu
diff --git a/arch/sh/boards/mach-lboxre2/irq.c b/arch/sh/boards/mach-lboxre2/irq.c
index 8aa171a..a250e3b 100644
--- a/arch/sh/boards/mach-lboxre2/irq.c
+++ b/arch/sh/boards/mach-lboxre2/irq.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/lboxre2/irq.c
  *
  * Copyright (C) 2007 Nobuhiro Iwamatsu
  *
  * NTT COMWARE L-BOX RE2 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/boards/mach-lboxre2/setup.c b/arch/sh/boards/mach-lboxre2/setup.c
index 6660622..20d01b4 100644
--- a/arch/sh/boards/mach-lboxre2/setup.c
+++ b/arch/sh/boards/mach-lboxre2/setup.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/lbox/setup.c
  *
  * Copyright (C) 2007 Nobuhiro Iwamatsu
  *
  * NTT COMWARE L-BOX RE2 Support
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-microdev/Makefile b/arch/sh/boards/mach-microdev/Makefile
index 4e3588e..05c5698 100644
--- a/arch/sh/boards/mach-microdev/Makefile
+++ b/arch/sh/boards/mach-microdev/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SuperH MicroDev specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-microdev/fdc37c93xapm.c b/arch/sh/boards/mach-microdev/fdc37c93xapm.c
index 458a7cf..2a04f72 100644
--- a/arch/sh/boards/mach-microdev/fdc37c93xapm.c
+++ b/arch/sh/boards/mach-microdev/fdc37c93xapm.c
@@ -1,5 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Setup for the SMSC FDC37C93xAPM
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
@@ -7,9 +7,6 @@
  * Copyright (C) 2004, 2005 Paul Mundt
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
diff --git a/arch/sh/boards/mach-microdev/io.c b/arch/sh/boards/mach-microdev/io.c
index acdafb0..a76c127 100644
--- a/arch/sh/boards/mach-microdev/io.c
+++ b/arch/sh/boards/mach-microdev/io.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/superh/microdev/io.c
  *
@@ -6,9 +7,6 @@
  * Copyright (C) 2004 Paul Mundt
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-microdev/irq.c b/arch/sh/boards/mach-microdev/irq.c
index 9a8aff3..dc27492 100644
--- a/arch/sh/boards/mach-microdev/irq.c
+++ b/arch/sh/boards/mach-microdev/irq.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/superh/microdev/irq.c
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-microdev/setup.c b/arch/sh/boards/mach-microdev/setup.c
index 6c66ee4..706b48f 100644
--- a/arch/sh/boards/mach-microdev/setup.c
+++ b/arch/sh/boards/mach-microdev/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/superh/microdev/setup.c
  *
@@ -6,9 +7,6 @@
  * Copyright (C) 2004, 2005 Paul Mundt
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-migor/Makefile b/arch/sh/boards/mach-migor/Makefile
index 4601a89..c223d75 100644
--- a/arch/sh/boards/mach-migor/Makefile
+++ b/arch/sh/boards/mach-migor/Makefile
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	 := setup.o sdram.o
 obj-$(CONFIG_SH_MIGOR_QVGA)	+=  lcd_qvga.o
diff --git a/arch/sh/boards/mach-migor/lcd_qvga.c b/arch/sh/boards/mach-migor/lcd_qvga.c
index 8bccd34..4ebf130 100644
--- a/arch/sh/boards/mach-migor/lcd_qvga.c
+++ b/arch/sh/boards/mach-migor/lcd_qvga.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Support for SuperH MigoR Quarter VGA LCD Panel
  *
@@ -5,10 +6,6 @@
  *
  * Based on lcd_powertip.c from Kenati Technologies Pvt Ltd.
  * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>,
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/delay.h>
diff --git a/arch/sh/boards/mach-migor/sdram.S b/arch/sh/boards/mach-migor/sdram.S
index 614aa3a..3a6bee1 100644
--- a/arch/sh/boards/mach-migor/sdram.S
+++ b/arch/sh/boards/mach-migor/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Migo-R sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-r2d/Makefile b/arch/sh/boards/mach-r2d/Makefile
index 0d4c75a..7e7ac5e 100644
--- a/arch/sh/boards/mach-r2d/Makefile
+++ b/arch/sh/boards/mach-r2d/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the RTS7751R2D specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-r2d/setup.c b/arch/sh/boards/mach-r2d/setup.c
index 4b98a52..3bc52f6 100644
--- a/arch/sh/boards/mach-r2d/setup.c
+++ b/arch/sh/boards/mach-r2d/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Sales RTS7751R2D Support.
  *
  * Copyright (C) 2002 - 2006 Atom Create Engineering Co., Ltd.
  * Copyright (C) 2004 - 2007 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-rsk/Makefile b/arch/sh/boards/mach-rsk/Makefile
index 6a4e1b5..43cca39 100644
--- a/arch/sh/boards/mach-rsk/Makefile
+++ b/arch/sh/boards/mach-rsk/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y				:= setup.o
 obj-$(CONFIG_SH_RSK7203)	+= devices-rsk7203.o
 obj-$(CONFIG_SH_RSK7264)	+= devices-rsk7264.o
diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index a8089f7..e6b05d4 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Europe RSK+ 7203 Support.
  *
  * Copyright (C) 2008 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-rsk/devices-rsk7264.c b/arch/sh/boards/mach-rsk/devices-rsk7264.c
index 7251e37..eaf700a 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7264.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7264.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RSK+SH7264 Support.
  *
  * Copyright (C) 2012 Renesas Electronics Europe
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-rsk/devices-rsk7269.c b/arch/sh/boards/mach-rsk/devices-rsk7269.c
index 4a54459..4b1e386 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7269.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7269.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RSK+SH7269 Support
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-rsk/setup.c b/arch/sh/boards/mach-rsk/setup.c
index 6bc134b..9370c4f 100644
--- a/arch/sh/boards/mach-rsk/setup.c
+++ b/arch/sh/boards/mach-rsk/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Europe RSK+ Support.
  *
  * Copyright (C) 2008 Paul Mundt
  * Copyright (C) 2008 Peter Griffin <pgriffin@mpc-data.co.uk>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-sdk7780/Makefile b/arch/sh/boards/mach-sdk7780/Makefile
index 3d8f0be..37e857f 100644
--- a/arch/sh/boards/mach-sdk7780/Makefile
+++ b/arch/sh/boards/mach-sdk7780/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SDK7780 specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-sdk7780/irq.c b/arch/sh/boards/mach-sdk7780/irq.c
index e5f7564..fa392f3 100644
--- a/arch/sh/boards/mach-sdk7780/irq.c
+++ b/arch/sh/boards/mach-sdk7780/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/renesas/sdk7780/irq.c
  *
  * Renesas Technology Europe SDK7780 Support.
  *
  * Copyright (C) 2008  Nicholas Beck <nbeck@mpc-data.co.uk>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-sdk7780/setup.c b/arch/sh/boards/mach-sdk7780/setup.c
index 2241659..482761b 100644
--- a/arch/sh/boards/mach-sdk7780/setup.c
+++ b/arch/sh/boards/mach-sdk7780/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/renesas/sdk7780/setup.c
  *
  * Renesas Solutions SH7780 SDK Support
  * Copyright (C) 2008 Nicholas Beck <nbeck@mpc-data.co.uk>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-sdk7786/Makefile b/arch/sh/boards/mach-sdk7786/Makefile
index 45d32e3..731a87c 100644
--- a/arch/sh/boards/mach-sdk7786/Makefile
+++ b/arch/sh/boards/mach-sdk7786/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	:= fpga.o irq.o nmi.o setup.o
 
 obj-$(CONFIG_GPIOLIB)		+= gpio.o
diff --git a/arch/sh/boards/mach-sdk7786/fpga.c b/arch/sh/boards/mach-sdk7786/fpga.c
index 3e4ec66..6d2a3d3 100644
--- a/arch/sh/boards/mach-sdk7786/fpga.c
+++ b/arch/sh/boards/mach-sdk7786/fpga.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-sdk7786/gpio.c b/arch/sh/boards/mach-sdk7786/gpio.c
index 4799701..c4587d1 100644
--- a/arch/sh/boards/mach-sdk7786/gpio.c
+++ b/arch/sh/boards/mach-sdk7786/gpio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA USRGPIR Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/boards/mach-sdk7786/irq.c b/arch/sh/boards/mach-sdk7786/irq.c
index 46943a0..340c306 100644
--- a/arch/sh/boards/mach-sdk7786/irq.c
+++ b/arch/sh/boards/mach-sdk7786/irq.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA IRQ Controller Support.
  *
  * Copyright (C) 2010  Matt Fleming
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/irq.h>
 #include <mach/fpga.h>
diff --git a/arch/sh/boards/mach-sdk7786/nmi.c b/arch/sh/boards/mach-sdk7786/nmi.c
index edcfa1f..c2e09d7 100644
--- a/arch/sh/boards/mach-sdk7786/nmi.c
+++ b/arch/sh/boards/mach-sdk7786/nmi.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA NMI Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/boards/mach-sdk7786/setup.c b/arch/sh/boards/mach-sdk7786/setup.c
index c29268b..65721c3 100644
--- a/arch/sh/boards/mach-sdk7786/setup.c
+++ b/arch/sh/boards/mach-sdk7786/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Europe SDK7786 Support.
  *
  * Copyright (C) 2010  Matt Fleming
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-sdk7786/sram.c b/arch/sh/boards/mach-sdk7786/sram.c
index c81c3ab..d76cdb7 100644
--- a/arch/sh/boards/mach-sdk7786/sram.c
+++ b/arch/sh/boards/mach-sdk7786/sram.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA SRAM Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/arch/sh/boards/mach-se/7206/Makefile b/arch/sh/boards/mach-se/7206/Makefile
index 5c9eaa0..b40b308 100644
--- a/arch/sh/boards/mach-se/7206/Makefile
+++ b/arch/sh/boards/mach-se/7206/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 7206 SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7343/Makefile b/arch/sh/boards/mach-se/7343/Makefile
index 4c3666a..e058661 100644
--- a/arch/sh/boards/mach-se/7343/Makefile
+++ b/arch/sh/boards/mach-se/7343/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 7343 SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 6129aef..39a3175 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hitachi UL SolutionEngine 7343 FPGA IRQ Support.
  *
@@ -6,10 +7,6 @@
  *
  * Based on linux/arch/sh/boards/se/7343/irq.c
  * Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define DRV_NAME "SE7343-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
diff --git a/arch/sh/boards/mach-se/770x/Makefile b/arch/sh/boards/mach-se/770x/Makefile
index 43ea14f..900d93c 100644
--- a/arch/sh/boards/mach-se/770x/Makefile
+++ b/arch/sh/boards/mach-se/770x/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 770x SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7721/Makefile b/arch/sh/boards/mach-se/7721/Makefile
index 7f09030..09436f1 100644
--- a/arch/sh/boards/mach-se/7721/Makefile
+++ b/arch/sh/boards/mach-se/7721/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	 := setup.o irq.o
diff --git a/arch/sh/boards/mach-se/7721/irq.c b/arch/sh/boards/mach-se/7721/irq.c
index d85022e..e6ef2a2 100644
--- a/arch/sh/boards/mach-se/7721/irq.c
+++ b/arch/sh/boards/mach-se/7721/irq.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7721/irq.c
  *
  * Copyright (C) 2008  Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-se/7721/setup.c b/arch/sh/boards/mach-se/7721/setup.c
index a0b3dba..3af724d 100644
--- a/arch/sh/boards/mach-se/7721/setup.c
+++ b/arch/sh/boards/mach-se/7721/setup.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7721/setup.c
  *
  * Copyright (C) 2008 Renesas Solutions Corp.
  *
  * Hitachi UL SolutionEngine 7721 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-se/7722/Makefile b/arch/sh/boards/mach-se/7722/Makefile
index 8694373..a5e89c0 100644
--- a/arch/sh/boards/mach-se/7722/Makefile
+++ b/arch/sh/boards/mach-se/7722/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HITACHI UL SolutionEngine 7722 specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 24c74a8..f6e3009 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hitachi UL SolutionEngine 7722 FPGA IRQ Support.
  *
  * Copyright (C) 2007  Nobuhiro Iwamatsu
  * Copyright (C) 2012  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define DRV_NAME "SE7722-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
diff --git a/arch/sh/boards/mach-se/7722/setup.c b/arch/sh/boards/mach-se/7722/setup.c
index e04e2bc..2cd4a2e 100644
--- a/arch/sh/boards/mach-se/7722/setup.c
+++ b/arch/sh/boards/mach-se/7722/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7722/setup.c
  *
@@ -5,11 +6,6 @@
  * Copyright (C) 2012 Paul Mundt
  *
  * Hitachi UL SolutionEngine 7722 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-se/7724/Makefile b/arch/sh/boards/mach-se/7724/Makefile
index a08b368..6c6112b 100644
--- a/arch/sh/boards/mach-se/7724/Makefile
+++ b/arch/sh/boards/mach-se/7724/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HITACHI UL SolutionEngine 7724 specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7724/irq.c b/arch/sh/boards/mach-se/7724/irq.c
index 64e681e..14ce302 100644
--- a/arch/sh/boards/mach-se/7724/irq.c
+++ b/arch/sh/boards/mach-se/7724/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7724/irq.c
  *
@@ -9,10 +10,6 @@
  * Copyright (C) 2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7724 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-se/7724/sdram.S b/arch/sh/boards/mach-se/7724/sdram.S
index 6fa4734..61c1fe7 100644
--- a/arch/sh/boards/mach-se/7724/sdram.S
+++ b/arch/sh/boards/mach-se/7724/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * MS7724SE sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-se/7751/Makefile b/arch/sh/boards/mach-se/7751/Makefile
index a338fd9..2406d3e 100644
--- a/arch/sh/boards/mach-se/7751/Makefile
+++ b/arch/sh/boards/mach-se/7751/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 7751 SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7780/Makefile b/arch/sh/boards/mach-se/7780/Makefile
index 6b88ada..1f6669a 100644
--- a/arch/sh/boards/mach-se/7780/Makefile
+++ b/arch/sh/boards/mach-se/7780/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HITACHI UL SolutionEngine 7780 specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7780/irq.c b/arch/sh/boards/mach-se/7780/irq.c
index d5c9edc..d427dfd 100644
--- a/arch/sh/boards/mach-se/7780/irq.c
+++ b/arch/sh/boards/mach-se/7780/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7780/irq.c
  *
  * Copyright (C) 2006,2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7780 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-se/7780/setup.c b/arch/sh/boards/mach-se/7780/setup.c
index ae5a1d8..309f268 100644
--- a/arch/sh/boards/mach-se/7780/setup.c
+++ b/arch/sh/boards/mach-se/7780/setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7780/setup.c
  *
  * Copyright (C) 2006,2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7780 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-sh03/Makefile b/arch/sh/boards/mach-sh03/Makefile
index 400306a..ab52d5a 100644
--- a/arch/sh/boards/mach-sh03/Makefile
+++ b/arch/sh/boards/mach-sh03/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Interface (CTP/PCI-SH03) specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-sh7763rdp/Makefile b/arch/sh/boards/mach-sh7763rdp/Makefile
index f6c0b55..d634131 100644
--- a/arch/sh/boards/mach-sh7763rdp/Makefile
+++ b/arch/sh/boards/mach-sh7763rdp/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y    := setup.o irq.o
diff --git a/arch/sh/boards/mach-sh7763rdp/irq.c b/arch/sh/boards/mach-sh7763rdp/irq.c
index add698c..efd382b 100644
--- a/arch/sh/boards/mach-sh7763rdp/irq.c
+++ b/arch/sh/boards/mach-sh7763rdp/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/renesas/sh7763rdp/irq.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2008 Renesas Solutions Corp.
  * Copyright (C) 2008  Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-sh7763rdp/setup.c
index 6e62686..97e715e 100644
--- a/arch/sh/boards/mach-sh7763rdp/setup.c
+++ b/arch/sh/boards/mach-sh7763rdp/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/renesas/sh7763rdp/setup.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2008 Renesas Solutions Corp.
  * Copyright (C) 2008 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-x3proto/Makefile b/arch/sh/boards/mach-x3proto/Makefile
index 0cbe3d0..6caefa1 100644
--- a/arch/sh/boards/mach-x3proto/Makefile
+++ b/arch/sh/boards/mach-x3proto/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y += setup.o ilsel.o
 
 obj-$(CONFIG_GPIOLIB)		+= gpio.o
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index cea88b0..efc992f 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-x3proto/gpio.c
  *
  * Renesas SH-X3 Prototype Baseboard GPIO Support.
  *
  * Copyright (C) 2010 - 2012  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3proto/ilsel.c
index 95e3461..f0d5eb4 100644
--- a/arch/sh/boards/mach-x3proto/ilsel.c
+++ b/arch/sh/boards/mach-x3proto/ilsel.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-x3proto/ilsel.c
  *
  * Helper routines for SH-X3 proto board ILSEL.
  *
  * Copyright (C) 2007 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/arch/sh/boards/mach-x3proto/setup.c b/arch/sh/boards/mach-x3proto/setup.c
index d682e2b..95b85f2 100644
--- a/arch/sh/boards/mach-x3proto/setup.c
+++ b/arch/sh/boards/mach-x3proto/setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-x3proto/setup.c
  *
  * Renesas SH-X3 Prototype Board Support.
  *
  * Copyright (C) 2007 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index cde370ca..c24970e 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH generic board support, using device tree
  *
  * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/of.h>
-- 
2.7.4
