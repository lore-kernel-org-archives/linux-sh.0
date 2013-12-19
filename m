From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 19 Dec 2013 17:57:22 +0000
Subject: [PATCH 1/2] arm: shmobile: r8a7790: Add SATA clock
Message-Id: <1387475843-25849-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA 0/1 clock support. External 100MHz SATA 0/1
reference clock is supposed to be applied to the following pins:
  CICREFP0_SATA/CICREFP1_SATA;
  CICREFN0_SATA/CICREFN1_SATA.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index c5c60ec..9d5dabf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -73,6 +73,18 @@ static struct clk extal_clk = {
 	.mapping	= &cpg_mapping,
 };
 
+/* External SATA0 reference clock: 100MHz fixed */
+static struct clk sata0_clk = {
+	.rate		= 100000000,
+	.mapping	= &cpg_mapping,
+};
+
+/* External SATA1 reference clock: 100MHz fixed */
+static struct clk sata1_clk = {
+	.rate		= 100000000,
+	.mapping	= &cpg_mapping,
+};
+
 static struct sh_clk_ops followparent_clk_ops = {
 	.recalc	= followparent_recalc,
 };
@@ -140,6 +152,8 @@ static struct clk *main_clks[] = {
 	&ddr_clk,
 	&mp_clk,
 	&cp_clk,
+	&sata0_clk,
+	&sata1_clk,
 };
 
 /* SDHI (DIV4) clock */
@@ -187,6 +201,7 @@ enum {
 	MSTP1009, MSTP1008, MSTP1007, MSTP1006, MSTP1005,
 	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP917,
+	MSTP815, MSTP814,
 	MSTP813,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
 	MSTP717, MSTP716,
@@ -215,6 +230,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP929] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 29, 0), /* I2C2 */
 	[MSTP928] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 28, 0), /* I2C3 */
 	[MSTP917] = SH_CLK_MSTP32(&qspi_clk, SMSTPCR9, 17, 0), /* QSPI */
+	[MSTP815] = SH_CLK_MSTP32(&sata0_clk, SMSTPCR8, 15, 0), /* SATA0 */
+	[MSTP814] = SH_CLK_MSTP32(&sata1_clk, SMSTPCR8, 14, 0),	/* SATA1 */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP725] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 25, 0), /* LVDS1 */
@@ -317,6 +334,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
+	CLKDEV_DEV_ID("sata-r8a7790.0", &mstp_clks[MSTP815]),
+	CLKDEV_DEV_ID("sata-r8a7790.1", &mstp_clks[MSTP814]),
 
 	/* ICK */
 	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
-- 
1.8.3.1

