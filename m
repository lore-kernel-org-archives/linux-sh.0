From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 29 Oct 2015 19:54:03 +0000
Subject: [PATCH] [trivial] clk: shmobile: rcar-gen2: Spelling/Grammar: dependant of, ouput
Message-Id: <1446148443-20414-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Jiri Kosina <trivial@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

s/dependant of/dependent on/
s/ouput/output/

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/clk-rcar-gen2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index 3f02b40b4911831c..5928d8480db90061 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -117,7 +117,7 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	 *
 	 * Using experimental measurements, it seems that no more than
 	 * ~10 iterations are needed, independently of the CPU rate.
-	 * Since this value might be dependant of external xtal rate, pll1
+	 * Since this value might be dependent on external xtal rate, pll1
 	 * rate or even the other emulation clocks rate, use 1000 as a
 	 * "super" safe value.
 	 */
@@ -264,7 +264,7 @@ static struct clk * __init cpg_adsp_clk_register(struct rcar_gen2_cpg *cpg)
  * 1  1  0	30 / 2		x172/2	x208/2	x106
  * 1  1  1	30 / 2		x172/2	x208/2	x88
  *
- * *1 :	Table 7.6 indicates VCO ouput (PLLx = VCO/2)
+ * *1 :	Table 7.6 indicates VCO output (PLLx = VCO/2)
  */
 #define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 12) | \
 					 (((md) & BIT(13)) >> 12) | \
-- 
1.9.1

