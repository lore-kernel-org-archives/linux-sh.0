Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F340CA551B
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjIMJYQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666319A2
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:06 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 405d25b9-50c6-404e-b0a4-7aba98487fd3;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id B47B41C005D;
        Wed, 13 Sep 2023 18:24:04 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 14/30] drivers/irqchip: Add SH7751 Internal INTC drivers.
Date:   Wed, 13 Sep 2023 18:23:39 +0900
Message-Id: <1f9decd26e1321e30ca5091c2447456f0e81efe1.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/irqchip/Kconfig              |   9 ++
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-renesas-sh7751.c | 232 +++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..167832daa903 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -679,4 +679,13 @@ config SUNPLUS_SP7021_INTC
 	  chained controller, routing all interrupt source in P-Chip to
 	  the primary controller on C-Chip.
 
+config RENESAS_SH7751_INTC
+        bool "Renesas SH7751 Interrupt Controller"
+	depends on SH_DEVICE_TREE
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
index 000000000000..1ce0851e35cd
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751.c
@@ -0,0 +1,232 @@
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
+
+#define IPRA	0
+#define IPRB	4
+#define IPRC	8
+#define IPRD	12
+#define INTPRI00 128
+#define IPR_B12	12
+#define IPR_B8	8
+#define IPR_B4	4
+#define IPR_B0	0
+
+/* INTEVT to IPR mapping */
+static const struct iprmap {
+	int intevt;
+	int off;
+	int bit;
+} iprmaps[] = {
+#define IPRDEF(e, o, b) { .intevt = evt2irq(e), .off = o, .bit = b }
+	IPRDEF(0x240, IPRD, IPR_B12),	/* IRL0 */
+	IPRDEF(0x2a0, IPRD, IPR_B8),	/* IRL1 */
+	IPRDEF(0x300, IPRD, IPR_B4),	/* IRL2 */
+	IPRDEF(0x360, IPRD, IPR_B0),	/* IRL3 */
+	IPRDEF(0x400, IPRA, IPR_B12),	/* TMU0 */
+	IPRDEF(0x420, IPRA, IPR_B8),	/* TMU1 */
+	IPRDEF(0x440, IPRA, IPR_B4),	/* TMU2 TNUI */
+	IPRDEF(0x460, IPRA, IPR_B4),	/* TMU2 TICPI */
+	IPRDEF(0x480, IPRA, IPR_B0),	/* RTC ATI */
+	IPRDEF(0x4a0, IPRA, IPR_B0),	/* RTC PRI */
+	IPRDEF(0x4c0, IPRA, IPR_B0),	/* RTC CUI */
+	IPRDEF(0x4e0, IPRB, IPR_B4),	/* SCI ERI */
+	IPRDEF(0x500, IPRB, IPR_B4),	/* SCI RXI */
+	IPRDEF(0x520, IPRB, IPR_B4),	/* SCI TXI */
+	IPRDEF(0x540, IPRB, IPR_B4),	/* SCI TEI */
+	IPRDEF(0x560, IPRB, IPR_B12),	/* WDT */
+	IPRDEF(0x580, IPRB, IPR_B8),	/* REF RCMI */
+	IPRDEF(0x5a0, IPRB, IPR_B4),	/* REF ROVI */
+	IPRDEF(0x600, IPRC, IPR_B0),	/* H-UDI */
+	IPRDEF(0x620, IPRC, IPR_B12),	/* GPIO */
+	IPRDEF(0x640, IPRC, IPR_B8),	/* DMAC DMTE0 */
+	IPRDEF(0x660, IPRC, IPR_B8),	/* DMAC DMTE1 */
+	IPRDEF(0x680, IPRC, IPR_B8),	/* DMAC DMTE2 */
+	IPRDEF(0x6a0, IPRC, IPR_B8),	/* DMAC DMTE3 */
+	IPRDEF(0x6c0, IPRC, IPR_B8),	/* DMAC DMAE */
+	IPRDEF(0x700, IPRC, IPR_B4),	/* SCIF ERI */
+	IPRDEF(0x720, IPRC, IPR_B4),	/* SCIF RXI */
+	IPRDEF(0x740, IPRC, IPR_B4),	/* SCIF BRI */
+	IPRDEF(0x760, IPRC, IPR_B4),	/* SCIF TXI */
+	IPRDEF(0x780, IPRC, IPR_B8),	/* DMAC DMTE4 */
+	IPRDEF(0x7a0, IPRC, IPR_B8),	/* DMAC DMTE5 */
+	IPRDEF(0x7c0, IPRC, IPR_B8),	/* DMAC DMTE6 */
+	IPRDEF(0x7e0, IPRC, IPR_B8),	/* DMAC DMTE7 */
+	IPRDEF(0xa00, INTPRI00, IPR_B0),	/* PCIC PCISERR */
+	IPRDEF(0xa20, INTPRI00, IPR_B4),	/* PCIC PCIDMA3 */
+	IPRDEF(0xa40, INTPRI00, IPR_B4),	/* PCIC PCIDMA2 */
+	IPRDEF(0xa60, INTPRI00, IPR_B4),	/* PCIC PCIDMA1 */
+	IPRDEF(0xa80, INTPRI00, IPR_B4),	/* PCIC PCIDMA0 */
+	IPRDEF(0xaa0, INTPRI00, IPR_B4),	/* PCIC PCIPWON */
+	IPRDEF(0xac0, INTPRI00, IPR_B4),	/* PCIC PCIPWDWN */
+	IPRDEF(0xae0, INTPRI00, IPR_B4),	/* PCIC PCIERR */
+	IPRDEF(0xb00, INTPRI00, IPR_B8),	/* TMU3 */
+	IPRDEF(0xb80, INTPRI00, IPR_B12),	/* TMU4 */
+};
+
+static int ipr_compare(const void *a, const void *b)
+{
+	return (int)a - ((struct iprmap *)b)->intevt;
+}
+
+static void update_ipr(struct sh7751_intc_regs *reg, int irq, int pval)
+{
+	void *prireg;
+	struct iprmap *p;
+	u16 pri;
+
+	p = bsearch((void *)irq, iprmaps, ARRAY_SIZE(iprmaps),
+		       sizeof(struct iprmap), ipr_compare);
+	if (p) {
+		prireg = (p->off < INTPRI00) ? reg->ipr + p->off : reg->intpri00;
+		pri = ~(0x000f << p->bit);
+		pri &= __raw_readw(prireg);
+		pri |= (pval & 0x0f) << p->bit;
+		__raw_writew(pri, prireg);
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
+		/* IRL encoded externel interrupt */
+		/* disable for SR.IMASK */
+		clear_bit(irq, imask_mask);
+		if (interrupt_priority < IMASK_PRIORITY - irq)
+			interrupt_priority = IMASK_PRIORITY - irq;
+		set_interrupt_registers(interrupt_priority);
+	} else
+		/* Internal periphreal interrupt */
+		/* IPR priority is 0 */
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
+static int __init sh7751_intc_of_init(struct device_node *intc,
+				      struct device_node *parent)
+{
+	u16 icr;
+	struct irq_domain *domain;
+	void *intc_baseaddr;
+	void *intc_baseaddr2;
+
+	intc_baseaddr = of_iomap(intc, 0);
+	intc_baseaddr2 = of_iomap(intc, 1);
+	if (IS_ERR(intc_baseaddr)) {
+		pr_err("%s: Invalid register definition\n", intc->name);
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
+		icr |= ICR_IRLM;
+		__raw_writew(icr, sh7751_regs.icr);
+	}
+
+	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, &sh7751_regs);
+	if (domain == NULL) {
+		pr_err("%s: cannot initialize irq domain\n", intc->name);
+		return -ENOMEM;
+	}
+
+	irq_set_default_host(domain);
+	return 0;
+}
+
+IRQCHIP_DECLARE(sh_7751_intc,
+		"renesas,sh7751-intc", sh7751_intc_of_init);
-- 
2.39.2

