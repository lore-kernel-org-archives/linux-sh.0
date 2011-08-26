From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 05:25:11 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 MSIOF clock support
Message-Id: <20110826052511.25734.78502.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add clock control support for sh7372 MSIOF hardware blocks.

No upstream sh7372 boards are making use of MSIOF0->2,
but the sh7372 hardware happens to come out of reset with
all MSIOF MSTP clocks _enabled_, so to save power we need
to implement a fix in software to shut down unused clocks.

This patch relies on the recently merged

 794d78f drivers: sh: late disabling of clocks V2

to make sure the unused clocks get disabled as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This patch is needed by upcoming A3SM sleep mode support
 code that can only enter deep sleep in case most clocks
 are disabled - including these MSIOF clocks.

 arch/arm/mach-shmobile/clock-sh7372.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- 0007/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-08-26 13:34:25.000000000 +0900
@@ -503,14 +503,14 @@ static struct clk *late_main_clks[] = {
 	&sh7372_fsidivb_clk,
 };
 
-enum { MSTP001,
+enum { MSTP001, MSTP000,
        MSTP131, MSTP130,
        MSTP129, MSTP128, MSTP127, MSTP126, MSTP125,
        MSTP118, MSTP117, MSTP116, MSTP113,
        MSTP106, MSTP101, MSTP100,
        MSTP223,
-       MSTP214, MSTP218, MSTP217, MSTP216,
-       MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
+       MSTP218, MSTP217, MSTP216, MSTP214, MSTP208,
+       MSTP207, MSTP206, MSTP205, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
        MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
        MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP407, MSTP406, MSTP403,
        MSTP_NR };
@@ -520,6 +520,7 @@ enum { MSTP001,
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP001] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR0, 1, 0), /* IIC2 */
+	[MSTP000] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR0, 0, 0), /* MSIOF0 */
 	[MSTP131] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 31, 0), /* VEU3 */
 	[MSTP130] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 30, 0), /* VEU2 */
 	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* VEU1 */
@@ -539,8 +540,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP217] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 17, 0), /* DMAC2 */
 	[MSTP216] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 16, 0), /* DMAC3 */
 	[MSTP214] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 14, 0), /* USBDMAC */
+	[MSTP208] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 8, 0), /* MSIOF1 */
 	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
+	[MSTP205] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 5, 0), /* MSIOF2 */
 	[MSTP204] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 2, 0), /* SCIFA2 */
@@ -611,6 +614,7 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* IIC2 */
+	CLKDEV_DEV_ID("spi_sh_msiof.0", &mstp_clks[MSTP000]), /* MSIOF0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.4", &mstp_clks[MSTP131]), /* VEU3 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.3", &mstp_clks[MSTP130]), /* VEU2 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.2", &mstp_clks[MSTP129]), /* VEU1 */
@@ -632,8 +636,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* DMAC2 */
 	CLKDEV_DEV_ID("sh-dma-engine.2", &mstp_clks[MSTP216]), /* DMAC3 */
 	CLKDEV_DEV_ID("sh-dma-engine.3", &mstp_clks[MSTP214]), /* USB-DMAC0 */
+	CLKDEV_DEV_ID("spi_sh_msiof.1", &mstp_clks[MSTP208]), /* MSIOF1 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP206]), /* SCIFB */
+	CLKDEV_DEV_ID("spi_sh_msiof.2", &mstp_clks[MSTP205]), /* MSIOF2 */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP202]), /* SCIFA2 */
