Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481FBCA5527
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbjIMJYR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80A319A4
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:06 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 2d6421df-92c6-4b32-8d7a-54d5e48583d9;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 1E1BD1C0198;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 16/30] drivers/irqchip: SH7751 IRL external encoder with enable gate.
Date:   Wed, 13 Sep 2023 18:23:41 +0900
Message-Id: <ca08873f80dfc356ae4fed363b9cc6ef5e9c8af6.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
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
 drivers/irqchip/irq-renesas-sh7751irl.c | 183 ++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-sh7751irl.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 167832daa903..9ea7fd49d7cb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -688,4 +688,11 @@ config RENESAS_SH7751_INTC
 	  Support for the Renesas SH7751 On-chip interrupt controller.
 	  And external interrupt encoder for some targets.
 
+config RENESAS_SH7751IRL_INTC
+        bool "Renesas SH7751 based target IRL encoder support."
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
index 000000000000..3aadf9336115
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751irl.c
@@ -0,0 +1,183 @@
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
+	int pol;
+	int nr_irq;
+	u32 enable_map[NUM_IRQ];
+};
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
+static inline u32 set_reset_bit(int val, u32 in, int bit, int pol)
+{
+	val &= 1;
+	if (pol)
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
+		val = set_reset_bit(en, val, priv->enable_map[irq], priv->pol);
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
+	of_property_read_u32(node, "sh7751irl,width", &priv->width);
+	if (priv->width != 8 && priv->width != 16 && priv->width != 32) {
+		pr_err("%s Invalid register width.\n", node->name);
+		ret = -EINVAL;
+		goto error;
+	}
+	of_property_read_u32(node, "sh7751irl,polarity", &priv->pol);
+	priv->nr_irq = of_property_count_u32_elems(node, "sh7751irl,irqbit");
+	if (priv->nr_irq <= 0 || priv->nr_irq >= NUM_IRQ) {
+		pr_err("%s sh7751irl: Invalid register definition.\n", node->name);
+		ret = -EINVAL;
+		goto error;
+	}
+	of_property_read_u32_array(node, "sh7751irl,irqbit", priv->enable_map, priv->nr_irq);
+
+	d = irq_domain_add_tree(node, &sh7751irl_intc_domain_ops, priv);
+	if (d == NULL) {
+		pr_err("%s: cannot initialize irq domain\n", node->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+	priv->irq_domain = d;
+	irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+
+	return 0;
+error:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(renesas_sh7751_irl, "renesas,sh7751-irl-ext", sh7751irl_init);
-- 
2.39.2

