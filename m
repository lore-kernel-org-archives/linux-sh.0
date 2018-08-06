From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 06 Aug 2018 02:23:56 +0000
Subject: [PATCH 04/13] sh: sh2: convert to SPDX identifiers
Message-Id: <87y3dknsq5.wl-kuninori.morimoto.gx@renesas.com>
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

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh2/Makefile       | 1 +
 arch/sh/kernel/cpu/sh2/clock-sh7619.c | 5 +----
 arch/sh/kernel/cpu/sh2/entry.S        | 7 ++-----
 arch/sh/kernel/cpu/sh2/ex.S           | 7 ++-----
 arch/sh/kernel/cpu/sh2/probe.c        | 5 +----
 arch/sh/kernel/cpu/sh2/setup-sh7619.c | 5 +----
 arch/sh/kernel/cpu/sh2/smp-j2.c       | 5 +----
 7 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2/Makefile b/arch/sh/kernel/cpu/sh2/Makefile
index 904c428..214c3a5 100644
--- a/arch/sh/kernel/cpu/sh2/Makefile
+++ b/arch/sh/kernel/cpu/sh2/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Linux/SuperH SH-2 backends.
 #
diff --git a/arch/sh/kernel/cpu/sh2/clock-sh7619.c b/arch/sh/kernel/cpu/sh2/clock-sh7619.c
index e80252a..d66d194c 100644
--- a/arch/sh/kernel/cpu/sh2/clock-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/clock-sh7619.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2/clock-sh7619.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on clock-sh4.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2/entry.S b/arch/sh/kernel/cpu/sh2/entry.S
index 1ee0a6e..0a1c2bf 100644
--- a/arch/sh/kernel/cpu/sh2/entry.S
+++ b/arch/sh/kernel/cpu/sh2/entry.S
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2/entry.S
  *
  * The SH-2 exception entry
  *
  * Copyright (C) 2005-2008 Yoshinori Sato
  * Copyright (C) 2005  AXE,Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2/ex.S b/arch/sh/kernel/cpu/sh2/ex.S
index 85b0bf8..dd0cc88 100644
--- a/arch/sh/kernel/cpu/sh2/ex.S
+++ b/arch/sh/kernel/cpu/sh2/ex.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2/ex.S
  *
  * The SH-2 exception vector table
  *
  * Copyright (C) 2005 Yoshinori Sato
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index a5bd036..d342ea0 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2/probe.c
  *
  * CPU Subtype Probing for SH-2.
  *
  * Copyright (C) 2002 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/of_fdt.h>
diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index d08db08..f5b6841 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7619 Setup
  *
  *  Copyright (C) 2006  Yoshinori Sato
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2/smp-j2.c b/arch/sh/kernel/cpu/sh2/smp-j2.c
index 6ccd7e4..ae44dc2 100644
--- a/arch/sh/kernel/cpu/sh2/smp-j2.c
+++ b/arch/sh/kernel/cpu/sh2/smp-j2.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SMP support for J2 processor
  *
  * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/smp.h>
-- 
2.7.4

