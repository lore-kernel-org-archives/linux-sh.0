From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Jun 2015 04:53:30 +0000
Subject: [PATCH 2/6][RFC] clk: shmobile: CPG write protect register support for MSTP
Message-Id: <87381twp4y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R-Car Gen3 needs to care about CPG write protect register when driver
driver access to CPG/MSTP.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/clock/renesas,cpg-mstp-clocks.txt           |  3 +++
 drivers/clk/shmobile/clk-mstp.c                          | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 16ed181..d897b13 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -19,12 +19,15 @@ Required Properties:
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2-W) MSTP gate clocks
     - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2-N) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
+    - "renesas,r8a7795-mstp-clocks" for R8A7795 (R-Car H3) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
     and "renesas,cpg-mstp-clocks" as a fallback.
   - reg: Base address and length of the I/O mapped registers used by the MSTP
     clocks. The first register is the clock control register and is mandatory.
     The second register is the clock status register and is optional when not
     implemented in hardware.
+    The third register is the CPG write protect register and is optional when
+    not implemented in hardware.
   - clocks: Reference to the parent clocks, one per output clock. The parents
     must appear in the same order as the output clocks.
   - #clock-cells: Must be 1
diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 2d2fe77..eb92cf8 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/spinlock.h>
+#include "rcar-clk.h"
 
 /*
  * MSTP clocks. We can't use standard gate clocks as we need to poll on the
@@ -30,12 +31,14 @@
  * @data: clocks in this group
  * @smstpcr: module stop control register
  * @mstpsr: module stop status register (optional)
+ * @cpgwpr: CPG write protect register (optional)
  * @lock: protects writes to SMSTPCR
  */
 struct mstp_clock_group {
 	struct clk_onecell_data data;
 	void __iomem *smstpcr;
 	void __iomem *mstpsr;
+	void __iomem *cpgwpr;
 	spinlock_t lock;
 };
 
@@ -69,7 +72,17 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 		value &= ~bitmask;
 	else
 		value |= bitmask;
-	clk_writel(value, group->smstpcr);
+
+	if (group->cpgwpr) {
+		unsigned long cmn_flags;
+
+		rcar_cpgwpcr_lock(&cmn_flags);
+		clk_writel(~value, group->cpgwpr);
+		clk_writel(value, group->smstpcr);
+		rcar_cpgwpcr_unlock(&cmn_flags);
+	} else {
+		clk_writel(value, group->smstpcr);
+	}
 
 	spin_unlock_irqrestore(&group->lock, flags);
 
@@ -174,6 +187,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 
 	group->smstpcr = of_iomap(np, 0);
 	group->mstpsr = of_iomap(np, 1);
+	group->cpgwpr = of_iomap(np, 2);
 
 	if (group->smstpcr = NULL) {
 		pr_err("%s: failed to remap SMSTPCR\n", __func__);
-- 
1.9.1

