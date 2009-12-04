From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:46 +0000
Subject: [PATCH (sh-2.6.30.y) 04/13] stm: pm: Add suspend support on stx5197
Message-Id: <1259938375-27499-4-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/cpu/sh4/clock-stx5197.c |   61 ++++++++------
 arch/sh/kernel/pm/suspend-stx5197.c    |  147 ++++++++++++++++++++++++++++++++
 include/linux/stm/stx5197.h            |   39 +++++++++
 3 files changed, 221 insertions(+), 26 deletions(-)
 create mode 100644 arch/sh/kernel/pm/suspend-stx5197.c

diff --git a/arch/sh/kernel/cpu/sh4/clock-stx5197.c b/arch/sh/kernel/cpu/sh4/clock-stx5197.c
index bb96c5b..e952aa0 100644
--- a/arch/sh/kernel/cpu/sh4/clock-stx5197.c
+++ b/arch/sh/kernel/cpu/sh4/clock-stx5197.c
@@ -12,13 +12,12 @@
 #include <linux/stm/sysconf.h>
 #include <linux/errno.h>
 #include <linux/io.h>
-#include <linux/pm.h>
+#include <linux/stm/stx5197.h>
+
 #include <linux/delay.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 
-#include "./soc-stx5197.h"
-
 #ifdef CONFIG_CLK_LOW_LEVEL_DEBUG
 #include <linux/stm/pio.h>
 #define KERN_NULL
@@ -28,8 +27,27 @@
 #define dbg_print(fmt, args...)
 #endif
 
+#define XTAL	30000000
 static void __iomem *ss_base;
 
+enum clocks_ID {
+	CLK_XTAL_ID,
+	CLK_PLLA_ID,
+	CLK_PLLB_ID,
+	CLK_DDR_ID,
+	CLK_LMI_ID,
+	CLK_BLT_ID,
+	CLK_SYS_ID,
+	CLK_FDMA_ID,
+	CLK_SPARE_ID,
+	CLK_AV_ID,
+	CLK_SPARE2_ID,
+	CLK_ETH_ID,
+	CLK_ST40_ID,
+	CLK_ST40P_ID,
+};
+
+
 /* External XTAL ----------------------------------------------------------- */
 
 static void xtal_init(struct clk *clk)
@@ -55,10 +73,10 @@ static unsigned long pll_freq(unsigned long input, int id)
 	unsigned long freq, ndiv, pdiv, mdiv;
 	int pll_num = id - CLK_PLLA_ID;
 
-	config0 = readl(ss_base + CLK_PLL_CONFIG0(pll_num));
-	config1 = readl(ss_base + CLK_PLL_CONFIG1(pll_num));
+	config0 = readl(ss_base + (pll_num ? PLLB_CONFIG0 : PLLA_CONFIG0));
+	config1 = readl(ss_base + (pll_num ? PLLB_CONFIG1 : PLLA_CONFIG1));
 
-	if (config1 & CLK_PLL_CONFIG1_POFF)
+	if (config1 & PLL_CONFIG1_POFF)
 		return 0;
 
 	mdiv = (config0 >> 0) & 0xff;
@@ -164,6 +182,9 @@ FMV: Commented because currently in the clk API there is no
 #endif
 };
 
+#define CLKDIV0_CONFIG0		0x90
+#define CLKDIV1_4_CONFIG0(n)	(0x0a0 + ((n-1)*0xc))
+#define CLKDIV6_10_CONFIG0(n)	(0x0d0 + ((n-6)*0xc))
 static unsigned long divider_freq(unsigned long input, int div_num)
 {
 	int offset;
@@ -250,15 +271,18 @@ static void dividedpll_hw_set(unsigned long addr,
 		      "r" (cfg0),
 		      "r" (cfg1),
 		      "r" (cfg2), /* with enable */
-		      "r" (ss_base + CLK_MODE_CTRL),
-		      "r" (CLK_MODE_CTRL_X1),
-		      "r" (CLK_MODE_CTRL_PROG),
+		      "r" (ss_base + MODE_CONTROL),
+		      "r" (MODE_CONTROL_X1),
+		      "r" (MODE_CONTROL_PROG),
 		      "r" (1000000)
 		:     "memory");
 	writel(0x100, ss_base + CLK_LOCK_CFG); /* UnLock */
 	local_irq_restore(flag);
 }
 
+#define CLKDIV_CONF0(x)		(((x) = 0) ? CLKDIV0_CONFIG0 : ((x) < 5) ? \
+			CLKDIV1_4_CONFIG0(x) : CLKDIV6_10_CONFIG0(x))
+
 static int dividedpll_clk_XXable(struct clk *clk, int enable)
 {
 	unsigned long num = clk->id-CLK_DDR_ID;
@@ -383,27 +407,12 @@ static struct clk generic_comms_clk = {
 	.ops		= &generic_clk_ops,
 };
 
-#ifdef CONFIG_PM
-int clk_pm_state(pm_message_t state)
-{
-	static int prev_state = PM_EVENT_ON;
-	switch (state.event) {
-	case PM_EVENT_ON:
-	case PM_EVENT_SUSPEND:
-	case PM_EVENT_FREEZE:
-		prev_state = state.event;
-		break;
-	}
-	return 0;
-}
-#endif
-
 int __init clk_init(void)
 {
 	int i, ret;
 
-	ss_base = ioremap(SYS_SERV_BASE_ADDR, 1024);
-	if (! ss_base)
+	ss_base = ioremap(SYS_SERVICE_ADDR, 1024);
+	if (!ss_base)
 		panic("Unable to remap system services");
 
 	ret = clk_register(&xtal_osc);
diff --git a/arch/sh/kernel/pm/suspend-stx5197.c b/arch/sh/kernel/pm/suspend-stx5197.c
new file mode 100644
index 0000000..6d314eb
--- /dev/null
+++ b/arch/sh/kernel/pm/suspend-stx5197.c
@@ -0,0 +1,147 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/pm/suspend-stx5197.c
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2009  STMicroelectronics
+ * Author: Francesco M. Virlinzi  <francesco.virlinzi@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License V.2 ONLY.  See linux/COPYING for more information.
+ *
+ * ------------------------------------------------------------------------- */
+
+#include <linux/init.h>
+#include <linux/suspend.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+#include <linux/irqflags.h>
+#include <linux/io.h>
+#include <linux/stm/sysconf.h>
+#include <linux/stm/stx5197.h>
+
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/irq-ilc.h>
+
+#include "stm_suspend.h"
+
+/*
+ * System Service Finite State Machine
+ *	+-------+   +------+    +------+
+ *	| reset |-->|  X1  |<-->| Prog |
+ *	+-------+   +------+    +------+
+ *	    	        |	   |
+ *	    		|	   |
+ *		wakeup	|       +-------+
+ *		event	+-------|Standby|
+ *			        +-------+
+ */
+
+#define SYS		SYS_SERVICE_ADDR
+#define SHD		ICHD_BASE_ADDR
+
+#define	SYS_CFG_H	(SHD + 0x14)
+#define SYS_MON_J	(SHD + 0x3C)
+
+static const long stx5197_standby_table[] __cacheline_aligned = {
+POKE32(SYS + CLK_LOCK_CFG, 0xf0),
+POKE32(SYS + CLK_LOCK_CFG, 0x0f), /* UnLock the clocks */
+
+POKE32(SYS + MODE_CONTROL, MODE_CONTROL_X1),
+
+/* 1. Move all the clock on OSC */
+OR32(SYS + CLK_REDUCED_PM_CTRL, CLK_REDUCED_ON_XTAL_STDBY),
+OR32(SYS + PLLA_CONFIG1, PLL_CONFIG1_POFF),
+POKE32(SYS + MODE_CONTROL, MODE_CONTROL_PROG),
+END_MARKER,
+
+POKE32(SYS + MODE_CONTROL, MODE_CONTROL_X1),
+
+UPDATE32(SYS + CLK_REDUCED_PM_CTRL, ~CLK_REDUCED_ON_XTAL_STDBY, 0),
+UPDATE32(SYS + PLLA_CONFIG1, ~PLL_CONFIG1_POFF, 0),
+WHILE_NE32(SYS + PLLA_CONFIG1, PLL_CONFIG1_LOCK, PLL_CONFIG1_LOCK),
+POKE32(SYS + MODE_CONTROL, MODE_CONTROL_PROG),
+
+POKE32(SYS + CLK_LOCK_CFG, 0x100), /* Lock the clocks */
+DELAY(4),
+END_MARKER,
+};
+
+/* *********************
+ * MEM INSTRUCTION TABLE
+ * *********************
+ */
+static const long stx5197_mem_table[] __cacheline_aligned = {
+OR32(SYS_CFG_H, (1<<26)),
+WHILE_NE32(SYS_MON_J, (1<<24), (1<<24)),
+
+POKE32(SYS + CLK_LOCK_CFG, 0xf0),
+POKE32(SYS + CLK_LOCK_CFG, 0x0f), /* UnLock the clocks */
+
+/* disable PLLs in standby */
+OR32(SYS + CLK_LP_MODE_DIS0, CLK_LP_MODE_DIS0_VALUE),
+POKE32(SYS + MODE_CONTROL, MODE_CONTROL_STDB), /* IN STANDBY */
+
+END_MARKER,
+/*
+ * On a wakeup Event the System Service goes directly in X1 mode */
+UPDATE32(SYS + PLLA_CONFIG1, ~PLL_CONFIG1_POFF, 0),
+UPDATE32(SYS + PLLB_CONFIG1, ~PLL_CONFIG1_POFF, 0),
+/* Wait PLLs lock */
+WHILE_NE32(SYS + PLLA_CONFIG1, PLL_CONFIG1_LOCK, PLL_CONFIG1_LOCK),
+WHILE_NE32(SYS + PLLB_CONFIG1, PLL_CONFIG1_LOCK, PLL_CONFIG1_LOCK),
+
+POKE32(SYS + MODE_CONTROL, MODE_CONTROL_PROG),
+POKE32(SYS + CLK_LOCK_CFG, 0x100), /* Lock the clocks */
+
+DELAY(5),
+UPDATE32(SYS_CFG_H, ~(1 << 26), 0),
+WHILE_NE32(SYS_MON_J, (1 << 24), 0),
+
+DELAY(4),
+
+END_MARKER,
+};
+
+static int stx5197_evt_to_irq(unsigned long evt)
+{
+	return ((evt < 0x400) ? ilc2irq(evt) : evt2irq(evt));
+}
+
+static struct stm_suspend_t stx5197_suspend = {
+	.flags = NO_SLEEP_ON_MEMSTANDBY,
+	.evt_to_irq = stx5197_evt_to_irq,
+
+	.stby_tbl = (long)stx5197_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx5197_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+
+	.mem_tbl = (long)stx5197_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx5197_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init stx5197_suspend_setup(void)
+{
+	int i;
+	struct sysconf_field *sc[2];
+
+	sc[0] = sysconf_claim(CFG_MONITOR_J, 24, 24, "LMI - PM");
+	sc[1] = sysconf_claim(CFG_CTRL_H, 26, 26, "LMI - PM");
+
+	for (i = 0; i < 2; ++i)
+		if (!sc[i])
+			goto error;
+
+	return stm_suspend_register(&stx5197_suspend);
+
+error:
+	printk(KERN_ERR "[STM][PM]: Some sysconf is already required\n");
+	printk(KERN_ERR "[STM][PM]: the PM will not be registered\n");
+	for (i = 0; i < 2; ++i)
+		if (sc[i])
+			sysconf_release(sc[i]);
+	return -EINVAL;
+}
+
+late_initcall(stx5197_suspend_setup);
diff --git a/include/linux/stm/stx5197.h b/include/linux/stm/stx5197.h
index 2620437..5b2ca5d 100644
--- a/include/linux/stm/stx5197.h
+++ b/include/linux/stm/stx5197.h
@@ -72,6 +72,45 @@ void stx5197_configure_ethernet(struct stx5197_ethernet_config *config);
 
 void stx5197_configure_usb(void);
 
+/* Base addresses */
+#define SYS_SERVICE_ADDR			0xFDC00000
+#define ICHD_BASE_ADDR				0xFD901000
+
+#define MODE_CONTROL				0x110
+#define   MODE_CONTROL_NULL			0x000
+#define   MODE_CONTROL_X1			0x001
+#define   MODE_CONTROL_PROG			0x002
+#define   MODE_CONTROL_STDB			0x003
+
+#define CLK_LOCK_CFG				0x300
+#define CLK_OBS_CFG				0x188
+#define FORCE_CFG				0x184
+#define PLL_SELECT_CFG				0x180
+#define PLLA_CONFIG0				0x000
+#define PLLA_CONFIG1				0x004
+#define PLLB_CONFIG0				0x008
+#define PLLB_CONFIG1				0x00C
+#define   PLL_CONFIG1_POFF			(1 << 13)
+#define   PLL_CONFIG1_LOCK			(1 << 15)
+
+/*
+ * The REDUCED_PM is used in CLK_MODE_CTRL_PROG...
+ */
+#define CLK_REDUCED_PM_CTRL			0x114
+#define   CLK_REDUCED_ON_XTAL_MEMSTDBY		(1 << 11)
+#define   CLK_REDUCED_ON_XTAL_STDBY		(~(0x22))
+
+#define CLK_LP_MODE_DIS0			0x118
+#define   CLK_LP_MODE_DIS0_VALUE		(0x3 << 11)
+
+#define CLK_LP_MODE_DIS1			0x11C
+#define   CLK_LP_MODE_DIS1_VALUE		(0x3 << 8)
+
+#define CLK_PLL_SELECT_CFG			0x180
+#define CLK_DIV_FORCE_CFG			0x184
+#define CLK_OBSERVE				0x188
+
+#define CLK_LOCK_CFG				0x300
 
 #endif
 
-- 
1.6.2.5

