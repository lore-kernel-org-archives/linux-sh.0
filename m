From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Sep 2015 10:22:58 +0000
Subject: [PATCH 02/05][RFC] clk: Add parent array to struct clk_init_data
Message-Id: <20150915102258.15716.22991.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150915102238.15716.91170.sendpatchset@little-apple>
In-Reply-To: <20150915102238.15716.91170.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: linux-sh@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Add an optional array of parent clocks to struct clk_init_data
to allow relying on clock pointers instead of strings during
registration of clocks. 

Using this parent array the clock providers step over the line to
become clock consumers since they can use of_clk_get() to get the
parent clock and pass it during registration. Good or bad.

Clock providers that register clocks may use the parent array
pre-populate parent clocks to not have to rely on strings lookup.

This in turn makes it possible to have clock providers using a single
DT node with several clock-indices but omitting the clock-output-names
property. As it is today the clock index is not taken into consideration
when generating a default parent name in case clock-output-names is missing.

TODO: Figure out how to deal with ref counting and if clock providers
should use clk_put() or not.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/clk.c            |   14 +++++++++++---
 include/linux/clk-provider.h |    2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

--- 0001/drivers/clk/clk.c
+++ work/drivers/clk/clk.c	2015-09-15 18:30:36.390513000 +0900
@@ -2360,8 +2360,8 @@ static int __clk_init(struct device *dev
 		 * for a NULL pointer.  We can always perform lazy lookups for
 		 * missing parents later on.
 		 */
-		if (core->parents)
-			for (i = 0; i < core->num_parents; i++)
+		for (i = 0; i < core->num_parents; i++)
+			if (core->parents && !core->parents[i])
 				core->parents[i]  					clk_core_lookup(core->parent_names[i]);
 	}
@@ -2549,7 +2549,9 @@ struct clk *clk_register(struct device *
 		ret = -ENOMEM;
 		goto fail_parent_names;
 	}
-
+	if (hw->init->parents)
+		core->parents = kcalloc(core->num_parents, sizeof(struct clk *),
+					GFP_KERNEL);
 
 	/* copy each string name in case parent_names is __initdata */
 	for (i = 0; i < core->num_parents; i++) {
@@ -2561,6 +2563,11 @@ struct clk *clk_register(struct device *
 		}
 	}
 
+	/* convert each parent pointer to struct clk_core */
+	for (i = 0; i < core->num_parents; i++)
+		if (core->parents && !IS_ERR(hw->init->parents[i]))
+			core->parents[i] = hw->init->parents[i]->core;
+
 	INIT_HLIST_HEAD(&core->clks);
 
 	hw->clk = __clk_create_clk(hw, NULL, NULL);
@@ -2577,6 +2584,7 @@ struct clk *clk_register(struct device *
 	hw->clk = NULL;
 
 fail_parent_names_copy:
+	kfree(core->parents);
 	while (--i >= 0)
 		kfree_const(core->parent_names[i]);
 	kfree(core->parent_names);
--- 0001/include/linux/clk-provider.h
+++ work/include/linux/clk-provider.h	2015-09-15 18:17:15.000000000 +0900
@@ -222,6 +222,7 @@ struct clk_ops {
  * @name: clock name
  * @ops: operations this clock supports
  * @parent_names: array of string names for all possible parents
+ * @parents: array of pointers to all possible parents
  * @num_parents: number of possible parents
  * @flags: framework-level hints and quirks
  */
@@ -229,6 +230,7 @@ struct clk_init_data {
 	const char		*name;
 	const struct clk_ops	*ops;
 	const char		* const *parent_names;
+	struct clk		**parents;
 	u8			num_parents;
 	unsigned long		flags;
 };
