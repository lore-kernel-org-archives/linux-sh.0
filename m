From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:49 +0000
Subject: [PATCH (sh-2.6.30.y) 07/13] stm: pm: Add suspend support to the stx7111
Message-Id: <1259938375-27499-7-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/pm/suspend-stx7111.c |  161 +++++++++++++++++++++++++++++++++++
 include/linux/stm/stx7111.h         |   37 ++++++++
 2 files changed, 198 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/kernel/pm/suspend-stx7111.c

diff --git a/arch/sh/kernel/pm/suspend-stx7111.c b/arch/sh/kernel/pm/suspend-stx7111.c
new file mode 100644
index 0000000..cb5d813
--- /dev/null
+++ b/arch/sh/kernel/pm/suspend-stx7111.c
@@ -0,0 +1,161 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/pm/suspend-stx7111.c
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
+#include <linux/io.h>
+#include <linux/stm/stx7111.h>
+
+#include <asm/system.h>
+#include <asm/irq-ilc.h>
+
+#include "stm_suspend.h"
+
+#define CGA		CKGA_BASE_ADDRESS
+
+#define _SYSCONF(x)	(SYSCFG_BASE_ADDRESS + 0x100 + (x) * 4)
+#define _SYSSTA(x)	(SYSCFG_BASE_ADDRESS + 0x8 + (x) * 4)
+
+/* *************************
+ * STANDBY INSTRUCTION TABLE
+ * *************************
+ */
+static unsigned long stx7111_standby_table[] __cacheline_aligned = {
+POKE32(CGA + CKGA_OSC_DIV_CFG(0), 0x1f),	/* reduces the clk_STNoc_ic  */
+POKE32(CGA + CKGA_OSC_DIV_CFG(4), 0x1f),	/* reduces the st40 frequency*/
+POKE32(CGA + CKGA_OSC_DIV_CFG(5), 29),		/* clk_ic_if_100 @ 1 MHz     */
+POKE32(CGA + CKGA_CLKOPSRC_SWITCH_CFG, 0x0),/* All clocks on OSC 	     */
+END_MARKER,
+
+POKE32(CGA + CKGA_CLKOPSRC_SWITCH_CFG, 0xa6aa59aa),
+END_MARKER,
+};
+
+
+/* *********************
+ * MEM INSTRUCTION TABLE
+ * *********************
+ */
+static unsigned long stx7111_mem_table[] __cacheline_aligned = {
+OR32(_SYSCONF(38), (1 << 20)),	/* Enables the DDR self refresh mode */
+WHILE_NE32(_SYSSTA(4), 1, 1),	/* waits until the ack bit is zero */
+
+OR32(_SYSCONF(11), (1 << 12)),	/* Turn-off the ClockGenD */
+
+POKE32(CGA + CKGA_OSC_DIV_CFG(0), 0x1f),
+POKE32(CGA + CKGA_OSC_DIV_CFG(4), 0x1f),
+POKE32(CGA + CKGA_OSC_DIV_CFG(5),  29),
+POKE32(CGA + CKGA_OSC_DIV_CFG(17), 0x1f),
+
+POKE32(CGA + CKGA_CLKOPSRC_SWITCH_CFG, 0),	/* clocks on OSC */
+POKE32(CGA + CKGA_CLKOPSRC_SWITCH_CFG2, 0), /* clocks on OSC */
+
+OR32(CGA + CKGA_POWER_CFG, 0x3),	/* PLLs in power down */
+
+END_MARKER,
+
+UPDATE32(CGA + CKGA_POWER_CFG, ~3, 0),	/* Turn-on the PLLs */
+WHILE_NE32(CGA + CKGA_PLL0_CFG, CKGA_PLL_CFG_LOCK, CKGA_PLL_CFG_LOCK),
+WHILE_NE32(CGA + CKGA_PLL1_CFG, CKGA_PLL_CFG_LOCK, CKGA_PLL_CFG_LOCK),
+
+POKE32(CGA + CKGA_CLKOPSRC_SWITCH_CFG, 0xa6aa59aa),
+POKE32(CGA + CKGA_CLKOPSRC_SWITCH_CFG2, 0xa),
+
+UPDATE32(_SYSCONF(11), ~(1 << 12), 0),	/* Turn-on the LMI ClocksGenD */
+WHILE_NE32(_SYSSTA(3), 1, 1),		/* Wait LMI ClocksGenD lock   */
+
+UPDATE32(_SYSCONF(38), ~(1 << 20), 0),	/* Disables DDR self refresh  */
+WHILE_NE32(_SYSSTA(4), 1, 0),		/* waits until the ack bit    */
+
+END_MARKER
+};
+
+static void stx7111_support(int suspend)
+{
+	static unsigned long saved_data[6];
+	if (suspend) {
+		saved_data[0] = ioread32(CGA + CKGA_CLKOPSRC_SWITCH_CFG);
+		saved_data[1] = ioread32(CGA + CKGA_CLKOPSRC_SWITCH_CFG2);
+		saved_data[2] = ioread32(CGA + CKGA_OSC_DIV_CFG(0));
+		saved_data[3] = ioread32(CGA + CKGA_OSC_DIV_CFG(4));
+		saved_data[4] = ioread32(CGA + CKGA_OSC_DIV_CFG(5));
+		saved_data[5] = ioread32(CGA + CKGA_OSC_DIV_CFG(17));
+		return;
+	}
+
+	iowrite32(saved_data[0], CGA + CKGA_CLKOPSRC_SWITCH_CFG);
+	iowrite32(saved_data[1], CGA + CKGA_CLKOPSRC_SWITCH_CFG2);
+	iowrite32(saved_data[2], CGA + CKGA_OSC_DIV_CFG(0));
+	iowrite32(saved_data[3], CGA + CKGA_OSC_DIV_CFG(4));
+	iowrite32(saved_data[4], CGA + CKGA_OSC_DIV_CFG(5));
+	iowrite32(saved_data[5], CGA + CKGA_OSC_DIV_CFG(17));
+}
+
+static int stx7111_suspend_prepare_late(void)
+{
+	stx7111_support(1);
+	return 0;
+}
+
+static void stx7111_wake(void)
+{
+	stx7111_support(0);
+}
+
+static int stx7111_evttoirq(unsigned long evt)
+{
+	return (evt < 0x400 ? ilc2irq(evt) : evt2irq(evt));
+}
+
+static struct stm_suspend_t stx7111_suspend = {
+	.ops.prepare_late = stx7111_suspend_prepare_late,
+	.ops.wake = stx7111_wake,
+	.evt_to_irq = stx7111_evttoirq,
+
+	.stby_tbl = (unsigned long)stx7111_standby_table,
+	.stby_size = DIV_ROUND_UP(ARRAY_SIZE(stx7111_standby_table) *
+			sizeof(long), L1_CACHE_BYTES),
+
+	.mem_tbl = (unsigned long)stx7111_mem_table,
+	.mem_size = DIV_ROUND_UP(ARRAY_SIZE(stx7111_mem_table) * sizeof(long),
+			L1_CACHE_BYTES),
+};
+
+static int __init stx7111_suspend_setup(void)
+{
+	int i;
+	struct sysconf_field *sc[4];
+
+	sc[0] = sysconf_claim(SYS_CFG, 38, 20, 20, "LMI - PM");
+	sc[1] = sysconf_claim(SYS_CFG, 11, 12, 12, "LMI - PM");
+	sc[2] = sysconf_claim(SYS_STA, 4, 0, 0, "LMI - PM");
+	sc[3] = sysconf_claim(SYS_STA, 3, 0, 0, "LMI - PM");
+
+	for (i = 0; i < 4; ++i)
+		if (!sc[i])
+			goto error;
+
+	return stm_suspend_register(&stx7111_suspend);
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
+late_initcall(stx7111_suspend_setup);
diff --git a/include/linux/stm/stx7111.h b/include/linux/stm/stx7111.h
index a6021b0..ce5e4e1 100644
--- a/include/linux/stm/stx7111.h
+++ b/include/linux/stm/stx7111.h
@@ -68,4 +68,41 @@ void stx7111_configure_pci(struct stm_plat_pci_config *pci_config);
 int  stx7111_pcibios_map_platform_irq(struct stm_plat_pci_config *pci_config,
                 u8 pin);
 
+/* --- Base addresses ---------------------------------------- */
+#define CKGA_BASE_ADDRESS	0xFE213000
+#define SYSCFG_BASE_ADDRESS	0xFE001000     /* SysConf registers */
+
+/* --- CKGA registers ( hardware specific ) ------------------- */
+#define CKGA_PLL0_CFG			0x000
+#define CKGA_PLL1_CFG			0x004
+#define   CKGA_PLL_CFG_BYPASS		(1 << 20)
+#define   CKGA_PLL_CFG_LOCK		(1 << 31)
+
+#define CKGA_POWER_CFG			0x010
+#define CKGA_CLKOPSRC_SWITCH_CFG	0x014
+#define CKGA_OSC_ENABLE_FB		0x018
+#define CKGA_PLL0_ENABLE_FB		0x01c
+#define CKGA_PLL1_ENABLE_FB		0x020
+#define CKGA_CLKOPSRC_SWITCH_CFG2       0x024
+
+#define CKGA_CLKOBS_MUX1_CFG		0x030
+#define CKGA_CLKOBS_MASTER_MAXCOUNT	0x034
+#define CKGA_CLKOBS_CMD			0x038
+#define CKGA_CLKOBS_STATUS		0x03c
+#define CKGA_CLKOBS_SLAVE0_COUNT	0x040
+#define CKGA_OSCMUX_DEBUG		0x044
+#define CKGA_CLKOBS_MUX2_CFG		0x048
+#define CKGA_LOW_POWER_CTRL		0x04C
+
+#define CKGA_OSC_DIV0_CFG		0x800
+#define CKGA_OSC_DIV_CFG(x)		(CKGA_OSC_DIV0_CFG + (x) * 4)
+
+#define CKGA_PLL0HS_DIV0_CFG		0x900
+#define CKGA_PLL0HS_DIV_CFG(x)		(CKGA_PLL0HS_DIV0_CFG + (x) * 4)
+
+#define CKGA_PLL0LS_DIV0_CFG		0xA00
+#define CKGA_PLL0LS_DIV_CFG(x)		(CKGA_PLL0LS_DIV0_CFG + (x) * 4)
+
+#define CKGA_PLL1_DIV0_CFG		0xB00
+#define CKGA_PLL1_DIV_CFG(x)		(CKGA_PLL1_DIV0_CFG + (x) * 4)
 #endif
-- 
1.6.2.5

