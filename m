From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Mar 2013 13:24:29 +0000
Subject: [PATCH/RFC 2/2] ARM: shmobile: sh73a0: extend MSTP clocks to wait for success
Message-Id: <Pine.LNX.4.64.1303221423490.12375@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a status register to all MSTP clocks to enable waiting for enable
completion.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |   82 +++++++++++++++++---------------
 1 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 34b5c5a..ce97ee0 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -54,6 +54,12 @@
 #define PLL1CR		IOMEM(0xe6150028)
 #define PLL2CR		IOMEM(0xe615002c)
 #define PLL3CR		IOMEM(0xe61500dc)
+#define MSTPSR0		IOMEM(0xe6150030)
+#define MSTPSR1		IOMEM(0xe6150038)
+#define MSTPSR2		IOMEM(0xe6150040)
+#define MSTPSR3		IOMEM(0xe6150048)
+#define MSTPSR4		IOMEM(0xe615004c)
+#define MSTPCR5		IOMEM(0xe615003c)
 #define SMSTPCR0	IOMEM(0xe6150130)
 #define SMSTPCR1	IOMEM(0xe6150134)
 #define SMSTPCR2	IOMEM(0xe6150138)
@@ -494,46 +500,46 @@ enum { MSTP001,
 	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
-#define MSTP(_parent, _reg, _bit, _flags) \
-	SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
+#define MSTP(_parent, _reg, _bit, _sts, _flags)			\
+	SH_CLK_MSTP32_STS(_parent, _reg, _bit, _sts, _flags)
 
 static struct clk mstp_clks[MSTP_NR] = {
-	[MSTP001] = MSTP(&div4_clks[DIV4_HP], SMSTPCR0, 1, 0), /* IIC2 */
-	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* CEU1 */
-	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* CSI2-RX1 */
-	[MSTP127] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 27, 0), /* CEU0 */
-	[MSTP126] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 26, 0), /* CSI2-RX0 */
-	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
-	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX0 */
-	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, 0), /* IIC0 */
-	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
-	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, 0), /* SCIFA7 */
-	[MSTP218] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 18, 0), /* SY-DMAC */
-	[MSTP217] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 17, 0), /* MP-DMAC */
-	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
-	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
-	[MSTP204] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 4, 0), /* SCIFA0 */
-	[MSTP203] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 3, 0), /* SCIFA1 */
-	[MSTP202] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 2, 0), /* SCIFA2 */
-	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
-	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
-	[MSTP331] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 31, 0), /* SCIFA6 */
-	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
-	[MSTP328] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 28, 0), /*FSI*/
-	[MSTP325] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 25, 0), /* IrDA */
-	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
-	[MSTP322] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 22, 0), /* USB */
-	[MSTP314] = MSTP(&div6_clks[DIV6_SDHI0], SMSTPCR3, 14, 0), /* SDHI0 */
-	[MSTP313] = MSTP(&div6_clks[DIV6_SDHI1], SMSTPCR3, 13, 0), /* SDHI1 */
-	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
-	[MSTP311] = MSTP(&div6_clks[DIV6_SDHI2], SMSTPCR3, 11, 0), /* SDHI2 */
-	[MSTP303] = MSTP(&main_div2_clk, SMSTPCR3, 3, 0), /* TPU1 */
-	[MSTP302] = MSTP(&main_div2_clk, SMSTPCR3, 2, 0), /* TPU2 */
-	[MSTP301] = MSTP(&main_div2_clk, SMSTPCR3, 1, 0), /* TPU3 */
-	[MSTP300] = MSTP(&main_div2_clk, SMSTPCR3, 0, 0), /* TPU4 */
-	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
-	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, 0), /* IIC4 */
-	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
+	[MSTP001] = MSTP(&div4_clks[DIV4_HP], SMSTPCR0, 1, MSTPSR0, 0), /* IIC2 */
+	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, MSTPSR1, 0), /* CEU1 */
+	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, MSTPSR1, 0), /* CSI2-RX1 */
+	[MSTP127] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 27, MSTPSR1, 0), /* CEU0 */
+	[MSTP126] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 26, MSTPSR1, 0), /* CSI2-RX0 */
+	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, MSTPSR1, 0), /* TMU0 */
+	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, MSTPSR1, 0), /* DSITX0 */
+	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, MSTPSR1, 0), /* IIC0 */
+	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, MSTPSR1, 0), /* LCDC0 */
+	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, MSTPSR2, 0), /* SCIFA7 */
+	[MSTP218] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 18, MSTPSR2, 0), /* SY-DMAC */
+	[MSTP217] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 17, MSTPSR2, 0), /* MP-DMAC */
+	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, MSTPSR2, 0), /* SCIFA5 */
+	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, MSTPSR2, 0), /* SCIFB */
+	[MSTP204] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 4, MSTPSR2, 0), /* SCIFA0 */
+	[MSTP203] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 3, MSTPSR2, 0), /* SCIFA1 */
+	[MSTP202] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 2, MSTPSR2, 0), /* SCIFA2 */
+	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, MSTPSR2, 0), /* SCIFA3 */
+	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, MSTPSR2, 0), /* SCIFA4 */
+	[MSTP331] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 31, MSTPSR3, 0), /* SCIFA6 */
+	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, MSTPSR3, 0), /* CMT10 */
+	[MSTP328] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 28, MSTPSR3, 0), /*FSI*/
+	[MSTP325] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 25, MSTPSR3, 0), /* IrDA */
+	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, MSTPSR3, 0), /* IIC1 */
+	[MSTP322] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 22, MSTPSR3, 0), /* USB */
+	[MSTP314] = MSTP(&div6_clks[DIV6_SDHI0], SMSTPCR3, 14, MSTPSR3, 0), /* SDHI0 */
+	[MSTP313] = MSTP(&div6_clks[DIV6_SDHI1], SMSTPCR3, 13, MSTPSR3, 0), /* SDHI1 */
+	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, MSTPSR3, 0), /* MMCIF0 */
+	[MSTP311] = MSTP(&div6_clks[DIV6_SDHI2], SMSTPCR3, 11, MSTPSR3, 0), /* SDHI2 */
+	[MSTP303] = MSTP(&main_div2_clk, SMSTPCR3, 3, MSTPSR3, 0), /* TPU1 */
+	[MSTP302] = MSTP(&main_div2_clk, SMSTPCR3, 2, MSTPSR3, 0), /* TPU2 */
+	[MSTP301] = MSTP(&main_div2_clk, SMSTPCR3, 1, MSTPSR3, 0), /* TPU3 */
+	[MSTP300] = MSTP(&main_div2_clk, SMSTPCR3, 0, MSTPSR3, 0), /* TPU4 */
+	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, MSTPSR4, 0), /* IIC3 */
+	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, MSTPSR4, 0), /* IIC4 */
+	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, MSTPSR4, 0), /* KEYSC */
 };
 
 /* The lookups structure below includes duplicate entries for some clocks
-- 
1.7.2.5

