Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03699CDB484
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjJNOyX (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjJNOyW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:22 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94111DE
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:20 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id a1adc803-59f6-44b9-85b0-e7f20c90385d;
        Sat, 14 Oct 2023 23:54:20 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id C43081C04FD;
        Sat, 14 Oct 2023 23:54:19 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, maz@kernel.org
Subject: [RFC PATCH v3 16/35] drivers/irqchip: SH7751 IRL external encoder with enable gate.
Date:   Sat, 14 Oct 2023 23:53:51 +0900
Message-Id: <5dfc2f45fd9a701a92ba86800e4f6eba35d96ede.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SH7751 have 15 level external interrupt.
It is typically connected to the CPU through a priority encoder
that can suppress requests.
This driver provides a way to control those hardware with irqchip.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/irqchip/Kconfig                 |   7 +
 drivers/irqchip/Makefile                |   2 +
 drivers/irqchip/irq-renesas-sh7751irl.c | 206 ++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-sh7751irl.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 87bd490fec21..998c99c2c8ee 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -688,4 +688,11 @@ config RENESAS_SH7751_INTC
 	  Support for the Renesas SH7751 On-chip interrupt controller.
 	  And external interrupt encoder for some targets.
 
+config RENESAS_SH7751IRL_INTC
+	bool "Renesas SH7751 based target IRL encoder support."
+	depends on RENESAS_SH7751_INTC
+	help
+	  Support for External Interrupt encoder
+	  on the some Renesas SH7751 based target.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 26c91d075e25..91df16726b1f 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -121,3 +121,5 @@ obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
 obj-$(CONFIG_RENESAS_SH7751_INTC)	+= irq-renesas-sh7751.o
+obj-$(CONFIG_RENESAS_SH7751IRL_INTC)	+= irq-renesas-sh7751irl.o
+
diff --git a/drivers/irqchip/irq-renesas-sh7751irl.c b/drivers/irqchip/irq-renesas-sh7751irl.c
new file mode 100644
index 000000000000..1520d0cfda1e
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751irl.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SH7751 based board IRL encoder driver
+ * (Renesas RTS7751R2D / IO DATA DEVICE LANDISK, USL-5P)
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
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#define NUM_IRQ 15
+#define EXTIRQ_BASE 16
+
+struct sh7751irl_intc_priv {
+	void __iomem *base;
+	struct irq_domain *irq_domain;
+	int width;
+	int type;
+	int nr_irq;
+	u32 enable_map[NUM_IRQ];
+};
+
+enum {type_enable, type_mask};
+
+static inline u32 get_reg(void *addr, int w)
+{
+	switch (w) {
+	case 8:
+		return __raw_readb(addr);
+	case 16:
+		return __raw_readw(addr);
+	case 32:
+		return __raw_readl(addr);
+	}
+	return 0;
+}
+
+static inline void set_reg(void *addr, int w, u32 val)
+{
+	switch (w) {
+	case 8:
+		__raw_writeb(val, addr);
+		break;
+	case 16:
+		__raw_writew(val, addr);
+		break;
+	case 32:
+		__raw_writel(val, addr);
+		break;
+	}
+}
+
+static inline struct sh7751irl_intc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static inline u32 set_reset_bit(int val, u32 in, int bit, int type)
+{
+	val &= 1;
+	if (type == type_mask)
+		val ^= 1;
+	in &= ~(1 << bit);
+	return in | (val << bit);
+}
+
+static inline void mask_unmask(struct irq_data *data, int en)
+{
+	struct sh7751irl_intc_priv *priv = irq_data_to_priv(data);
+	int irq = data->irq - EXTIRQ_BASE;
+	u32 val;
+
+	if (priv->nr_irq > irq && priv->enable_map[irq] < priv->width) {
+		val = get_reg(priv->base, priv->width);
+		val = set_reset_bit(en, val, priv->enable_map[irq], priv->type);
+		set_reg(priv->base, priv->width, val);
+	}
+}
+
+static void sh7751irl_intc_mask_irq(struct irq_data *data)
+{
+	mask_unmask(data, 0);
+}
+
+static void sh7751irl_intc_unmask_irq(struct irq_data *data)
+{
+	mask_unmask(data, 1);
+}
+
+static struct irq_chip sh7751irl_intc_chip = {
+	.name		= "SH7751IRL-INTC",
+	.irq_unmask	= sh7751irl_intc_unmask_irq,
+	.irq_mask	= sh7751irl_intc_mask_irq,
+};
+
+static int sh7751irl_intc_map(struct irq_domain *h, unsigned int virq,
+			       irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &sh7751irl_intc_chip, handle_level_irq);
+	irq_get_irq_data(virq)->chip_data = h->host_data;
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
+	return 0;
+}
+
+static int sh7751irl_intc_translate(struct irq_domain *domain,
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
+		*hwirq = fwspec->param[0] + EXTIRQ_BASE;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct irq_domain_ops sh7751irl_intc_domain_ops = {
+	.map = sh7751irl_intc_map,
+	.translate = sh7751irl_intc_translate,
+};
+
+static int sh7751irl_init(struct device_node *node, struct device_node *parent)
+{
+	struct sh7751irl_intc_priv *priv;
+	struct irq_domain *d;
+	int ret = 0;
+	int type = -1;
+	u32 *p;
+	unsigned int i, nr_input = 0;
+	const char *type_str;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = of_iomap(node, 0);
+	if (IS_ERR(priv->base)) {
+		ret = PTR_ERR(priv->base);
+		goto error;
+	}
+	of_property_read_u32(node, "renesas,width", &priv->width);
+	if (priv->width != 8 && priv->width != 16 && priv->width != 32) {
+		pr_err("%s Invalid register width.\n", node->name);
+		ret = -EINVAL;
+		goto error;
+	}
+	if (!of_property_read_string(node, "renesas,regtype", &type_str)) {
+		if (strcasecmp("enable", type_str) == 0)
+			type = type_enable;
+		else if (strcasecmp("mask", type_str) == 0)
+			type = type_mask;
+	}
+	if (type < 0) {
+		pr_err("%pOFP: renesas,regtype Invalid register type (%s).\n", node, type_str);
+		ret = -EINVAL;
+		goto error;
+	}
+	priv->type = type;
+
+	priv->nr_irq = of_property_count_u32_elems(node, "renesas,irqbit");
+	if (priv->nr_irq < NUM_IRQ) {
+		of_property_read_u32_array(node, "renesas,irqbit", priv->enable_map, priv->nr_irq);
+		for (p = priv->enable_map, i = 0; i < priv->nr_irq; p++, i++) {
+			if (*p != 0xffffffff)
+				nr_input++;
+		}
+	}
+	if (priv->nr_irq <= 0 || priv->nr_irq >= NUM_IRQ || nr_input > priv->width) {
+		pr_err("%pOFP: renesas,irqbit Invalid register definition.\n", node);
+		ret = -EINVAL;
+		goto error;
+	}
+	d = irq_domain_add_tree(node, &sh7751irl_intc_domain_ops, priv);
+	if (d == NULL) {
+		pr_err("%pOFP: cannot initialize irq domain\n", node);
+		ret = -ENOMEM;
+		goto error;
+	}
+	priv->irq_domain = d;
+	irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+	pr_info("%pOFP: SH7751 External Interrupt encoder (input=%d)", node, nr_input);
+	return 0;
+error:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(renesas_sh7751_irl, "renesas,sh7751-irl-ext", sh7751irl_init);
-- 
2.39.2

