From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Sep 2018 01:28:51 +0000
Subject: [PATCH v2 resend 09/13] sh: sh5: convert to SPDX identifiers
Message-Id: <87d0t1yrxv.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pnx1ys2k.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pnx1ys2k.wl-kuninori.morimoto.gx@renesas.com>
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
 arch/sh/kernel/cpu/sh5/clock-sh5.c | 5 +----
 arch/sh/kernel/cpu/sh5/entry.S     | 7 ++-----
 arch/sh/kernel/cpu/sh5/fpu.c       | 5 +----
 arch/sh/kernel/cpu/sh5/probe.c     | 5 +----
 arch/sh/kernel/cpu/sh5/setup-sh5.c | 5 +----
 arch/sh/kernel/cpu/sh5/switchto.S  | 7 ++-----
 arch/sh/kernel/cpu/sh5/unwind.c    | 5 +----
 7 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh5/clock-sh5.c b/arch/sh/kernel/cpu/sh5/clock-sh5.c
index c48b93d..43763c2 100644
--- a/arch/sh/kernel/cpu/sh5/clock-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/clock-sh5.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/clock-sh5.c
  *
  * SH-5 support for the clock framework
  *
  *  Copyright (C) 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
index 0c8d037..de68ffd 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh5/entry.S
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2004 - 2008  Paul Mundt
  * Copyright (C) 2003, 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh5/fpu.c b/arch/sh/kernel/cpu/sh5/fpu.c
index 9f8713a..9218d9e 100644
--- a/arch/sh/kernel/cpu/sh5/fpu.c
+++ b/arch/sh/kernel/cpu/sh5/fpu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/fpu.c
  *
@@ -7,10 +8,6 @@
  *
  * Started from SH4 version:
  *   Copyright (C) 1999, 2000  Kaz Kojima & Niibe Yutaka
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sched.h>
 #include <linux/signal.h>
diff --git a/arch/sh/kernel/cpu/sh5/probe.c b/arch/sh/kernel/cpu/sh5/probe.c
index eca427c..9472501 100644
--- a/arch/sh/kernel/cpu/sh5/probe.c
+++ b/arch/sh/kernel/cpu/sh5/probe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/probe.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
index 084a9cc..41c1673 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH5-101/SH5-103 CPU Setup
  *
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh5/switchto.S b/arch/sh/kernel/cpu/sh5/switchto.S
index 45c351b0..d1beff7 100644
--- a/arch/sh/kernel/cpu/sh5/switchto.S
+++ b/arch/sh/kernel/cpu/sh5/switchto.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh5/switchto.S
  *
  * sh64 context switch
  *
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
 */
 
 	.section .text..SHmedia32,"ax"
diff --git a/arch/sh/kernel/cpu/sh5/unwind.c b/arch/sh/kernel/cpu/sh5/unwind.c
index 3a4fed4..3cb0cd9 100644
--- a/arch/sh/kernel/cpu/sh5/unwind.c
+++ b/arch/sh/kernel/cpu/sh5/unwind.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/unwind.c
  *
  * Copyright (C) 2004  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kallsyms.h>
 #include <linux/kernel.h>
-- 
2.7.4
