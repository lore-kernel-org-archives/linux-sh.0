From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 23 Aug 2018 02:52:57 +0000
Subject: [PATCH v2 11/13] sh: cpu: convert to SPDX identifiers
Message-Id: <874lfldcl9.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k1ohdcqu.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1ohdcqu.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/clock.c        |  5 +----
 arch/sh/kernel/cpu/init.c         |  5 +----
 arch/sh/kernel/cpu/irq/Makefile   |  1 +
 arch/sh/kernel/cpu/irq/intc-sh5.c |  5 +----
 arch/sh/kernel/cpu/irq/ipr.c      |  5 +----
 arch/sh/kernel/cpu/pfc.c          | 10 +---------
 6 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index fca9b1e7..6fb3441 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/clock.c - SuperH clock framework
  *
@@ -9,10 +10,6 @@
  *	Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *
  *  Modified for omap shared clock framework by Tony Lindgren <tony@atomide.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index c4f01c5..ce7291e 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/init.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2002 - 2009  Paul Mundt
  * Copyright (C) 2003  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/irq/Makefile b/arch/sh/kernel/cpu/irq/Makefile
index 3f8e794..8b91cb9 100644
--- a/arch/sh/kernel/cpu/irq/Makefile
+++ b/arch/sh/kernel/cpu/irq/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Linux/SuperH CPU-specific IRQ handlers.
 #
diff --git a/arch/sh/kernel/cpu/irq/intc-sh5.c b/arch/sh/kernel/cpu/irq/intc-sh5.c
index 9e056a3..744f903 100644
--- a/arch/sh/kernel/cpu/irq/intc-sh5.c
+++ b/arch/sh/kernel/cpu/irq/intc-sh5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/irq/intc-sh5.c
  *
@@ -9,10 +10,6 @@
  * Per-interrupt selective. IRLM=0 (Fixed priority) is not
  * supported being useless without a cascaded interrupt
  * controller.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/kernel/cpu/irq/ipr.c b/arch/sh/kernel/cpu/irq/ipr.c
index 5de6dff5..d41bce7 100644
--- a/arch/sh/kernel/cpu/irq/ipr.c
+++ b/arch/sh/kernel/cpu/irq/ipr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Interrupt handling for IPR-based IRQ.
  *
@@ -11,10 +12,6 @@
  *	On-chip supporting modules for SH7709/SH7709A/SH7729.
  *	Hitachi SolutionEngine external I/O:
  *		MS7709SE01, MS7709ASE01, and MS7750SE01
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/kernel/cpu/pfc.c b/arch/sh/kernel/cpu/pfc.c
index d766564..062056e 100644
--- a/arch/sh/kernel/cpu/pfc.c
+++ b/arch/sh/kernel/cpu/pfc.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH Pin Function Control Initialization
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/init.h>
-- 
2.7.4
