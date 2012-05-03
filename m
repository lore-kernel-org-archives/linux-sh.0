From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 03 May 2012 15:05:31 +0000
Subject: [PATCH 02/29] sh: ecovec: remove unused .down_pwr() MMCIF callback
Message-Id: <1336057558-11031-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

.down_pwr() on ecovec was equivalent to .set_pwr(0). Now that .down_pwr()
is no longer used by the driver, it can be removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/sh/boards/mach-ecovec24/setup.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index d12fe9d..a2f70e6 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -877,11 +877,6 @@ static void mmcif_set_pwr(struct platform_device *pdev, int state)
 	gpio_set_value(GPIO_PTB7, state);
 }
 
-static void mmcif_down_pwr(struct platform_device *pdev)
-{
-	gpio_set_value(GPIO_PTB7, 0);
-}
-
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "SH_MMCIF",
@@ -903,7 +898,6 @@ static struct resource sh_mmcif_resources[] = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.set_pwr	= mmcif_set_pwr,
-	.down_pwr	= mmcif_down_pwr,
 	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
-- 
1.7.2.5

