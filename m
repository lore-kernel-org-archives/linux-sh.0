From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Mar 2014 20:47:42 +0000
Subject: [PATCH 7/7] ARM: shmobile: r8a7791 legacy: Add GPIO clocks
Message-Id: <1395953262-4290-8-git-send-email-geert@linux-m68k.org>
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
 arch/arm/mach-shmobile/clock-r8a7791.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 5929062aa480..0eed1a0c52c0 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -172,6 +172,7 @@ enum {
 	MSTP1108, MSTP1107, MSTP1106,
 	MSTP931, MSTP930, MSTP929, MSTP928, MSTP927, MSTP925,
 	MSTP917,
+	MSTP912, MSTP911, MSTP910, MSTP909, MSTP908, MSTP907, MSTP905, MSTP904,
 	MSTP815, MSTP814,
 	MSTP813,
 	MSTP811, MSTP810, MSTP809,
@@ -197,6 +198,14 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP927] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 27, MSTPSR9, 0), /* I2C4 */
 	[MSTP925] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 25, MSTPSR9, 0), /* I2C5 */
 	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
+	[MSTP912] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 12, MSTPSR9, 0), /* GPIO0 */
+	[MSTP911] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 11, MSTPSR9, 0), /* GPIO1 */
+	[MSTP910] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 10, MSTPSR9, 0), /* GPIO2 */
+	[MSTP909] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 9, MSTPSR9, 0), /* GPIO3 */
+	[MSTP908] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 8, MSTPSR9, 0), /* GPIO4 */
+	[MSTP907] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 7, MSTPSR9, 0), /* GPIO5 */
+	[MSTP905] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 5, MSTPSR9, 0), /* GPIO6 */
+	[MSTP904] = SH_CLK_MSTP32_STS(&cp_clk, SMSTPCR9, 4, MSTPSR9, 0), /* GPIO7 */
 	[MSTP815] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 15, MSTPSR8, 0), /* SATA0 */
 	[MSTP814] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 14, MSTPSR8, 0), /* SATA1 */
 	[MSTP813] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR8, 13, MSTPSR8, 0), /* Ether */
@@ -281,6 +290,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-rcar_gen2.3", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.4", &mstp_clks[MSTP927]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.5", &mstp_clks[MSTP925]),
+	CLKDEV_DEV_ID("gpio_rcar.0", &mstp_clks[MSTP912]),
+	CLKDEV_DEV_ID("gpio_rcar.1", &mstp_clks[MSTP911]),
+	CLKDEV_DEV_ID("gpio_rcar.2", &mstp_clks[MSTP910]),
+	CLKDEV_DEV_ID("gpio_rcar.3", &mstp_clks[MSTP909]),
+	CLKDEV_DEV_ID("gpio_rcar.4", &mstp_clks[MSTP908]),
+	CLKDEV_DEV_ID("gpio_rcar.5", &mstp_clks[MSTP907]),
+	CLKDEV_DEV_ID("gpio_rcar.6", &mstp_clks[MSTP905]),
+	CLKDEV_DEV_ID("gpio_rcar.7", &mstp_clks[MSTP904]),
 	CLKDEV_DEV_ID("r8a7791-ether", &mstp_clks[MSTP813]), /* Ether */
 	CLKDEV_DEV_ID("r8a7791-vin.0", &mstp_clks[MSTP811]),
 	CLKDEV_DEV_ID("r8a7791-vin.1", &mstp_clks[MSTP810]),
-- 
1.7.9.5

