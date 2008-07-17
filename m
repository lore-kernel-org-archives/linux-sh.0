From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 09:56:15 +0000
Subject: [PATCH] sh: Add SuperH Mobile MSTPCR bits to clock framework
Message-Id: <20080717095615.19566.83528.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Handle module stop clock bits in MSTPCRn through the clock framework.
The clocks are named after the bits in the data sheet. The association
between bit number and hardware block is processor specific.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |  116 ++++++++++++++++++++++++++++++++
 include/asm-sh/cpu-sh4/freq.h          |    3 
 2 files changed, 119 insertions(+)

--- 0009/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-07-17 12:11:54.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/errno.h>
+#include <linux/stringify.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 
@@ -558,6 +559,115 @@ static struct clk sh7722_video_clock = {
 	.ops = &sh7722_video_clk_ops,
 };
 
+static int sh7722_mstpcr_start_stop(struct clk *clk, unsigned long reg,
+				    int enable)
+{
+	unsigned long bit = clk->arch_flags;
+	unsigned long r;
+
+	r = ctrl_inl(reg);
+
+	if (enable)
+		r &= ~(1 << bit);
+	else
+		r |= (1 << bit);
+
+	ctrl_outl(r, reg);
+	return 0;
+}
+
+static void sh7722_mstpcr0_enable(struct clk *clk)
+{
+	sh7722_mstpcr_start_stop(clk, MSTPCR0, 1);
+}
+
+static void sh7722_mstpcr0_disable(struct clk *clk)
+{
+	sh7722_mstpcr_start_stop(clk, MSTPCR0, 0);
+}
+
+static void sh7722_mstpcr1_enable(struct clk *clk)
+{
+	sh7722_mstpcr_start_stop(clk, MSTPCR1, 1);
+}
+
+static void sh7722_mstpcr1_disable(struct clk *clk)
+{
+	sh7722_mstpcr_start_stop(clk, MSTPCR1, 0);
+}
+
+static void sh7722_mstpcr2_enable(struct clk *clk)
+{
+	sh7722_mstpcr_start_stop(clk, MSTPCR2, 1);
+}
+
+static void sh7722_mstpcr2_disable(struct clk *clk)
+{
+	sh7722_mstpcr_start_stop(clk, MSTPCR2, 0);
+}
+
+static struct clk_ops sh7722_mstpcr0_clk_ops = {
+	.enable = sh7722_mstpcr0_enable,
+	.disable = sh7722_mstpcr0_disable,
+};
+
+static struct clk_ops sh7722_mstpcr1_clk_ops = {
+	.enable = sh7722_mstpcr1_enable,
+	.disable = sh7722_mstpcr1_disable,
+};
+
+static struct clk_ops sh7722_mstpcr2_clk_ops = {
+	.enable = sh7722_mstpcr2_enable,
+	.disable = sh7722_mstpcr2_disable,
+};
+
+#define DECLARE_MSTPCRN(regnr, bitnr, bitstr)		\
+{							\
+	.name = "mstp" __stringify(regnr) bitstr,	\
+	.arch_flags = bitnr,				\
+	.ops = &sh7722_mstpcr ## regnr ## _clk_ops,	\
+}
+
+#define DECLARE_MSTPCR(regnr) \
+	DECLARE_MSTPCRN(regnr, 31, "31"), \
+	DECLARE_MSTPCRN(regnr, 30, "30"), \
+	DECLARE_MSTPCRN(regnr, 29, "29"), \
+	DECLARE_MSTPCRN(regnr, 28, "28"), \
+	DECLARE_MSTPCRN(regnr, 27, "27"), \
+	DECLARE_MSTPCRN(regnr, 26, "26"), \
+	DECLARE_MSTPCRN(regnr, 25, "25"), \
+	DECLARE_MSTPCRN(regnr, 24, "24"), \
+	DECLARE_MSTPCRN(regnr, 23, "23"), \
+	DECLARE_MSTPCRN(regnr, 22, "22"), \
+	DECLARE_MSTPCRN(regnr, 21, "21"), \
+	DECLARE_MSTPCRN(regnr, 20, "20"), \
+	DECLARE_MSTPCRN(regnr, 19, "19"), \
+	DECLARE_MSTPCRN(regnr, 18, "18"), \
+	DECLARE_MSTPCRN(regnr, 17, "17"), \
+	DECLARE_MSTPCRN(regnr, 16, "16"), \
+	DECLARE_MSTPCRN(regnr, 15, "15"), \
+	DECLARE_MSTPCRN(regnr, 14, "14"), \
+	DECLARE_MSTPCRN(regnr, 13, "13"), \
+	DECLARE_MSTPCRN(regnr, 12, "12"), \
+	DECLARE_MSTPCRN(regnr, 11, "11"), \
+	DECLARE_MSTPCRN(regnr, 10, "10"), \
+	DECLARE_MSTPCRN(regnr, 9, "09"), \
+	DECLARE_MSTPCRN(regnr, 8, "08"), \
+	DECLARE_MSTPCRN(regnr, 7, "07"), \
+	DECLARE_MSTPCRN(regnr, 6, "06"), \
+	DECLARE_MSTPCRN(regnr, 5, "05"), \
+	DECLARE_MSTPCRN(regnr, 4, "04"), \
+	DECLARE_MSTPCRN(regnr, 3, "03"), \
+	DECLARE_MSTPCRN(regnr, 2, "02"), \
+	DECLARE_MSTPCRN(regnr, 1, "01"), \
+	DECLARE_MSTPCRN(regnr, 0, "00")
+
+static struct clk sh7722_mstpcr[] = {
+	DECLARE_MSTPCR(0),
+	DECLARE_MSTPCR(1),
+	DECLARE_MSTPCR(2),
+};
+
 static struct clk *sh7722_clocks[] = {
 	&sh7722_umem_clock,
 	&sh7722_sh_clock,
@@ -600,5 +710,11 @@ int __init arch_clk_init(void)
 		clk_register(sh7722_clocks[i]);
 	}
 	clk_put(master);
+
+	for (i = 0; i < ARRAY_SIZE(sh7722_mstpcr); i++) {
+		pr_debug( "Registering mstpcr '%s'\n", sh7722_mstpcr[i].name);
+		clk_register(&sh7722_mstpcr[i]);
+	}
+
 	return 0;
 }
--- 0002/include/asm-sh/cpu-sh4/freq.h
+++ work/include/asm-sh/cpu-sh4/freq.h	2008-07-16 18:33:24.000000000 +0900
@@ -19,6 +19,9 @@
 #define SCLKACR			0xa4150008
 #define SCLKBCR			0xa415000c
 #define IrDACLKCR		0xa4150010
+#define MSTPCR0			0xa4150030
+#define MSTPCR1			0xa4150034
+#define MSTPCR2			0xa4150038
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
       defined(CONFIG_CPU_SUBTYPE_SH7780)
 #define	FRQCR			0xffc80000
