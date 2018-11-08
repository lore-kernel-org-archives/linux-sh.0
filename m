From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2018 06:28:43 +0000
Subject: [PATCH resend 10/13] sh: shmobile: convert to SPDX identifiers
Message-Id: <874lcs146w.wl-kuninori.morimoto.gx@renesas.com>
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
 arch/sh/kernel/cpu/shmobile/Makefile  | 1 +
 arch/sh/kernel/cpu/shmobile/cpuidle.c | 5 +----
 arch/sh/kernel/cpu/shmobile/pm.c      | 5 +----
 arch/sh/kernel/cpu/shmobile/sleep.S   | 7 ++-----
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/Makefile b/arch/sh/kernel/cpu/shmobile/Makefile
index e8a5111..7581d5f 100644
--- a/arch/sh/kernel/cpu/shmobile/Makefile
+++ b/arch/sh/kernel/cpu/shmobile/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Linux/SuperH SH-Mobile backends.
 #
diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index c32e660..dbd2cde 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/shmobile/cpuidle.c
  *
  * Cpuidle support code for SuperH Mobile
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/shmobile/pm.c b/arch/sh/kernel/cpu/shmobile/pm.c
index fba2be5..ca9945f 100644
--- a/arch/sh/kernel/cpu/shmobile/pm.c
+++ b/arch/sh/kernel/cpu/shmobile/pm.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/shmobile/pm.c
  *
  * Power management support code for SuperH Mobile
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/shmobile/sleep.S b/arch/sh/kernel/cpu/shmobile/sleep.S
index e6aac65..f928c03 100644
--- a/arch/sh/kernel/cpu/shmobile/sleep.S
+++ b/arch/sh/kernel/cpu/shmobile/sleep.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh4a/sleep-sh_mobile.S
  *
  * Sleep mode and Standby modes support for SuperH Mobile
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/sys.h>
-- 
2.7.4
