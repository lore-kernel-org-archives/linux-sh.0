From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 26 Dec 2013 15:35:56 +0000
Subject: [PATCH 1/2] arm: shmobile: r8a7790: Add VIN clock support
Message-Id: <1388072157-12325-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds VIN[0-3] clock support to R8A7790 SoC.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index c5c60ec..81f45a0 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -188,6 +188,7 @@ enum {
 	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP917,
 	MSTP813,
+	MSTP811, MSTP810, MSTP809, MSTP808,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
 	MSTP717, MSTP716,
 	MSTP704,
@@ -216,6 +217,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP928] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 28, 0), /* I2C3 */
 	[MSTP917] = SH_CLK_MSTP32(&qspi_clk, SMSTPCR9, 17, 0), /* QSPI */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
+	[MSTP811] = SH_CLK_MSTP32(&zg_clk, SMSTPCR8, 11, 0), /* VIN0 */
+	[MSTP810] = SH_CLK_MSTP32(&zg_clk, SMSTPCR8, 10, 0), /* VIN1 */
+	[MSTP809] = SH_CLK_MSTP32(&zg_clk, SMSTPCR8,  9, 0), /* VIN2 */
+	[MSTP808] = SH_CLK_MSTP32(&zg_clk, SMSTPCR8,  8, 0), /* VIN3 */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP725] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 25, 0), /* LVDS1 */
 	[MSTP724] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 24, 0), /* DU0 */
@@ -300,6 +305,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
+	CLKDEV_DEV_ID("r8a7790-vin.0", &mstp_clks[MSTP811]),
+	CLKDEV_DEV_ID("r8a7790-vin.1", &mstp_clks[MSTP810]),
+	CLKDEV_DEV_ID("r8a7790-vin.2", &mstp_clks[MSTP809]),
+	CLKDEV_DEV_ID("r8a7790-vin.3", &mstp_clks[MSTP808]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
-- 
1.8.3.1

