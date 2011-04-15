From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:03:17 +0000
Subject: [PATCH 1/2] sh: fix SD / MMC configuration dependencies on ecovec
Message-Id: <Pine.LNX.4.64.1104152000450.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Update CONFIG_MMC_TMIO to the new CONFIG_MMC_SDHI symbol and fix
MMCIF to also function in modular builds for ecovec.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/sh/boards/mach-ecovec24/setup.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 86a0d56..bb13d0e 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -482,7 +482,7 @@ static struct i2c_board_info ts_i2c_clients = {
 	.irq		= IRQ0,
 };
 
-#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
+#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 /* SDHI0 */
 static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 {
@@ -522,7 +522,7 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
 static void sdhi1_set_pwr(struct platform_device *pdev, int state)
 {
@@ -836,7 +836,7 @@ static struct platform_device vou_device = {
 	},
 };
 
-#if defined(CONFIG_MMC_SH_MMCIF)
+#if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SH_MMCIF */
 static void mmcif_set_pwr(struct platform_device *pdev, int state)
 {
@@ -898,9 +898,9 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
-#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
+#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 	&sdhi0_device,
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
 #endif
 #else
@@ -912,7 +912,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&fsi_device,
 	&irda_device,
 	&vou_device,
-#if defined(CONFIG_MMC_SH_MMCIF)
+#if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sh_mmcif_device,
 #endif
 };
@@ -1180,7 +1180,7 @@ static int __init arch_setup(void)
 	gpio_direction_input(GPIO_PTR5);
 	gpio_direction_input(GPIO_PTR6);
 
-#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
+#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 	/* enable SDHI0 on CN11 (needs DS2.4 set to ON) */
 	gpio_request(GPIO_FN_SDHI0CD,  NULL);
 	gpio_request(GPIO_FN_SDHI0WP,  NULL);
@@ -1193,7 +1193,7 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_PTB6, NULL);
 	gpio_direction_output(GPIO_PTB6, 0);
 
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 on CN12 (needs DS2.6,7 set to ON,OFF) */
 	gpio_request(GPIO_FN_SDHI1CD,  NULL);
 	gpio_request(GPIO_FN_SDHI1WP,  NULL);
@@ -1284,7 +1284,7 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_PTU5, NULL);
 	gpio_direction_output(GPIO_PTU5, 0);
 
-#if defined(CONFIG_MMC_SH_MMCIF)
+#if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable MMCIF (needs DS2.6,7 set to OFF,ON) */
 	gpio_request(GPIO_FN_MMC_D7, NULL);
 	gpio_request(GPIO_FN_MMC_D6, NULL);
-- 
1.7.2.5

