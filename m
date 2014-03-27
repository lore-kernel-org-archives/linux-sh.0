From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Mar 2014 20:47:41 +0000
Subject: [PATCH 6/7] ARM: shmobile: r8a7790 legacy: Add GPIO clocks
Message-Id: <1395953262-4290-7-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1395953262-4290-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395953262-4290-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
 arch/arm/mach-shmobile/clock-r8a7790.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index a6089a6ceabd..2569aab525e4 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -214,6 +214,7 @@ enum {
 	MSTP1009, MSTP1008, MSTP1007, MSTP1006, MSTP1005,
 	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP917,
+	MSTP912, MSTP911, MSTP910, MSTP909, MSTP908, MSTP907,
 	MSTP815, MSTP814,
 	MSTP813,
 	MSTP811, MSTP810, MSTP809, MSTP808,
@@ -258,6 +259,12 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP929] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
 	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
 	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
+	[MSTP912] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 12, MSTPSR9, 0), /* GPIO0 */
+	[MSTP911] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 11, MSTPSR9, 0), /* GPIO1 */
+	[MSTP910] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 10, MSTPSR9, 0), /* GPIO2 */
+	[MSTP909] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 9, MSTPSR9, 0), /* GPIO3 */
+	[MSTP908] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 8, MSTPSR9, 0), /* GPIO4 */
+	[MSTP907] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 7, MSTPSR9, 0), /* GPIO5 */
 	[MSTP815] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 15, MSTPSR8, 0), /* SATA0 */
 	[MSTP814] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 14, MSTPSR8, 0), /* SATA1 */
 	[MSTP813] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR8, 13, MSTPSR8, 0), /* Ether */
@@ -355,6 +362,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.2", &mstp_clks[MSTP929]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.3", &mstp_clks[MSTP928]),
+	CLKDEV_DEV_ID("gpio_rcar.0", &mstp_clks[MSTP912]),
+	CLKDEV_DEV_ID("gpio_rcar.1", &mstp_clks[MSTP911]),
+	CLKDEV_DEV_ID("gpio_rcar.2", &mstp_clks[MSTP910]),
+	CLKDEV_DEV_ID("gpio_rcar.3", &mstp_clks[MSTP909]),
+	CLKDEV_DEV_ID("gpio_rcar.4", &mstp_clks[MSTP908]),
+	CLKDEV_DEV_ID("gpio_rcar.5", &mstp_clks[MSTP907]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("r8a7790-vin.0", &mstp_clks[MSTP811]),
 	CLKDEV_DEV_ID("r8a7790-vin.1", &mstp_clks[MSTP810]),
-- 
1.7.9.5

