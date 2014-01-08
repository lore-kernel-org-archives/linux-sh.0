From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 08 Jan 2014 16:31:25 +0000
Subject: [PATCH 3/3] ARM: shmobile: r8a7790: Add SATA clocks
Message-Id: <1389198685-6435-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378813194-19493-4-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1378813194-19493-4-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA[01] clock support to R8A7790 SoC.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index d1b1b8f..b22f89d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -196,6 +196,7 @@ enum {
 	MSTP1009, MSTP1008, MSTP1007, MSTP1006, MSTP1005,
 	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP917,
+	MSTP815, MSTP814,
 	MSTP813,
 	MSTP811, MSTP810, MSTP809, MSTP808,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
@@ -225,6 +226,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP929] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
 	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
 	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
+	[MSTP815] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 15, MSTPSR8, 0), /* SATA0 */
+	[MSTP814] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 14, MSTPSR8, 0), /* SATA1 */
 	[MSTP813] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR8, 13, MSTPSR8, 0), /* Ether */
 	[MSTP811] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 11, MSTPSR8, 0), /* VIN0 */
 	[MSTP810] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 10, MSTPSR8, 0), /* VIN1 */
@@ -339,6 +342,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("pci-rcar-gen2.0", &mstp_clks[MSTP703]),
 	CLKDEV_DEV_ID("pci-rcar-gen2.1", &mstp_clks[MSTP703]),
 	CLKDEV_DEV_ID("pci-rcar-gen2.2", &mstp_clks[MSTP703]),
+	CLKDEV_DEV_ID("sata-r8a7790.0", &mstp_clks[MSTP815]),
+	CLKDEV_DEV_ID("sata-r8a7790.1", &mstp_clks[MSTP814]),
 
 	/* ICK */
 	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
-- 
1.8.3.1

