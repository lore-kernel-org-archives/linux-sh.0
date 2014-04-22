From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 22 Apr 2014 13:19:09 +0000
Subject: [PATCH 1/4] clk: shmobile: div6: support selectable-input clocks
Message-Id: <1398172752-30567-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

Adds support for DIV6 clocks with selectable parents as found in the r8a7740
and other SoCs.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 .../bindings/clock/renesas,cpg-div6-clocks.txt        |  8 ++++++++
 drivers/clk/shmobile/clk-div6.c                       | 19 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 952e373..f8302f5 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -7,6 +7,7 @@ to 64.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r8a7740-div6-clock" for R8A7740 DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
     - "renesas,cpg-div6-clock" for generic DIV6 clocks
@@ -15,6 +16,13 @@ Required Properties:
   - #clock-cells: Must be 0
   - clock-output-names: The name of the clock as a free-form string
 
+Optional Properties:
+
+  - renesas,src-shift: Bit position of the input clock selector (default:
+    fixed input clock)
+  - renesas,src-width: Bit width of the input clock selector (default: fixed
+    input clock)
+
 
 Example
 -------
diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index f065f69..5be8161 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -121,6 +121,7 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 	const char *name;
 	struct clk *clk;
 	int ret;
+	u32 src_shift, src_width;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
 	if (!clock) {
@@ -150,7 +151,23 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 		goto error;
 	}
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	if (!of_property_read_u32(np, "renesas,src-shift", &src_shift)) {
+		if (!of_property_read_u32(np, "renesas,src-width",
+					&src_width)) {
+			unsigned int parent_idx +				(clk_readl(clock->reg) >> src_shift) &
+				(BIT(src_width) - 1);
+			parent_name = of_clk_get_parent_name(np, parent_idx);
+		}
+		else {
+			pr_err("%s: renesas,src-shift without renesas,"
+			       "src-width in %s\n", __func__, np->name);
+			goto error;
+		}
+	}
+	else
+		parent_name = of_clk_get_parent_name(np, 0);
+
 	if (parent_name = NULL) {
 		pr_err("%s: failed to get %s DIV6 clock parent name\n",
 		       __func__, np->name);
-- 
1.8.4.5

