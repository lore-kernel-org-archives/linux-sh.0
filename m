From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 08 May 2009 14:49:50 +0000
Subject: [PATCH] Fix UBC setup and registers for SH2A
Message-Id: <1241794190.16311.30.camel@quercus-bis>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From 0eab785eda2d1c980da7ecd59acda9f50b25ac73 Mon Sep 17 00:00:00 2001
From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 8 May 2009 14:55:48 +0100
Subject: [PATCH] Fix UBC setup and registers for SH2A


Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
Signed-off-by: Peter Griffin <kieranbingham@gmail.com>
---
 arch/sh/include/asm/ubc.h          |   11 +++++++++++
 arch/sh/include/cpu-sh2a/cpu/ubc.h |   29 ++++++++++++++++++++++++++++-
 arch/sh/kernel/process_32.c        |    4 +++-
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/ubc.h b/arch/sh/include/asm/ubc.h
index a7b9028..4ca4b77 100644
--- a/arch/sh/include/asm/ubc.h
+++ b/arch/sh/include/asm/ubc.h
@@ -42,12 +42,23 @@
 
 #define BRCR_CMFA		(1 << 15)
 #define BRCR_CMFB		(1 << 14)
+
+#if defined CONFIG_CPU_SH2A
+#define BRCR_CMFCA		(1 << 15)
+#define BRCR_CMFCB		(1 << 14)
+#define BRCR_CMFDA		(1 << 13)
+#define BRCR_CMFDB		(1 << 12)
+#define BRCR_PCBB		(1 << 6)	/* 1: after execution */
+#define BRCR_PCBA		(1 << 5)	/* 1: after execution */
+#define BRCR_PCTE		0
+#else
 #define BRCR_PCTE		(1 << 11)
 #define BRCR_PCBA		(1 << 10)	/* 1: after execution */
 #define BRCR_DBEB		(1 << 7)
 #define BRCR_PCBB		(1 << 6)
 #define BRCR_SEQ		(1 << 3)
 #define BRCR_UBDE		(1 << 0)
+#endif
 
 #ifndef __ASSEMBLY__
 /* arch/sh/kernel/cpu/ubc.S */
diff --git a/arch/sh/include/cpu-sh2a/cpu/ubc.h b/arch/sh/include/cpu-sh2a/cpu/ubc.h
index 8ce2fc1..a277e24 100644
--- a/arch/sh/include/cpu-sh2a/cpu/ubc.h
+++ b/arch/sh/include/cpu-sh2a/cpu/ubc.h
@@ -1 +1,28 @@
-#include <cpu-sh2/cpu/ubc.h>
+/*
+ * include/asm-sh/cpu-sh2a/ubc.h
+ *
+ * Copyright (C) 2008 Kieran Bingham
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ASM_CPU_SH2A_UBC_H
+#define __ASM_CPU_SH2A_UBC_H
+
+#define UBC_BARA                0xfffc0400
+#define UBC_BAMRA               0xfffc0404
+#define UBC_BBRA                0xfffc04a0	/* 16 bit access */
+#define UBC_BDRA                0xfffc0408
+#define UBC_BDMRA               0xfffc040c
+
+#define UBC_BARB                0xfffc0410
+#define UBC_BAMRB               0xfffc0414
+#define UBC_BBRB                0xfffc04b0	/* 16 bit access */
+#define UBC_BDRB                0xfffc0418
+#define UBC_BDMRB               0xfffc041c
+
+#define UBC_BRCR                0xfffc04c0
+
+#endif /* __ASM_CPU_SH2A_UBC_H */
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 6d94725..9289ede 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -251,7 +251,8 @@ static void ubc_set_tracing(int asid, unsigned long pc)
 
 	if (current_cpu_data.type = CPU_SH7729 ||
 	    current_cpu_data.type = CPU_SH7710 ||
-	    current_cpu_data.type = CPU_SH7712) {
+	    current_cpu_data.type = CPU_SH7712 ||
+	    current_cpu_data.type = CPU_SH7203){
 		ctrl_outw(BBR_INST | BBR_READ | BBR_CPU, UBC_BBRA);
 		ctrl_outl(BRCR_PCBA | BRCR_PCTE, UBC_BRCR);
 	} else {
@@ -407,6 +408,7 @@ asmlinkage void break_point_trap(void)
 #else
 	ctrl_outw(0, UBC_BBRA);
 	ctrl_outw(0, UBC_BBRB);
+	ctrl_outl(0, UBC_BRCR);
 #endif
 	current->thread.ubc_pc = 0;
 	ubc_usercnt -= 1;
-- 
1.5.6.3



