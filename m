From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 09 Sep 2011 10:28:22 +0000
Subject: [PATCH 09/10] fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
Message-Id: <87ehzqqabh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dot clock of SH MIPI are depends on each platform board.
This patch adds set_dot_clock() function for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   34 +++++++++++++++++++++---
 arch/arm/mach-shmobile/board-ap4evb.c |   25 ++++++++++++++++++
 arch/arm/mach-shmobile/board-kota2.c  |   38 +++++++++++++++++++++++----
 drivers/video/sh_mipi_dsi.c           |   45 ++++++++-------------------------
 include/video/sh_mipi_dsi.h           |    3 ++
 5 files changed, 100 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 87e9091..5aa1432 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -320,6 +320,34 @@ static struct resource mipidsi0_resources[] = {
 	},
 };
 
+#define DSI0PHYCR	0xe615006c
+static int sh_mipi_set_dot_clock(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable)
+{
+	struct clk *pck;
+	int ret = -EIO;
+
+	pck = clk_get(&pdev->dev, "dsip_clk");
+	if (IS_ERR(pck))
+		goto sh_mipi_set_dot_clock_pck_err;
+
+	if (enable) {
+		clk_set_rate(pck, clk_round_rate(pck,  24000000));
+		__raw_writel(0x2a809010, DSI0PHYCR);
+		clk_enable(pck);
+	} else {
+		clk_disable(pck);
+	}
+
+	ret = 0;
+
+	clk_put(pck);
+
+sh_mipi_set_dot_clock_pck_err:
+	return ret;
+}
+
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc0_info.ch[0],
@@ -328,6 +356,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.clksrc		= 1,
 	.flags		= SH_MIPI_DSI_HSABM |
 			  SH_MIPI_DSI_SYNC_PULSES_MODE,
+	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
 static struct platform_device mipidsi0_device = {
@@ -467,8 +496,6 @@ void __init ag5evm_init_irq(void)
 	__raw_writew(__raw_readw(PINTCR0A) | (2<<10), PINTCR0A);
 }
 
-#define DSI0PHYCR	0xe615006c
-
 static void __init ag5evm_init(void)
 {
 	sh73a0_pinmux_init();
@@ -549,9 +576,6 @@ static void __init ag5evm_init(void)
 	gpio_direction_output(GPIO_PORT235, 0);
 	lcd_backlight_reset();
 
-	/* MIPI-DSI clock setup */
-	__raw_writel(0x2a809010, DSI0PHYCR);
-
 	/* enable SDHI0 on CN15 [SD I/F] */
 	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 114fd8a..3ed10d7 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -575,12 +575,37 @@ static struct resource mipidsi0_resources[] = {
 	},
 };
 
+#define PHYCTRL		0x0070
+static int sh_mipi_set_dot_clock(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable)
+{
+	struct clk *pck = clk_get(&pdev->dev, "dsip_clk");
+	void __iomem *phy =  base + PHYCTRL;
+
+	if (IS_ERR(pck))
+		return -EIO;
+
+	if (enable) {
+		clk_set_rate(pck, clk_round_rate(pck, 24000000));
+		iowrite32(ioread32(phy) | (0xb << 8), phy);
+		clk_enable(pck);
+	} else {
+		clk_disable(pck);
+	}
+
+	clk_put(pck);
+
+	return 0;
+}
+
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc_info.ch[0],
 	.lane		= 2,
 	.vsynw_offset	= 17,
 	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE,
+	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
 static struct platform_device mipidsi0_device = {
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index a2be703..a225111 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -20,6 +20,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -365,6 +366,34 @@ static u32 sh_mipi_extra_dcs[] = {
 	SH_MIPI_DCS(0x2c),		/* memory write on */
 };
 
+#define DSI0PCKCR	0xe6150064
+#define DSI0PHYCR	0xe615006c
+static int sh_mipi_set_dot_clock(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable)
+{
+	struct clk *pck;
+	int ret = -EIO;
+
+	pck = clk_get(&pdev->dev, "dsip_clk");
+	if (IS_ERR(pck))
+		goto sh_mipi_set_dot_clock_pck_err;
+
+	if (enable) {
+		clk_set_rate(pck, clk_round_rate(pck,  19200000));
+		__raw_writel(0x2a8b9a0d, DSI0PHYCR); /* 268.8MHz (33.6MHz x8) */
+		clk_enable(pck);
+	} else {
+		clk_disable(pck);
+	}
+
+	ret = 0;
+
+	clk_put(pck);
+sh_mipi_set_dot_clock_pck_err:
+	return ret;
+}
+
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc0_info.ch[0],
@@ -377,6 +406,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 			  SH_MIPI_DSI_SYNC_BURST_MODE,
 	.extra_array	= sh_mipi_extra_dcs,
 	.extra_array_len= ARRAY_SIZE(sh_mipi_extra_dcs),
+	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
 static struct platform_device mipidsi0_device = {
@@ -434,9 +464,6 @@ void __init kota2_init_irq(void)
 	__raw_writew(2 << 10, PINTCR0A);
 }
 
-#define DSI0PCKCR	0xe6150064
-#define DSI0PHYCR	0xe615006c
-
 static void __init kota2_init(void)
 {
 	sh73a0_pinmux_init();
@@ -534,9 +561,8 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_SDHID1_1_PU, NULL);
 	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
 
-	/* MIPI-DSI clock setup */
-	__raw_writel(0x00000119, DSI0PCKCR);
-	__raw_writel(0x2a8b9111, DSI0PHYCR);
+	/* MIPI-DSI clock clean up */
+	__raw_writel(0x00000000, DSI0PCKCR);
 
 	/* Unreset LCD Panel */
 	gpio_request(GPIO_PORT217, NULL);
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 166b468..e42cd81 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -59,7 +59,6 @@ struct sh_mipi {
 	void __iomem	*base;
 	void __iomem	*linkbase;
 	struct clk	*dsit_clk;
-	struct clk	*dsip_clk;
 	struct device	*dev;
 
 	void	*next_board_data;
@@ -313,8 +312,8 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	/* DSI-Tx bias on */
 	iowrite32(0x00000001, base + PHYCTRL);
 	udelay(200);
-	/* Deassert resets, power on, set multiplier */
-	iowrite32(0x03070b01, base + PHYCTRL);
+	/* Deassert resets, power on */
+	iowrite32(0x03070001, base + PHYCTRL);
 
 	/* setup l-bridge */
 
@@ -441,6 +440,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	if (!res || !res2 || idx >= ARRAY_SIZE(mipi_dsi) || !pdata)
 		return -ENODEV;
 
+	if (!pdata->set_dot_clock)
+		return -EINVAL;
+
 	mutex_lock(&array_lock);
 	if (idx < 0)
 		for (idx = 0; idx < ARRAY_SIZE(mipi_dsi) && mipi_dsi[idx]; idx++)
@@ -501,34 +503,10 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "DSI-T clk %lu -> %lu\n", f_current, rate);
 
-	mipi->dsip_clk = clk_get(&pdev->dev, "dsip_clk");
-	if (IS_ERR(mipi->dsip_clk)) {
-		ret = PTR_ERR(mipi->dsip_clk);
-		goto eclkpget;
-	}
-
-	f_current = clk_get_rate(mipi->dsip_clk);
-	/* Between 10 and 50MHz */
-	rate = clk_round_rate(mipi->dsip_clk, 24000000);
-	if (rate > 0 && rate != f_current)
-		ret = clk_set_rate(mipi->dsip_clk, rate);
-	else
-		ret = rate;
-	if (ret < 0)
-		goto esetprate;
-
-	dev_dbg(&pdev->dev, "DSI-P clk %lu -> %lu\n", f_current, rate);
-
-	msleep(10);
-
 	ret = clk_enable(mipi->dsit_clk);
 	if (ret < 0)
 		goto eclkton;
 
-	ret = clk_enable(mipi->dsip_clk);
-	if (ret < 0)
-		goto eclkpon;
-
 	mipi_dsi[idx] = mipi;
 
 	pm_runtime_enable(&pdev->dev);
@@ -538,6 +516,10 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto emipisetup;
 
+	ret = pdata->set_dot_clock(pdev, mipi->base, 1);
+	if (ret < 0)
+		goto emipisetup;
+
 	mutex_unlock(&array_lock);
 	platform_set_drvdata(pdev, mipi);
 
@@ -557,13 +539,8 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 emipisetup:
 	mipi_dsi[idx] = NULL;
 	pm_runtime_disable(&pdev->dev);
-	clk_disable(mipi->dsip_clk);
-eclkpon:
 	clk_disable(mipi->dsit_clk);
 eclkton:
-esetprate:
-	clk_put(mipi->dsip_clk);
-eclkpget:
 esettrate:
 	clk_put(mipi->dsit_clk);
 eclktget:
@@ -614,10 +591,10 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	pdata->lcd_chan->board_cfg.board_data = NULL;
 
 	pm_runtime_disable(&pdev->dev);
-	clk_disable(mipi->dsip_clk);
 	clk_disable(mipi->dsit_clk);
 	clk_put(mipi->dsit_clk);
-	clk_put(mipi->dsip_clk);
+	pdata->set_dot_clock(pdev, mipi->base, 0);
+
 	iounmap(mipi->linkbase);
 	if (res2)
 		release_mem_region(res2->start, resource_size(res2));
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index fb3950e..5ded705 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -61,6 +61,9 @@ struct sh_mipi_dsi_info {
 	unsigned int			vsynw_offset;
 	u32				*extra_array;
 	int				extra_array_len;
+	int	(*set_dot_clock)(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable);
 };
 
 #endif
-- 
1.7.4.1

