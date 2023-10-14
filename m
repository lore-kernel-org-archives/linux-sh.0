Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AFECDB491
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjJNOya (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJNOyY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:24 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F99E4
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:21 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 9f7e78b4-0ea4-4aa4-ad98-e06a1d254fc5;
        Sat, 14 Oct 2023 23:54:19 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 2A18D1C053C;
        Sat, 14 Oct 2023 23:54:19 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, maz@kernel.org
Subject: [RFC PATCH v3 14/35] drivers/irqchip: Add SH7751 Internal INTC drivers.
Date:   Sat, 14 Oct 2023 23:53:49 +0900
Message-Id: <b7d3002d7033a94a57577af68a13f4cfc3a88947.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SH7751 Internal interrupt controler driver.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/irqchip/Kconfig              |   9 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-renesas-sh7751.c | 255 +++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..87bd490fec21 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -679,4 +679,13 @@ config SUNPLUS_SP7021_INTC
 	  chained controller, routing all interrupt source in P-Chip to
 	  the primary controller on C-Chip.
 
+config RENESAS_SH7751_INTC
+	bool "Renesas SH7751 Interrupt Controller"
+	depends on SH_DEVICE_TREE || COMPILE_TEST
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Renesas SH7751 On-chip interrupt controller.
+	  And external interrupt encoder for some targets.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..26c91d075e25 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
+obj-$(CONFIG_RENESAS_SH7751_INTC)	+= irq-renesas-sh7751.o
diff --git a/drivers/irqchip/irq-renesas-sh7751.c b/drivers/irqchip/irq-renesas-sh7751.c
new file mode 100644
index 000000000000..585367d9c9a4
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751.c
@@ -0,0 +1,255 @@
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
+#include <linux/bsearch.h>
+#include <linux/io.h>
+#include <linux/sort.h>
+#include <dt-bindings/interrupt-controller/sh_intc.h>
+
+struct iprmap {
+	unsigned int irq;
+	unsigned int reg;
+	unsigned int bits;
+};
+
+struct sh7751_intc_priv {
+	void *icr;
+	void *ipr;
+	void *intpri00;
+	void *intreq00;
+	void *intmsk00;
+	void *intmskclr00;
+	struct iprmap *iprmap;
+	unsigned int num_ipr;
+	bool irlm;
+};
+
+#define ICR_IRLM BIT(7)
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
+static int search_ipr_comp(const void *a, const void *b)
+{
+	return (int)a - ((struct iprmap *)b)->irq;
+}
+
+static void update_ipr(struct sh7751_intc_priv *priv, int irq, int pval)
+{
+	void *prireg;
+	struct iprmap *p;
+	u16 pri;
+
+	p = bsearch((void *)irq, priv->iprmap, priv->num_ipr,
+		       sizeof(struct iprmap), search_ipr_comp);
+	if (p) {
+		prireg = (p->reg < INTPRI00) ? priv->ipr : priv->intpri00;
+		prireg += p->reg & (INTPRI00 - 1);
+		pri = ~(0x000f << p->bits);
+		pri &= __raw_readw(prireg);
+		pri |= (pval & 0x0f) << p->bits;
+		__raw_writew(pri, prireg);
+	} else
+		pr_warn_once("%s: undefined IPR in irq %d\n", __FILE__, irq);
+}
+
+static void sh7751_disable_irq(struct irq_data *data)
+{
+	unsigned int irq = data->irq;
+	struct sh7751_intc_priv *priv = data->chip_data;
+
+	if (irq < 16 && !priv->irlm) {
+		/* IRL encoded externel interrupt */
+		/* disable for SR.IMASK */
+		clear_bit(irq, imask_mask);
+		if (interrupt_priority < IMASK_PRIORITY - irq)
+			interrupt_priority = IMASK_PRIORITY - irq;
+		set_interrupt_registers(interrupt_priority);
+	} else
+		/* Internal periphreal interrupt */
+		/* IPR priority is 0 */
+		update_ipr(priv, irq, 0);
+}
+
+static void sh7751_enable_irq(struct irq_data *data)
+{
+	unsigned int irq = data->irq;
+	struct sh7751_intc_priv *priv = data->chip_data;
+
+	if (irq < 16 && !priv->irlm) {
+		set_bit(irq, imask_mask);
+		interrupt_priority = IMASK_PRIORITY -
+		  find_first_bit(imask_mask, IMASK_PRIORITY);
+		set_interrupt_registers(interrupt_priority);
+	} else
+		update_ipr(priv, irq, 1);
+}
+
+static const struct irq_chip sh7751_irq_chip = {
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
+static int sort_ipr_cmp(const void *a, const void *b)
+{
+	unsigned int irq_a = ((struct iprmap *)a)->irq;
+	unsigned int irq_b = ((struct iprmap *)b)->irq;
+
+	return irq_a - irq_b;
+}
+
+static void sort_ipr_swap(void *a, void *b, int sz)
+{
+	struct iprmap tmp;
+
+	memcpy(&tmp, a, sizeof(tmp));
+	memcpy(a, b, sizeof(tmp));
+	memcpy(b, &tmp, sizeof(tmp));
+}
+
+static int __init load_ipr_map(struct device_node *intc,
+			       struct sh7751_intc_priv *priv)
+{
+	int num_ipr;
+	struct iprmap *p;
+	u32 val[3];
+	unsigned int i, idx;
+
+	num_ipr = of_property_count_elems_of_size(intc, "renesas,ipr-map", sizeof(u32) * 3);
+	if (num_ipr < 0)
+		return num_ipr;
+
+	priv->iprmap = kcalloc(num_ipr, sizeof(struct iprmap), GFP_KERNEL);
+	if (priv->iprmap == NULL) {
+		pr_err("%s: Failed to alloc memory\n", intc->name);
+		return -ENOMEM;
+	}
+	priv->num_ipr = num_ipr;
+
+	for (p = priv->iprmap, idx = 0; num_ipr > 0; p++, num_ipr--) {
+		for (i = 0; i < 3; idx++, i++) {
+			if (of_property_read_u32_index(intc, "renesas,ipr-map",
+						       idx, &val[i])) {
+				pr_err("%s: Failed to load ipr-map\n", intc->name);
+				kfree(priv->iprmap);
+				return -EINVAL;
+			}
+		}
+		p->irq = evt2irq(val[0]);
+		p->reg = val[1];
+		p->bits = val[2];
+	}
+	/* This table will be searched using bsearch, so sort it. */
+	sort(priv->iprmap, priv->num_ipr, sizeof(struct iprmap),
+	     sort_ipr_cmp, sort_ipr_swap);
+
+	for (p = priv->iprmap, idx = 0; idx < priv->num_ipr; p++, idx++)
+		pr_debug("irq=%04x reg=%02x bits=%d\n", p->irq, p->reg, p->bits);
+	return 0;
+}
+
+static int __init sh7751_intc_of_init(struct device_node *intc,
+				      struct device_node *parent)
+{
+	u16 icr;
+	struct irq_domain *domain;
+	void *intc_baseaddr;
+	void *intc_baseaddr2;
+	struct sh7751_intc_priv *priv;
+	int ret;
+
+	intc_baseaddr = of_iomap(intc, 0);
+	intc_baseaddr2 = of_iomap(intc, 1);
+	if (IS_ERR(intc_baseaddr)) {
+		pr_err("%pOFP: Invalid register definition\n", intc);
+		return -EINVAL;
+	}
+
+	priv = kzalloc(sizeof(struct sh7751_intc_priv), GFP_KERNEL);
+	if (priv == NULL) {
+		pr_err("%pOFP: Failed to alloc memory\n", intc);
+		return -ENOMEM;
+	}
+	ret = load_ipr_map(intc, priv);
+	if (ret < 0) {
+		kfree(priv);
+		return ret;
+	}
+
+	priv->icr = intc_baseaddr;
+	priv->ipr = intc_baseaddr + 4;
+	priv->intpri00 = intc_baseaddr2;
+	priv->intreq00 = intc_baseaddr2 + 0x20;
+	priv->intmsk00 = intc_baseaddr2 + 0x40;
+	priv->intmskclr00 = intc_baseaddr2 + 0x60;
+
+	if (of_property_read_bool(intc, "renesas,irlm")) {
+		priv->irlm = true;
+		icr = __raw_readw(priv->icr);
+		icr |= ICR_IRLM;
+		__raw_writew(icr, priv->icr);
+	}
+
+	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, priv);
+	if (domain == NULL) {
+		pr_err("%pOFP: cannot initialize irq domain\n", intc);
+		kfree(priv);
+		return -ENOMEM;
+	}
+
+	irq_set_default_host(domain);
+	pr_info("%pOFP: SH7751 Interrupt controller (%s external IRQ)",
+		intc, priv->irlm ? "4 lines" : "15 level");
+	return 0;
+}
+
+IRQCHIP_DECLARE(sh_7751_intc,
+		"renesas,sh7751-intc", sh7751_intc_of_init);
-- 
2.39.2

