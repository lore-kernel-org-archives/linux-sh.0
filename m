From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Nov 2008 13:18:38 +0000
Subject: [PATCH 4/8] sh: timer rewrite, cmt driver
Message-Id: <20081121131838.4157.65689.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

CMT driver for the new SuperH timer base code implementation.
Both 16-bit and 32-bit CMT versions are supported, but only 32-bit
is tested. This driver only contains hardware specific bits, the
logic handling clock events and clock sources is performed by the
timer_inc helper code.

Works fine as clock source and/or event in periodic or oneshot mode.
Tested on sh7722 and sh7723, but should work with any cpu/architecture.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                |    7 +
 drivers/clocksource/Makefile   |    1 
 drivers/clocksource/sh_cmt.c   |  270 ++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/sh_timer.c |    3 
 include/linux/sh_timer.h       |   15 ++
 5 files changed, 295 insertions(+), 1 deletion(-)

--- 0003/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-21 19:42:56.000000000 +0900
@@ -396,6 +396,13 @@ config SH_TIMER_TMU
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
--- 0003/drivers/clocksource/Makefile
+++ work/drivers/clocksource/Makefile	2008-11-21 19:42:56.000000000 +0900
@@ -4,3 +4,4 @@ obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_SH_TIMER)		+= sh_timer.o
 obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
+obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o timer_inc.o
--- /dev/null
+++ work/drivers/clocksource/sh_cmt.c	2008-11-21 19:47:28.000000000 +0900
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
+DEFINE_SPINLOCK(sh_cmt_lock);
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
+static inline unsigned long sh_cmt_read(struct sh_timer_config *cfg, int reg_nr)
+{
+	void __iomem *base = cfg->priv.cmt.mapbase;
+	unsigned long offs;
+
+	if (reg_nr = CMSTR) {
+		offs = 0;
+		base -= cfg->channel_offset;
+	} else
+		offs = reg_nr;
+
+	if (cfg->flags & SH_TIMER_FLAGS_CMT_16BIT)
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
+static inline void sh_cmt_write(struct sh_timer_config *cfg, int reg_nr,
+				unsigned long value)
+{
+	void __iomem *base = cfg->priv.cmt.mapbase;
+	unsigned long offs;
+
+	if (reg_nr = CMSTR) {
+		offs = 0;
+		base -= cfg->channel_offset;
+	} else
+		offs = reg_nr;
+
+	if (cfg->flags & SH_TIMER_FLAGS_CMT_16BIT)
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
+	struct sh_timer_config *cfg = priv;
+	unsigned long v1, v2, v3;
+
+	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
+	do {
+		v1 = sh_cmt_read(cfg, CMCNT);
+		v2 = sh_cmt_read(cfg, CMCNT);
+		v3 = sh_cmt_read(cfg, CMCNT);
+	} while (unlikely((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
+			  || (v3 > v1 && v3 < v2)));
+
+	*has_wrapped = sh_cmt_read(cfg, CMCSR) & cfg->priv.cmt.overflow_bit;
+	return v2;
+}
+
+static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
+{
+	struct sh_timer_config *cfg = dev_id;
+	struct timer_inc *tip = &cfg->priv.cmt.ti;
+
+	/* clear flags */
+	sh_cmt_write(cfg, CMCSR, sh_cmt_read(cfg, CMCSR)
+		     & cfg->priv.cmt.clear_bits);
+
+	timer_inc_interrupt(tip);
+	return IRQ_HANDLED;
+}
+
+static void sh_cmt_start_stop_ch(struct sh_timer_config *cfg, int start)
+{
+	unsigned long flags, value;
+
+	/* start stop register shared by multiple timer channels */
+	spin_lock_irqsave(&sh_cmt_lock, flags);
+	value = sh_cmt_read(cfg, CMSTR);
+
+	if (start)
+		value |= 1 << cfg->timer_bit;
+	else
+		value &= ~(1 << cfg->timer_bit);
+
+	sh_cmt_write(cfg, CMSTR, value);
+	spin_unlock_irqrestore(&sh_cmt_lock, flags);
+}
+
+static int sh_cmt_start(void *priv)
+{
+	struct sh_timer_config *cfg = priv;
+	unsigned long n = cfg->priv.cmt.ch_size;
+	int ret;
+
+	/* request and map memory */
+	if (!request_mem_region(cfg->base + cfg->channel_offset,
+				n, cfg->name)) {
+		pr_err("sh_cmt: failed to request memory region\n");
+		ret = -EBUSY;
+		goto err0;
+	}
+
+	cfg->priv.cmt.mapbase = ioremap_nocache(cfg->base,
+						cfg->channel_offset + n);
+	if (cfg->priv.cmt.mapbase = NULL) {
+		pr_err("sh_cmt: failed to remap I/O memory\n");
+		ret = -ENXIO;
+		goto err1;
+	}
+
+	/* let mapbase point to our channel */
+	cfg->priv.cmt.mapbase += cfg->channel_offset;
+
+	/* request interrupt */
+	ret = request_irq(cfg->irq, sh_cmt_interrupt,
+			  IRQF_TIMER | IRQF_DISABLED | IRQF_IRQPOLL,
+			  cfg->name, cfg);
+	if (ret) {
+		pr_err("sh_cmt: failed to request irq\n");
+		goto err2;
+	}
+
+	/* enable clocks */
+	cfg->priv.cmt.clk = clk_get(NULL, cfg->clk);
+	if (IS_ERR(cfg->priv.cmt.clk)) {
+		pr_err("sh_cmt: cannot get clock \"%s\"\n", cfg->clk);
+		ret = PTR_ERR(cfg->clk);
+		goto err3;
+	}
+	clk_enable(cfg->priv.cmt.clk);
+
+	/* make sure channel is disabled */
+	sh_cmt_start_stop_ch(cfg, 0);
+
+	/* configure channel, periodic mode and maximum timeout */
+	if (cfg->flags & SH_TIMER_FLAGS_CMT_16BIT)
+		sh_cmt_write(priv, CMCSR, 0);
+	else
+		sh_cmt_write(priv, CMCSR, 0x01a4);
+
+	sh_cmt_write(priv, CMCOR, 0xffffffff);
+	sh_cmt_write(priv, CMCNT, 0);
+
+	/* enable channel */
+	sh_cmt_start_stop_ch(cfg, 1);
+	return 0;
+
+ err3:
+	free_irq(cfg->irq, cfg);
+ err2:
+	iounmap(cfg->priv.cmt.mapbase - cfg->channel_offset);
+ err1:
+	release_mem_region(cfg->base + cfg->channel_offset, n);
+ err0:
+	return ret;
+}
+
+static void sh_cmt_stop(void *priv)
+{
+	struct sh_timer_config *cfg = priv;
+
+	/* disable channel */
+	sh_cmt_start_stop_ch(cfg, 0);
+
+	/* let go of clocks */
+	clk_disable(cfg->priv.cmt.clk);
+	clk_put(cfg->priv.cmt.clk);
+
+	/* free up interrupt and memory map resources */
+	free_irq(cfg->irq, cfg);
+	iounmap(cfg->priv.cmt.mapbase - cfg->channel_offset);
+	release_mem_region(cfg->base + cfg->channel_offset,
+			   cfg->priv.cmt.ch_size);
+}
+
+struct timer_inc_ops sh_cmt_ops = {
+	.set_match = sh_cmt_set_match,
+	.get_counter = sh_cmt_get_counter,
+	.start = sh_cmt_start,
+	.stop = sh_cmt_stop,
+};
+
+static int sh_cmt_sysdev_add(struct sys_device *sysdev)
+{
+	struct sh_timer_config *cfg = to_sh_timer(sysdev);
+	int width;
+
+	if (cfg->type != SH_TIMER_TYPE_CMT)
+		return -EINVAL;
+
+	memset(&cfg->priv.cmt, 0, sizeof(cfg->priv.cmt));
+
+	if (cfg->flags & SH_TIMER_FLAGS_CMT_16BIT) {
+		width = 16;
+		cfg->priv.cmt.ch_size = 6;
+		cfg->priv.cmt.overflow_bit = 0x80;
+		cfg->priv.cmt.clear_bits = ~0xc0;
+	} else {
+		width = 32;
+		cfg->priv.cmt.ch_size = 12;
+		cfg->priv.cmt.overflow_bit = 0x8000;
+		cfg->priv.cmt.clear_bits = ~0xc000;
+	}
+
+	return timer_inc_register(&cfg->priv.cmt.ti,
+				  cfg->name, cfg, width, CMT_CLOCKRATE,
+				  &sh_cmt_ops, 1, 1);
+}
+
+struct sysdev_driver sh_cmt = {
+	.add = sh_cmt_sysdev_add,
+};
--- 0003/drivers/clocksource/sh_timer.c
+++ work/drivers/clocksource/sh_timer.c	2008-11-21 19:42:56.000000000 +0900
@@ -29,6 +29,9 @@ struct sysdev_driver *sh_timer_drivers[]
 #ifdef CONFIG_SH_TIMER_TMU
 	&sh_tmu,
 #endif
+#ifdef CONFIG_SH_TIMER_CMT
+	&sh_cmt,
+#endif
 };
 
 int sh_timer_register(struct sh_timer_config *timers, int nr_timers)
--- 0003/include/linux/sh_timer.h
+++ work/include/linux/sh_timer.h	2008-11-21 19:45:57.000000000 +0900
@@ -18,11 +18,16 @@
 #include <linux/clk.h>
 #include <linux/sysdev.h>
 #include <linux/clockchips.h>
+#include <linux/timer_inc.h>
 
 enum sh_timer_type { SH_TIMER_TYPE_INVALID = 0,
-		     SH_TIMER_TYPE_TMU };
+		     SH_TIMER_TYPE_TMU,
+		     SH_TIMER_TYPE_CMT };
 
 extern struct sysdev_driver sh_tmu;
+extern struct sysdev_driver sh_cmt;
+
+#define SH_TIMER_FLAGS_CMT_16BIT (1 << 0)
 
 struct sh_timer_config {
 	enum sh_timer_type type;
@@ -44,6 +49,14 @@ struct sh_timer_config {
 			struct clock_event_device ced;
 #endif
 		} tmu;
+		struct {
+			void __iomem *mapbase;
+			struct clk *clk;
+			struct timer_inc ti;
+			unsigned long ch_size;
+			unsigned long overflow_bit;
+			unsigned long clear_bits;
+		} cmt;
 	} priv;
 
 	struct sys_device sysdev;
