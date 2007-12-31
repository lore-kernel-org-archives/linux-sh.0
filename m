From: "Andrew Murray" <amurray@mpc-data.co.uk>
Date: Mon, 31 Dec 2007 16:32:25 +0000
Subject: [PATCH] sh: sh7712 clock support
Message-Id: <0C997DD87CC88A4F86C897F52650B52B820E8F@MOLSON.mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andrew Murray <amurray@mpc-data.co.uk>

This patch provides specific clock support for the SH7712. (This is my first ever patch, so apologies if I've not followed the procedure correctly!)

Signed-off-by: Andrew Murray <amurray@mpc-data.co.uk>
---
diff -uprN -x sh-2.6/Documentation/dontdiff sh-2.6/arch/sh/kernel/cpu/sh3/clock-sh7712.c sh-2.6-devel/arch/sh/kernel/cpu/sh3/clock-sh7712.c
--- sh-2.6/arch/sh/kernel/cpu/sh3/clock-sh7712.c	1970-01-01 01:00:00.000000000 +0100
+++ sh-2.6-devel/arch/sh/kernel/cpu/sh3/clock-sh7712.c	2007-12-31 15:04:51.000000000 +0000
@@ -0,0 +1,81 @@
+/*
+ * arch/sh/kernel/cpu/sh3/clock-sh7712.c
+ *
+ * SH7712 support for the clock framework
+ *
+ *  Copyright (C) 2007  Andrew Murray <amurray@mpc-data.co.uk>
+ *
+ * Based on arch/sh/kernel/cpu/sh3/clock-sh3.c
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int multipliers[] = { 1, 2, 3 };
+static int divisors[]    = { 1, 2, 3, 4, 6 };
+
+static void master_clk_init(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = (frqcr & 0x0300) >> 8;
+
+	clk->rate *= multipliers[idx];
+}
+
+static struct clk_ops sh7712_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = frqcr & 0x0007;
+
+	clk->rate = clk->parent->rate / divisors[idx];
+}
+
+static struct clk_ops sh7712_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_init(struct clk *clk)
+{
+	clk->rate = CONFIG_SH_PCLK_FREQ;
+}
+
+static struct clk_ops sh7712_bus_clk_ops = {
+	.init		= bus_clk_init,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = (frqcr & 0x0030) >> 4;
+
+	clk->rate = clk->parent->rate / divisors[idx];
+}
+
+static struct clk_ops sh7712_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7712_clk_ops[] = {
+	&sh7712_master_clk_ops,
+	&sh7712_module_clk_ops,
+	&sh7712_bus_clk_ops,
+	&sh7712_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7712_clk_ops))
+		*ops = sh7712_clk_ops[idx];
+}
+
diff -uprN -x sh-2.6/Documentation/dontdiff sh-2.6/arch/sh/kernel/cpu/sh3/Makefile sh-2.6-devel/arch/sh/kernel/cpu/sh3/Makefile
--- sh-2.6/arch/sh/kernel/cpu/sh3/Makefile	2007-12-31 14:47:32.000000000 +0000
+++ sh-2.6-devel/arch/sh/kernel/cpu/sh3/Makefile	2007-12-31 15:01:15.000000000 +0000
@@ -22,5 +22,6 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7706)	:= cl
 clock-$(CONFIG_CPU_SUBTYPE_SH7709)	:= clock-sh7709.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7710)	:= clock-sh7710.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7720)	:= clock-sh7710.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7712)	:= clock-sh7712.o
 
 obj-y	+= $(clock-y)
diff -uprN -x sh-2.6/Documentation/dontdiff sh-2.6/include/asm-sh/cpu-sh3/freq.h sh-2.6-devel/include/asm-sh/cpu-sh3/freq.h
--- sh-2.6/include/asm-sh/cpu-sh3/freq.h	2007-12-31 14:47:47.000000000 +0000
+++ sh-2.6-devel/include/asm-sh/cpu-sh3/freq.h	2007-12-31 15:02:30.000000000 +0000
@@ -10,7 +10,12 @@
 #ifndef __ASM_CPU_SH3_FREQ_H
 #define __ASM_CPU_SH3_FREQ_H
 
+#ifdef CONFIG_CPU_SUBTYPE_SH7712
+#define FRQCR			0xA415FF80
+#else
 #define FRQCR			0xffffff80
+#endif
+
 #define MIN_DIVISOR_NR		0
 #define MAX_DIVISOR_NR		4


Internal Virus Database is out-of-date.
Checked by AVG Free Edition. 
Version: 7.5.516 / Virus Database: 269.17.8 - Release Date: 24/12/2007 00:00
 
