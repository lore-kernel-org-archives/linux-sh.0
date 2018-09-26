From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Sep 2018 01:27:44 +0000
Subject: [PATCH v2 resend 05/13] sh: sh2a: convert to SPDX identifiers
Message-Id: <87in2tyrzq.wl-kuninori.morimoto.gx@renesas.com>
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
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/entry.S         | 7 ++-----
 arch/sh/kernel/cpu/sh2a/ex.S            | 7 ++-----
 arch/sh/kernel/cpu/sh2a/fpu.c           | 5 +----
 arch/sh/kernel/cpu/sh2a/opcode_helper.c | 5 +----
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c | 5 +----
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c | 5 +----
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c | 5 +----
 arch/sh/kernel/cpu/sh2a/probe.c         | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-mxg.c     | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c  | 5 +----
 19 files changed, 21 insertions(+), 78 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
index 532a36c..5a5daaa 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7201.c
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
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c b/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
index 529f719..c620539 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7203.c
  *
@@ -10,10 +11,6 @@
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
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c b/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
index 1777898..d286d7b 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7206.c
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
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
index 7e06e39..d9acc1e 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7264.c
  *
  * SH7264 clock framework support
  *
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7269.c b/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
index 663a97b..c17ab0d 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7269.c
  *
  * SH7269 clock framework support
  *
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2a/entry.S b/arch/sh/kernel/cpu/sh2a/entry.S
index da77a8e..9f11fc8 100644
--- a/arch/sh/kernel/cpu/sh2a/entry.S
+++ b/arch/sh/kernel/cpu/sh2a/entry.S
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2a/entry.S
  *
  * The SH-2A exception entry
  *
  * Copyright (C) 2008 Yoshinori Sato
  * Based on arch/sh/kernel/cpu/sh2/entry.S
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2a/ex.S b/arch/sh/kernel/cpu/sh2a/ex.S
index 4568066..ed91996 100644
--- a/arch/sh/kernel/cpu/sh2a/ex.S
+++ b/arch/sh/kernel/cpu/sh2a/ex.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2a/ex.S
  *
  * The SH-2A exception vector table
  *
  * Copyright (C) 2008 Yoshinori Sato
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2a/fpu.c b/arch/sh/kernel/cpu/sh2a/fpu.c
index 352f894..74b48db 100644
--- a/arch/sh/kernel/cpu/sh2a/fpu.c
+++ b/arch/sh/kernel/cpu/sh2a/fpu.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Save/restore floating point context for signal handlers.
  *
  * Copyright (C) 1999, 2000  Kaz Kojima & Niibe Yutaka
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * FIXME! These routines can be optimized in big endian case.
  */
 #include <linux/sched/signal.h>
diff --git a/arch/sh/kernel/cpu/sh2a/opcode_helper.c b/arch/sh/kernel/cpu/sh2a/opcode_helper.c
index 72aa61c..c509081 100644
--- a/arch/sh/kernel/cpu/sh2a/opcode_helper.c
+++ b/arch/sh/kernel/cpu/sh2a/opcode_helper.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/opcode_helper.c
  *
  * Helper for the SH-2A 32-bit opcodes.
  *
  *  Copyright (C) 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
index eef17dc..a6777e6 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7203 Pinmux
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
index 569decb..7a103e1 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7264 Pinmux
  *
  *  Copyright (C) 2012  Renesas Electronics Europe Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
index 4c17fb6..4da432e 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7269 Pinmux
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh2a/probe.c b/arch/sh/kernel/cpu/sh2a/probe.c
index 3f87971..c66a3bc 100644
--- a/arch/sh/kernel/cpu/sh2a/probe.c
+++ b/arch/sh/kernel/cpu/sh2a/probe.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/probe.c
  *
  * CPU Subtype Probing for SH-2A.
  *
  * Copyright (C) 2004 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <asm/processor.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index 060fdd3..52350ad 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas MX-G (R8A03022BG) Setup
  *
  *  Copyright (C) 2008, 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index c1301f6..b51ed76 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  SH7201 setup
  *
  *  Copyright (C) 2008  Peter Griffin pgriffin@mpc-data.co.uk
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index 32ec732..89b3e49 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7203 and SH7263 Setup
  *
  *  Copyright (C) 2007 - 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index 8d8d354..36ff3a3 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7206 Setup
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
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index ab71eab..d199618 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7264 Setup
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index c7e81b2..9095c96 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7269 Setup
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
-- 
2.7.4
