Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9673CA551A
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjIMJYN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957F199E
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:05 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id cd8459a2-a307-4c58-8e39-13d8eefa5ff9;
        Wed, 13 Sep 2023 18:24:04 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id C8DFF1C0198;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, linux-clk@vger.kernel.org
Subject: [RFC PATCH v2 10/30] drivers/clk: SH7750 / SH7751 CPG Driver
Date:   Wed, 13 Sep 2023 18:23:35 +0900
Message-Id: <a9a3e6f0dfdd1c5d6970d2decffef3c07d93476e.1694596125.git.ysato@users.sourceforge.jp>
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
 drivers/clk/renesas/clk-sh7750.c | 236 +++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 drivers/clk/renesas/clk-sh7750.c

diff --git a/drivers/clk/renesas/clk-sh7750.c b/drivers/clk/renesas/clk-sh7750.c
new file mode 100644
index 000000000000..51f1aecd23dc
--- /dev/null
+++ b/drivers/clk/renesas/clk-sh7750.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas SH7750/51 CPG driver
+ *
+ * Copyright 2023 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include "clk-shdiv.h"
+#include <dt-bindings/clock/sh7750.h>
+
+static DEFINE_SPINLOCK(clklock);
+
+/* PCLK divide rate selector */
+static const struct clk_div_table pdiv_table[] = {
+	{ .val = 0, .div = 2, },
+	{ .val = 1, .div = 3, },
+	{ .val = 2, .div = 4, },
+	{ .val = 3, .div = 6, },
+	{ .val = 4, .div = 8, },
+	{ }
+};
+
+/* ICLK and BCLK divide rate selector */
+static const struct clk_div_table div_table[] = {
+	{ .val = 0, .div = 1, },
+	{ .val = 1, .div = 2, },
+	{ .val = 2, .div = 3, },
+	{ .val = 3, .div = 4, },
+	{ .val = 4, .div = 6, },
+	{ .val = 5, .div = 8, },
+	{ }
+};
+
+struct cpg_priv {
+	struct clk_hw hw;
+	void __iomem *frqcr;
+	void __iomem *wdt;
+	u32 mode;
+	bool have_div1;
+};
+
+#define to_priv(_hw) container_of(_hw, struct cpg_priv, hw)
+
+#define FRQCR_PLL1EN BIT(10)
+static const int pll1mult[] = { 12, 12, 6, 12, 6, 12, 1};
+
+static unsigned long pll_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	struct cpg_priv *cpg = to_priv(hw);
+	unsigned long rate = parent_rate;
+	uint16_t frqcr;
+
+	frqcr = ioread16(cpg->frqcr);
+	if (frqcr & FRQCR_PLL1EN) {
+		rate *= pll1mult[cpg->mode];
+		if (cpg->mode < 6 && cpg->have_div1)
+			rate /= 2;
+	}
+	return rate;
+}
+
+static void get_round_rate(struct cpg_priv *cpg,
+			   unsigned long *out, bool *pllen,
+			   unsigned long rate, unsigned long prate)
+{
+	long pllout, res;
+	bool pll;
+
+	if (cpg->mode < 6 && cpg->have_div1)
+		prate /= 2;
+
+	pllout = prate * pll1mult[cpg->mode];
+	if (abs(pllout - rate) > abs(prate - rate)) {
+		res = prate;
+		pll = false;
+	} else {
+		res = pllout;
+		pll = true;
+	}
+	if (out)
+		*out = res;
+	if (pllen)
+		*pllen = pll;
+}
+
+static int pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct cpg_priv *cpg = to_priv(hw);
+
+	get_round_rate(cpg, &req->rate, NULL, req->rate, req->best_parent_rate);
+	return 0;
+}
+
+static int pll_set_rate(struct clk_hw *hw,
+			unsigned long rate, unsigned long prate)
+{
+	struct cpg_priv *cpg = to_priv(hw);
+	bool oldpll, newpll;
+	uint16_t frqcr;
+
+	frqcr = ioread16(cpg->frqcr);
+	get_round_rate(cpg, NULL, &newpll, rate, prate);
+	oldpll = frqcr & FRQCR_PLL1EN;
+	frqcr &= ~FRQCR_PLL1EN;
+
+	if (newpll) {
+		frqcr |= FRQCR_PLL1EN;
+		if (!oldpll) {
+			/* set PLL wakeup delay time */
+			iowrite16(0xa500, cpg->wdt + 4);
+			iowrite16(0xa507, cpg->wdt + 4);
+			iowrite16(0xa507, cpg->wdt + 4);
+			iowrite16(0x5a00, cpg->wdt);
+		}
+	}
+	iowrite16(frqcr, cpg->frqcr);
+
+	/* Test for new PLL state */
+	frqcr = ioread16(cpg->frqcr);
+	oldpll = frqcr & FRQCR_PLL1EN;
+	return !(oldpll == newpll);
+}
+
+static const struct clk_ops pll_ops = {
+	.recalc_rate = pll_recalc_rate,
+	.determine_rate = pll_determine_rate,
+	.set_rate = pll_set_rate,
+};
+
+#define PLLOUT "pllout"
+
+static int __init register_pll(struct device_node *node, struct cpg_priv *cpg)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	struct clk_init_data init;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.name = PLLOUT;
+	init.ops = &pll_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	cpg->hw.init = &init;
+
+	if (of_clk_hw_register(node, &cpg->hw) < 0) {
+		pr_err("%s: failed to register %s pll clock (%ld)\n",
+		       __func__, clk_name, PTR_ERR(clk));
+		return 0;
+	}
+	of_clk_add_hw_provider(node, of_clk_hw_simple_get, &cpg->hw);
+
+	return 1;
+}
+
+static void __init register_div(struct device_node *node, struct cpg_priv *cpg)
+{
+	static const char * const divout[] = {
+		[SH7750_CPG_FCK] = "fck",
+		[SH7750_CPG_BCK] = "bck",
+		[SH7750_CPG_ICK] = "ick",
+	};
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(divout); i++) {
+		if (sh_div_clk_register(node, divout[i], PLLOUT,
+					cpg->frqcr, i * 3, 3,
+					(i == 0) ? pdiv_table : div_table,
+					&clklock) < 0)
+			pr_err("%s: failed to register %s div clock (%ld)\n",
+			       __func__, divout[i], PTR_ERR(clk));
+	}
+}
+
+
+static void __init sh7750_cpg_setup(struct device_node *node)
+{
+	unsigned int num_parents;
+	struct cpg_priv *cpg;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: no parent found", node->name);
+		return;
+	}
+
+	cpg = kzalloc(sizeof(struct cpg_priv), GFP_KERNEL);
+	if (!cpg) {
+		pr_err("%s: failed to alloc memory", node->name);
+		return;
+	}
+
+	of_property_read_u32_index(node, "renesas,mode", 0, &cpg->mode);
+	if (cpg->mode >= 7) {
+		pr_err("%s: Invalid clock mode setting (%u)\n",
+		       node->name, cpg->mode);
+		goto cpg_free;
+	}
+	cpg->have_div1 = (of_device_is_compatible(node, "renesas,sh7750r-pll-clk") == 0);
+
+	cpg->frqcr = of_iomap(node, 0);
+	if (cpg->frqcr == NULL) {
+		pr_err("%s: failed to map divide register", node->name);
+		goto cpg_free;
+	}
+
+	cpg->wdt = of_iomap(node, 1);
+	if (cpg->wdt == NULL) {
+		pr_err("%s: failed to map watchdog register", node->name);
+		goto unmap_frqcr;
+	}
+
+	if (!register_pll(node, cpg))
+		goto unmap_wdt;
+
+	register_div(node, cpg);
+
+unmap_wdt:
+	iounmap(cpg->wdt);
+unmap_frqcr:
+	iounmap(cpg->frqcr);
+cpg_free:
+	kfree(cpg);
+}
+
+CLK_OF_DECLARE(sh7750_cpg, "renesas,sh7750-cpg",
+	       sh7750_cpg_setup);
-- 
2.39.2

