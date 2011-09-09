From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 09 Sep 2011 10:25:44 +0000
Subject: [PATCH 02/10] fbdev: sh_mipi_dsi: tidyup dsip_clk
Message-Id: <87obyuqafu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

dsipck clock is controled by CLKDEV_ICK_ID() in clock-shxxx.
dsi0p_clk/dsi1p_clk naming is not needed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    4 ++--
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 ++--
 drivers/video/sh_mipi_dsi.c           |    4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 6b1619a..c2702b5 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -604,8 +604,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("hdmi_clk", &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
-	CLKDEV_ICK_ID("dsi0p_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
-	CLKDEV_ICK_ID("dsi1p_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* IIC2 */
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index a2c572e..80cb438 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -320,8 +320,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sdhi2_clk", &div6_clks[DIV6_SDHI2]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
-	CLKDEV_ICK_ID("dsi0p_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
-	CLKDEV_ICK_ID("dsi1p_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index bdf687d..d24ba7e 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -388,7 +388,6 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	struct resource *res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	unsigned long rate, f_current;
 	int idx = pdev->id, ret;
-	char dsip_clk[] = "dsi.p_clk";
 
 	if (!res || !res2 || idx >= ARRAY_SIZE(mipi_dsi) || !pdata)
 		return -ENODEV;
@@ -453,8 +452,7 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "DSI-T clk %lu -> %lu\n", f_current, rate);
 
-	sprintf(dsip_clk, "dsi%1.1dp_clk", idx);
-	mipi->dsip_clk = clk_get(&pdev->dev, dsip_clk);
+	mipi->dsip_clk = clk_get(&pdev->dev, "dsip_clk");
 	if (IS_ERR(mipi->dsip_clk)) {
 		ret = PTR_ERR(mipi->dsip_clk);
 		goto eclkpget;
-- 
1.7.4.1

