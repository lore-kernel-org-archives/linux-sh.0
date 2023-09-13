Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E6ECA5523
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbjIMJYP (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47068173E
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:05 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id da1abe5c-e986-40d7-846a-8155217b1ea4;
        Wed, 13 Sep 2023 18:24:04 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 1A6621C005D;
        Wed, 13 Sep 2023 18:24:04 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, linux-clk@vger.kernel.org
Subject: [RFC PATCH v2 11/30] drivers/clk: SuperH generai clock divider helper
Date:   Wed, 13 Sep 2023 18:23:36 +0900
Message-Id: <d886ddd66e60319483619d90176ba34537c471e8.1694596125.git.ysato@users.sourceforge.jp>
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
 drivers/clk/renesas/clk-shdiv.c | 346 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/clk-shdiv.h |  18 ++
 2 files changed, 364 insertions(+)
 create mode 100644 drivers/clk/renesas/clk-shdiv.c
 create mode 100644 drivers/clk/renesas/clk-shdiv.h

diff --git a/drivers/clk/renesas/clk-shdiv.c b/drivers/clk/renesas/clk-shdiv.c
new file mode 100644
index 000000000000..90055bc384c7
--- /dev/null
+++ b/drivers/clk/renesas/clk-shdiv.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SuperH divider clock driver
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include "clk-shdiv.h"
+
+#define div_mask(width)	((1 << (width)) - 1)
+
+static unsigned int _get_table_maxdiv(const struct clk_div_table *table,
+				      u8 width)
+{
+	unsigned int maxdiv = 0, mask = div_mask(width);
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div > maxdiv && clkt->val <= mask)
+			maxdiv = clkt->div;
+	return maxdiv;
+}
+
+static unsigned int _get_maxdiv(const struct clk_div_table *table, u8 width)
+{
+	if (table)
+		return _get_table_maxdiv(table, width);
+	return div_mask(width) + 1;
+}
+
+static unsigned int _get_table_div(const struct clk_div_table *table,
+				   unsigned int val)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val == val)
+			return clkt->div;
+	return 0;
+}
+
+static unsigned int _get_div(const struct clk_div_table *table,
+			     unsigned int val,  u8 width)
+{
+	if (table)
+		return _get_table_div(table, val);
+	return val + 1;
+}
+
+static unsigned int _get_table_val(const struct clk_div_table *table,
+				   unsigned int div)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div == div)
+			return clkt->val;
+	return 0;
+}
+
+static unsigned int _get_val(const struct clk_div_table *table,
+			     unsigned int div, u8 width)
+{
+	if (table)
+		return  _get_table_val(table, div);
+	return div - 1;
+}
+
+static unsigned long sh_divider_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate,
+					 unsigned int val,
+					 const struct clk_div_table *table)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int div;
+
+	div = _get_div(table, val, divider->width);
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+}
+
+static unsigned long sh_clk_divider_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int val;
+
+	val = __raw_readw(divider->reg) >> divider->shift;
+	val &= div_mask(divider->width);
+
+	return sh_divider_recalc_rate(hw, parent_rate, val, divider->table);
+}
+
+static bool _is_valid_table_div(const struct clk_div_table *table,
+				unsigned int div)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div == div)
+			return true;
+	return false;
+}
+
+static bool _is_valid_div(const struct clk_div_table *table, unsigned int div)
+{
+	if (table)
+		return _is_valid_table_div(table, div);
+	return true;
+}
+
+static int _round_up_table(const struct clk_div_table *table, int div)
+{
+	const struct clk_div_table *clkt;
+	int up = INT_MAX;
+
+	for (clkt = table; clkt->div; clkt++) {
+		if (clkt->div == div)
+			return clkt->div;
+		else if (clkt->div < div)
+			continue;
+
+		if ((clkt->div - div) < (up - div))
+			up = clkt->div;
+	}
+
+	return up;
+}
+
+static int _div_round_up(const struct clk_div_table *table,
+			 unsigned long parent_rate, unsigned long rate)
+{
+	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+
+	if (table)
+		div = _round_up_table(table, div);
+
+	return div;
+}
+
+static int _div_round(const struct clk_div_table *table,
+		      unsigned long parent_rate, unsigned long rate)
+{
+	return _div_round_up(table, parent_rate, rate);
+}
+
+static bool _is_best_div(unsigned long rate, unsigned long now,
+			 unsigned long best)
+{
+	return now <= rate && now > best;
+}
+
+static int _next_div(const struct clk_div_table *table, int div)
+{
+	div++;
+
+	if (table)
+		return _round_up_table(table, div);
+
+	return div;
+}
+
+static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *best_parent_rate,
+			       const struct clk_div_table *table, u8 width)
+{
+	int i, bestdiv = 0;
+	unsigned long parent_rate, best = 0, now, maxdiv;
+	unsigned long parent_rate_saved = *best_parent_rate;
+
+	if (!rate)
+		rate = 1;
+
+	maxdiv = _get_maxdiv(table, width);
+
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		parent_rate = *best_parent_rate;
+		bestdiv = _div_round(table, parent_rate, rate);
+		bestdiv = bestdiv == 0 ? 1 : bestdiv;
+		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
+		return bestdiv;
+	}
+
+	/*
+	 * The maximum divider we can use without overflowing
+	 * unsigned long in rate * i below
+	 */
+	maxdiv = min(ULONG_MAX / rate, maxdiv);
+
+	for (i = _next_div(table, 0); i <= maxdiv;
+	     i = _next_div(table, i)) {
+		if (rate * i == parent_rate_saved) {
+			/*
+			 * It's the most ideal case if the requested rate can be
+			 * divided from parent clock without needing to change
+			 * parent rate, so return the divider immediately.
+			 */
+			*best_parent_rate = parent_rate_saved;
+			return i;
+		}
+		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+					       rate * i);
+		now = DIV_ROUND_UP_ULL((u64)parent_rate, i);
+		if (_is_best_div(rate, now, best)) {
+			bestdiv = i;
+			best = now;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	if (!bestdiv) {
+		bestdiv = _get_maxdiv(table, width);
+		*best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), 1);
+	}
+
+	return bestdiv;
+}
+
+static long sh_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *prate, const struct clk_div_table *table,
+			u8 width)
+{
+	int div;
+
+	div = clk_divider_bestdiv(hw, rate, prate, table, width);
+
+	return DIV_ROUND_UP_ULL((u64)*prate, div);
+}
+
+static int sh_clk_divider_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	long rate, prate;
+
+	prate = req->best_parent_rate;
+	rate = sh_divider_round_rate(hw, req->rate, &prate, divider->table,
+				     divider->width);
+	if (rate < 0)
+		return rate;
+	req->rate = rate;
+	req->best_parent_rate = prate;
+	return 0;
+}
+
+static int sh_divider_get_val(unsigned long rate, unsigned long parent_rate,
+			   const struct clk_div_table *table, u8 width)
+{
+	unsigned int div, value;
+
+	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+
+	if (!_is_valid_div(table, div))
+		return -EINVAL;
+
+	value = _get_val(table, div, width);
+
+	return min_t(unsigned int, value, div_mask(width));
+}
+
+static int sh_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int value;
+	unsigned long flags = 0;
+	u16 val;
+
+	value = sh_divider_get_val(rate, parent_rate, divider->table,
+				   divider->width);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	val = __raw_readw(divider->reg);
+	val &= ~(div_mask(divider->width) << divider->shift);
+	val |= value << divider->shift;
+	__raw_writew(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static const struct clk_ops sh_clk_divider_ops = {
+	.recalc_rate = sh_clk_divider_recalc_rate,
+	.determine_rate = sh_clk_divider_determine_rate,
+	.set_rate = sh_clk_divider_set_rate,
+};
+
+static int _register_divider(struct device_node *node, const char *name,
+			     const char *parent_name,
+			     void __iomem *reg, u8 shift, u8 width,
+			     const struct clk_div_table *table,
+			     spinlock_t *lock)
+{
+	struct clk_divider *div;
+	struct clk_init_data init;
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return -ENOMEM;
+
+	init.name = name;
+	init.ops = &sh_clk_divider_ops;
+	init.flags = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_divider assignments */
+	div->reg = reg;
+	div->shift = shift;
+	div->width = width;
+	div->lock = lock;
+	div->hw.init = &init;
+	div->table = table;
+
+	/* register the clock */
+	if (of_clk_hw_register(node, &div->hw) < 0)
+		kfree(div);
+	of_clk_add_hw_provider(node, of_clk_hw_simple_get, &div->hw);
+
+	return 0;
+}
+
+int sh_div_clk_register(struct device_node *node, const char *name,
+			const char *parent_name,
+			void __iomem *reg, u8 shift, u8 width,
+			const struct clk_div_table *table,
+			spinlock_t *lock)
+{
+	return _register_divider(node, name, parent_name, reg, shift,
+				 width, table, lock);
+}
+EXPORT_SYMBOL_GPL(sh_div_clk_register);
diff --git a/drivers/clk/renesas/clk-shdiv.h b/drivers/clk/renesas/clk-shdiv.h
new file mode 100644
index 000000000000..fd49c06da9ff
--- /dev/null
+++ b/drivers/clk/renesas/clk-shdiv.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CLK_SHDIV_H__
+#define __CLK_SHDIV_H__
+/*
+ * SuperH divider clock driver
+ */
+
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+
+int sh_div_clk_register(struct device_node *node, const char *name,
+			const char *parent_name,
+			void __iomem *reg, u8 shift, u8 width,
+			const struct clk_div_table *table,
+			spinlock_t *lock);
+
+#endif
-- 
2.39.2

