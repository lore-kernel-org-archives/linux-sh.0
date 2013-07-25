From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 25 Jul 2013 23:26:40 +0000
Subject: [PATCH 04/12] sh: ecovec24: Remove mmcif .down_pwr() callback
Message-Id: <1374794808-21890-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The callback isn't used by the mmcif driver, don't initialize it in
board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4d46700..e1b6aa3 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -983,11 +983,6 @@ static struct platform_device vou_device = {
 
 #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SH_MMCIF */
-static void mmcif_down_pwr(struct platform_device *pdev)
-{
-	cn12_set_pwr(pdev, 0);
-}
-
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "SH_MMCIF",
@@ -1009,7 +1004,6 @@ static struct resource sh_mmcif_resources[] = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.set_pwr	= cn12_set_pwr,
-	.down_pwr	= mmcif_down_pwr,
 	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
-- 
1.8.1.5

