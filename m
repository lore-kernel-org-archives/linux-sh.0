From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 28 Jan 2011 09:59:54 +0000
Subject: [PATCH] ARM: mach-shmobile: Add sh73a0 MIPI-CSI and CEU clocks
Message-Id: <20110128100425.25190.1956.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh73a0 CPGA to support clocks for CEU
and MIPI-CSI. This includes MSTP bits for CSI and
CEU and div6 clkdev bindings for VCK1-3.

Fix the order of the MSTP32 entries in the clkdev
table while at it.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-01-28 18:51:24.000000000 +0900
@@ -263,7 +263,7 @@ static struct clk div6_clks[DIV6_NR] = {
 };
 
 enum { MSTP001,
-	MSTP125, MSTP118, MSTP116, MSTP100,
+	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP325, MSTP323, MSTP312,
@@ -275,6 +275,10 @@ enum { MSTP001,
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP001] = MSTP(&div4_clks[DIV4_HP], SMSTPCR0, 1, 0), /* IIC2 */
+	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* CEU1 */
+	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* CSI2-RX1 */
+	[MSTP127] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 27, 0), /* CEU0 */
+	[MSTP126] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 26, 0), /* CSI2-RX0 */
 	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
 	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX0 */
 	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, 0), /* IIC0 */
@@ -306,6 +310,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("r_clk", &r_clk),
 
 	/* DIV6 clocks */
+	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
+	CLKDEV_CON_ID("vck2_clk", &div6_clks[DIV6_VCK2]),
+	CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
 	CLKDEV_ICK_ID("dsi0p_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
@@ -313,11 +320,15 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
-	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
+	CLKDEV_DEV_ID("sh_mobile_ceu.1", &mstp_clks[MSTP129]), /* CEU1 */
+	CLKDEV_DEV_ID("sh-mobile-csi2.1", &mstp_clks[MSTP128]), /* CSI2-RX1 */
+	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[MSTP127]), /* CEU0 */
+	CLKDEV_DEV_ID("sh-mobile-csi2.0", &mstp_clks[MSTP126]), /* CSI2-RX0 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP125]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
-	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
