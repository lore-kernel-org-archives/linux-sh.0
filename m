From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 01 Jun 2011 07:32:07 +0000
Subject: [PATCH] ARM: mach-shmobile: add DMAC clock definitions on SH7372
Message-Id: <Pine.LNX.4.64.1106010921190.22716@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These definitions are needed to let the runtime PM subsystem turn off
DMAC clocks, when it is suspended by the driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

I'm not sure I've selected parent clocks correctly for DMAC. According to 
the datasheet all three DMAC units on sh7372 have two parent clocks: "HP" 
and "S,ZS". After a fair bit of uncertainty I picked up the HP clock, 
because (1) it is also used on sh73a0, and (2) currently no devices on 
sh7372 specify the "S,ZS" clock as their parent clock.

 arch/arm/mach-shmobile/clock-sh7372.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index d17eb66..c0800d8 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -509,6 +509,7 @@ enum { MSTP001,
        MSTP118, MSTP117, MSTP116, MSTP113,
        MSTP106, MSTP101, MSTP100,
        MSTP223,
+       MSTP218, MSTP217, MSTP216,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
        MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
        MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP406, MSTP403,
@@ -534,6 +535,9 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP101] = MSTP(&div4_clks[DIV4_M1], SMSTPCR1, 1, 0), /* VPU */
 	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
 	[MSTP223] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR2, 23, 0), /* SPU2 */
+	[MSTP218] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 18, 0), /* DMAC1 */
+	[MSTP217] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 17, 0), /* DMAC2 */
+	[MSTP216] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 16, 0), /* DMAC3 */
 	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
 	[MSTP204] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 4, 0), /* SCIFA0 */
@@ -626,6 +630,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.6", &mstp_clks[MSTP223]), /* SPU2DSP0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.7", &mstp_clks[MSTP223]), /* SPU2DSP1 */
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]), /* DMAC1 */
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* DMAC2 */
+	CLKDEV_DEV_ID("sh-dma-engine.2", &mstp_clks[MSTP216]), /* DMAC3 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP206]), /* SCIFB */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
-- 
1.7.2.5

