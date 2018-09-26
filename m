From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Sep 2018 01:28:00 +0000
Subject: [PATCH v2 resend 06/13] sh: sh3: convert to SPDX identifiers
Message-Id: <87h8idyrz9.wl-kuninori.morimoto.gx@renesas.com>
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
 arch/sh/kernel/cpu/sh3/clock-sh3.c     | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7705.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7706.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7709.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7710.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7712.c  | 5 +----
 arch/sh/kernel/cpu/sh3/entry.S         | 7 ++-----
 arch/sh/kernel/cpu/sh3/ex.S            | 9 +++------
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c | 5 +----
 arch/sh/kernel/cpu/sh3/probe.c         | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh3.c     | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  | 5 +----
 arch/sh/kernel/cpu/sh3/swsusp.S        | 7 ++-----
 16 files changed, 20 insertions(+), 68 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/clock-sh3.c b/arch/sh/kernel/cpu/sh3/clock-sh3.c
index 90faa44..d776572 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh3.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh3.c
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
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7705.c b/arch/sh/kernel/cpu/sh3/clock-sh7705.c
index a8da4a9..4947114 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7705.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7705.c
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
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7706.c b/arch/sh/kernel/cpu/sh3/clock-sh7706.c
index a4088e5..1785502 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7706.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7706.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7706.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on arch/sh/kernel/cpu/sh3/clock-sh7709.c
  *  Copyright (C) 2005  Andriy Skulysh
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7709.c b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
index 54a6d4b..54701bb 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7709.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7709.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on arch/sh/kernel/cpu/sh3/clock-sh7705.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7710.c b/arch/sh/kernel/cpu/sh3/clock-sh7710.c
index ce601b2..e60d0bc 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7710.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7710.c
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
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7712.c b/arch/sh/kernel/cpu/sh3/clock-sh7712.c
index 21438a9..5af553f 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7712.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7712.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7712.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on arch/sh/kernel/cpu/sh3/clock-sh3.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index 262db6e..25eb809 100644
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh3/entry.S
  *
  *  Copyright (C) 1999, 2000, 2002  Niibe Yutaka
  *  Copyright (C) 2003 - 2012  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sys.h>
 #include <linux/errno.h>
diff --git a/arch/sh/kernel/cpu/sh3/ex.S b/arch/sh/kernel/cpu/sh3/ex.S
index 99b4d02..ee2113f 100644
--- a/arch/sh/kernel/cpu/sh3/ex.S
+++ b/arch/sh/kernel/cpu/sh3/ex.S
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *  arch/sh/kernel/cpu/sh3/ex.S
  *
  *  The SH-3 and SH-4 exception vector table.
-
+ *
  *  Copyright (C) 1999, 2000, 2002  Niibe Yutaka
  *  Copyright (C) 2003 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/linkage.h>
 
diff --git a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
index 26e90a6..34015e6 100644
--- a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7720 Pinmux
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh3/probe.c b/arch/sh/kernel/cpu/sh3/probe.c
index 426e1e1..5e7ad59 100644
--- a/arch/sh/kernel/cpu/sh3/probe.c
+++ b/arch/sh/kernel/cpu/sh3/probe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/probe.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 1999, 2000  Niibe Yutaka
  * Copyright (C) 2002  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh3.c b/arch/sh/kernel/cpu/sh3/setup-sh3.c
index 53be70b..8058c01 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh3.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh3.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Shared SH3 Setup code
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index f6e392e..e19d1ce 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7705 Setup
  *
  *  Copyright (C) 2006 - 2009  Paul Mundt
  *  Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 59a8861..5c5144b 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH3 Setup code for SH7706, SH7707, SH7708, SH7709
  *
@@ -7,10 +8,6 @@
  * Based on setup-sh7709.c
  *
  *  Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index ea52410..4776e24 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH3 Setup code for SH7710, SH7712
  *
  *  Copyright (C) 2006 - 2009  Paul Mundt
  *  Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index bf34b4e..1d4c34e 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Setup code for SH7720, SH7721.
  *
@@ -8,10 +9,6 @@
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
diff --git a/arch/sh/kernel/cpu/sh3/swsusp.S b/arch/sh/kernel/cpu/sh3/swsusp.S
index 0114542..dc111c4 100644
--- a/arch/sh/kernel/cpu/sh3/swsusp.S
+++ b/arch/sh/kernel/cpu/sh3/swsusp.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh3/swsusp.S
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sys.h>
 #include <linux/errno.h>
-- 
2.7.4
