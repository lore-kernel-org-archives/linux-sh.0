From: Benoit Cousson <bcousson@baylibre.com>
Date: Tue, 25 Feb 2014 13:39:54 +0000
Subject: [PATCH] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <530C9D2A.8030409@baylibre.com>
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

Note: The kick bit is used as well to change 3 other emulation clocks:
Debug Trace port clock (ZTR), Debug Trace bus clock (ZT), and Debug
clock (ZTRD2). It is not clear from the spec [1] if there
is any relation between the CPU clock rate and these emulation clocks.
Moreover, these clocks are probably supposed to be controled by an
external debugger / tracer like Lauterbach PowerTrace.
For all these reasons, the current implementation does not expose these
clock nodes and thus does not have to consider the multiple accesses
to the kick bit.

Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[1] R-Car-H2-v0.6-en.pdf - page 186
---

Salut Laurent,

If you have any information about these emulation clocks, please let me
know.

Moreover, the CCF clock driver is shared with the r8a7791, so a test on 
that platform will be good.

Regards,
Benoit


  drivers/clk/shmobile/clk-rcar-gen2.c | 26 ++++++++++++++++++++++++--
  1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c 
b/drivers/clk/shmobile/clk-rcar-gen2.c
index a59ec21..9f12746 100644
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
@@ -83,17 +86,35 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, 
unsigned long rate,
  {
  	struct cpg_z_clk *zclk = to_z_clk(hw);
  	unsigned int mult;
-	u32 val;
+	u32 val, kick;
+	int i;

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
+	 * Set KICK bit in FRQCRB to update hardware setting and
+	 * wait for completion.
+	 */
+	kick = clk_readl(zclk->kick_reg);
+	kick |= CPG_FRQCRB_KICK;
+	clk_writel(kick, zclk->kick_reg);
+
+	for (i = 1000; i; i--)
+		if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
+			cpu_relax();
+		else
+			return 0;
+
+	return -ETIMEDOUT;
  }

  static const struct clk_ops cpg_z_clk_ops = {
@@ -120,6 +141,7 @@ static struct clk * __init cpg_z_clk_register(struct 
rcar_gen2_cpg *cpg)
  	init.num_parents = 1;

  	zclk->reg = cpg->reg + CPG_FRQCRC;
+	zclk->kick_reg = cpg->reg + CPG_FRQCRB;
  	zclk->hw.init = &init;

  	clk = clk_register(NULL, &zclk->hw);
-- 
1.8.3.2




