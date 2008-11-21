From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Nov 2008 13:16:39 +0000
Subject: [PATCH 2/8] sh: timer rewrite, tmu driver
Message-Id: <20081121131639.4127.20122.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

TMU driver for the new SuperH timer base code implementation.
Based on the old in-tree driver, but rewritten to become reentrant
and fit the new timer base code. Hardware configuration is received
from the processor code.

Tickless behaviour is similar to old in-tree code which means the
interrupt count seems too high, at least compared to the CMT driver.
This driver is useful for testing but needs further work.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                |    7 +
 drivers/clocksource/Makefile   |    1 
 drivers/clocksource/sh_timer.c |    3 
 drivers/clocksource/sh_tmu.c   |  275 ++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_timer.h       |   17 ++
 5 files changed, 302 insertions(+), 1 deletion(-)

--- 0002/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-21 20:05:05.000000000 +0900
@@ -389,6 +389,13 @@ config SH_TIMER
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 
+config SH_TIMER_TMU
+	def_bool y
+	prompt "TMU timer support"
+	depends on SH_TIMER && GENERIC_CLOCKEVENTS
+	help
+	  This enables build of the TMU system timer driver.
+
 config SH_TMU
 	def_bool y
 	prompt "TMU timer support"
--- 0002/drivers/clocksource/Makefile
+++ work/drivers/clocksource/Makefile	2008-11-21 20:05:05.000000000 +0900
@@ -3,3 +3,4 @@ obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclo
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_SH_TIMER)		+= sh_timer.o
+obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
--- 0002/drivers/clocksource/sh_timer.c
+++ work/drivers/clocksource/sh_timer.c	2008-11-21 20:05:05.000000000 +0900
@@ -26,6 +26,9 @@ struct sysdev_class sh_timer_class = {
 };
 
 struct sysdev_driver *sh_timer_drivers[] = {
+#ifdef CONFIG_SH_TIMER_TMU
+	&sh_tmu,
+#endif
 };
 
 int sh_timer_register(struct sh_timer_config *timers, int nr_timers)
--- /dev/null
+++ work/drivers/clocksource/sh_tmu.c	2008-11-21 20:25:53.000000000 +0900
@@ -0,0 +1,275 @@
+/*
+ * SuperH Timer Support - TMU
+ *
+ *  Copyright (C) 2008 Magnus Damm
+ *
+ * Derived from timer-tmu.c,
+ *
+ *  Copyright (C) 2005 - 2007  Paul Mundt
+ *
+ * TMU handling code hacked out of arch/sh/kernel/time.c
+ *
+ *  Copyright (C) 1999  Tetsuya Okada & Niibe Yutaka
+ *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
+ *  Copyright (C) 2002, 2003, 2004  Paul Mundt
+ *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
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
+
+#define TMU_TOCR_INIT	0x00
+#define TMU_TCR_INIT	0x0020
+
+#define TSTR 0x00 /* shared offset */
+#define TCOR 0x00 /* channel offset */
+#define TCNT 0x04 /* channel offset */
+#define TCR 0x08 /* channel offset */
+
+DEFINE_SPINLOCK(sh_tmu_lock);
+
+static void sh_tmu_set_irq(struct sh_timer_config *cfg, int enabled)
+{
+	void __iomem *base = cfg->priv.tmu.mapbase;
+	unsigned short value;
+
+	value = ioread16(base + TCR);
+
+	if (enabled)
+		value |= 1 << 5;
+	else
+		value &= ~(1 << 5);
+
+	iowrite16(value, base + TCR);
+}
+
+static void sh_tmu_clear_status(struct sh_timer_config *cfg)
+{
+	void __iomem *base = cfg->priv.tmu.mapbase;
+	unsigned short value;
+
+	value = ioread16(base + TCR);
+	value &= ~(1 << 8); /* Clear UNF bit */
+	iowrite16(value, base + TCR);
+}
+
+static void sh_tmu_start_stop_ch(struct sh_timer_config *cfg, int start)
+{
+	void __iomem *base = cfg->priv.tmu.mapbase - cfg->channel_offset;
+	unsigned long value;
+
+	if (start)
+		sh_tmu_set_irq(cfg, 1);
+
+	/* if hardware has TOCR register, TSTR is located 4 bytes up */
+	if ((cfg->base & 0xf) = 0)
+		base += 4;
+
+	/* start stop register shared by multiple timer channels */
+	value = ioread8(base + TSTR);
+
+	if (start)
+		value |= 1 << cfg->timer_bit;
+	else
+		value &= ~(1 << cfg->timer_bit);
+
+	iowrite8(value, base + TSTR);
+
+	if (!start)
+		sh_tmu_set_irq(cfg, 0);
+}
+
+static void sh_tmu_timer_set_interval(struct sh_timer_config *cfg,
+				      unsigned long interval,
+				      int reload)
+{
+	void __iomem *base = cfg->priv.tmu.mapbase;
+
+	sh_tmu_start_stop_ch(cfg, 0);
+
+	iowrite32(interval, base + TCNT);
+	iowrite32(reload ? interval : 0, base + TCOR);
+
+	sh_tmu_start_stop_ch(cfg, 1);
+}
+
+static struct sh_timer_config *to_cfg(struct clock_event_device *ced)
+{
+	return container_of(ced, struct sh_timer_config, priv.tmu.ced);
+}
+
+static int sh_tmu_set_next_event(unsigned long cycles,
+				 struct clock_event_device *evt)
+{
+	struct sh_timer_config *cfg = to_cfg(evt);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sh_tmu_lock, flags);
+	sh_tmu_timer_set_interval(cfg, cycles, 0);
+	spin_unlock_irqrestore(&sh_tmu_lock, flags);
+	return 0;
+}
+
+static void sh_tmu_set_mode(enum clock_event_mode mode,
+			    struct clock_event_device *evt)
+{
+	struct sh_timer_config *cfg = to_cfg(evt);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sh_tmu_lock, flags);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		sh_tmu_timer_set_interval(cfg,
+					  cfg->priv.tmu.periodic_interval, 1);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		sh_tmu_start_stop_ch(cfg, 0);
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_irqrestore(&sh_tmu_lock, flags);
+}
+
+static irqreturn_t sh_tmu_interrupt(int irq, void *dev_id)
+{
+	struct sh_timer_config *cfg = dev_id;
+	struct clock_event_device *evt = &cfg->priv.tmu.ced;
+
+	sh_tmu_clear_status(cfg);
+	if (cfg->priv.tmu.ced.mode = CLOCK_EVT_MODE_ONESHOT)
+		sh_tmu_start_stop_ch(cfg, 0);
+
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static int sh_tmu_setup_clockevent(struct sh_timer_config *cfg)
+{
+	unsigned long flags;
+	struct clock_event_device *ced;
+	void __iomem *base;
+	unsigned long frequency;
+	int divisor;
+	int ret;
+
+	/* request and map memory */
+	if (!request_mem_region(cfg->base + cfg->channel_offset,
+				12, cfg->name)) {
+		pr_err("sh_tmu: failed to request memory region\n");
+		ret = -EBUSY;
+		goto err0;
+	}
+
+	base = ioremap_nocache(cfg->base, cfg->channel_offset + 12);
+	if (base = NULL) {
+		pr_err("sh_tmu: failed to remap I/O memory\n");
+		ret = -ENXIO;
+		goto err1;
+	}
+	base += cfg->channel_offset;
+	cfg->priv.tmu.mapbase = base;
+
+	/* request interrupt */
+	ret = request_irq(cfg->irq, sh_tmu_interrupt,
+			  IRQF_TIMER | IRQF_DISABLED | IRQF_IRQPOLL,
+			  cfg->name, cfg);
+	if (ret) {
+		pr_err("sh_tmu: failed to request irq\n");
+		goto err2;
+	}
+
+	/* enable clocks */
+	cfg->priv.tmu.clk = clk_get(NULL, cfg->clk);
+	if (IS_ERR(cfg->priv.tmu.clk)) {
+		pr_err("sh_tmu: cannot get clock \"%s\"\n", cfg->clk);
+		ret = PTR_ERR(cfg->clk);
+		goto err3;
+	}
+
+	clk_enable(cfg->priv.tmu.clk);
+
+	spin_lock_irqsave(&sh_tmu_lock, flags);
+
+	/* make sure channel is disabled */
+	sh_tmu_start_stop_ch(cfg, 0);
+
+	/* if hardware has TOCR register, setup that to begin with */
+	if ((cfg->base & 0xf) = 0)
+		iowrite8(TMU_TOCR_INIT, base - cfg->channel_offset);
+
+	divisor = TMU_TCR_INIT & 0x7;
+	frequency = clk_get_rate(cfg->priv.tmu.clk) / (4 << (divisor << 1));
+	cfg->priv.tmu.periodic_interval = (frequency + HZ / 2) / HZ;
+
+	/* setup TCR register */
+	iowrite16(TMU_TCR_INIT, base + TCR);
+
+	spin_unlock_irqrestore(&sh_tmu_lock, flags);
+
+	ced = &cfg->priv.tmu.ced;
+	ced->name = cfg->name;
+	ced->shift = 32;
+	ced->rating = 1;
+	ced->features = CLOCK_EVT_FEAT_PERIODIC;
+	ced->features |= CLOCK_EVT_FEAT_ONESHOT;
+	ced->set_mode = sh_tmu_set_mode;
+	ced->set_next_event = sh_tmu_set_next_event;
+	ced->mult = div_sc(frequency, NSEC_PER_SEC, ced->shift);
+	ced->max_delta_ns = clockevent_delta2ns(-1, ced);
+	ced->min_delta_ns = clockevent_delta2ns(1, ced);
+	ced->cpumask = cpumask_of_cpu(0);
+
+	clockevents_register_device(ced);
+	return 0;
+
+ err3:
+	free_irq(cfg->irq, cfg);
+ err2:
+	iounmap(base - cfg->channel_offset);
+ err1:
+	release_mem_region(cfg->base + cfg->channel_offset, 12);
+ err0:
+	return ret;
+}
+
+static int sh_tmu_sysdev_add(struct sys_device *sysdev)
+{
+	struct sh_timer_config *cfg = to_sh_timer(sysdev);
+
+	if (cfg->type != SH_TIMER_TYPE_TMU)
+		return -EINVAL;
+
+	return sh_tmu_setup_clockevent(cfg);
+}
+
+struct sysdev_driver sh_tmu = {
+	.add = sh_tmu_sysdev_add,
+};
--- 0002/include/linux/sh_timer.h
+++ work/include/linux/sh_timer.h	2008-11-21 20:05:05.000000000 +0900
@@ -17,8 +17,12 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/sysdev.h>
+#include <linux/clockchips.h>
 
-enum sh_timer_type { SH_TIMER_TYPE_INVALID = 0 };
+enum sh_timer_type { SH_TIMER_TYPE_INVALID = 0,
+		     SH_TIMER_TYPE_TMU };
+
+extern struct sysdev_driver sh_tmu;
 
 struct sh_timer_config {
 	enum sh_timer_type type;
@@ -31,6 +35,17 @@ struct sh_timer_config {
 	char *clk;
 	int irq;
 
+	union {
+		struct {
+			void __iomem *mapbase;
+			struct clk *clk;
+			unsigned long periodic_interval;
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+			struct clock_event_device ced;
+#endif
+		} tmu;
+	} priv;
+
 	struct sys_device sysdev;
 };
 
