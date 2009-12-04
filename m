From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:51 +0000
Subject: [PATCH (sh-2.6.30.y) 09/13] stm: pm: Add suspend support to the stx7200
Message-Id: <1259938375-27499-9-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds the standby support to the stx7200
The memstandby currently doesn't work

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/cpu/sh4/clock-stx7200.c |   19 ++--
 arch/sh/kernel/pm/suspend-stx7200.c    |  178 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/pm/suspend-stx7200_t.S  |   84 +++++++++++++++
 include/linux/stm/stx7200.h            |   16 +++
 4 files changed, 289 insertions(+), 8 deletions(-)
 create mode 100644 arch/sh/kernel/pm/suspend-stx7200.c
 create mode 100644 arch/sh/kernel/pm/suspend-stx7200_t.S

diff --git a/arch/sh/kernel/cpu/sh4/clock-stx7200.c b/arch/sh/kernel/cpu/sh4/clock-stx7200.c
index 4aed957..7c2b289 100644
--- a/arch/sh/kernel/cpu/sh4/clock-stx7200.c
+++ b/arch/sh/kernel/cpu/sh4/clock-stx7200.c
@@ -12,29 +12,32 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/stm/stx7200.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 #include <asm/io.h>
 
-#include "./clock-common.h"
-#include "./soc-stx7200.h"
+#include "clock-common.h"
+
+#define SYSACLKIN	27000000
+#define SYSBCLKIN	30000000
 
 /* Alternate clock for clockgen A, B and C respectivly */
 /* B & C come from SYSCLKINALT pin, SYSCLKINALT2 from PIO2[2] */
 unsigned long sysclkinalt[3] = { 0,0,0};
 
-#define CLOCKGEN_PLL_CFG(pll)	(CLOCKGEN_BASE_ADDR + ((pll)*0x4))
+#define CLOCKGEN_PLL_CFG(pll)	(CLOCKGENA_BASE_ADDR + ((pll)*0x4))
 #define   CLOCKGEN_PLL_CFG_BYPASS		(1<<20)
-#define CLOCKGEN_MUX_CFG	(CLOCKGEN_BASE_ADDR + 0x0c)
+#define CLOCKGEN_MUX_CFG	(CLOCKGENA_BASE_ADDR + 0x0c)
 #define   CLOCKGEN_MUX_CFG_SYSCLK_SRC		(1<<0)
 #define   CLOCKGEN_MUX_CFG_PLL_SRC(pll)		(1<<((pll)+1))
 #define   CLOCKGEN_MUX_CFG_DIV_SRC(pll)		(1<<((pll)+4))
 #define   CLOCKGEN_MUX_CFG_FDMA_SRC(fdma)	(1<<((fdma)+7))
 #define   CLOCKGEN_MUX_CFG_IC_REG_SRC		(1<<9)
-#define CLOCKGEN_DIV_CFG	(CLOCKGEN_BASE_ADDR + 0x10)
-#define CLOCKGEN_DIV2_CFG	(CLOCKGEN_BASE_ADDR + 0x14)
-#define CLOCKGEN_CLKOBS_MUX_CFG	(CLOCKGEN_BASE_ADDR + 0x18)
-#define CLOCKGEN_POWER_CFG	(CLOCKGEN_BASE_ADDR + 0x1c)
+#define CLOCKGEN_DIV_CFG	(CLOCKGENA_BASE_ADDR + 0x10)
+#define CLOCKGEN_DIV2_CFG	(CLOCKGENA_BASE_ADDR + 0x14)
+#define CLOCKGEN_CLKOBS_MUX_CFG	(CLOCKGENA_BASE_ADDR + 0x18)
+#define CLOCKGEN_POWER_CFG	(CLOCKGENA_BASE_ADDR + 0x1c)
 
 #define CLOCKGENB_PLL0_CFG	(CLOCKGENB_BASE_ADDR + 0x3c)
 #define CLOCKGENB_IN_MUX_CFG	(CLOCKGENB_BASE_ADDR + 0x44)
diff --git a/arch/sh/kernel/pm/suspend-stx7200.c b/arch/sh/kernel/pm/suspend-stx7200.c
new file mode 100644
index 0000000..d31c67c
--- /dev/null
+++ b/arch/sh/kernel/pm/suspend-stx7200.c
@@ -0,0 +1,178 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/pm/suspend-stx7200.c
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
+#include <linux/delay.h>
+#include <linux/irqflags.h>
+#include <linux/stm/sysconf.h>
+#include <linux/stm/stx7200.h>
+#include <linux/io.h>
+
+#include <asm/system.h>
+#include <asm/irq-ilc.h>
+
+#include "stm_suspend.h"
+
+#define SYSCONF(x)	(SYSCONF_BASE_ADDR + 0x100 + (x) * 0x4)
+#define SYSSTA(x)	(SYSCONF_BASE_ADDR + (x) * 0x4)
+#define CGA	CLOCKGENA_BASE_ADDR
+#define CGB	CLOCKGENB_BASE_ADDR
+
+#define CPRC		0xffc00000
+#define  CPRC_STBCR	(CPRC + 0x04)
+#define  CPRC_STBCR2	(CPRC + 0x10)
+/* *************************
+ * STANDBY INSTRUCTION TABLE
+ * *************************
+ */
+static unsigned long stx7200_standby_table[] __cacheline_aligned = {
+/* ClockGen_B.PLL management */
+OR32(CGB + CLKB_PLL0_CFG, CLKB_PLL0_BYPASS),	/* enable bypass */
+OR32(CGB + CLKB_PWR_CFG, CLKB_PLL0_OFF),	/* turn off */
+/* Down scale the GenA.Pll0 and GenA.Pll2*/
+OR32(CGA + CLKA_PLL(0), CLKA_PLL_BYPASS),
+OR32(CGA + CLKA_PLL(2), CLKA_PLL_BYPASS),
+OR32(CGA + CLKA_PWR_CFG, 5),
+
+END_MARKER,
+
+UPDATE32(CGA + CLKA_PWR_CFG, ~5, 0),
+WHILE_NE32(CGA + CLKA_PLL(0), CLKA_PLL_LOCK, CLKA_PLL_LOCK),
+WHILE_NE32(CGA + CLKA_PLL(2), CLKA_PLL_LOCK, CLKA_PLL_LOCK),
+
+UPDATE32(CGA + CLKA_PLL(0), ~CLKA_PLL_BYPASS, 0),
+UPDATE32(CGA + CLKA_PLL(2), ~CLKA_PLL_BYPASS, 0),
+
+/*
+ * Reprogram the ClockGen_B.PLL
+ */
+UPDATE32(CGB + CLKB_PWR_CFG, ~CLKB_PLL0_OFF, 0),	/* turn on */
+POKE32(CGB + CLKB_PLL0_CFG, 0x2803 | CLKB_PLL0_BYPASS),
+WHILE_NE32(CGB + CLKB_PLL0_CFG, CLKB_PLL0_LOCK, CLKB_PLL0_LOCK),
+UPDATE32(CGB + CLKB_PLL0_CFG, ~CLKB_PLL0_BYPASS, 0),
+END_MARKER
+};
+
+/* *********************
+ * MEM INSTRUCTION TABLE
+ * *********************
+ */
+
+static unsigned long stx7200_mem_table[] __cacheline_aligned = {
+
+/* 1. Enables the DDR self refresh mode */
+OR32(SYSCONF(38), 1 << 20),
+WHILE_NE32(SYSSTA(4), 1, 1),
+OR32(SYSCONF(39), 1 << 20),
+WHILE_NE32(SYSSTA(6), 1, 1),
+
+DELAY(10),
+
+/* ClockGen_B.PLL management */
+OR32(CGB + CLKB_PLL0_CFG, CLKB_PLL0_BYPASS),	/* enable bypass */
+OR32(CGB + CLKB_PWR_CFG, CLKB_PLL0_OFF),	/* turn off */
+#if 0
+UPDATE32(SYSCONF(11), ~1, 0),
+UPDATE32(SYSCONF(15), ~1, 0),
+
+OR32(SYSCONF(11), 1 << 12),
+#endif
+/* 2. Down scale the GenA.Pll0, GenA.Pll1 and GenA.Pll2*/
+OR32(CGA + CLKA_PLL(0), CLKA_PLL_BYPASS),
+OR32(CGA + CLKA_PLL(1), CLKA_PLL_BYPASS),
+OR32(CGA + CLKA_PLL(2), CLKA_PLL_BYPASS),
+
+OR32(CGA + CLKA_PWR_CFG, 7),
+OR32(SYSCONF(22), 1), /* global power down */
+POKE8(CPRC_STBCR, 0x80),
+END_MARKER,
+/*
+ * Reprogram the ClockGen_B.PLL
+ */
+UPDATE32(CGB + CLKB_PWR_CFG, ~CLKB_PLL0_OFF, 0),	/* turn on */
+POKE32(CGB + CLKB_PLL0_CFG, 0x2803 | CLKB_PLL0_BYPASS),
+WHILE_NE32(CGB + CLKB_PLL0_CFG, CLKB_PLL0_LOCK, CLKB_PLL0_LOCK),
+UPDATE32(CGB + CLKB_PLL0_CFG, ~CLKB_PLL0_BYPASS, 0),
+/*
+ * Turn on ClockGen_A.PLLs
+ */
+UPDATE32(CGA + CLKA_PWR_CFG, ~7, 0),
+WHILE_NE32(CGA + CLKA_PLL(0), CLKA_PLL_LOCK, CLKA_PLL_LOCK),
+WHILE_NE32(CGA + CLKA_PLL(1), CLKA_PLL_LOCK, CLKA_PLL_LOCK),
+WHILE_NE32(CGA + CLKA_PLL(2), CLKA_PLL_LOCK, CLKA_PLL_LOCK),
+
+UPDATE32(CGA + CLKA_PLL(0), ~CLKA_PLL_BYPASS, 0),
+UPDATE32(CGA + CLKA_PLL(1), ~CLKA_PLL_BYPASS, 0),
+UPDATE32(CGA + CLKA_PLL(2), ~CLKA_PLL_BYPASS, 0),
+
+DELAY(100),
+UPDATE32(SYSCONF(38), ~(1 << 20), 0),
+WHILE_NE32(SYSSTA(4), 1, 0),
+UPDATE32(SYSCONF(39), ~(1 << 20), 0),
+WHILE_NE32(SYSSTA(6), 1, 0),
+
+DELAY(100),
+END_MARKER,
+};
+
+static int stx7200_evttoirq(unsigned long evt)
+{
+	return ((evt < 0x400) ? ilc2irq(evt) : evt2irq(evt));
+}
+
+static struct stm_suspend_t soc_suspend __cacheline_aligned = {
+	.evt_to_irq = stx7200_evttoirq,
+
+	.stby_tbl = (unsigned long)stx7200_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx7200_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+
+	.mem_tbl = (unsigned long)stx7200_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx7200_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init stx7200_suspend_setup(void)
+{
+	struct sysconf_field *sc[4];
+	int i;
+
+	sc[0] = sysconf_claim(SYS_STA, 4, 0, 0, "pm");
+	sc[1] = sysconf_claim(SYS_STA, 6, 0, 0, "pm");
+	sc[2] = sysconf_claim(SYS_CFG, 38, 20, 20, "pm");
+	sc[3] = sysconf_claim(SYS_CFG, 39, 20, 20, "pm");
+
+#ifdef CONFIG_PM_DEBUG
+	ctrl_outl(0xc, CLKA_CLKOUT_SEL +
+		CLOCKGENA_BASE_ADDR); /* sh4:2 routed on SYSCLK_OUT */
+#endif
+
+	for (i = 0; i < 4; ++i)
+		if (!sc[i])
+			goto error;
+
+	return stm_suspend_register(&soc_suspend);
+
+error:
+	printk(KERN_ERR "[STM][PM]: Some sysconf is already required\n");
+	printk(KERN_ERR "[STM][PM]: the PM will not be registered\n");
+	for (i = 0; i < 4; ++i)
+		if (sc[i])
+			sysconf_release(sc[i]);
+
+	return -EINVAL;
+}
+
+late_initcall(stx7200_suspend_setup);
diff --git a/arch/sh/kernel/pm/suspend-stx7200_t.S b/arch/sh/kernel/pm/suspend-stx7200_t.S
new file mode 100644
index 0000000..12e4093
--- /dev/null
+++ b/arch/sh/kernel/pm/suspend-stx7200_t.S
@@ -0,0 +1,84 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/cpu/sh4/suspend-stx7200_t.S
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2009  STMicroelectronics
+ * Author: Francesco M. Virlinzi  <francesco.virlinzi@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License V.2 ONLY.  See linux/COPYING for more information.
+ *
+ * ------------------------------------------------------------------------- */
+
+#include "soc-stx7200.h"
+#include "stm_suspend.h"
+
+#define CGA	CLOCKGENA_BASE_ADDR
+
+.text
+.balign 32
+.global stx7200_mem_table
+stx7200_mem_table:
+
+!OR32(SYSCONF(38), 1 << 20)	! DDR in self refresh
+!WHILE_NE32(SYSSTA(4), 1, 1)
+
+!OR32(SYSCONF(39), 1 << 20)	! DDR in self refresh
+!WHILE_NE32(SYSSTA(6), 1, 1)
+
+!UPDATE32(SYSCONF(11), ~1 , 0x0)
+!UPDATE32(SYSCONF(15), ~1 , 0x0)
+
+!OR32(SYSCONF(11), 1 << 12)	! Turn-off LMI.PLL
+!DELAY(200)
+
+OR32(CGA + CLKA_PLL(0), CLKA_PLL_BYPASS)
+!OR32(CGA + CLKA_PLL(1), CLKA_PLL_BYPASS)
+OR32(CGA + CLKA_PLL(2), CLKA_PLL_BYPASS)
+
+OR32(CGA + CLKA_PWR_CFG, PLL_PWR_OFF(0) | PLL_PWR_OFF(2))
+END_MARKER
+
+UPDATE32(CGA + CLKA_PWR_CFG, ~(PLL_PWR_OFF(0) | PLL_PWR_OFF(2)), 0x0)
+
+WHILE_NE32(CGA + CLKA_PLL(0), CLKA_PLL_LOCK, CLKA_PLL_LOCK)
+!WHILE_NE32(CGA + CLKA_PLL(1), CLKA_PLL_LOCK, CLKA_PLL_LOCK)
+WHILE_NE32(CGA + CLKA_PLL(2), CLKA_PLL_LOCK, CLKA_PLL_LOCK)
+
+UPDATE32(CGA + CLKA_PLL(0), ~CLKA_PLL_BYPASS, 0x0)
+!UPDATE32(CGA + CLKA_PLL(1), ~CLKA_PLL_BYPASS, 0x0)
+UPDATE32(CGA + CLKA_PLL(2), ~CLKA_PLL_BYPASS, 0x0)
+!DELAY(200)
+
+!.long OP_ELSE; 1: ; .long 2f - .
+!UPDATE32(SYSCONF(11), ~(1 << 12), 0x0)	! Turn-on LMI.PLL
+!ENDIF(2)
+!.long OP_IF_EQ32, SYSCONF(11), (1 << 12), 0x0, (1b - .)
+
+!DELAY(200)
+!.long OP_ELSE; 1: ; .long 2f - .
+!OR32(SYSCONF(11), 1)
+!ENDIF(2)
+!.long OP_IF_EQ32, SYSCONF(11), 1, 1, (1b - .)
+
+!.long OP_ELSE; 1: ; .long 2f - .
+!OR32(SYSCONF(15), 1)
+!ENDIF(2)
+!.long OP_IF_EQ32, SYSCONF(15), 1, 1, (1b - .)
+!DELAY(200)
+
+!.long OP_ELSE; 1: ; .long 2f - .
+!ENDIF(2)
+!UPDATE32(SYSCONF(38), ~(1 << 20), 0x0)
+!.long OP_IF_EQ32, SYSCONF(38), (1 << 20), 0x0, (1b - .)
+!WHILE_NE32(SYSSTA(4), 1, 0x0)
+
+!UPDATE32(SYSCONF(39), ~(1 << 20), 0x0)
+!WHILE_NE32(SYSSTA(6), 1, 0x0)
+
+DELAY(500)
+END_MARKER
+
+.global stx7200_mem_tbl_size
+stx7200_mem_tbl_size:
+.long . - stx7200_mem_table
diff --git a/include/linux/stm/stx7200.h b/include/linux/stm/stx7200.h
index d2dabfc..2ea37d5 100644
--- a/include/linux/stm/stx7200.h
+++ b/include/linux/stm/stx7200.h
@@ -91,5 +91,21 @@ struct stx7200_audio_config {
 };
 void stx7200_configure_audio(struct stx7200_audio_config *config);
 
+#define SYSCONF_BASE_ADDR		0xFD704000
+#define CLOCKGENA_BASE_ADDR		0xFD700000      /* Clockgen A */
+#define CLOCKGENB_BASE_ADDR		0xFD701000      /* Clockgen B */
+
+#define CLKA_PLL(x)			(4 * (x))
+#define   CLKA_PLL_BYPASS		(1 << 20)
+#define   CLKA_PLL_LOCK			(1 << 31)
+#define CLKA_CLKOUT_SEL			0x18
+#define CLKA_PWR_CFG			0x1C
+
+#define CLKB_PLL0_CFG			0x3C
+#define   CLKB_PLL0_LOCK		(1 << 31)
+#define   CLKB_PLL0_BYPASS		(1 << 20)
+#define   CLKB_PLL0_LOCK                (1 << 31)
+#define CLKB_PWR_CFG			0x58
+#define   CLKB_PLL0_OFF			(1 << 15)
 
 #endif
-- 
1.6.2.5

