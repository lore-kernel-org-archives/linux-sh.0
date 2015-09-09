From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Sep 2015 12:58:26 +0000
Subject: [PATCH] clk: shmobile: div6: Make clock-output-names optional
Message-Id: <1441803506-30749-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Renesas DIV6 clocks provide a single clock output.  Hence make the
"clock-output-names" DT property optional instead of mandatory. In case
the DT property is omitted the DT node name will be used.

Rename the variable "name" to "clk_name" to make the code more similar
with fixed-factor-clock.c, and to avoid a conflict with a nested local
variable while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/clock/renesas,cpg-div6-clocks.txt   |  4 ++++
 drivers/clk/shmobile/clk-div6.c                             | 13 +++----------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index e1bdf14ac2dfdab2..361315db3d8cfb58 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -21,6 +21,10 @@ Required Properties:
     clocks must be specified.  For clocks with multiple parents, invalid
     settings must be specified as "<0>".
   - #clock-cells: Must be 0
+
+
+Optional Properties:
+
   - clock-output-names: The name of the clock as a free-form string
 
 
diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index b4c8d6746f68a7b8..57016ff9c585fc6e 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -178,10 +178,9 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 	const char **parent_names;
 	struct clk_init_data init;
 	struct div6_clock *clock;
-	const char *name;
+	const char *clk_name = np->name;
 	struct clk *clk;
 	unsigned int i;
-	int ret;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
 	if (!clock)
@@ -215,13 +214,7 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 	clock->div = (clk_readl(clock->reg) & CPG_DIV6_DIV_MASK) + 1;
 
 	/* Parse the DT properties. */
-	ret = of_property_read_string(np, "clock-output-names", &name);
-	if (ret < 0) {
-		pr_err("%s: failed to get %s DIV6 clock output name\n",
-		       __func__, np->name);
-		goto error;
-	}
-
+	of_property_read_string(np, "clock-output-names", &clk_name);
 
 	for (i = 0, valid_parents = 0; i < num_parents; i++) {
 		const char *name = of_clk_get_parent_name(np, i);
@@ -255,7 +248,7 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 	}
 
 	/* Register the clock. */
-	init.name = name;
+	init.name = clk_name;
 	init.ops = &cpg_div6_clock_ops;
 	init.flags = CLK_IS_BASIC;
 	init.parent_names = parent_names;
-- 
1.9.1

