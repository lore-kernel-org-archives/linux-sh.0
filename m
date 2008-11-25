From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Nov 2008 13:00:11 +0000
Subject: [PATCH 4/8] sh: timer rewrite V2, cmt driver
Message-Id: <20081125130011.8586.1233.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

CMT driver for the SuperH timer base code implementation V2.
Both 16-bit and 32-bit CMT versions are supported, but only 32-bit
is tested. This driver only contains hardware specific bits, the
logic handling clock events and clock sources is performed by the
timer_inc helper code.

Works fine as clock source and/or event in periodic or oneshot mode.
Tested on sh7722 and sh7723, but should work with any cpu/architecture.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1 include:
 - Reworked private data handling - no more union in sh_timer.h
 - Made spinlock static
 - Use setup_irq() to request early interrupt
 - Removed request_mem_region()/free_mem_region()
 - Removed sysdev code

 arch/sh/Kconfig                |    7 +
 drivers/clocksource/Makefile   |    1 
 drivers/clocksource/sh_cmt.c   |  270 ++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/sh_timer.c |    3 
 include/linux/sh_timer.h       |    5 
 5 files changed, 285 insertions(+), 1 deletion(-)

--- 0006/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-25 20:37:29.000000000 +0900
@@ -397,6 +397,13 @@ config SH_TIMER_TMU
 	help
 	  This enables build of the TMU system timer driver.
 
+config SH_TIMER_CMT
+	def_bool y
+	prompt "CMT timer support"
+	depends on SH_TIMER
+	help
+	  This enables build of the CMT system timer driver.
+
 config SH_TMU
 	def_bool y
 	prompt "TMU timer support"
--- 0005/drivers/clocksource/Makefile
+++ work/drivers/clocksource/Makefile	2008-11-25 20:37:29.000000000 +0900
@@ -4,3 +4,4 @@ obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_SH_TIMER)		+= sh_timer.o
 obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
+obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o timer_inc.o
--- /dev/null
+++ work/drivers/clocksource/sh_cmt.c	2008-11-25 20:40:58.000000000 +0900
@@ -0,0 +1,270 @@
+/*
+ * SuperH Timer Support - CMT
+ *
+ *  Copyright (C) 2008 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+
+#include <linux/sh_timer.h>
+#include <linux/timer_inc.h>
+
+struct sh_cmt_priv {
+	void __iomem *mapbase;
+	struct clk *clk;
+	struct timer_inc ti;
+	unsigned long ch_size;
+	unsigned long overflow_bit;
+	unsigned long clear_bits;
+	struct irqaction irqaction;
+	struct sh_timer_config cfg;
+};
+
+static DEFINE_SPINLOCK(sh_cmt_lock);
+
+/* The CMT is driven by the 32KHz r_clk, and the best resolution we
+ * can get is 4096 ticks per second by configuring the CMT to divide by 8.
+ */
+
+#define CMT_CLOCKRATE (32768 / 8)
+
+#define CMSTR -1 /* shared register */
+#define CMCSR 0 /* channel register */
+#define CMCNT 1 /* channel register */
+#define CMCOR 2 /* channel register */
+
+static inline unsigned long sh_cmt_read(struct sh_cmt_priv *p, int reg_nr)
+{
+	void __iomem *base = p->mapbase;
+	unsigned long offs;
+
+	if (reg_nr = CMSTR) {
+		offs = 0;
+		base -= p->cfg.channel_offset;
+	} else
+		offs = reg_nr;
+
+	if (p->cfg.flags & SH_TIMER_FLAGS_CMT_16BIT)
+		offs <<= 1;
+	else {
+		offs <<= 2;
+		if ((reg_nr = CMCNT) || (reg_nr = CMCOR))
+			return ioread32(base + offs);
+	}
+
+	return ioread16(base + offs);
+}
+
+static inline void sh_cmt_write(struct sh_cmt_priv *p, int reg_nr,
+				unsigned long value)
+{
+	void __iomem *base = p->mapbase;
+	unsigned long offs;
+
+	if (reg_nr = CMSTR) {
+		offs = 0;
+		base -= p->cfg.channel_offset;
+	} else
+		offs = reg_nr;
+
+	if (p->cfg.flags & SH_TIMER_FLAGS_CMT_16BIT)
+		offs <<= 1;
+	else {
+		offs <<= 2;
+		if ((reg_nr = CMCNT) || (reg_nr = CMCOR)) {
+			iowrite32(value, base + offs);
+			return;
+		}
+	}
+
+	iowrite16(value, base + offs);
+}
+
+static void sh_cmt_set_match(void *priv, unsigned long value)
+{
+	sh_cmt_write(priv, CMCOR, value);
+}
+
+static unsigned long sh_cmt_get_counter(void *priv, int *has_wrapped)
+{
+	struct sh_cmt_priv *p = priv;
+	unsigned long v1, v2, v3;
+
+	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
+	do {
+		v1 = sh_cmt_read(p, CMCNT);
+		v2 = sh_cmt_read(p, CMCNT);
+		v3 = sh_cmt_read(p, CMCNT);
+	} while (unlikely((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
+			  || (v3 > v1 && v3 < v2)));
+
+	*has_wrapped = sh_cmt_read(p, CMCSR) & p->overflow_bit;
+	return v2;
+}
+
+static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
+{
+	struct sh_cmt_priv *p = dev_id;
+	struct timer_inc *tip = &p->ti;
+
+	/* clear flags */
+	sh_cmt_write(p, CMCSR, sh_cmt_read(p, CMCSR) & p->clear_bits);
+
+	timer_inc_interrupt(tip);
+	return IRQ_HANDLED;
+}
+
+static void sh_cmt_start_stop_ch(struct sh_cmt_priv *p, int start)
+{
+	unsigned long flags, value;
+
+	/* start stop register shared by multiple timer channels */
+	spin_lock_irqsave(&sh_cmt_lock, flags);
+	value = sh_cmt_read(p, CMSTR);
+
+	if (start)
+		value |= 1 << p->cfg.timer_bit;
+	else
+		value &= ~(1 << p->cfg.timer_bit);
+
+	sh_cmt_write(p, CMSTR, value);
+	spin_unlock_irqrestore(&sh_cmt_lock, flags);
+}
+
+static int sh_cmt_start(void *priv)
+{
+	struct sh_cmt_priv *p = priv;
+	unsigned long n = p->ch_size;
+	int ret;
+
+	/* map memory */
+	p->mapbase = ioremap_nocache(p->cfg.base, p->cfg.channel_offset + n);
+	if (p->mapbase = NULL) {
+		pr_err("sh_cmt: failed to remap I/O memory\n");
+		ret = -ENXIO;
+		goto err0;
+	}
+
+	/* let mapbase point to our channel */
+	p->mapbase += p->cfg.channel_offset;
+
+	/* request irq using setup_irq() (too early for request_irq()) */
+	p->irqaction.name = p->cfg.name;
+	p->irqaction.handler = sh_cmt_interrupt;
+	p->irqaction.dev_id = p;
+	p->irqaction.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL;
+	p->irqaction.mask = CPU_MASK_NONE;
+	ret = setup_irq(p->cfg.irq, &p->irqaction);
+	if (ret) {
+		pr_err("sh_cmt: failed to request irq %d\n", p->cfg.irq);
+		goto err1;
+	}
+
+	/* enable clocks */
+	p->clk = clk_get(NULL, p->cfg.clk);
+	if (IS_ERR(p->clk)) {
+		pr_err("sh_cmt: cannot get clock \"%s\"\n", p->cfg.clk);
+		ret = PTR_ERR(p->clk);
+		goto err2;
+	}
+	clk_enable(p->clk);
+
+	/* make sure channel is disabled */
+	sh_cmt_start_stop_ch(p, 0);
+
+	/* configure channel, periodic mode and maximum timeout */
+	if (p->cfg.flags & SH_TIMER_FLAGS_CMT_16BIT)
+		sh_cmt_write(p, CMCSR, 0);
+	else
+		sh_cmt_write(p, CMCSR, 0x01a4);
+
+	sh_cmt_write(p, CMCOR, 0xffffffff);
+	sh_cmt_write(p, CMCNT, 0);
+
+	/* enable channel */
+	sh_cmt_start_stop_ch(p, 1);
+	return 0;
+
+ err2:
+	free_irq(p->cfg.irq, p);
+ err1:
+	iounmap(p->mapbase - p->cfg.channel_offset);
+ err0:
+	return ret;
+}
+
+static void sh_cmt_stop(void *priv)
+{
+	struct sh_cmt_priv *p = priv;
+
+	/* disable channel */
+	sh_cmt_start_stop_ch(p, 0);
+
+	/* let go of clocks */
+	clk_disable(p->clk);
+	clk_put(p->clk);
+
+	/* free up interrupt and memory map resources */
+	free_irq(p->cfg.irq, p);
+	iounmap(p->mapbase - p->cfg.channel_offset);
+}
+
+static struct timer_inc_ops sh_cmt_ops = {
+	.set_match = sh_cmt_set_match,
+	.get_counter = sh_cmt_get_counter,
+	.start = sh_cmt_start,
+	.stop = sh_cmt_stop,
+};
+
+static int sh_cmt_setup(void *priv, void *config)
+{
+	struct sh_cmt_priv *p = priv;
+	int width;
+
+	memset(p, 0, sizeof(*p));
+	memcpy(&p->cfg, config, sizeof(p->cfg));
+
+	if (p->cfg.flags & SH_TIMER_FLAGS_CMT_16BIT) {
+		width = 16;
+		p->ch_size = 6;
+		p->overflow_bit = 0x80;
+		p->clear_bits = ~0xc0;
+	} else {
+		width = 32;
+		p->ch_size = 12;
+		p->overflow_bit = 0x8000;
+		p->clear_bits = ~0xc000;
+	}
+
+	return timer_inc_register(&p->ti, p->cfg.name, p, width,
+				  CMT_CLOCKRATE,
+				  &sh_cmt_ops, 1, 1);
+}
+
+struct early_timer sh_cmt = {
+	.priv_size = sizeof(struct sh_cmt_priv),
+	.setup = sh_cmt_setup,
+};
--- 0005/drivers/clocksource/sh_timer.c
+++ work/drivers/clocksource/sh_timer.c	2008-11-25 20:38:57.000000000 +0900
@@ -25,6 +25,9 @@ struct early_timer *sh_timers_early[] = 
 #ifdef CONFIG_SH_TIMER_TMU
 	[SH_TIMER_TYPE_TMU] = &sh_tmu,
 #endif
+#ifdef CONFIG_SH_TIMER_CMT
+	[SH_TIMER_TYPE_CMT] = &sh_cmt,
+#endif
 };
 
 static struct sh_timer_config *sh_timer_timers;
--- 0005/include/linux/sh_timer.h
+++ work/include/linux/sh_timer.h	2008-11-25 20:40:35.000000000 +0900
@@ -14,9 +14,12 @@ struct early_timer {
 	int (*setup)(void *priv, void *config);
 };
 
-enum sh_timer_type { SH_TIMER_TYPE_TMU, SH_TIMER_TYPE_NR };
+enum sh_timer_type { SH_TIMER_TYPE_TMU, SH_TIMER_TYPE_CMT, SH_TIMER_TYPE_NR };
 
 extern struct early_timer sh_tmu;
+extern struct early_timer sh_cmt;
+
+#define SH_TIMER_FLAGS_CMT_16BIT (1 << 0)
 
 struct sh_timer_config {
 	enum sh_timer_type type;
