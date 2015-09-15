From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Sep 2015 10:23:26 +0000
Subject: [PATCH 05/05][RFC] clk: fixed-factor: Make use of parent array
Message-Id: <20150915102326.15716.63028.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150915102238.15716.91170.sendpatchset@little-apple>
In-Reply-To: <20150915102238.15716.91170.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: linux-sh@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Extend the fixed-factor-clock code to use the parent array
to pass in the parent clock instead of relying on string
lookup.

This replaces of_clk_get_parent_name() with of_clk_get()
which makes it possible to use a parent clock from a shared DT
node with multiple clock-indices and without clock-output-names.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/clk-fixed-factor.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- 0006/drivers/clk/clk-fixed-factor.c
+++ work/drivers/clk/clk-fixed-factor.c	2015-09-15 18:28:33.410513000 +0900
@@ -8,6 +8,7 @@
  * Standard functionality for the common clock API.
  */
 #include <linux/module.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -120,10 +121,11 @@ EXPORT_SYMBOL_GPL(clk_register_fixed_fac
  */
 void __init of_fixed_factor_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk *clk, *parent;
 	const char *clk_name = node->name;
-	const char *parent_name;
+	const char *parent_name = NULL;
 	u32 div, mult;
+	struct clk_init_data init = {};
 
 	if (of_property_read_u32(node, "clock-div", &div)) {
 		pr_err("%s Fixed factor clock <%s> must have a clock-div property\n",
@@ -138,10 +140,14 @@ void __init of_fixed_factor_clk_setup(st
 	}
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
-	parent_name = of_clk_get_parent_name(node, 0);
+	parent = of_clk_get(node, 0);
+
+	init.name = clk_name;
+	init.parents = &parent;
+	init.parent_names = &parent_name;
+
+	clk = clk_register_fixed_factor_init(NULL, &init, mult, div);
 
-	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
-					mult, div);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
