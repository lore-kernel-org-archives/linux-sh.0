From: Benoit Cousson <bcousson@baylibre.com>
Date: Fri, 28 Feb 2014 13:12:05 +0000
Subject: [PATCH v4] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <1393593125-27894-1-git-send-email-bcousson@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Z clock frequency change is effective only after setting the kick
bit located in the FRQCRB register.
Without that, the CA15 CPUs clock rate will never change.

Fix that by checking if the kick bit is cleared and enable it to make
the clock rate change effective. The bit is cleared automatically upon
completion.

Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
Cc: Mike Turquette <mturquette@linaro.org>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
Hi Mike,

This patch is fixing the current non-working implementation, so feel free
to take it for you next -rc series if you like.

Thanks,
Benoit

v4: Simplify the loop test as suggested by Sergei.

v3: Remove some comments after Mike T. clarification about CCF locking 
    mechanism. Add the Acked-by from Laurent.

v2: Add more comments about worst case latency and fix some minors nits.

---
 drivers/clk/shmobile/clk-rcar-gen2.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index a59ec21..d0a0aa5 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -26,6 +26,8 @@ struct rcar_gen2_cpg {
 	void __iomem *reg;
 };
 
+#define CPG_FRQCRB			0x00000004
+#define CPG_FRQCRB_KICK			BIT(31)
 #define CPG_SDCKCR			0x00000074
 #define CPG_PLL0CR			0x000000d8
 #define CPG_FRQCRC			0x000000e0
@@ -45,6 +47,7 @@ struct rcar_gen2_cpg {
 struct cpg_z_clk {
 	struct clk_hw hw;
 	void __iomem *reg;
+	void __iomem *kick_reg;
 };
 
 #define to_z_clk(_hw)	container_of(_hw, struct cpg_z_clk, hw)
@@ -83,17 +86,45 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct cpg_z_clk *zclk = to_z_clk(hw);
 	unsigned int mult;
-	u32 val;
+	u32 val, kick;
+	unsigned int i;
 
 	mult = div_u64((u64)rate * 32, parent_rate);
 	mult = clamp(mult, 1U, 32U);
 
+	if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
+		return -EBUSY;
+
 	val = clk_readl(zclk->reg);
 	val &= ~CPG_FRQCRC_ZFC_MASK;
 	val |= (32 - mult) << CPG_FRQCRC_ZFC_SHIFT;
 	clk_writel(val, zclk->reg);
 
-	return 0;
+	/*
+	 * Set KICK bit in FRQCRB to update hardware setting and wait for
+	 * clock change completion.
+	 */
+	kick = clk_readl(zclk->kick_reg);
+	kick |= CPG_FRQCRB_KICK;
+	clk_writel(kick, zclk->kick_reg);
+
+	/*
+	 * Note: There is no HW information about the worst case latency.
+	 *
+	 * Using experimental measurements, it seems that no more than
+	 * ~10 iterations are needed, independently of the CPU rate.
+	 * Since this value might be dependant of external xtal rate, pll1
+	 * rate or even the other emulation clocks rate, use 1000 as a
+	 * "super" safe value.
+	 */
+	for (i = 1000; i; i--) {
+		if (!(clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK))
+			return 0;
+
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
 }
 
 static const struct clk_ops cpg_z_clk_ops = {
@@ -120,6 +151,7 @@ static struct clk * __init cpg_z_clk_register(struct rcar_gen2_cpg *cpg)
 	init.num_parents = 1;
 
 	zclk->reg = cpg->reg + CPG_FRQCRC;
+	zclk->kick_reg = cpg->reg + CPG_FRQCRB;
 	zclk->hw.init = &init;
 
 	clk = clk_register(NULL, &zclk->hw);
-- 
1.8.3.2

