From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:47 +0000
Subject: [PATCH (sh-2.6.30.y) 05/13] stm: pm: Add suspend support to the stx7100
Message-Id: <1259938375-27499-5-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/cpu/sh4/clock-stx7100.c |    6 +-
 arch/sh/kernel/pm/suspend-stx7100.c    |  178 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/pm/suspend-stx7100_t.S  |  165 +++++++++++++++++++++++++++++
 include/linux/stm/stx7100.h            |   43 ++++++++
 4 files changed, 389 insertions(+), 3 deletions(-)
 create mode 100644 arch/sh/kernel/pm/suspend-stx7100.c
 create mode 100644 arch/sh/kernel/pm/suspend-stx7100_t.S

diff --git a/arch/sh/kernel/cpu/sh4/clock-stx7100.c b/arch/sh/kernel/cpu/sh4/clock-stx7100.c
index 0280e9c..493884d 100644
--- a/arch/sh/kernel/cpu/sh4/clock-stx7100.c
+++ b/arch/sh/kernel/cpu/sh4/clock-stx7100.c
@@ -17,8 +17,8 @@
 #include <asm/io.h>
 #include <asm-generic/div64.h>
 
-#include "./clock-common.h"
-#include "./soc-stb7100.h"
+#include <linux/stm/stx7100.h>
+#include "clock-common.h"
 
 #ifdef CONFIG_CLK_LOW_LEVEL_DEBUG
 #include <linux/stm/pio.h>
@@ -268,7 +268,7 @@ int __init clk_init(void)
 	/**************/
 	/* Clockgen A */
 	/**************/
-	clkgena_base = ioremap(CLOCKGEN_BASE_ADDR, 0x100);
+	clkgena_base = ioremap(CLOCKGENA_BASE_ADDR, 0x100);
 
 	for (i = 0; i < ARRAY_SIZE(onchip_clocks); i++) {
 		struct clk *clk = onchip_clocks[i];
diff --git a/arch/sh/kernel/pm/suspend-stx7100.c b/arch/sh/kernel/pm/suspend-stx7100.c
new file mode 100644
index 0000000..ada7620
--- /dev/null
+++ b/arch/sh/kernel/pm/suspend-stx7100.c
@@ -0,0 +1,178 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/cpu/sh4/suspend-stx7100.c
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
+#include <linux/irqflags.h>
+#include <linux/stm/sysconf.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/stm/stx7100.h>
+#include <asm/system.h>
+#include <asm/mmu.h>
+
+#include "stm_suspend.h"
+
+#define	CGA	(0xA0000000 + CLOCKGENA_BASE_ADDR)
+
+/* *************************
+ * STANDBY INSTRUCTION TABLE
+ * *************************
+ */
+static const long stx7100_standby_table[] __cacheline_aligned = {
+POKE32(CGA + CLKA_LOCK, 0xc0de),
+/* PLL0 at the minimum frequency */
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_BYPASS),
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_ENABLE, 0),
+UPDATE32(CGA + CLKA_PLL0, ~0x7ffff, CLKA_PLL0_SUSPEND),
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_ENABLE),
+WHILE_NE32(CGA + CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED),
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_BYPASS, 0),
+
+POKE32(CGA + CLKA_ST40_PER, 0x5),
+POKE32(CGA + CLKA_ST40_IC, 0x5),
+POKE32(CGA + CLKA_ST40, 0x3),
+END_MARKER,
+
+POKE32(CGA + CLKA_ST40, 0x0),
+POKE32(CGA + CLKA_ST40_IC, 0x1),
+POKE32(CGA + CLKA_ST40_PER, 0x0),
+/* PLL0 at the standard frequency */
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_BYPASS),
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_ENABLE, 0),
+UPDATE32(CGA + CLKA_PLL0, ~0x7ffff, CLKA_PLL0_RESUME),
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_ENABLE),
+WHILE_NE32(CGA + CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED),
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_BYPASS, 0),
+POKE32(CGA + CLKA_LOCK, 0x0),
+END_MARKER
+};
+
+/* *********************
+ * MEM INSTRUCTION TABLE
+ * *********************
+ */
+extern long stx7100_mem_table, stx7100_mem_tbl_size;
+/*
+ * Due to several cut version and the several external clock
+ * the mem instruncion tables needs if/else/endif instructions...
+ * impossible to write that in C-code...
+ * The mem_standby table is in a dedicated assembly file.
+ */
+#ifdef CONFIG_32BIT
+/*
+ * In 32bits all the entries mapped on the hw are invalidated
+ * to avoid multi-hit.
+ * A special entry (14 th) is created to simulate the P2 area.
+ */
+static void stx7100_support(int suspend)
+{
+	unsigned int i, tmp;
+	static int addr_14, data_14, invalidated;
+
+	if (suspend) {
+		invalidated = 0;
+		/*
+		 * Invalidate all the 0xb... entries
+		 * to avoid multi hit on the PMB
+		 */
+		for (i = 2; i < 14; ++i) {
+			tmp = ctrl_inl(PMB_ADDR | (i << PMB_E_SHIFT));
+			if ((tmp & 0xb0000000) = 0xb0000000 &&
+			     tmp & PMB_V) {
+				invalidated |= (1 << i);
+				ctrl_outl(tmp & ~PMB_V, PMB_ADDR |
+					(i << PMB_E_SHIFT));
+			}
+		}
+		addr_14 = ctrl_inl(PMB_ADDR | (14 << PMB_E_SHIFT));
+		data_14 = ctrl_inl(PMB_DATA | (14 << PMB_E_SHIFT));
+
+		/* Create an entry ad-hoc to simulate the P2 area */
+		ctrl_outl(addr_14 & ~PMB_V, PMB_ADDR | (14 << PMB_E_SHIFT));
+		ctrl_outl(0xb8000000 | PMB_V, PMB_ADDR | (14 << PMB_E_SHIFT));
+		ctrl_outl(0x18000000 | PMB_V | PMB_SZ_64M | PMB_UB | PMB_WT,
+			PMB_DATA | (14 << PMB_E_SHIFT));
+		return;
+	}
+	ctrl_outl(0, PMB_ADDR | (14 << PMB_E_SHIFT));
+	ctrl_outl(data_14, PMB_DATA | (14 << PMB_E_SHIFT));
+	ctrl_outl(addr_14, PMB_ADDR | (14 << PMB_E_SHIFT));
+	for (i = 2; i < 14; ++i)
+		if (invalidated & (1 << i)) {
+			tmp = ctrl_inl(PMB_ADDR | (i << PMB_E_SHIFT));
+			ctrl_outl(tmp | PMB_V, PMB_ADDR | (i << PMB_E_SHIFT));
+	}
+}
+
+static int stx7100_prepare_late(void)
+{
+	stx7100_support(1);
+	return 0;
+}
+
+static void stx7100_wake(void)
+{
+	stx7100_support(0);
+}
+#else
+#define stx7100_prepare_late	NULL
+#define stx7100_wake		NULL
+#endif
+
+static int stx7100_evttoirq(unsigned long evt)
+{
+	return evt2irq(evt);
+}
+
+
+static struct stm_suspend_t stx7100_suspend = {
+	.ops.prepare_late = stx7100_prepare_late,
+	.ops.wake = stx7100_wake,
+	.evt_to_irq = stx7100_evttoirq,
+
+	.stby_tbl = (long)stx7100_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx7100_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+};
+
+static int __init stx7100_suspend_setup(void)
+{
+	struct sysconf_field *sc[4];
+	int i;
+
+	stx7100_suspend.mem_tbl = (long)&stx7100_mem_table;
+	stx7100_suspend.mem_size +		DIV_ROUND_UP(stx7100_mem_tbl_size, L1_CACHE_BYTES);
+
+	sc[0] = sysconf_claim(SYS_STA, 12, 28, 28, "pm");
+	sc[1] = sysconf_claim(SYS_STA, 13, 28, 28, "pm");
+	sc[2] = sysconf_claim(SYS_CFG, 11, 28, 28, "pm");
+	sc[3] = sysconf_claim(SYS_CFG, 11, 30, 30, "pm");
+
+	for (i = 0; i < 4; ++i)
+		if (!sc[i])
+			goto error;
+
+	return stm_suspend_register(&stx7100_suspend);
+
+error:
+	printk(KERN_ERR "[STM][PM]: Some sysconf is already required\n");
+	printk(KERN_ERR "[STM][PM]: the PM will not be registered\n");
+	for (i = 0; i < 4; ++i)
+		if (sc[i])
+			sysconf_release(sc[i]);
+	return -EINVAL;
+}
+
+late_initcall(stx7100_suspend_setup);
diff --git a/arch/sh/kernel/pm/suspend-stx7100_t.S b/arch/sh/kernel/pm/suspend-stx7100_t.S
new file mode 100644
index 0000000..75773f8
--- /dev/null
+++ b/arch/sh/kernel/pm/suspend-stx7100_t.S
@@ -0,0 +1,165 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/pm/suspend-stx7100_t.c
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2009  STMicroelectronics
+ * Author: Francesco M. Virlinzi  <francesco.virlinzi@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License V.2 ONLY.  See linux/COPYING for more information.
+ *
+ * ------------------------------------------------------------------------- */
+
+#include <linux/stm/stx7100.h>
+#include "stm_suspend.h"
+
+#define	CGA	(0xA0000000 + CLOCKGENA_BASE_ADDR)
+
+#define SYSDEV(x)		(4 * (x) + 0xA0000000 + SYSCONF_BASE_ADDR)
+#define   CPU_ID		(SYSDEV(0x0))
+#define SYSSTA(x)		(0x8 + SYSDEV(x))
+#define SYSCONF(x)		(0x100 + SYSDEV(x))
+
+#define STB7100_DEVID_7100_VAL		0x024
+#define STB7100_DEVID_7109_VAL		0x02c
+#define STB7100_DEVID_ID_SHIFT		12
+#define STB7100_DEVID_ID_MASK		0x3ff
+#define STB7100_DEVID_CUT_SHIFT		28
+#define STB7100_DEVID_CUT_MASK		0xf
+#define CPU_ID_MASK  ((STB7100_DEVID_CUT_MASK << STB7100_DEVID_CUT_SHIFT) | \
+		(STB7100_DEVID_ID_MASK << STB7100_DEVID_ID_SHIFT))
+
+#define STB7100_CUT1 (STB7100_DEVID_7100_VAL << STB7100_DEVID_ID_SHIFT)
+#define STB7100_CUT2 (STB7100_DEVID_7100_VAL << STB7100_DEVID_ID_SHIFT) | \
+		(1 << STB7100_DEVID_CUT_SHIFT)
+#define STB7100_CUT3 (STB7100_DEVID_7100_VAL << STB7100_DEVID_ID_SHIFT) | \
+		(2 << STB7100_DEVID_CUT_SHIFT)
+#define STB7109_CUT1 (STB7100_DEVID_7109_VAL << STB7100_DEVID_ID_SHIFT)
+#define STB7109_CUT2 (STB7100_DEVID_7109_VAL << STB7100_DEVID_ID_SHIFT) | \
+		(1 << STB7100_DEVID_CUT_SHIFT)
+#define STB7109_CUT3 (STB7100_DEVID_7109_VAL << STB7100_DEVID_ID_SHIFT) | \
+		(2 << STB7100_DEVID_CUT_SHIFT)
+
+.balign 32
+.global stx7100_mem_table
+stx7100_mem_table:
+	! Enables the DDR self refresh mode
+#if 0
+OR32(SYSCONF(11), (1 << 28) | (1 << 30))
+WHILE_NE32(SYSSTA(12), (1 << 28), (1 << 28))
+WHILE_NE32(SYSSTA(13), (1 << 28), (1 << 28))
+#endif
+	! PLL0 at the minimum frequency
+POKE32(CGA + CLKA_LOCK, 0xc0de)
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_BYPASS)
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_ENABLE, 0x0)
+UPDATE32(CGA + CLKA_PLL0, ~0x7ffff, CLKA_PLL0_SUSPEND)
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_ENABLE)
+WHILE_NE32(CGA + CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED)
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_BYPASS, 0x0)
+
+#if 0
+	! PLL1 at the minimum frequency
+OR32(CGA + CLKA_PLL1_BYPASS, 2)
+UPDATE32(CGA + CLKA_PLL1, ~CLKA_PLL1_ENABLE, 0x0)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, CLKA_PLL1_SUSPEND)
+OR32(CGA + CLKA_PLL1, CLKA_PLL1_ENABLE)
+WHILE_NE32(CGA + CLKA_PLL1_LOCK, CLKA_PLL1_LOCK_LOCKED, CLKA_PLL1_LOCK_LOCKED)
+UPDATE32(CGA + CLKA_PLL1_BYPASS, ~2, 0x0)
+
+	! Turn-off the LMI clocks and the ST231 clocks
+UPDATE32(CGA + CLKA_CLK_EN, ~CLKA_CLK_EN_DEFAULT, 0x0)
+#endif
+
+POKE32(CGA + CLKA_ST40_PER, 0x5)
+POKE32(CGA + CLKA_ST40_IC,  0x5)
+POKE32(CGA + CLKA_ST40, 0x3)
+
+END_MARKER
+
+	! Restore the highest frequency cpu/bus/per ratios */
+POKE32(CGA + CLKA_ST40, 0x0)
+POKE32(CGA + CLKA_ST40_IC, 0x1)
+POKE32(CGA + CLKA_ST40_PER, 0x0)
+
+!	PLL0 at the standard frequency */
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_BYPASS)
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_ENABLE, 0x0)
+UPDATE32(CGA + CLKA_PLL0, ~0x7ffff, CLKA_PLL0_RESUME)
+OR32(CGA + CLKA_PLL0, CLKA_PLL0_ENABLE)
+WHILE_NE32(CGA + CLKA_PLL0_LOCK, CLKA_PLL0_LOCK_LOCKED, CLKA_PLL0_LOCK_LOCKED)
+UPDATE32(CGA + CLKA_PLL0, ~CLKA_PLL0_BYPASS, 0x0)
+
+#if 0
+	! Turn-on the LMI clocks and the ST231 clocks*/
+OR32(CGA + CLKA_CLK_EN, CLKA_CLK_EN_DEFAULT)
+
+! PLL1 at the standard frequency
+OR32(CGA + CLKA_PLL1_BYPASS, 2)
+UPDATE32(CGA + CLKA_PLL1, ~CLKA_PLL1_ENABLE, 0x0)
+#if (CONFIG_SH_EXTERNAL_CLOCK = 30000000)
+/*
+ * 30 MHz Xtal clock
+ */
+IF_EQ32(1, CPU_ID, CPU_ID_MASK, STB7100_CUT1)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1e | (0x85 << 8) | (0x0 << 16))
+ELSE(1)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x0a | (0x80 << 8) | (0x1 << 16))
+ENDIF(1)
+
+IF_EQ32(2, CPU_ID, CPU_ID_MASK, STB7100_CUT3)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1e | (0xc8 << 8) | (0x0 << 16))
+ENDIF(2)
+
+IF_EQ32(3, CPU_ID, CPU_ID_MASK, STB7109_CUT2)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1e | (0xc8 << 8) | (0x0 << 16))
+ENDIF(3)
+
+IF_EQ32(4, CPU_ID, CPU_ID_MASK, STB7109_CUT3)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1e | (0xc8 << 8) | (0x0 << 16))
+ENDIF(4)
+
+#elif (CONFIG_SH_EXTERNAL_CLOCK = 27000000)
+/*
+ * 27 MHz Xtal clock
+ */
+IF_EQ32(1, CPU_ID, CPU_ID_MASK, STB7100_CUT1)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1b | (0x85 << 8) | (0x0 << 16))
+ELSE(1)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x09 | (0x80 << 8) | (0x1 << 16))
+ENDIF(1)
+
+IF_EQ32(2, CPU_ID, CPU_ID_MASK, STB7100_CUT3)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1b | (0xc8 << 8) | (0x0 << 16))
+ENDIF(2)
+
+IF_EQ32(3, CPU_ID, CPU_ID_MASK, STB7109_CUT2)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1b | (0xc8 << 8) | (0x0 << 16))
+ENDIF(3)
+
+IF_EQ32(4, CPU_ID, CPU_ID_MASK, STB7109_CUT3)
+UPDATE32(CGA + CLKA_PLL1, ~0x7ffff, 0x1b | (0xc8 << 8) | (0x0 << 16))
+ENDIF(4)
+#else
+#error External Oscillator not supported for PM.
+#endif
+
+OR32(CGA + CLKA_PLL1, CLKA_PLL1_ENABLE)
+
+WHILE_NE32(CGA + CLKA_PLL1_LOCK, CLKA_PLL1_LOCK_LOCKED, CLKA_PLL1_LOCK_LOCKED)
+UPDATE32(CGA + CLKA_PLL1_BYPASS, ~2, 0x0)
+
+!	Disables DDR self refresh */
+UPDATE32(SYSCONF(11), ~((1 << 28) | (1 << 30)), 0x0)
+WHILE_NE32(SYSSTA(12), (1 << 28), 0x0)
+#endif
+WHILE_NE32(SYSSTA(13), (1 << 28), 0x0)
+
+DELAY(10)
+POKE32(CGA + CLKA_LOCK, 0x0)
+END_MARKER
+
+.global stx7100_mem_tbl_size
+stx7100_mem_tbl_size:
+.long . - stx7100_mem_table
+
diff --git a/include/linux/stm/stx7100.h b/include/linux/stm/stx7100.h
index e452bd4..c1c7720 100644
--- a/include/linux/stm/stx7100.h
+++ b/include/linux/stm/stx7100.h
@@ -1,6 +1,7 @@
 #ifndef __LINUX_STM_STX7100_H
 #define __LINUX_STM_STX7100_H
 
+#ifndef __ASSEMBLER__
 #include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/stm/platform.h>
@@ -67,5 +68,47 @@ struct stx7100_pata_config {
 };
 void stx7100_configure_pata(struct stx7100_pata_config *config);
 
+#endif
+
+#define CLOCKGENA_BASE_ADDR	0x19213000	/* Clockgen A */
+#define SYSCONF_BASE_ADDR	0x19001000	/* Sysconf */
+
+#define CLKA_LOCK			0x00
+#define CLKA_PLL0			0x08
+#define   CLKA_PLL0_BYPASS		(1 << 20)
+#define   CLKA_PLL0_ENABLE		(1 << 19)
+#define   CLKA_PLL0_SUSPEND		((5 << 16) | (100 << 8) | \
+		(CONFIG_SH_EXTERNAL_CLOCK / 1000000))
+
+#if CONFIG_SH_EXTERNAL_CLOCK = 30000000
+#define   CLKA_PLL0_RESUME	(0x14 | (0xb1 << 8) | (0x0 << 16))
+#else
+#define   CLKA_PLL0_RESUME	(0x06 | (0x3b << 8) | (0x0 << 16))
+#endif
 
+#define CLKA_PLL0_LOCK			0x10
+#define   CLKA_PLL0_LOCK_LOCKED		0x01
+
+#define CLKA_ST40			0x14
+#define CLKA_ST40_IC			0x18
+#define CLKA_ST40_PER			0x1c
+#define CLKA_FDMA			0x20
+#define CLKA_PLL1			0x24
+#define   CLKA_PLL1_ENABLE		(1 << 19)
+#define   CLKA_PLL1_SUSPEND		((5 << 16) | (100 << 8) | \
+		(CONFIG_SH_EXTERNAL_CLOCK / 1000000))
+#define CLKA_PLL1_LOCK			0x2C
+#define   CLKA_PLL1_LOCK_LOCKED		0x01
+
+#define CLKA_CLK_DIV			0x30
+#define CLKA_CLK_EN			0x34
+#define   CLKA_CLK_EN_ST231_AUD		(1 << 0)
+#define   CLKA_CLK_EN_ST231_VID		(1 << 1)
+#define   CLKA_CLK_EN_LMI_SYS		(1 << 4)
+#define   CLKA_CLK_EN_LMI_VID		(1 << 5)
+#define   CLKA_CLK_EN_DEFAULT		(CLKA_CLK_EN_ST231_AUD |	\
+					 CLKA_CLK_EN_ST231_VID |	\
+					 CLKA_CLK_EN_LMI_SYS   |	\
+					 CLKA_CLK_EN_LMI_VID)
+#define CLKA_PLL1_BYPASS		0x3c
 #endif
-- 
1.6.2.5

