From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 30 Dec 2014 20:51:53 +0000
Subject: [PATCH v2] clk-rcar-gen2: ADSP clock support
Message-Id: <30876083.4tlAgq9Aak@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mturquette@linaro.org, linux-kernel@vger.kernel.org, sboyd@codeaurora.org
Cc: robh+dt@kernel.org, linux-sh@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

Add the ADSP clock support to the R-Car generation 2 CPG driver.  This clock
gets derived from  PLL1.  The layout of the ADSPCKCR register is  similar to
those of the clocks supported by the 'clk-div6' driver but the divider encoding
is non-linear, so can't be supported by that driver...

Based on the original patch by Konstantin Kozhevnikov
<konstantin.kozhevnikov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'clk-next' branch of Mike Turquette's 'linux.git' repo
plus the RCAN clock support patch posted last week.

Changes in version 2:
- swapped "adsp" and "rcan" in the binding document.

 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt |    5 -
 drivers/clk/shmobile/clk-rcar-gen2.c                                     |   48 ++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

Index: linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
=================================--- linux.orig/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -16,7 +16,8 @@ Required Properties:
   - clocks: Reference to the parent clock
   - #clock-cells: Must be 1
   - clock-output-names: The names of the clocks. Supported clocks are "main",
-    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z", and "rcan"
+    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z", "rcan", and
+    "adsp"
 
 
 Example
@@ -30,5 +31,5 @@ Example
 		#clock-cells = <1>;
 		clock-output-names = "main", "pll0, "pll1", "pll3",
 				     "lb", "qspi", "sdh", "sd0", "sd1", "z",
-				     "rcan";
+				     "rcan", "adsp";
 	};
Index: linux/drivers/clk/shmobile/clk-rcar-gen2.c
=================================--- linux.orig/drivers/clk/shmobile/clk-rcar-gen2.c
+++ linux/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -33,6 +33,7 @@ struct rcar_gen2_cpg {
 #define CPG_FRQCRC			0x000000e0
 #define CPG_FRQCRC_ZFC_MASK		(0x1f << 8)
 #define CPG_FRQCRC_ZFC_SHIFT		8
+#define CPG_ADSPCKCR			0x0000025c
 #define CPG_RCANCKCR			0x00000270
 
 /* -----------------------------------------------------------------------------
@@ -162,6 +163,51 @@ static struct clk * __init cpg_z_clk_reg
 	return clk;
 }
 
+/* ADSP divisors */
+static const struct clk_div_table cpg_adsp_div_table[] = {
+	{  1,  3 }, {  2,  4 }, {  3,  6 }, {  4,  8 },
+	{  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
+	{ 10, 36 }, { 11, 48 }, {  0,  0 },
+};
+
+static struct clk * __init cpg_adsp_clk_register(struct rcar_gen2_cpg *cpg)
+{
+	const char *parent_name = "pll1";
+	struct clk_divider *div;
+	struct clk_gate *gate;
+	struct clk *clk;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	div->reg = cpg->reg + CPG_ADSPCKCR;
+	div->width = 4;
+	div->table = cpg_adsp_div_table;
+	div->lock = &cpg->lock;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate) {
+		kfree(div);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	gate->reg = cpg->reg + CPG_RCANCKCR;
+	gate->bit_idx = 8;
+	gate->flags = CLK_GATE_SET_TO_DISABLE;
+	gate->lock = &cpg->lock;
+
+	clk = clk_register_composite(NULL, "adsp", &parent_name, 1, NULL, NULL,
+				     &div->hw, &clk_divider_ops,
+				     &gate->hw, &clk_gate_ops, 0);
+	if (IS_ERR(clk)) {
+		kfree(gate);
+		kfree(div);
+	}
+
+	return clk;
+}
+
 static struct clk * __init cpg_rcan_clk_register(struct rcar_gen2_cpg *cpg,
 						 struct device_node *np)
 {
@@ -301,6 +347,8 @@ rcar_gen2_cpg_register_clock(struct devi
 		shift = 0;
 	} else if (!strcmp(name, "z")) {
 		return cpg_z_clk_register(cpg);
+	} else if (!strcmp(name, "adsp")) {
+		return cpg_adsp_clk_register(cpg);
 	} else if (!strcmp(name, "rcan")) {
 		return cpg_rcan_clk_register(cpg, np);
 	} else {

