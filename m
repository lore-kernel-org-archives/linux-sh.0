From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Sep 2015 10:23:16 +0000
Subject: [PATCH 04/05][RFC] clk: fixed-factor: Pass struct clk_init_data
Message-Id: <20150915102316.15716.14756.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150915102238.15716.91170.sendpatchset@little-apple>
In-Reply-To: <20150915102238.15716.91170.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: linux-sh@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Break out a function named clk_register_fixed_factor_init()
that takes a struct clk_init_data pointer that may or may not
contain a populated parent array.

Useful for SoC-specific clock drivers that want to pass an
populated parent array during clock registration.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/clk-fixed-factor.c |   32 ++++++++++++++++++++++----------
 include/linux/clk-provider.h   |    4 ++++
 2 files changed, 26 insertions(+), 10 deletions(-)

--- 0003/drivers/clk/clk-fixed-factor.c
+++ work/drivers/clk/clk-fixed-factor.c	2015-09-14 21:51:21.600513000 +0900
@@ -70,12 +70,12 @@ const struct clk_ops clk_fixed_factor_op
 };
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		unsigned int mult, unsigned int div)
+struct clk *clk_register_fixed_factor_init(struct device *dev,
+					   struct clk_init_data *init,
+					   unsigned int mult,
+					   unsigned int div)
 {
 	struct clk_fixed_factor *fix;
-	struct clk_init_data init = {};
 	struct clk *clk;
 
 	fix = kmalloc(sizeof(*fix), GFP_KERNEL);
@@ -85,13 +85,11 @@ struct clk *clk_register_fixed_factor(st
 	/* struct clk_fixed_factor assignments */
 	fix->mult = mult;
 	fix->div = div;
-	fix->hw.init = &init;
+	fix->hw.init = init;
 
-	init.name = name;
-	init.ops = &clk_fixed_factor_ops;
-	init.flags = flags | CLK_IS_BASIC;
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
+	init->ops = &clk_fixed_factor_ops;
+	init->flags |= CLK_IS_BASIC;
+	init->num_parents = 1;
 
 	clk = clk_register(dev, &fix->hw);
 
@@ -100,6 +98,20 @@ struct clk *clk_register_fixed_factor(st
 
 	return clk;
 }
+EXPORT_SYMBOL_GPL(clk_register_fixed_factor_init);
+
+struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div)
+{
+	struct clk_init_data init = {};
+
+	init.name = name;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+
+	return clk_register_fixed_factor_init(dev, &init, mult, div);
+}
 EXPORT_SYMBOL_GPL(clk_register_fixed_factor);
 
 #ifdef CONFIG_OF
--- 0004/include/linux/clk-provider.h
+++ work/include/linux/clk-provider.h	2015-09-14 21:51:34.000513000 +0900
@@ -484,6 +484,10 @@ struct clk_fixed_factor {
 };
 
 extern const struct clk_ops clk_fixed_factor_ops;
+struct clk *clk_register_fixed_factor_init(struct device *dev,
+					   struct clk_init_data *init,
+					   unsigned int mult,
+					   unsigned int div);
 struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
