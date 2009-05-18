From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 18 May 2009 13:18:18 +0000
Subject: [PATCH] stm: pm: Rework the suspend SOC code
Message-Id: <1242652698-12170-1-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Changed the suspend SOC code based on the registration mechanism

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/cpu/sh4/clock-stx7200.c   |    5 +-
 arch/sh/kernel/cpu/sh4/soc-stb7100.h     |    7 ++
 arch/sh/kernel/cpu/sh4/soc-stx5197.h     |   17 ++--
 arch/sh/kernel/cpu/sh4/soc-stx7141.h     |    2 +-
 arch/sh/kernel/cpu/sh4/soc-stx7200.h     |   34 +++++----
 arch/sh/kernel/cpu/sh4/suspend-stb7100.c |  102 ++++++++++----------------
 arch/sh/kernel/cpu/sh4/suspend-stx5197.c |  119 ++++++++++++-----------------
 arch/sh/kernel/cpu/sh4/suspend-stx7105.c |  112 +++++++++++-----------------
 arch/sh/kernel/cpu/sh4/suspend-stx7111.c |   98 ++++++++++--------------
 arch/sh/kernel/cpu/sh4/suspend-stx7141.c |  102 +++++++++++---------------
 arch/sh/kernel/cpu/sh4/suspend-stx7200.c |   94 ++++++++++--------------
 11 files changed, 294 insertions(+), 398 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/clock-stx7200.c b/arch/sh/kernel/cpu/sh4/clock-stx7200.c
index cf03964..ce6a92d 100644
--- a/arch/sh/kernel/cpu/sh4/clock-stx7200.c
+++ b/arch/sh/kernel/cpu/sh4/clock-stx7200.c
@@ -620,8 +620,9 @@ int clk_pm_state(pm_message_t state)
 		tmp = readl(CLOCKGENB_BASE_ADDR + CLKB_PWR_CFG);
 		writel(tmp & ~CLKB_PLL0_OFF,
 			CLOCKGENB_BASE_ADDR + CLKB_PWR_CFG);
-
-		mdelay(10); /* wait for stable signal */
+		/* Wait PllB lock */
+		while ((readl(CLOCKGENB_BASE_ADDR + CLKB_PLL0_CFG)
+			& CLKB_PLL0_LOCK) != 0);
 		tmp = readl(CLOCKGENB_BASE_ADDR + CLKB_PLL0_CFG);
 		writel(tmp & ~CLKB_PLL0_BYPASS,
 			CLOCKGENB_BASE_ADDR + CLKB_PLL0_CFG);
diff --git a/arch/sh/kernel/cpu/sh4/soc-stb7100.h b/arch/sh/kernel/cpu/sh4/soc-stb7100.h
index 8f75fd8..20fa102 100644
--- a/arch/sh/kernel/cpu/sh4/soc-stb7100.h
+++ b/arch/sh/kernel/cpu/sh4/soc-stb7100.h
@@ -22,6 +22,10 @@
   #define CLKA_PLL0_ENABLE		(1 << 19)
   #define CLKA_PLL0_SUSPEND		((5 << 16) | (100 << 8) | \
 	(CONFIG_SH_EXTERNAL_CLOCK / 1000000))
+
+#define CLKA_PLL0_LOCK			0x10
+  #define CLKA_PLL0_LOCK_LOCKED		0x01
+
 #define CLKA_ST40			0x14
 #define CLKA_ST40_IC			0x18
 #define CLKA_ST40_PER			0x1c
@@ -30,6 +34,9 @@
   #define CLKA_PLL1_ENABLE		(1 << 19)
   #define CLKA_PLL1_SUSPEND		((5 << 16) | (100 << 8) | \
 	(CONFIG_SH_EXTERNAL_CLOCK / 1000000))
+#define CLKA_PLL1_LOCK			0x2C
+  #define CLKA_PLL1_LOCK_LOCKED		0x01
+
 #define CLKA_CLK_DIV			0x30
 #define CLKA_CLK_EN			0x34
   #define CLKA_CLK_EN_ST231_AUD		(1 << 0)
diff --git a/arch/sh/kernel/cpu/sh4/soc-stx5197.h b/arch/sh/kernel/cpu/sh4/soc-stx5197.h
index 4009a76..54092e0 100644
--- a/arch/sh/kernel/cpu/sh4/soc-stx5197.h
+++ b/arch/sh/kernel/cpu/sh4/soc-stx5197.h
@@ -40,7 +40,8 @@ enum clocks_ID {
 
 #define CLK_PLL_CONFIG0(x)	((x*8)+0x0)
 #define CLK_PLL_CONFIG1(x)	((x*8)+0x4)
-  #define CLK_PLL_CONFIG1_POFF	(1<<13)
+#define  CLK_PLL_CONFIG1_POFF	(1<<13)
+#define  CLK_PLL_CONFIG1_LOCK	(1<<15)
 
 #define CLKDIV0_CONFIG0		0x90
 #define CLKDIV1_4_CONFIG0(n)	(0x0a0 + ((n-1)*0xc))
@@ -54,20 +55,20 @@ enum clocks_ID {
 
 
 #define CLK_MODE_CTRL		0x110
- #define CLK_MODE_CTRL_NULL	0x0
- #define CLK_MODE_CTRL_X1	0x1
- #define CLK_MODE_CTRL_PROG	0x2
- #define CLK_MODE_CTRL_STDB	0x3
+#define   CLK_MODE_CTRL_NULL	0x0
+#define   CLK_MODE_CTRL_X1	0x1
+#define   CLK_MODE_CTRL_PROG	0x2
+#define   CLK_MODE_CTRL_STDB	0x3
 
 /*
  * The REDUCED_PM is used in CLK_MODE_CTRL_PROG...
  */
 #define CLK_REDUCED_PM_CTRL	0x114
- #define CLK_REDUCED_ON_XTAL_MEMSTDBY	(1<<11)
- #define CLK_REDUCED_ON_XTAL_STDBY	(~(0x22))
+#define   CLK_REDUCED_ON_XTAL_MEMSTDBY	(1<<11)
+#define   CLK_REDUCED_ON_XTAL_STDBY	(~(0x22))
 
 #define CLK_LP_MODE_DIS0	0x118
-  #define CLK_LP_MODE_DIS0_VALUE	((0x3 << 11) | (0x7ff & ~(1<<9)))
+#define   CLK_LP_MODE_DIS0_VALUE	(0x3 << 11)
 
 #define CLK_LP_MODE_DIS2	0x11C
 
diff --git a/arch/sh/kernel/cpu/sh4/soc-stx7141.h b/arch/sh/kernel/cpu/sh4/soc-stx7141.h
index d98b506..5048610 100644
--- a/arch/sh/kernel/cpu/sh4/soc-stx7141.h
+++ b/arch/sh/kernel/cpu/sh4/soc-stx7141.h
@@ -21,7 +21,7 @@
 #define CLOCKGENA_BASE_ADDR	0xfe213000	/* Clockgen A */
 #define CLOCKGENB_BASE_ADDR	0xfe000000	/* Clockgen B */
 
-#define ckga_pll0_cfg			0x000
+#define CKGA_PLL0_CFG			0x000
   #define CKGA_PLL0_CFG_DIVRES		(1 << 20)
   #define CKGA_PLL0_CFG_BYPASS		CKGA_PLL0_CFG_DIVRES
   #define CKGA_PLL0_CFG_LOCK		(1 << 31)
diff --git a/arch/sh/kernel/cpu/sh4/soc-stx7200.h b/arch/sh/kernel/cpu/sh4/soc-stx7200.h
index 9045b16..5933506 100644
--- a/arch/sh/kernel/cpu/sh4/soc-stx7200.h
+++ b/arch/sh/kernel/cpu/sh4/soc-stx7200.h
@@ -24,38 +24,42 @@
 #define CLOCKGENC_BASE_ADDR	0xfd601000	/* Clockgen C */
 
 #define CLKA_PLL0			0x00
-  #define CLKA_PLL0_BYPASS		(1 << 20)
-  #define CLKA_PLL0_ENABLE_STATUS	(1 << 19)
-  #define CLKA_PLL0_SUSPEND		((5 << 16) | (100 << 8) | \
+#define   CLKA_PLL0_BYPASS		(1 << 20)
+#define   CLKA_PLL0_ENABLE_STATUS	(1 << 19)
+#define   CLKA_PLL0_LOCK		(1 << 31)
+#define   CLKA_PLL0_SUSPEND		((5 << 16) | (100 << 8) | \
 	(SYSACLKIN / 1000000))
 
 #define CLKA_PLL1			0x04
-  #define CLKA_PLL1_BYPASS		(1 << 20)
-  #define CLKA_PLL1_ENABLE_STATUS	(1 << 19)
-  #define CLKA_PLL1_SUSPEND		((100 << 8) | (SYSACLKIN / 1000000))
+#define   CLKA_PLL1_BYPASS		(1 << 20)
+#define   CLKA_PLL1_ENABLE_STATUS	(1 << 19)
+#define   CLKA_PLL1_LOCK		(1 << 31)
+#define   CLKA_PLL1_SUSPEND		((100 << 8) | (SYSACLKIN / 1000000))
 
 #define CLKA_PLL2			0x08
-  #define CLKA_PLL2_BYPASS		(1 << 20)
-  #define CLKA_PLL2_ENABLE_STATUS	(1 << 19)
-  #define CLKA_PLL2_SUSPEND		((5 << 16) | (100 << 8) | \
+#define   CLKA_PLL2_BYPASS		(1 << 20)
+#define   CLKA_PLL2_ENABLE_STATUS	(1 << 19)
+#define   CLKA_PLL2_LOCK		(1 << 31)
+#define   CLKA_PLL2_SUSPEND		((5 << 16) | (100 << 8) | \
 	(SYSACLKIN / 1000000))
 
 #define CKGA_CLKOUT_SEL			0x18
 
 #define CLKA_PWR_CFG			0x1C
-  #define PWR_CFG_PLL0_OFF		0x1
-  #define PWR_CFG_PLL1_OFF		0x2
-  #define PWR_CFG_PLL2_OFF 		0x4
+#define   PWR_CFG_PLL0_OFF		0x1
+#define   PWR_CFG_PLL1_OFF		0x2
+#define   PWR_CFG_PLL2_OFF 		0x4
 
 #define CLKA_DIV_CFG			0x10
 
 
 #define CLKB_PLL0_CFG			0x3C
-  #define CLKB_PLL0_BYPASS		(1 << 20)
-  #define CLKB_PLL0_SUSPEND		((5 << 16) | (100 << 8) | \
+#define   CLKB_PLL0_LOCK		(1 << 31)
+#define   CLKB_PLL0_BYPASS		(1 << 20)
+#define   CLKB_PLL0_SUSPEND		((5 << 16) | (100 << 8) | \
 	(SYSACLKIN / 1000000))
 
 #define CLKB_PWR_CFG			0x58
-  #define CLKB_PLL0_OFF			(1 << 15)
+#define   CLKB_PLL0_OFF			(1 << 15)
 
 #endif
diff --git a/arch/sh/kernel/cpu/sh4/suspend-stb7100.c b/arch/sh/kernel/cpu/sh4/suspend-stb7100.c
index e5134ec..79eab1f 100644
--- a/arch/sh/kernel/cpu/sh4/suspend-stb7100.c
+++ b/arch/sh/kernel/cpu/sh4/suspend-stb7100.c
@@ -32,11 +32,13 @@
 #define _SYS_CFG11			(6)
 #define _SYS_CFG11_MASK			(7)
 
+extern void __iomem *clkgena_base;
+
 /* *************************
  * STANDBY INSTRUCTION TABLE
  * *************************
  */
-
+#ifdef CONFIG_PM_DEBUG
 static unsigned long stb7100_standby_table[] __cacheline_aligned = {
 /* 1. PLL0 at the minimum frequency */
 	/* Unlock the clocks */
@@ -51,6 +53,8 @@ CLK_AND_LONG(CLKA_PLL0, ~(0x7ffff)),
 CLK_OR_LONG(CLKA_PLL0, CLKA_PLL0_SUSPEND),
 	/* enables the pll0 */
 CLK_OR_LONG(CLKA_PLL0, CLKA_PLL0_ENABLE),
+	/* Wait PLL0 lock */
+CLK_WHILE_NEQ(CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED),
 	/* removes the bypass */
 CLK_AND_LONG(CLKA_PLL0, ~(CLKA_PLL0_BYPASS)),
 	/* 0 4 5 - 1:4 1:6 1:8	*/
@@ -79,6 +83,8 @@ _OR(),
 CLK_STORE(CLKA_PLL0),
 	/* enables the pll0 */
 CLK_OR_LONG(CLKA_PLL0, CLKA_PLL0_ENABLE),
+	/* Wait PLL0 lock */
+CLK_WHILE_NEQ(CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED),
 	/* removes the bypass */
 CLK_AND_LONG(CLKA_PLL0, ~(CLKA_PLL0_BYPASS)),
 	/* Lock the clocks */
@@ -86,7 +92,7 @@ CLK_POKE(CLKA_LOCK, 0x0),
 /* END. */
 _END()
 };
-
+#endif
 /* *********************
  * MEM INSTRUCTION TABLE
  * *********************
@@ -112,6 +118,8 @@ CLK_AND_LONG(CLKA_PLL0, ~(0x7ffff)),
 CLK_OR_LONG(CLKA_PLL0, CLKA_PLL0_SUSPEND),
 	/* enables the pll0 */
 CLK_OR_LONG(CLKA_PLL0, CLKA_PLL0_ENABLE),
+	/* Wait PLL0 lock */
+CLK_WHILE_NEQ(CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED),
 	/* removes the bypass */
 CLK_AND_LONG(CLKA_PLL0, ~(CLKA_PLL0_BYPASS)),
 
@@ -126,6 +134,8 @@ CLK_AND_LONG(CLKA_PLL1, ~(0x7ffff)),
 CLK_OR_LONG(CLKA_PLL1, CLKA_PLL1_SUSPEND),
 	/* enables the pll1 */
 CLK_OR_LONG(CLKA_PLL1, CLKA_PLL1_ENABLE),
+	/* Wait PLL1 lock */
+CLK_WHILE_NEQ(CLKA_PLL1_LOCK, CLKA_PLL1_LOCK_LOCKED, CLKA_PLL1_LOCK_LOCKED),
 CLK_AND_LONG(CLKA_PLL1_BYPASS, ~(2)),		/* removes the bypass */
 
 /* 4. Turn-off the LMI clocks and the ST231 clocks */
@@ -150,6 +160,8 @@ CLK_AND_LONG(CLKA_PLL1, ~(CLKA_PLL1_ENABLE)),	/* disable the pll1 */
 DATA_LOAD(0x1),
 CLK_STORE(CLKA_PLL1),
 CLK_OR_LONG(CLKA_PLL1, CLKA_PLL1_ENABLE),	/* enables the pll1 */
+	/* Wait PLL1 lock */
+CLK_WHILE_NEQ(CLKA_PLL1_LOCK, CLKA_PLL1_LOCK_LOCKED, CLKA_PLL1_LOCK_LOCKED),
 CLK_AND_LONG(CLKA_PLL1_BYPASS, ~(2)),		/* removes the bypass */
 
 /* 4. Disables the DDR self refresh mode */
@@ -167,6 +179,8 @@ IMMEDIATE_SRC0(CLKA_PLL0_BYPASS),
 _OR(),
 CLK_STORE(CLKA_PLL0),				/* save the r2 in PLL0 */
 CLK_OR_LONG(CLKA_PLL0, CLKA_PLL0_ENABLE),	/* enables the pll0 */
+	/* Wait PLL0 lock */
+CLK_WHILE_NEQ(CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED),
 CLK_AND_LONG(CLKA_PLL0, ~(CLKA_PLL0_BYPASS)),	/* removes the bypass */
 CLK_POKE(CLKA_LOCK, 0x0),
 
@@ -182,46 +196,8 @@ static unsigned long stb7100_wrt_table[8] __cacheline_aligned;
 
 static int stb7100_suspend_prepare(suspend_state_t state)
 {
-	int ret = -EINVAL;
-	pm_message_t pms = {.event = PM_EVENT_SUSPEND, };
-	emi_pm_state(pms);
-/*	clk_pm_state(pms);*/
-	sysconf_pm_state(pms);
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-		stb7100_wrt_table[0] = readl(clkgena_base + CLKA_PLL0) & 0x7ffff;
-		ret = 0;
-	break;
-	case PM_SUSPEND_MEM:
-		stb7100_wrt_table[0] = readl(clkgena_base + CLKA_PLL0) & 0x7ffff;
-		stb7100_wrt_table[1] = readl(clkgena_base + CLKA_PLL1) & 0x7ffff;
-		ret = 0;
-	break;
-	}
-	return ret;
-}
-
-static int stb7100_suspend_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		return 1;
-	};
-	return 0;
-}
-
-/*
- * The xxxx_finish function is called after the resume
- * sysdev devices (i.e.: timer, cpufreq)
- * But it isn't a big issue in our platform
- */
-static int stb7100_suspend_finish(suspend_state_t state)
-{
-	pm_message_t pms = {.event = PM_EVENT_ON, };
-	sysconf_pm_state(pms);
-/*	clk_pm_state(pms);*/
-	emi_pm_state(pms);
+	stb7100_wrt_table[0] = readl(clkgena_base + CLKA_PLL0) & 0x7ffff;
+	stb7100_wrt_table[1] = readl(clkgena_base + CLKA_PLL1) & 0x7ffff;
 	return 0;
 }
 
@@ -234,31 +210,29 @@ static unsigned long stb7100_iomem[2] __cacheline_aligned = {
 	stb7100_wrt_table,
 };
 
-int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
+static struct sh4_suspend_t st40data __cacheline_aligned = {
+	.iobase = stb7100_iomem,
+	.ops.prepare = stb7100_suspend_prepare,
+	.evt_to_irq = stb7100_evttoirq,
+#ifdef CONFIG_PM_DEBUG
+	.stby_tbl = (unsigned long)stb7100_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stb7100_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+#endif
+	.mem_tbl = (unsigned long)stb7100_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stb7100_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+	.wrt_tbl = (unsigned long)stb7100_wrt_table,
+	.wrt_size = DIV_ROUND_UP(ARRAY_SIZE(stb7100_wrt_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init suspend_platform_setup()
 {
 	struct sysconf_field* sc;
 
 	stb7100_iomem[1] = (unsigned long) clkgena_base;
 
-	st40data->iobase = stb7100_iomem;
-	st40data->ops.valid  = stb7100_suspend_valid;
-	st40data->ops.finish = stb7100_suspend_finish;
-	st40data->ops.prepare = stb7100_suspend_prepare;
-
-	st40data->evt_to_irq = stb7100_evttoirq;
-
-	st40data->stby_tbl = (unsigned long)stb7100_standby_table;
-	st40data->stby_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stb7100_standby_table)*sizeof(long), L1_CACHE_BYTES);;
-
-	st40data->mem_tbl = (unsigned long)stb7100_mem_table;
-	st40data->mem_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stb7100_mem_table)*sizeof(long), L1_CACHE_BYTES);
-
-	st40data->wrt_tbl = (unsigned long)stb7100_wrt_table;
-	st40data->wrt_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stb7100_wrt_table)*sizeof(long), L1_CACHE_BYTES);
-
 	sc = sysconf_claim(SYS_STA, 12, 28, 28, "pm");
 	stb7100_wrt_table[_SYS_STA12] = (unsigned long)sysconf_address(sc);
 	stb7100_wrt_table[_SYS_STA12_MASK] = sysconf_mask(sc);
@@ -273,5 +247,7 @@ int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
 	sc = sysconf_claim(SYS_CFG, 11, 30, 30, "pm");
 	stb7100_wrt_table[_SYS_CFG11_MASK] |= sysconf_mask(sc);
 
-	return 0;
+	return sh4_suspend_register(&st40data);
 }
+
+late_initcall(suspend_platform_setup);
diff --git a/arch/sh/kernel/cpu/sh4/suspend-stx5197.c b/arch/sh/kernel/cpu/sh4/suspend-stx5197.c
index 69aa3f3..ee793ad 100644
--- a/arch/sh/kernel/cpu/sh4/suspend-stx5197.c
+++ b/arch/sh/kernel/cpu/sh4/suspend-stx5197.c
@@ -31,10 +31,25 @@
 #define _SYS_CFG_H                      (2)
 #define _SYS_CFG_H_MASK                 (3)
 
+
+
+/*
+ * System Service Finite State Machine
+ *	+-------+   +------+    +------+
+ *	| reset |-->|  X1  |<-->| Prog |
+ *	+-------+   +------+    +------+
+ *	    	       /\	   |
+ *	    		|	   \/
+ *		wakeup	|       +-------+
+ *		event	+-------|Standby|
+ *			        +-------+
+ */
+
 /* *************************
  * STANDBY INSTRUCTION TABLE
  * *************************
  */
+#ifdef CONFIG_PM_DEBUG
 static unsigned long stx5197_standby_table[] __cacheline_aligned = {
 CLK_POKE(CLK_LOCK_CFG, 0xf0),
 CLK_POKE(CLK_LOCK_CFG, 0x0f), /* UnLock the clocks */
@@ -54,6 +69,7 @@ CLK_POKE(CLK_LOCK_CFG, 0x0f), /* UnLock the clocks */
 CLK_POKE(CLK_MODE_CTRL, CLK_MODE_CTRL_X1),
 CLK_AND_LONG(CLK_REDUCED_PM_CTRL, ~CLK_REDUCED_ON_XTAL_STDBY),
 CLK_AND_LONG(CLK_PLL_CONFIG1(0), ~CLK_PLL_CONFIG1_POFF),
+CLK_WHILE_NEQ(CLK_PLL_CONFIG1(0), CLK_PLL_CONFIG1_LOCK, CLK_PLL_CONFIG1_LOCK),
 CLK_POKE(CLK_MODE_CTRL, CLK_MODE_CTRL_PROG),
 CLK_POKE(CLK_LOCK_CFG, 0x100), /* Lock the clocks */
 _DELAY(),
@@ -61,6 +77,7 @@ _DELAY(),
 _DELAY(),
 _END()
 };
+#endif
 
 /* *********************
  * MEM INSTRUCTION TABLE
@@ -73,22 +90,19 @@ DATA_WHILE_NEQ(_SYS_MON_J, _SYS_MON_J_MASK, _SYS_MON_J_MASK),
 CLK_POKE(CLK_LOCK_CFG, 0xf0),
 CLK_POKE(CLK_LOCK_CFG, 0x0f), /* UnLock the clocks */
 
-CLK_POKE(CLK_MODE_CTRL, CLK_MODE_CTRL_X1),
-/* on exetrnal Xtal */
-CLK_OR_LONG(CLK_REDUCED_PM_CTRL, CLK_REDUCED_ON_XTAL_MEMSTDBY),
-CLK_OR_LONG(CLK_PLL_CONFIG1(0), CLK_PLL_CONFIG1_POFF),
-CLK_OR_LONG(CLK_PLL_CONFIG1(1), CLK_PLL_CONFIG1_POFF),
-CLK_POKE(CLK_MODE_CTRL, CLK_MODE_CTRL_PROG),
-CLK_POKE(CLK_LOCK_CFG, 0x100), /* Lock the clocks */
+/* disable PLLs in standby */
+CLK_OR_LONG(CLK_LP_MODE_DIS0, CLK_LP_MODE_DIS0_VALUE),
+CLK_POKE(CLK_MODE_CTRL, CLK_MODE_CTRL_STDB), /* IN STANDBY */
 
-_END(),
-
-CLK_POKE(CLK_LOCK_CFG, 0xf0),
-CLK_POKE(CLK_LOCK_CFG, 0x0f), /* UnLock the clocks */
-CLK_POKE(CLK_MODE_CTRL, CLK_MODE_CTRL_X1),
+_END_NO_SLEEP(),
+/*
+ * On a wakeup Event the System Service goes directly in X1 mode */
 CLK_AND_LONG(CLK_PLL_CONFIG1(0), ~CLK_PLL_CONFIG1_POFF),
 CLK_AND_LONG(CLK_PLL_CONFIG1(1), ~CLK_PLL_CONFIG1_POFF),
-CLK_AND_LONG(CLK_REDUCED_PM_CTRL, ~CLK_REDUCED_ON_XTAL_MEMSTDBY), /* on PLLs */
+/* Wait PLLs lock */
+CLK_WHILE_NEQ(CLK_PLL_CONFIG1(0), CLK_PLL_CONFIG1_LOCK, CLK_PLL_CONFIG1_LOCK),
+CLK_WHILE_NEQ(CLK_PLL_CONFIG1(1), CLK_PLL_CONFIG1_LOCK, CLK_PLL_CONFIG1_LOCK),
+
 CLK_POKE(CLK_MODE_CTRL, CLK_MODE_CTRL_PROG),
 CLK_POKE(CLK_LOCK_CFG, 0x100), /* Lock the clocks */
 
@@ -109,42 +123,6 @@ static unsigned long stx5197_wrt_table[8] __cacheline_aligned;
 
 static int stx5197_suspend_prepare(suspend_state_t state)
 {
-	int ret = -EINVAL;
-	pm_message_t pms = {.event = PM_EVENT_SUSPEND, };
-	emi_pm_state(pms);
-/*	clk_pm_state(pms);*/
-	sysconf_pm_state(pms);
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		ret = 0;
-		break;
-	}
-	return ret;
-}
-
-static int stx5197_suspend_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		return 1;
-	};
-	return 0;
-}
-
-/*
- * The xxxx_finish function is called after the resume
- * sysdev devices (i.e.: timer, cpufreq)
- * But it isn't a big issue in our platform
- */
-static int stx5197_suspend_finish(suspend_state_t state)
-{
-	pm_message_t pms = {.event = PM_EVENT_ON, };
-	sysconf_pm_state(pms);
-/*	clk_pm_state(pms);*/
-	emi_pm_state(pms);
 	return 0;
 }
 
@@ -154,31 +132,30 @@ static unsigned long stx5197_iomem[2] __cacheline_aligned = {
 
 static int stx5197_evt_to_irq(unsigned long evt)
 {
-	return ilc2irq(evt);
+	return ((evt < 0x400) ? ilc2irq(evt) : evt2irq(evt));
 }
 
-int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
+static struct sh4_suspend_t st40data __cacheline_aligned = {
+	.iobase = stx5197_iomem,
+	.ops.prepare = stx5197_suspend_prepare,
+	.evt_to_irq = stx5197_evt_to_irq,
+#ifdef CONFIG_PM_DEBUG
+	.stby_tbl = (unsigned long)stx5197_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx5197_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+#endif
+	.mem_tbl = (unsigned long)stx5197_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx5197_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+	.wrt_tbl = (unsigned long)stx5197_wrt_table,
+	.wrt_size = DIV_ROUND_UP(ARRAY_SIZE(stx5197_wrt_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init suspend_platform_setup(void)
 {
 
 	struct sysconf_field* sc;
-	st40data->iobase = stx5197_iomem;
-	st40data->ops.valid = stx5197_suspend_valid;
-	st40data->ops.finish = stx5197_suspend_finish;
-	st40data->ops.prepare = stx5197_suspend_prepare;
-
-	st40data->evt_to_irq = stx5197_evt_to_irq;
-
-	st40data->stby_tbl = (unsigned long)stx5197_standby_table;
-	st40data->stby_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx5197_standby_table) * sizeof(long), L1_CACHE_BYTES);
-
-	st40data->mem_tbl = (unsigned long)stx5197_mem_table;
-	st40data->mem_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx5197_mem_table) * sizeof(long), L1_CACHE_BYTES);
-
-	st40data->wrt_tbl = (unsigned long)stx5197_wrt_table;
-	st40data->wrt_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx5197_wrt_table) * sizeof(long), L1_CACHE_BYTES);
 
 	sc = sysconf_claim(SYS_DEV, CFG_MONITOR_J, 24, 24, "LMI pwd ack");
 	stx5197_wrt_table[_SYS_MON_J] = (unsigned long)sysconf_address(sc);
@@ -188,5 +165,7 @@ int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
 	stx5197_wrt_table[_SYS_CFG_H] = (unsigned long)sysconf_address(sc);
 	stx5197_wrt_table[_SYS_CFG_H_MASK] = sysconf_mask(sc);
 
-	return 0;
+	return sh4_suspend_register(&st40data);
 }
+
+late_initcall(suspend_platform_setup);
diff --git a/arch/sh/kernel/cpu/sh4/suspend-stx7105.c b/arch/sh/kernel/cpu/sh4/suspend-stx7105.c
index b9b88a2..e5e0329 100644
--- a/arch/sh/kernel/cpu/sh4/suspend-stx7105.c
+++ b/arch/sh/kernel/cpu/sh4/suspend-stx7105.c
@@ -27,6 +27,10 @@
 
 #define _SYS_STA4		(7)
 #define _SYS_STA4_MASK		(8)
+#define _SYS_STA3		(11)
+#define _SYS_STA3_MASK		(12)
+#define _SYS_STA3_VALUE		(13)
+
 #define _SYS_CFG11		(9)
 #define _SYS_CFG11_MASK		(10)
 #define _SYS_CFG38		(5)
@@ -35,6 +39,7 @@
  * STANDBY INSTRUCTION TABLE
  * *************************
  */
+#ifdef CONFIG_PM_DEBUG
 static unsigned long stx7105_standby_table[] __cacheline_aligned = {
 /* 1. Move all the clock on OSC */
 CLK_POKE(CKGA_CLKOPSRC_SWITCH_CFG(0x0), 0x0),
@@ -57,7 +62,7 @@ CLK_STORE(CKGA_OSC_DIV_CFG(5)),
 /* END. */
 _END()
 };
-
+#endif
 /* *********************
  * MEM INSTRUCTION TABLE
  * *********************
@@ -91,8 +96,15 @@ _END(),
 
 /* Turn-on the PLLs */
 CLK_AND_LONG(CKGA_POWER_CFG, ~3),
+/* Wait PLLS lock */
+CLK_WHILE_NEQ(CKGA_PLL0_CFG, CKGA_PLL0_CFG_LOCK, CKGA_PLL0_CFG_LOCK),
+CLK_WHILE_NEQ(CKGA_PLL1_CFG, CKGA_PLL1_CFG_LOCK, CKGA_PLL1_CFG_LOCK),
+
 /* 1. Turn-on the LMI ClocksGenD */
 DATA_AND_NOT_LONG(_SYS_CFG11, _SYS_CFG11_MASK),
+/* Wait LMI ClocksGenD lock */
+DATA_WHILE_NEQ(_SYS_STA3, _SYS_STA3_MASK, _SYS_STA3_VALUE),
+
 /* 2. Disables the DDR self refresh mode */
 DATA_AND_NOT_LONG(_SYS_CFG38, _SYS_CFG38_MASK),
 /* waits until the ack bit is zero */
@@ -100,6 +112,7 @@ DATA_WHILE_EQ(_SYS_STA4, _SYS_STA4_MASK, _SYS_STA4_MASK),
 
 IMMEDIATE_DEST(0x10000),
 CLK_STORE(CKGA_PLL0LS_DIV_CFG(4)),
+
 /* 3. Restore the previous clocks setting */
 DATA_LOAD(0x0),
 CLK_STORE(CKGA_CLKOPSRC_SWITCH_CFG(0x0)),
@@ -111,6 +124,7 @@ DATA_LOAD(0x2),
 CLK_STORE(CKGA_OSC_DIV_CFG(0x0)),
 DATA_LOAD(0x4),
 CLK_STORE(CKGA_OSC_DIV_CFG(17)),
+
 _DELAY(),
 _DELAY(),
 _DELAY(),
@@ -121,23 +135,17 @@ static unsigned long stx7105_wrt_table[16] __cacheline_aligned;
 
 static int stx7105_suspend_prepare(suspend_state_t state)
 {
-	int ret = -EINVAL;
-	pm_message_t pms = {.event = PM_EVENT_SUSPEND, };
-	emi_pm_state(pms);
-	clk_pm_state(pms);
-	sysconf_pm_state(pms);
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
+#ifdef CONFIG_PM_DEBUG
+	if (state = PM_SUSPEND_STANDBY) {
 		stx7105_wrt_table[0] = /* swith config */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_CLKOPSRC_SWITCH_CFG(0));
 		stx7105_wrt_table[1] = /* clk_STNoc */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(0));
 		stx7105_wrt_table[2] = /* clk_ic_if_100 */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(5));
-		ret = 0;
-	break;
-	case PM_SUSPEND_MEM:
+	} else
+#endif
+	{
 		stx7105_wrt_table[0] = /* swith config */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_CLKOPSRC_SWITCH_CFG(0));
 		stx7105_wrt_table[1] = /* swith config 1 */
@@ -148,33 +156,7 @@ static int stx7105_suspend_prepare(suspend_state_t state)
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(5));
 		stx7105_wrt_table[4] = /* clk_ic_if_200 */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(17));
-		ret = 0;
-		break;
 	}
-	return ret;
-}
-
-static int stx7105_suspend_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		return 1;
-	};
-	return 0;
-}
-
-/*
- * The xxxx_finish function is called after the resume
- * sysdev devices (i.e.: timer, cpufreq)
- * But it isn't a big issue in our platform
- */
-static int stx7105_suspend_finish(suspend_state_t state)
-{
-	pm_message_t pms = {.event = PM_EVENT_ON, };
-	sysconf_pm_state(pms);
-	clk_pm_state(pms);
-	emi_pm_state(pms);
 	return 0;
 }
 
@@ -187,41 +169,27 @@ static int stx7105_evt_to_irq(unsigned long evt)
 	return evt2irq(evt);
 }
 
-#if 0
-#define GPLMI_BASEADDRESS		0xfe901000
-#define GPLMI_SCR_APPD			0x14
-static void stx7105_sleep_on_idle(void)
-{
-	iowrite32(0x10 << 16 | 0x10, GPLMI_BASEADDRESS + GPLMI_SCR_APPD);
-	asm volatile ("sleep    \n":::"memory");
-	iowrite32(0x0, GPLMI_BASEADDRESS + GPLMI_SCR_APPD);
-}
+static struct sh4_suspend_t st40data __cacheline_aligned = {
+	.iobase = stx7105_iomem,
+	.ops.prepare = stx7105_suspend_prepare,
+	.evt_to_irq = stx7105_evt_to_irq,
+#ifdef CONFIG_PM_DEBUG
+	.stby_tbl = (unsigned long)stx7105_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx7105_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
 #endif
+	.mem_tbl = (unsigned long)stx7105_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx7105_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+	.wrt_tbl = (unsigned long)stx7105_wrt_table,
+	.wrt_size = DIV_ROUND_UP(ARRAY_SIZE(stx7105_wrt_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
 
-int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
+static int __init suspend_platform_setup(void)
 {
 
 	struct sysconf_field* sc;
-	st40data->iobase = stx7105_iomem;
-	st40data->ops.valid = stx7105_suspend_valid;
-	st40data->ops.finish = stx7105_suspend_finish;
-	st40data->ops.prepare = stx7105_suspend_prepare;
-
-	st40data->evt_to_irq = stx7105_evt_to_irq;
-
-	st40data->stby_tbl = (unsigned long)stx7105_standby_table;
-	st40data->stby_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7105_standby_table) * sizeof(long), L1_CACHE_BYTES);
-
-	st40data->mem_tbl = (unsigned long)stx7105_mem_table;
-	st40data->mem_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7105_mem_table) * sizeof(long), L1_CACHE_BYTES);
-
-	st40data->wrt_tbl = (unsigned long)stx7105_wrt_table;
-	st40data->wrt_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7105_wrt_table) * sizeof(long), L1_CACHE_BYTES);
-
-/*	pm_idle = stx7105_sleep_on_idle;	*/
 	sc = sysconf_claim(SYS_CFG, 38, 20, 20, "pm");
 	stx7105_wrt_table[_SYS_CFG38]      = (unsigned long)sysconf_address(sc);
 	stx7105_wrt_table[_SYS_CFG38_MASK] = sysconf_mask(sc);
@@ -234,5 +202,11 @@ int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
 	stx7105_wrt_table[_SYS_STA4]      = (unsigned long)sysconf_address(sc);
 	stx7105_wrt_table[_SYS_STA4_MASK] = sysconf_mask(sc);
 
-	return 0;
+	sc = sysconf_claim(SYS_STA, 3, 0, 0, "pm");
+	stx7105_wrt_table[_SYS_STA3] = (unsigned long)sysconf_address(sc);
+	stx7105_wrt_table[_SYS_STA3_MASK] = sysconf_mask(sc);
+	stx7105_wrt_table[_SYS_STA3_VALUE] = 0;
+	return sh4_suspend_register(&st40data);
 }
+
+late_initcall(suspend_platform_setup);
diff --git a/arch/sh/kernel/cpu/sh4/suspend-stx7111.c b/arch/sh/kernel/cpu/sh4/suspend-stx7111.c
index a0b2104..8203184 100644
--- a/arch/sh/kernel/cpu/sh4/suspend-stx7111.c
+++ b/arch/sh/kernel/cpu/sh4/suspend-stx7111.c
@@ -27,6 +27,9 @@
 
 #define _SYS_STA4			(5)
 #define _SYS_STA4_MASK			(6)
+#define _SYS_STA3			(11)
+#define _SYS_STA3_MASK			(12)
+#define _SYS_STA3_VALUE			(13)
 
 #define _SYS_CFG11			(7)
 #define _SYS_CFG11_MASK			(8)
@@ -38,6 +41,7 @@
  * STANDBY INSTRUCTION TABLE
  * *************************
  */
+#ifdef CONFIG_PM_DEBUG
 static unsigned long stx7111_standby_table[] __cacheline_aligned = {
 /* 1. Move all the clock on OSC */
 CLK_POKE(CKGA_CLKOPSRC_SWITCH_CFG(0x0), 0x0),
@@ -64,6 +68,7 @@ CLK_STORE(CKGA_OSC_DIV_CFG(5)),
  /* END. */
 _END()
 };
+#endif
 
 /* *********************
  * MEM INSTRUCTION TABLE
@@ -96,9 +101,15 @@ _END(),
 
 /* Turn-on the PLLs */
 CLK_AND_LONG(CKGA_POWER_CFG, ~3),
+/* Wait PLLs lock */
+CLK_WHILE_NEQ(CKGA_PLL0_CFG, CKGA_PLL0_CFG_LOCK, CKGA_PLL0_CFG_LOCK),
+CLK_WHILE_NEQ(CKGA_PLL1_CFG, CKGA_PLL1_CFG_LOCK, CKGA_PLL1_CFG_LOCK),
 
 /* 1. Turn-on the LMI ClocksGenD */
 DATA_AND_NOT_LONG(_SYS_CFG11, _SYS_CFG11_MASK),
+/* Wait LMI ClocksGenD lock */
+DATA_WHILE_NEQ(_SYS_STA3, _SYS_STA3_MASK, _SYS_STA3_VALUE),
+
 /* 2. Disables the DDR self refresh mode */
 DATA_AND_NOT_LONG(_SYS_CFG38, _SYS_CFG38_MASK),
 /* waits until the ack bit is zero */
@@ -129,23 +140,17 @@ static unsigned long stx7111_wrt_table[16] __cacheline_aligned;
 
 static int stx7111_suspend_prepare(suspend_state_t state)
 {
-	int ret = -EINVAL;
-	pm_message_t pms = {.event = PM_EVENT_SUSPEND, };
-	emi_pm_state(pms);
-	clk_pm_state(pms);
-	sysconf_pm_state(pms);
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
+#ifdef CONFIG_PM_DEBUG
+	if (state = PM_SUSPEND_STANDBY) {
 		stx7111_wrt_table[0] = /* swith config */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_CLKOPSRC_SWITCH_CFG(0));
 		stx7111_wrt_table[1] = /* clk_STNoc_ic */
 		    ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(0));
 		stx7111_wrt_table[2] = /* clk_ic_if_100 */
 		    ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(5));
-		ret = 0;
-	break;
-	case PM_SUSPEND_MEM:
+	} else
+#endif
+	{
 		stx7111_wrt_table[0] = /* swith config */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_CLKOPSRC_SWITCH_CFG(0));
 		stx7111_wrt_table[1] = /* swith config 1 */
@@ -156,33 +161,7 @@ static int stx7111_suspend_prepare(suspend_state_t state)
 		    ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(5));
 		stx7111_wrt_table[4] = /* clk_ic_if_200 */
 		    ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(17));
-		ret = 0;
-		break;
 	}
-	return ret;
-}
-
-static int stx7111_suspend_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		return 1;
-	};
-	return 0;
-}
-
-/*
- * The xxxx_finish function is called after the resume
- * sysdev devices (i.e.: timer, cpufreq)
- * But it isn't a big issue in our platform
- */
-static int stx7111_suspend_finish(suspend_state_t state)
-{
-	pm_message_t pms = {.event = PM_EVENT_ON, };
-	sysconf_pm_state(pms);
-	clk_pm_state(pms);
-	emi_pm_state(pms);
 	return 0;
 }
 
@@ -195,31 +174,30 @@ static int stx7111_evttoirq(unsigned long evt)
 	return evt2irq(evt);
 }
 
-int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
+static struct sh4_suspend_t st40data __cacheline_aligned = {
+	.iobase = stx7111_iomem,
+	.ops.prepare = stx7111_suspend_prepare,
+	.evt_to_irq = stx7111_evttoirq,
+#ifdef CONFIG_PM_DEBUG
+	.stby_tbl = (unsigned long)stx7111_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx7111_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+#endif
+	.mem_tbl = (unsigned long)stx7111_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx7111_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+	.wrt_tbl = (unsigned long)stx7111_wrt_table,
+	.wrt_size = DIV_ROUND_UP(ARRAY_SIZE(stx7111_wrt_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init suspend_platform_setup()
 {
 	struct sysconf_field* sc;
 #ifdef CONFIG_PM_DEBUG
 /* route the sh4/2 clock frequenfy */
 	iowrite32(0xc, CLOCKGENA_BASE_ADDR + CKGA_CLKOBS_MUX1_CFG);
 #endif
-	st40data->iobase = stx7111_iomem;
-	st40data->ops.valid = stx7111_suspend_valid;
-	st40data->ops.finish = stx7111_suspend_finish;
-	st40data->ops.prepare = stx7111_suspend_prepare;
-
-	st40data->evt_to_irq = stx7111_evttoirq;
-
-	st40data->stby_tbl = (unsigned long)stx7111_standby_table;
-	st40data->stby_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7111_standby_table)*sizeof(long), L1_CACHE_BYTES);
-
-	st40data->mem_tbl = (unsigned long)stx7111_mem_table;
-	st40data->mem_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7111_mem_table)*sizeof(long), L1_CACHE_BYTES);
-
-	st40data->wrt_tbl = (unsigned long)stx7111_wrt_table;
-	st40data->wrt_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7111_wrt_table)*sizeof(long), L1_CACHE_BYTES);
 
 	sc = sysconf_claim(SYS_CFG, 38, 20, 20, "pm");
 	stx7111_wrt_table[_SYS_CFG38]      = (unsigned long)sysconf_address(sc);
@@ -233,5 +211,11 @@ int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
 	stx7111_wrt_table[_SYS_STA4]      = (unsigned long)sysconf_address(sc);
 	stx7111_wrt_table[_SYS_STA4_MASK] = sysconf_mask(sc);
 
-	return 0;
+	sc = sysconf_claim(SYS_STA, 3, 0, 0, "pm");
+	stx7111_wrt_table[_SYS_STA3] = (unsigned long)sysconf_address(sc);
+	stx7111_wrt_table[_SYS_STA3_MASK] = sysconf_mask(sc);
+	stx7111_wrt_table[_SYS_STA3_VALUE] = 0;
+	return sh4_suspend_register(&st40data);
 }
+
+late_initcall(suspend_platform_setup);
diff --git a/arch/sh/kernel/cpu/sh4/suspend-stx7141.c b/arch/sh/kernel/cpu/sh4/suspend-stx7141.c
index f2d131c..3dffc3a 100644
--- a/arch/sh/kernel/cpu/sh4/suspend-stx7141.c
+++ b/arch/sh/kernel/cpu/sh4/suspend-stx7141.c
@@ -31,6 +31,10 @@
 
 #define _SYS_STA4		(7)
 #define _SYS_STA4_MASK		(8)
+#define _SYS_STA3		(11)
+#define _SYS_STA3_MASK		(12)
+#define _SYS_STA3_VALUE		(13)
+
 #define _SYS_CFG11		(9)
 #define _SYS_CFG11_MASK		(10)
 #define _SYS_CFG38		(5)
@@ -40,6 +44,7 @@
  * STANDBY INSTRUCTION TABLE
  * *************************
  */
+#ifdef CONFIG_PM_DEBUG
 static unsigned long stx7141_standby_table[] __cacheline_aligned = {
 IMMEDIATE_DEST(0x1f),
 /* reduces the st40 frequency */
@@ -63,6 +68,7 @@ CLK_STORE(CKGA_OSC_DIV_CFG(10)),
  /* END. */
 _END()
 };
+#endif
 
 /* *********************
  * MEM INSTRUCTION TABLE
@@ -96,8 +102,15 @@ _END(),
 
 /* Turn-on the PLLs */
 CLK_AND_LONG(CKGA_POWER_CFG, ~3),
+/* Wait PLLs lock */
+CLK_WHILE_NEQ(CKGA_PLL0_CFG, CKGA_PLL0_CFG_LOCK, CKGA_PLL0_CFG_LOCK),
+CLK_WHILE_NEQ(CKGA_PLL1_CFG, CKGA_PLL1_CFG_LOCK, CKGA_PLL1_CFG_LOCK),
+
 /* 1. Turn-on the LMI ClocksGenD */
 DATA_AND_NOT_LONG(_SYS_CFG11, _SYS_CFG11_MASK),
+/* Wait LMI ClocksGenD lock */
+DATA_WHILE_NEQ(_SYS_STA3, _SYS_STA3_MASK, _SYS_STA3_VALUE),
+
 /* 2. Disables the DDR self refresh mode */
 DATA_AND_NOT_LONG(_SYS_CFG38, _SYS_CFG38_MASK),
 /* waits until the ack bit is zero */
@@ -126,23 +139,17 @@ static unsigned long stx7141_wrt_table[16] __cacheline_aligned;
 
 static int stx7141_suspend_prepare(suspend_state_t state)
 {
-	int ret = -EINVAL;
-	pm_message_t pms = {.event = PM_EVENT_SUSPEND, };
-	emi_pm_state(pms);
-	clk_pm_state(pms);
-	sysconf_pm_state(pms);
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
+#ifdef CONFIG_PM_DEBUG
+	if (state = PM_SUSPEND_STANDBY) {
 		stx7141_wrt_table[0] = /* swith config */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_CLKOPSRC_SWITCH_CFG(0));
 		stx7141_wrt_table[1] = /* clk_ic */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(0));
 		stx7141_wrt_table[2] = /* clk_ic_if_100 */
 		    ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(10));
-		ret = 0;
-		break;
-	case PM_SUSPEND_MEM:
+	} else
+#endif
+	{
 		stx7141_wrt_table[0] = /* swith config */
 		   ioread32(CLOCKGENA_BASE_ADDR + CKGA_CLKOPSRC_SWITCH_CFG(0));
 		stx7141_wrt_table[1] = /* swith config */
@@ -153,33 +160,7 @@ static int stx7141_suspend_prepare(suspend_state_t state)
 		    ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(10));
 		stx7141_wrt_table[4] = /* clk_ic_if_200 */
 		    ioread32(CLOCKGENA_BASE_ADDR + CKGA_OSC_DIV_CFG(17));
-		ret = 0;
-		break;
 	}
-	return ret;
-}
-
-static int stx7141_suspend_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		return 1;
-	};
-	return 0;
-}
-
-/*
- * The xxxx_finish function is called after the resume
- * sysdev devices (i.e.: timer, cpufreq)
- * But it isn't a big issue in our platform
- */
-static int stx7141_suspend_finish(suspend_state_t state)
-{
-	pm_message_t pms = {.event = PM_EVENT_ON, };
-	sysconf_pm_state(pms);
-	clk_pm_state(pms);
-	emi_pm_state(pms);
 	return 0;
 }
 
@@ -189,10 +170,27 @@ static unsigned long stx7141_iomem[2] __cacheline_aligned = {
 
 static int stx7141_evttoirq(unsigned long evt)
 {
-	return ilc2irq(evt);
+	return ((evt < 0x400) ? ilc2irq(evt) : evt2irq(evt));
 }
 
-int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
+static struct sh4_suspend_t st40data __cacheline_aligned = {
+	.iobase = stx7141_iomem,
+	.ops.prepare = stx7141_suspend_prepare,
+	.evt_to_irq = stx7141_evttoirq,
+#ifdef CONFIG_PM_DEBUG
+	.stby_tbl = (unsigned long)stx7141_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx7141_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+#endif
+	.mem_tbl = (unsigned long)stx7141_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx7141_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+	.wrt_tbl = (unsigned long)stx7141_wrt_table,
+	.wrt_size = DIV_ROUND_UP(ARRAY_SIZE(stx7141_wrt_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init suspend_platform_setup()
 {
 	struct sysconf_field *sc;
 #ifdef CONFIG_PM_DEBUG
@@ -202,24 +200,6 @@ int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
 	sc = sysconf_claim(SYS_CFG, 19, 22, 23, "clkA dbg");
 	sysconf_write(sc, 11);
 #endif
-	st40data->iobase = stx7141_iomem;
-	st40data->ops.valid = stx7141_suspend_valid;
-	st40data->ops.finish = stx7141_suspend_finish;
-	st40data->ops.prepare = stx7141_suspend_prepare;
-
-	st40data->evt_to_irq = stx7141_evttoirq;
-
-	st40data->stby_tbl = (unsigned long)stx7141_standby_table;
-	st40data->stby_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7141_standby_table)*sizeof(long), L1_CACHE_BYTES);
-
-	st40data->mem_tbl = (unsigned long)stx7141_mem_table;
-	st40data->mem_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7141_mem_table)*sizeof(long), L1_CACHE_BYTES);
-
-	st40data->wrt_tbl = (unsigned long)stx7141_wrt_table;
-        st40data->wrt_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7141_wrt_table) * sizeof(long), L1_CACHE_BYTES);
 
 	sc = sysconf_claim(SYS_CFG, 38, 20, 20, "pm");
 	stx7141_wrt_table[_SYS_CFG38]      = (unsigned long)sysconf_address(sc);
@@ -233,5 +213,11 @@ int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
 	stx7141_wrt_table[_SYS_STA4]      = (unsigned long)sysconf_address(sc);
 	stx7141_wrt_table[_SYS_STA4_MASK] = sysconf_mask(sc);
 
-	return 0;
+	sc = sysconf_claim(SYS_STA, 3, 0, 0, "pm");
+	stx7141_wrt_table[_SYS_STA3] = (unsigned long)sysconf_address(sc);
+	stx7141_wrt_table[_SYS_STA3_MASK] = sysconf_mask(sc);
+	stx7141_wrt_table[_SYS_STA3_VALUE] = 0;
+	return sh4_suspend_register(&st40data);
 }
+
+late_initcall(suspend_platform_setup);
diff --git a/arch/sh/kernel/cpu/sh4/suspend-stx7200.c b/arch/sh/kernel/cpu/sh4/suspend-stx7200.c
index 320b660..23201b1 100644
--- a/arch/sh/kernel/cpu/sh4/suspend-stx7200.c
+++ b/arch/sh/kernel/cpu/sh4/suspend-stx7200.c
@@ -40,6 +40,7 @@
  * STANDBY INSTRUCTION TABLE
  * *************************
  */
+#ifdef CONFIG_PM_DEBUG
 static unsigned long stx7200_standby_table[] __cacheline_aligned = {
 /* Down scale the GenA.Pll0 and GenA.Pll2*/
 CLK_OR_LONG(CLKA_PLL0, CLKA_PLL0_BYPASS),
@@ -79,6 +80,8 @@ _OR(),
 CLK_STORE(CLKA_PLL2),
 #endif
 CLK_AND_LONG(CLKA_PWR_CFG, ~(PWR_CFG_PLL0_OFF | PWR_CFG_PLL2_OFF)),
+CLK_WHILE_NEQ(CLKA_PLL0, CLKA_PLL0_LOCK, CLKA_PLL0_LOCK),
+CLK_WHILE_NEQ(CLKA_PLL2, CLKA_PLL2_LOCK, CLKA_PLL2_LOCK),
 CLK_AND_LONG(CLKA_PLL0, ~(CLKA_PLL0_BYPASS)),
 CLK_AND_LONG(CLKA_PLL2, ~(CLKA_PLL2_BYPASS)),
 
@@ -86,6 +89,7 @@ _DELAY(),
 /* END. */
 _END()
 };
+#endif
 
 /* *********************
  * MEM INSTRUCTION TABLE
@@ -118,6 +122,10 @@ CLK_OR_LONG(CLKA_PLL2, CLKA_PLL2_SUSPEND),
 
 CLK_AND_LONG(CLKA_PWR_CFG, ~(PWR_CFG_PLL0_OFF | PWR_CFG_PLL1_OFF | PWR_CFG_PLL2_OFF)),
 
+CLK_WHILE_NEQ(CLKA_PLL0, CLKA_PLL0_LOCK, CLKA_PLL0_LOCK),
+CLK_WHILE_NEQ(CLKA_PLL1, CLKA_PLL1_LOCK, CLKA_PLL1_LOCK),
+CLK_WHILE_NEQ(CLKA_PLL2, CLKA_PLL2_LOCK, CLKA_PLL2_LOCK),
+
 CLK_AND_LONG(CLKA_PLL0, ~(CLKA_PLL0_BYPASS)),
 CLK_AND_LONG(CLKA_PLL1, ~(CLKA_PLL1_BYPASS)),
 CLK_AND_LONG(CLKA_PLL2, ~(CLKA_PLL2_BYPASS)),
@@ -149,6 +157,10 @@ _OR(),
 CLK_STORE(CLKA_PLL2),
 #endif
 CLK_AND_LONG(CLKA_PWR_CFG, ~(PWR_CFG_PLL0_OFF | PWR_CFG_PLL1_OFF | PWR_CFG_PLL2_OFF)),
+/* Wait PLLs lock */
+CLK_WHILE_NEQ(CLKA_PLL0, CLKA_PLL0_LOCK, CLKA_PLL0_LOCK),
+CLK_WHILE_NEQ(CLKA_PLL1, CLKA_PLL1_LOCK, CLKA_PLL1_LOCK),
+CLK_WHILE_NEQ(CLKA_PLL2, CLKA_PLL2_LOCK, CLKA_PLL2_LOCK),
 
 CLK_AND_LONG(CLKA_PLL0, ~(CLKA_PLL0_BYPASS)),
 CLK_AND_LONG(CLKA_PLL1, ~(CLKA_PLL1_BYPASS)),
@@ -172,53 +184,25 @@ static unsigned long stx7200_wrt_table[16] __cacheline_aligned;
 
 static int stx7200_suspend_prepare(suspend_state_t state)
 {
-	pm_message_t pm = {.event = PM_EVENT_SUSPEND, };
-	emi_pm_state(pm);
-	clk_pm_state(pm);
-	sysconf_pm_state(pm);
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
+#ifdef CONFIG_PM_DEBUG
+	if (state = PM_SUSPEND_STANDBY) {
 		stx7200_wrt_table[0]  			readl(CLOCKGEN_BASE_ADDR + CLKA_PLL0) & 0x7ffff;
 		stx7200_wrt_table[1]  			readl(CLOCKGEN_BASE_ADDR + CLKA_PLL2) & 0x7ffff;
-		return 0;
-	case PM_SUSPEND_MEM:
+	} else
+#endif
+	{
 		stx7200_wrt_table[0]  			readl(CLOCKGEN_BASE_ADDR + CLKA_PLL0) & 0x7ffff;
 		stx7200_wrt_table[1]  			readl(CLOCKGEN_BASE_ADDR + CLKA_PLL1) & 0x7ffff;
 		stx7200_wrt_table[2]  			readl(CLOCKGEN_BASE_ADDR + CLKA_PLL2) & 0x7ffff;
-	   return 0;
 	}
-	return -EINVAL;
-}
-
-static int stx7200_suspend_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		return 1;
-	};
 	return 0;
 }
 
-/*
- * The xxxx_finish function is called after the resume
- * sysdev devices (i.e.: timer, cpufreq)
- * But it isn't a big issue in our platform
- */
-static int stx7200_suspend_finish(suspend_state_t state)
-{
-	pm_message_t pm = {.event = PM_EVENT_ON, };
-	sysconf_pm_state(pm);
-	clk_pm_state(pm);
-	emi_pm_state(pm);
-	return 0;
-}
 
 static unsigned long stx7200_iomem[2] __cacheline_aligned = {
 		stx7200_wrt_table,	/* To access Sysconf    */
@@ -226,32 +210,30 @@ static unsigned long stx7200_iomem[2] __cacheline_aligned = {
 
 static int stx7200_evttoirq(unsigned long evt)
 {
-	return ilc2irq(evt);
+	return ((evt < 0x400) ? ilc2irq(evt) : evt2irq(evt));
 }
 
-int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
+static struct sh4_suspend_t st40data __cacheline_aligned = {
+	.iobase = stx7200_iomem,
+	.ops.prepare = stx7200_suspend_prepare,
+	.evt_to_irq = stx7200_evttoirq,
+#ifdef CONFIG_PM_DEBUG
+	.stby_tbl = (unsigned long)stx7200_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx7200_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+#endif
+	.mem_tbl = (unsigned long)stx7200_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx7200_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+	.wrt_tbl = (unsigned long)stx7200_wrt_table,
+	.wrt_size = DIV_ROUND_UP(ARRAY_SIZE(stx7200_wrt_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init suspend_platform_setup()
 {
 	struct sysconf_field* sc;
 
-	st40data->iobase = stx7200_iomem;
-	st40data->ops.valid = stx7200_suspend_valid;
-	st40data->ops.finish = stx7200_suspend_finish;
-	st40data->ops.prepare = stx7200_suspend_prepare;
-
-	st40data->evt_to_irq = stx7200_evttoirq;
-
-	st40data->stby_tbl = (unsigned long)stx7200_standby_table;
-	st40data->stby_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7200_standby_table)*sizeof(long), L1_CACHE_BYTES);
-
-	st40data->mem_tbl = (unsigned long)stx7200_mem_table;
-	st40data->mem_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7200_mem_table)*sizeof(long), L1_CACHE_BYTES);
-
-	st40data->wrt_tbl = (unsigned long)stx7200_wrt_table;
-	st40data->wrt_size = DIV_ROUND_UP(
-		ARRAY_SIZE(stx7200_wrt_table) * sizeof(long), L1_CACHE_BYTES);
-
 	sc = sysconf_claim(SYS_STA, 4, 0, 0, "pm");
 	stx7200_wrt_table[_SYS_STA4] = (unsigned long)sysconf_address(sc);
 	stx7200_wrt_table[_SYS_STA4_MASK] = sysconf_mask(sc);
@@ -272,5 +254,7 @@ int __init suspend_platform_setup(struct sh4_suspend_t *st40data)
 	ctrl_outl(0xc, CKGA_CLKOUT_SEL +
 		CLOCKGEN_BASE_ADDR); /* sh4:2 routed on SYSCLK_OUT */
 #endif
-	return 0;
+	return sh4_suspend_register(&st40data);
 }
+
+late_initcall(suspend_platform_setup);
-- 
1.6.0.6

