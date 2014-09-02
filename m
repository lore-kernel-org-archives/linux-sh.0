From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Sep 2014 09:13:05 +0000
Subject: [PATCH v2 09/10] clk: shmobile: div6: support selectable-input clocks
Message-Id: <1409649186-1046-10-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

Support for setting the parent at initialization time based on the current
hardware configuration in DIV6 clocks with selectable parents as found in
the r8a73a4, r8a7740, sh73a0, and other SoCs.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/clock/renesas,cpg-div6-clocks.txt     | 12 +++++++-
 drivers/clk/shmobile/clk-div6.c                    | 32 ++++++++++++++++++----
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 952e373..2633ea1 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -7,14 +7,24 @@ to 64.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
+    - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
+    - "renesas,sh73a0-div6-clock" for SH73A0 (SH-MobileAG5) DIV6 clocks
     - "renesas,cpg-div6-clock" for generic DIV6 clocks
   - reg: Base address and length of the memory resource used by the DIV6 clock
-  - clocks: Reference to the parent clock
+  - clocks: Reference to the parent clock(s)
   - #clock-cells: Must be 0
   - clock-output-names: The name of the clock as a free-form string
 
+Optional Properties:
+
+  - renesas,src-shift: Bit position of the input clock selector (default:
+    fixed input clock; requires renesas,src-width)
+  - renesas,src-width: Bit width of the input clock selector (default: fixed
+    input clock; requires renesas,src-shift)
+
 
 Example
 -------
diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index f065f69..f8b57bf 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -39,8 +39,11 @@ struct div6_clock {
 static int cpg_div6_clock_enable(struct clk_hw *hw)
 {
 	struct div6_clock *clock = to_div6_clock(hw);
+	u32 val;
 
-	clk_writel(CPG_DIV6_DIV(clock->div - 1), clock->reg);
+	val = (clk_readl(clock->reg) & ~(CPG_DIV6_DIV_MASK | CPG_DIV6_CKSTP))
+	    | CPG_DIV6_DIV(clock->div - 1);
+	clk_writel(val, clock->reg);
 
 	return 0;
 }
@@ -52,7 +55,7 @@ static void cpg_div6_clock_disable(struct clk_hw *hw)
 	/* DIV6 clocks require the divisor field to be non-zero when stopping
 	 * the clock.
 	 */
-	clk_writel(CPG_DIV6_CKSTP | CPG_DIV6_DIV(CPG_DIV6_DIV_MASK),
+	clk_writel(clk_readl(clock->reg) | CPG_DIV6_CKSTP | CPG_DIV6_DIV_MASK,
 		   clock->reg);
 }
 
@@ -94,12 +97,14 @@ static int cpg_div6_clock_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct div6_clock *clock = to_div6_clock(hw);
 	unsigned int div = cpg_div6_clock_calc_div(rate, parent_rate);
+	u32 val;
 
 	clock->div = div;
 
+	val = clk_readl(clock->reg) & ~CPG_DIV6_DIV_MASK;
 	/* Only program the new divisor if the clock isn't stopped. */
-	if (!(clk_readl(clock->reg) & CPG_DIV6_CKSTP))
-		clk_writel(CPG_DIV6_DIV(clock->div - 1), clock->reg);
+	if (!(val & CPG_DIV6_CKSTP))
+		clk_writel(val | CPG_DIV6_DIV(clock->div - 1), clock->reg);
 
 	return 0;
 }
@@ -120,6 +125,8 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 	const char *parent_name;
 	const char *name;
 	struct clk *clk;
+	u32 src_shift;
+	u32 src_width;
 	int ret;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
@@ -150,7 +157,22 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 		goto error;
 	}
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	if (!of_property_read_u32(np, "renesas,src-shift", &src_shift)) {
+		if (!of_property_read_u32(np, "renesas,src-width",
+					&src_width)) {
+			unsigned int parent_idx +				(clk_readl(clock->reg) >> src_shift) &
+				(BIT(src_width) - 1);
+			parent_name = of_clk_get_parent_name(np, parent_idx);
+		} else {
+			pr_err("%s: renesas,src-shift without renesas,src-width in %s\n",
+			       __func__, np->name);
+			goto error;
+		}
+	} else {
+		parent_name = of_clk_get_parent_name(np, 0);
+	}
+
 	if (parent_name = NULL) {
 		pr_err("%s: failed to get %s DIV6 clock parent name\n",
 		       __func__, np->name);
-- 
1.8.4.5

