From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 10:33:18 +0000
Subject: [PATCH 06/10] sh: CMT platform driver using timer_inc
Message-Id: <20081201103318.26620.26073.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

CMT driver for the SuperH timer base code implementation V3.
Both 16-bit and 32-bit CMT versions are supported, but only 32-bit
is tested. This driver only contains hardware specific bits, the
logic handling clock events and clock sources is performed by the
timer_inc helper code.

Works fine as clock source and/or event in periodic or oneshot mode.
Tested on sh7722 and sh7723, but should work with any cpu/architecture.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V2 include:
 - Rewrote driver to platform driver and early timer
 - Only control clocks and hardware registers in disable()/enable()
 - Removed exported struct from sh_timer.c/sh_timer.h
 - sh_timer_early_probe() is used for early timer setup

 Changes since V1 include:
 - Reworked private data handling - no more union in sh_timer.h
 - Made spinlock static
 - Use setup_irq() to request early interrupt
 - Removed request_mem_region()/free_mem_region()
 - Removed sysdev code

 arch/sh/Kconfig              |    7 
 drivers/clocksource/Makefile |    1 
 drivers/clocksource/sh_cmt.c |  366 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)

--- 0003/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-01 13:40:49.000000000 +0900
@@ -394,6 +394,13 @@ config SH_TIMER
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 
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
+++ work/drivers/clocksource/Makefile	2008-12-01 13:40:49.000000000 +0900
@@ -3,3 +3,4 @@ obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclo
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_SH_TIMER)		+= sh_timer.o
+obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o timer_inc.o
--- /dev/null
+++ work/drivers/clocksource/sh_cmt.c	2008-12-01 14:00:39.000000000 +0900
@@ -0,0 +1,366 @@
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
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/sh_timer.h>
+#include <linux/timer_inc.h>
+
+struct sh_cmt_priv {
+	void __iomem *mapbase;
+	struct clk *clk;
+	struct timer_inc ti;
+	unsigned long width; /* 16 or 32 bit version of hardware block */
+	unsigned long overflow_bit;
+	unsigned long clear_bits;
+	struct irqaction irqaction;
+	struct platform_device *pdev;
+};
+
+static DEFINE_SPINLOCK(sh_cmt_lock);
+
+#define CMSTR -1 /* shared register */
+#define CMCSR 0 /* channel register */
+#define CMCNT 1 /* channel register */
+#define CMCOR 2 /* channel register */
+
+static inline unsigned long sh_cmt_read(struct sh_cmt_priv *p, int reg_nr)
+{
+	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
+	void __iomem *base = p->mapbase;
+	unsigned long offs;
+
+	if (reg_nr = CMSTR) {
+		offs = 0;
+		base -= cfg->channel_offset;
+	} else
+		offs = reg_nr;
+
+	if (p->width = 16)
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
+	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
+	void __iomem *base = p->mapbase;
+	unsigned long offs;
+
+	if (reg_nr = CMSTR) {
+		offs = 0;
+		base -= cfg->channel_offset;
+	} else
+		offs = reg_nr;
+
+	if (p->width = 16)
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
+	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
+	unsigned long flags, value;
+
+	/* start stop register shared by multiple timer channels */
+	spin_lock_irqsave(&sh_cmt_lock, flags);
+	value = sh_cmt_read(p, CMSTR);
+
+	if (start)
+		value |= 1 << cfg->timer_bit;
+	else
+		value &= ~(1 << cfg->timer_bit);
+
+	sh_cmt_write(p, CMSTR, value);
+	spin_unlock_irqrestore(&sh_cmt_lock, flags);
+}
+
+static int sh_cmt_enable(void *priv, unsigned long *rate)
+{
+	struct sh_cmt_priv *p = priv;
+	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
+	int ret;
+
+	/* enable clock */
+	ret = clk_enable(p->clk);
+	if (ret) {
+		pr_err("sh_cmt: cannot enable clock \"%s\"\n", cfg->clk);
+		return ret;
+	}
+	*rate = clk_get_rate(p->clk) / 8;
+
+	/* make sure channel is disabled */
+	sh_cmt_start_stop_ch(p, 0);
+
+	/* configure channel, periodic mode and maximum timeout */
+	if (p->width = 16)
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
+}
+
+static void sh_cmt_disable(void *priv)
+{
+	struct sh_cmt_priv *p = priv;
+
+	/* disable channel */
+	sh_cmt_start_stop_ch(p, 0);
+
+	/* stop clock */
+	clk_disable(p->clk);
+}
+
+static struct timer_inc_ops sh_cmt_ops = {
+	.set_match = sh_cmt_set_match,
+	.get_counter = sh_cmt_get_counter,
+	.enable = sh_cmt_enable,
+	.disable = sh_cmt_disable,
+};
+
+static int sh_cmt_setup(void *priv, struct platform_device *pdev)
+{
+	struct sh_cmt_priv *p = priv;
+	struct sh_timer_config *cfg = pdev->dev.platform_data;
+	struct resource *res;
+	int irq, ret;
+	ret = -ENXIO;
+
+	memset(p, 0, sizeof(*p));
+	p->pdev = pdev;
+
+	if (!cfg) {
+		dev_err(&p->pdev->dev, "missing platform data\n");
+		goto err0;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	res = platform_get_resource(p->pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
+		goto err0;
+	}
+
+	irq = platform_get_irq(p->pdev, 0);
+	if (irq < 0) {
+		dev_err(&p->pdev->dev, "failed to get irq\n");
+		goto err0;
+	}
+
+	/* map memory, let mapbase point to our channel */
+	p->mapbase = ioremap_nocache(res->start, resource_size(res));
+	if (p->mapbase = NULL) {
+		pr_err("sh_cmt: failed to remap I/O memory\n");
+		goto err0;
+	}
+
+	/* request irq using setup_irq() (too early for request_irq()) */
+	p->irqaction.name = cfg->name;
+	p->irqaction.handler = sh_cmt_interrupt;
+	p->irqaction.dev_id = p;
+	p->irqaction.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL;
+	p->irqaction.mask = CPU_MASK_NONE;
+	ret = setup_irq(irq, &p->irqaction);
+	if (ret) {
+		pr_err("sh_cmt: failed to request irq %d\n", irq);
+		goto err1;
+	}
+
+	/* get hold of clock */
+	p->clk = clk_get(&p->pdev->dev, cfg->clk);
+	if (IS_ERR(p->clk)) {
+		pr_err("sh_cmt: cannot get clock \"%s\"\n", cfg->clk);
+		ret = PTR_ERR(p->clk);
+		goto err2;
+	}
+
+	if (resource_size(res) = 6) {
+		p->width = 16;
+		p->overflow_bit = 0x80;
+		p->clear_bits = ~0xc0;
+	} else {
+		p->width = 32;
+		p->overflow_bit = 0x8000;
+		p->clear_bits = ~0xc000;
+	}
+
+	return timer_inc_register(&p->ti, cfg->name, p,
+				  p->width, &sh_cmt_ops,
+				  cfg->clockevent_rating,
+				  cfg->clocksource_rating);
+ err2:
+	free_irq(irq, p);
+ err1:
+	iounmap(p->mapbase);
+ err0:
+	return ret;
+}
+
+#ifndef MODULE
+/* early timer interface, used before platform devices are available */
+static struct sh_timer_early sh_cmt = {
+	.priv_size = sizeof(struct sh_cmt_priv),
+	.setup = sh_cmt_setup,
+};
+
+struct sh_timer_early *sh_timer_early_probe(struct platform_device *pdev)
+{
+	if (!strcmp(pdev->name, "sh_cmt"))
+		return &sh_cmt;
+
+	return NULL;
+}
+#endif
+
+static void sh_cmt_cleanup(struct sh_cmt_priv *p)
+{
+	timer_inc_unregister(&p->ti);
+
+	/* let go of clock */
+	clk_put(p->clk);
+
+	/* free up interrupt and memory map resources */
+	free_irq(platform_get_irq(p->pdev, 0), p);
+	iounmap(p->mapbase);
+}
+
+static int __devinit sh_cmt_probe(struct platform_device *pdev)
+{
+	struct sh_cmt_priv *early_p = platform_get_drvdata(pdev);
+	struct sh_cmt_priv *p;
+	int ret;
+
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (p = NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	if (early_p) {
+		pr_info("sh_cmt: switching from early timer\n");
+		sh_cmt_cleanup(early_p);
+		sh_timer_free_early(early_p, sizeof(*early_p));
+	}
+
+	ret = sh_cmt_setup(p, pdev);
+	if (ret) {
+		kfree(p);
+		platform_set_drvdata(pdev, NULL);
+	}
+	return ret;
+}
+
+static int __devexit sh_cmt_remove(struct platform_device *pdev)
+{
+	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
+
+	sh_cmt_cleanup(p);
+	kfree(p);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver sh_cmt_device_driver = {
+	.probe		= sh_cmt_probe,
+	.remove		= __devexit_p(sh_cmt_remove),
+	.driver		= {
+		.name	= "sh_cmt",
+	}
+};
+
+static int __init sh_cmt_init(void)
+{
+	return platform_driver_register(&sh_cmt_device_driver);
+}
+
+static void __exit sh_cmt_exit(void)
+{
+	platform_driver_unregister(&sh_cmt_device_driver);
+}
+
+module_init(sh_cmt_init);
+module_exit(sh_cmt_exit);
+
+MODULE_AUTHOR("Magnus Damm");
+MODULE_DESCRIPTION("SuperH CMT Timer Driver");
+MODULE_LICENSE("GPL");
