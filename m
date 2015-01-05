From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 05 Jan 2015 21:25:08 +0000
Subject: [PATCH v4] clk-rcar-gen2: RCAN clock support
Message-Id: <4052119.aMj07DL4s1@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vksavl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add the RCAN clock support to the R-Car generation 2 CPG driver.  This clock
gets derived from  the USB_EXTAL clock, dividing  it by 6.  The layout of the
RCANCKCR register is similar to those of the clocks supported by the 'clk-div6'
driver but has no divider field, and so can't be supported by that driver...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
The patch is against the 'clk-next' branch of Mike Turquette's 'linux.git' repo.

Changes in version 4:
- added Geert's ACK.

Changes in version 3:
- added the USB_EXTAL clock reference to the binding document.

Changes in version 2:
- switched to using the composite clock driver with the fixed factor and gated
  clock component drivers;
- removed *static* from 'parent_name' definition, switching from assignment to
  initializer;
- modified the binding document;
- modified the changelog.

 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt |   10 +-
 drivers/clk/shmobile/clk-rcar-gen2.c                                     |   40 ++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

Index: linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
=================================--- linux.orig/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -13,10 +13,11 @@ Required Properties:
 
   - reg: Base address and length of the memory resource used by the CPG
 
-  - clocks: Reference to the parent clock
+  - clocks: References to the parent clocks: first to the EXTAL clock, second
+    to the USB_EXTAL clock
   - #clock-cells: Must be 1
   - clock-output-names: The names of the clocks. Supported clocks are "main",
-    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1" and "z"
+    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z", and "rcan"
 
 
 Example
@@ -26,8 +27,9 @@ Example
 		compatible = "renesas,r8a7790-cpg-clocks",
 			     "renesas,rcar-gen2-cpg-clocks";
 		reg = <0 0xe6150000 0 0x1000>;
-		clocks = <&extal_clk>;
+		clocks = <&extal_clk &usb_extal_clk>;
 		#clock-cells = <1>;
 		clock-output-names = "main", "pll0, "pll1", "pll3",
-				     "lb", "qspi", "sdh", "sd0", "sd1", "z";
+				     "lb", "qspi", "sdh", "sd0", "sd1", "z",
+				     "rcan";
 	};
Index: linux/drivers/clk/shmobile/clk-rcar-gen2.c
=================================--- linux.orig/drivers/clk/shmobile/clk-rcar-gen2.c
+++ linux/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -33,6 +33,7 @@ struct rcar_gen2_cpg {
 #define CPG_FRQCRC			0x000000e0
 #define CPG_FRQCRC_ZFC_MASK		(0x1f << 8)
 #define CPG_FRQCRC_ZFC_SHIFT		8
+#define CPG_RCANCKCR			0x00000270
 
 /* -----------------------------------------------------------------------------
  * Z Clock
@@ -161,6 +162,43 @@ static struct clk * __init cpg_z_clk_reg
 	return clk;
 }
 
+static struct clk * __init cpg_rcan_clk_register(struct rcar_gen2_cpg *cpg,
+						 struct device_node *np)
+{
+	const char *parent_name = of_clk_get_parent_name(np, 1);
+	struct clk_fixed_factor *fixed;
+	struct clk_gate *gate;
+	struct clk *clk;
+
+	fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
+	if (!fixed)
+		return ERR_PTR(-ENOMEM);
+
+	fixed->mult = 1;
+	fixed->div = 6;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate) {
+		kfree(fixed);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	gate->reg = cpg->reg + CPG_RCANCKCR;
+	gate->bit_idx = 8;
+	gate->flags = CLK_GATE_SET_TO_DISABLE;
+	gate->lock = &cpg->lock;
+
+	clk = clk_register_composite(NULL, "rcan", &parent_name, 1, NULL, NULL,
+				     &fixed->hw, &clk_fixed_factor_ops,
+				     &gate->hw, &clk_gate_ops, 0);
+	if (IS_ERR(clk)) {
+		kfree(gate);
+		kfree(fixed);
+	}
+
+	return clk;
+}
+
 /* -----------------------------------------------------------------------------
  * CPG Clock Data
  */
@@ -263,6 +301,8 @@ rcar_gen2_cpg_register_clock(struct devi
 		shift = 0;
 	} else if (!strcmp(name, "z")) {
 		return cpg_z_clk_register(cpg);
+	} else if (!strcmp(name, "rcan")) {
+		return cpg_rcan_clk_register(cpg, np);
 	} else {
 		return ERR_PTR(-EINVAL);
 	}

