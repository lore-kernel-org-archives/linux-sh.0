From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 06 Aug 2018 02:24:43 +0000
Subject: [PATCH 07/13] sh: sh4: convert to SPDX identifiers
Message-Id: <87tvo8nsou.wl-kuninori.morimoto.gx@renesas.com>
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
instead of verbose license text,
excepting ${LINUX}/arch/sh/kernel/cpu/sh4/softfloat.c
which is not GPL license

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c | 5 +----
 arch/sh/kernel/cpu/sh4/clock-sh4.c     | 5 +----
 arch/sh/kernel/cpu/sh4/fpu.c           | 5 +----
 arch/sh/kernel/cpu/sh4/perf_event.c    | 5 +----
 arch/sh/kernel/cpu/sh4/probe.c         | 5 +----
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c | 5 +----
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  | 5 +----
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  | 5 +----
 arch/sh/kernel/cpu/sh4/sq.c            | 5 +----
 9 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
index 4b5bab5..c1cdef7 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/clock-sh4-202.c
  *
  * Additional SH4-202 support for the clock framework
  *
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4.c b/arch/sh/kernel/cpu/sh4/clock-sh4.c
index 99e5ec8..ee3c553 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/clock-sh4.c
  *
@@ -11,10 +12,6 @@
  *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
  *  Copyright (C) 2002, 2003, 2004  Paul Mundt
  *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4/fpu.c b/arch/sh/kernel/cpu/sh4/fpu.c
index 95fd2dcb..1ff56e5 100644
--- a/arch/sh/kernel/cpu/sh4/fpu.c
+++ b/arch/sh/kernel/cpu/sh4/fpu.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Save/restore floating point context for signal handlers.
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 1999, 2000  Kaz Kojima & Niibe Yutaka
  * Copyright (C) 2006  ST Microelectronics Ltd. (denorm support)
  *
diff --git a/arch/sh/kernel/cpu/sh4/perf_event.c b/arch/sh/kernel/cpu/sh4/perf_event.c
index fa4f724..db5847b 100644
--- a/arch/sh/kernel/cpu/sh4/perf_event.c
+++ b/arch/sh/kernel/cpu/sh4/perf_event.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance events support for SH7750-style performance counters
  *
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index a521bcf..ef4dd62 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/probe.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2001 - 2007  Paul Mundt
  * Copyright (C) 2003  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
index 2623f82..a40ef35 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH4-202 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
  *  Copyright (C) 2009  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 57d3068..b37bda6 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7091/SH7750/SH7750S/SH7750R/SH7751/SH7751R Setup
  *
  *  Copyright (C) 2006  Paul Mundt
  *  Copyright (C) 2006  Jamie Lenehan
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index e51fe17..86845da 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7760 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 4ca78ed..934ff84 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/sq.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2001 - 2006  Paul Mundt
  * Copyright (C) 2001, 2002  M. R. Brown
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/cpu.h>
-- 
2.7.4

