From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 09 Sep 2011 10:25:11 +0000
Subject: [PATCH 01/10] ARM: mach-shmobile: clock-sh73a0: add LCDC1 clock support
Message-Id: <87pqjaqags.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 84fd33c..a2c572e 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -263,7 +263,7 @@ static struct clk div6_clks[DIV6_NR] = {
 };
 
 enum { MSTP001,
-	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
+	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP117, MSTP116, MSTP100,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP325, MSTP323, MSTP318,
@@ -282,6 +282,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP126] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 26, 0), /* CSI2-RX0 */
 	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
 	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX0 */
+	[MSTP117] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, 0), /* IIC0 */
 	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
 	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, 0), /* SCIFA7 */
@@ -331,6 +332,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP125]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1", &mstp_clks[MSTP117]), /* LCDC1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
-- 
1.7.4.1

