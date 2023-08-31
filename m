Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0383C83F1C
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbjHaBMO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHaBMN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:13 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB6CDA
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 34e9f443-c981-4ecf-9a87-5710f0880049;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id D2FD11C05A0;
        Thu, 31 Aug 2023 10:12:05 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 05/12] drivers/irqchip: Add SH7751 and boards specific irqchip.
Date:   Thu, 31 Aug 2023 10:11:52 +0900
Message-Id: <52f2118d33bea5e74d4ffda4b3d935772e743ec2.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693444193.git.ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- irq-renesas-sh7751: Renesas SH7751 internal INTC.
- irq-renesas-r2d: Renesas RTS7751R2D external interrupt encoder.
- irq-iodata-julian: IO DATA Device LANDISK external interrupt encoder.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/irqchip/Kconfig              |   4 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-iodata-julian.c  | 163 +++++++++++++++++++++++
 drivers/irqchip/irq-renesas-r2d.c    | 175 +++++++++++++++++++++++++
 drivers/irqchip/irq-renesas-sh7751.c | 186 +++++++++++++++++++++++++++
 5 files changed, 529 insertions(+)
 create mode 100644 drivers/irqchip/irq-iodata-julian.c
 create mode 100644 drivers/irqchip/irq-renesas-r2d.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 09e422da482f..372b22d5183f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -660,6 +660,10 @@ config APPLE_AIC
 	help
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
+config RENESAS_SH_INTC
+	def_bool y if SH_DEVICE_TREE
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 
 config MCHP_EIC
 	bool "Microchip External Interrupt Controller"
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..a3859bdd0442 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
+obj-$(CONFIG_RENESAS_SH_INTC)		+= irq-renesas-sh7751.o irq-iodata-julian.o irq-renesas-r2d.o
diff --git a/drivers/irqchip/irq-iodata-julian.c b/drivers/irqchip/irq-iodata-julian.c
new file mode 100644
index 000000000000..95e502904a68
--- /dev/null
+++ b/drivers/irqchip/irq-iodata-julian.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IO-DATA DEVICE LANDISK / USL-5P (a.k.a Julian) interrupt encoder
+ *
+ * Copyright (C) 2023 Yoshinori Sato
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define NUM_IRQ 16
+
+struct julian_intc_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct irq_domain *irq_domain;
+};
+
+static struct julian_intc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void julian_intc_mask_irq(struct irq_data *data)
+{
+	struct julian_intc_priv *priv = irq_data_to_priv(data);
+	int irq = data->irq;
+	u8 mask;
+
+	mask = __raw_readb(priv->base + 5);
+	mask &= ~(1 << (irq - 5));
+	__raw_writeb(mask, priv->base + 5);
+}
+
+static void julian_intc_unmask_irq(struct irq_data *data)
+{
+	struct julian_intc_priv *priv = irq_data_to_priv(data);
+	int irq = data->irq;
+	u8 mask;
+
+	mask = __raw_readb(priv->base + 5);
+	mask |= (1 << (irq - 5));
+	__raw_writeb(mask, priv->base + 5);
+}
+
+static struct irq_chip julian_intc_chip = {
+	.name		= "JULIAN-INTC",
+	.irq_unmask	= julian_intc_unmask_irq,
+	.irq_mask	= julian_intc_mask_irq,
+};
+
+static __init int julian_intc_map(struct irq_domain *h, unsigned int virq,
+			       irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &julian_intc_chip, handle_level_irq);
+	irq_get_irq_data(virq)->chip_data = h->host_data;
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
+	return 0;
+}
+
+static int julian_intc_translate(struct irq_domain *domain,
+			       struct irq_fwspec *fwspec, unsigned long *hwirq,
+			       unsigned int *type)
+{
+	if (fwspec->param[0] >= NUM_IRQ)
+		return -EINVAL;
+
+	switch (fwspec->param_count) {
+	case 2:
+		*type = fwspec->param[1];
+		fallthrough;
+	case 1:
+		*hwirq = fwspec->param[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct irq_domain_ops julian_intc_domain_ops = {
+	.map = julian_intc_map,
+	.translate = julian_intc_translate,
+};
+
+static int julian_intc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct julian_intc_priv *priv;
+	struct irq_domain *d;
+	int ret = 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	d = irq_domain_add_tree(np, &julian_intc_domain_ops, priv);
+	if (d == NULL) {
+		dev_err(dev, "cannot initialize irq domain\n");
+		kfree(priv);
+		ret = -ENOMEM;
+	} else {
+		priv->irq_domain = d;
+		irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+	}
+	return ret;
+}
+
+static int julian_intc_remove(struct platform_device *pdev)
+{
+	struct julian_intc_priv *priv = platform_get_drvdata(pdev);
+
+	irq_domain_remove(priv->irq_domain);
+	return 0;
+}
+
+static const struct of_device_id julian_intc_dt_ids[] = {
+	{ .compatible = "iodata,julian-intc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, julian_intc_dt_ids);
+
+static struct platform_driver julian_intc_device_driver = {
+	.probe		= julian_intc_probe,
+	.remove		= julian_intc_remove,
+	.driver		= {
+		.name	= "iodata_julian_intc",
+		.of_match_table	= julian_intc_dt_ids,
+	}
+};
+
+static int __init julian_intc_init(void)
+{
+	return platform_driver_register(&julian_intc_device_driver);
+}
+postcore_initcall(julian_intc_init);
+
+static void __exit julian_intc_exit(void)
+{
+	platform_driver_unregister(&julian_intc_device_driver);
+}
+module_exit(julian_intc_exit);
+
+MODULE_AUTHOR("Yoshinori Sato");
+MODULE_DESCRIPTION("IO-DATA JULIAN external interrupt encoder");
diff --git a/drivers/irqchip/irq-renesas-r2d.c b/drivers/irqchip/irq-renesas-r2d.c
new file mode 100644
index 000000000000..595057c1f5aa
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-r2d.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RTS7751R2D interrupt encoder
+ *
+ * Copyright (C) 2023 Yoshinori Sato
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define NUM_IRQ 15
+
+struct r2d_intc_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct irq_domain *irq_domain;
+};
+
+static const int imask[] = {
+	1 << 11,	/* PCI INTD */
+	1 << 9,		/* CF IDE */
+	1 << 8,		/* CF CD */
+	1 << 12,	/* PCI INTC */
+	1 << 10,	/* SM501 */
+	1 << 6,		/* AX88796 / KEY */
+	1 << 5,		/* RTC ALARM */
+	1 << 4,		/* RTC T */
+	1 << 7,		/* SDCARD */
+	1 << 14,	/* PCI INTA */
+	1 << 13,	/* PCI INTB */
+	1 << 0,		/* EXT */
+	1 << 15,	/* TP */
+};
+
+static struct r2d_intc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void r2d_intc_mask_irq(struct irq_data *data)
+{
+	struct r2d_intc_priv *priv = irq_data_to_priv(data);
+	u16 mask;
+
+	mask = __raw_readw(priv->base);
+	mask &= ~(imask[data->irq]);
+	__raw_writew(mask, priv->base);
+}
+
+static void r2d_intc_unmask_irq(struct irq_data *data)
+{
+	struct r2d_intc_priv *priv = irq_data_to_priv(data);
+	u16 mask;
+
+	mask = __raw_readw(priv->base);
+	mask |= imask[data->irq];
+	__raw_writew(mask, priv->base);
+}
+
+static struct irq_chip r2d_intc_chip = {
+	.name		= "R2D-INTC",
+	.irq_unmask	= r2d_intc_unmask_irq,
+	.irq_mask	= r2d_intc_mask_irq,
+};
+
+static __init int r2d_intc_map(struct irq_domain *h, unsigned int virq,
+			       irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &r2d_intc_chip, handle_level_irq);
+	irq_get_irq_data(virq)->chip_data = h->host_data;
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
+	return 0;
+}
+
+static int r2d_intc_translate(struct irq_domain *domain,
+			       struct irq_fwspec *fwspec, unsigned long *hwirq,
+			       unsigned int *type)
+{
+	if (fwspec->param[0] >= NUM_IRQ)
+		return -EINVAL;
+
+	switch (fwspec->param_count) {
+	case 2:
+		*type = fwspec->param[1];
+		fallthrough;
+	case 1:
+		*hwirq = fwspec->param[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct irq_domain_ops r2d_intc_domain_ops = {
+//	.alloc = r2d_intc_alloc,
+	.map = r2d_intc_map,
+	.translate = r2d_intc_translate,
+};
+
+static int r2d_intc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct r2d_intc_priv *priv;
+	struct irq_domain *d;
+	int ret = 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	d = irq_domain_add_tree(np, &r2d_intc_domain_ops, priv);
+	if (d == NULL) {
+		dev_err(dev, "cannot initialize irq domain\n");
+		kfree(priv);
+		ret = -ENOMEM;
+	} else {
+		priv->irq_domain = d;
+		irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+	}
+	return ret;
+}
+
+static int r2d_intc_remove(struct platform_device *pdev)
+{
+	struct r2d_intc_priv *priv = platform_get_drvdata(pdev);
+
+	irq_domain_remove(priv->irq_domain);
+	return 0;
+}
+
+static const struct of_device_id r2d_intc_dt_ids[] = {
+	{ .compatible = "renesas,rts7751r2d-intc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, r2d_intc_dt_ids);
+
+static struct platform_driver r2d_intc_device_driver = {
+	.probe		= r2d_intc_probe,
+	.remove		= r2d_intc_remove,
+	.driver		= {
+		.name	= "renesas_r2d_intc",
+		.of_match_table	= r2d_intc_dt_ids,
+	}
+};
+
+static int __init r2d_intc_init(void)
+{
+	return platform_driver_register(&r2d_intc_device_driver);
+}
+postcore_initcall(r2d_intc_init);
+
+static void __exit r2d_intc_exit(void)
+{
+	platform_driver_unregister(&r2d_intc_device_driver);
+}
+module_exit(r2d_intc_exit);
+
+MODULE_AUTHOR("Yoshinori Sato");
+MODULE_DESCRIPTION("Renesas RTS7751R2D external interrupt encoder");
diff --git a/drivers/irqchip/irq-renesas-sh7751.c b/drivers/irqchip/irq-renesas-sh7751.c
new file mode 100644
index 000000000000..1c4b2be44c27
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas SH7751 interrupt controller driver
+ *
+ * Copyright 2023 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/io.h>
+
+static struct sh7751_intc_regs {
+	void *icr;
+	void *ipr;
+	void *intpri00;
+	void *intreq00;
+	void *intmsk00;
+	void *intmskclr00;
+} sh7751_regs;
+
+#define ICR_IRLM (1 << 7)
+
+static const unsigned int ipr_table[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 0 - 7 */
+	0x41, 0xff, 0xff, 0x40, 0xff, 0xff, 0xff, 0xff, /* 8 - 15 */
+	0x03, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00, 0x11, /* 16 - 23 */
+	0x11, 0x11, 0x11, 0x13, 0x12, 0x12, 0xff, 0xff, /* 24 - 31 */
+	0x30, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x21, /* 32 - 39 */
+	0x21, 0x21, 0x21, 0x21, 0x32, 0x32, 0x32, 0x32, /* 40 - 47 */
+	0xff, 0xff, 0xff, 0x40, 0xff, 0xff, 0xff, 0xff, /* 48 - 55 */
+	0xff, 0xff, 0xff, 0x40, 0xff, 0xff, 0xff, 0xff, /* 56 - 63 */
+};
+
+static const unsigned int pri_table[] = {
+	0, 4, 4, 4, 4, 4, 4, 4,
+	8, 32, 32, 32, 12, 32, 32, 32,
+};
+
+/* Bitmap of IRQ masked */
+#define IMASK_PRIORITY	15
+
+static DECLARE_BITMAP(imask_mask, IMASK_PRIORITY);
+static int interrupt_priority;
+
+static inline void set_interrupt_registers(int ip)
+{
+	unsigned long __dummy;
+
+	asm volatile(
+#ifdef CONFIG_CPU_HAS_SR_RB
+		     "ldc	%2, r6_bank\n\t"
+#endif
+		     "stc	sr, %0\n\t"
+		     "and	#0xf0, %0\n\t"
+		     "shlr2	%0\n\t"
+		     "cmp/eq	#0x3c, %0\n\t"
+		     "bt/s	1f	! CLI-ed\n\t"
+		     " stc	sr, %0\n\t"
+		     "and	%1, %0\n\t"
+		     "or	%2, %0\n\t"
+		     "ldc	%0, sr\n"
+		     "1:"
+		     : "=&z" (__dummy)
+		     : "r" (~0xf0), "r" (ip << 4)
+		     : "t");
+}
+
+static void update_ipr(struct sh7751_intc_regs *reg, int irq, int on)
+{
+	unsigned int addr;
+	int pos;
+	uint16_t pri;
+
+	if (irq < 64) {
+		if (ipr_table[irq] != 0xff) {
+			addr = (ipr_table[irq] & 0xf0) >> 2;
+			pos = (ipr_table[irq] & 0x0f) * 4;
+			pri = ~(0x000f << pos);
+			pri &= __raw_readw(reg->ipr + addr);
+			if (on)
+				pri |= 1 << pos;
+			__raw_writew(pri, reg->ipr + addr);
+		}
+	} else {
+		if (pri_table[irq - 64] < 32) {
+			pos = pri_table[irq - 64];
+			pri = ~(0x000f << pos);
+			pri &= __raw_readw(reg->intpri00);
+			if (on)
+				pri |= 1 << pos;
+			__raw_writew(pri, reg->intpri00);
+		}
+	}
+}
+
+static void sh7751_disable_irq(struct irq_data *data)
+{
+	unsigned int irq = data->irq;
+	struct sh7751_intc_regs *reg = data->chip_data;
+	uint16_t icr = __raw_readw(reg->icr);
+
+	if (irq < 16 && (icr & ICR_IRLM) == 0) {
+		clear_bit(irq, imask_mask);
+		if (interrupt_priority < IMASK_PRIORITY - irq)
+			interrupt_priority = IMASK_PRIORITY - irq;
+		set_interrupt_registers(interrupt_priority);
+	} else
+		update_ipr(reg, irq, 0);
+}
+
+static void sh7751_enable_irq(struct irq_data *data)
+{
+	unsigned int irq = data->irq;
+	struct sh7751_intc_regs *reg = data->chip_data;
+	uint16_t icr = __raw_readw(reg->icr);
+
+	if (irq < 16 && (icr & ICR_IRLM) == 0) {
+		set_bit(irq, imask_mask);
+		interrupt_priority = IMASK_PRIORITY -
+		  find_first_bit(imask_mask, IMASK_PRIORITY);
+		set_interrupt_registers(interrupt_priority);
+	} else
+		update_ipr(reg, irq, 1);
+}
+
+struct irq_chip sh7751_irq_chip = {
+	.name		= "SH7751-INTC",
+	.irq_unmask	= sh7751_enable_irq,
+	.irq_mask	= sh7751_disable_irq,
+};
+
+static int irq_sh7751_map(struct irq_domain *h, unsigned int virq,
+				  irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &sh7751_irq_chip, handle_level_irq);
+	irq_get_irq_data(virq)->chip_data = h->host_data;
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
+	return 0;
+}
+static const struct irq_domain_ops irq_ops = {
+	.map = irq_sh7751_map,
+	.xlate  = irq_domain_xlate_onecell,
+};
+
+static int __init sh7751_intc_of_init(struct device_node *intc,
+				      struct device_node *parent)
+{
+	unsigned short icr;
+	struct irq_domain *domain;
+	void *intc_baseaddr;
+	void *intc_baseaddr2;
+
+	intc_baseaddr = of_iomap(intc, 0);
+	intc_baseaddr2 = of_iomap(intc, 1);
+	if (!intc_baseaddr) {
+		pr_err("Invalid INTC address\n");
+		return -EINVAL;
+	}
+
+	sh7751_regs.icr = intc_baseaddr;
+	sh7751_regs.ipr = intc_baseaddr + 4;
+	sh7751_regs.intpri00 = intc_baseaddr2;
+	sh7751_regs.intreq00 = intc_baseaddr2 + 0x20;
+	sh7751_regs.intmsk00 = intc_baseaddr2 + 0x40;
+	sh7751_regs.intmskclr00 = intc_baseaddr2 + 0x60;
+
+	if (of_property_read_bool(intc, "sh7751,irlm")) {
+		icr = __raw_readw(sh7751_regs.icr);
+		icr |= 0x80;	// IRLM = 1
+		__raw_writew(icr, sh7751_regs.icr);
+	}
+
+	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, &sh7751_regs);
+	if (!domain) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+	irq_set_default_host(domain);
+	return 0;
+}
+
+IRQCHIP_DECLARE(sh_7751_intc,
+		"renesas,sh7751-intc", sh7751_intc_of_init);
-- 
2.39.2

