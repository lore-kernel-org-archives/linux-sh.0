From: Arnd Hannemann <arnd@arndnet.de>
Date: Wed, 29 Dec 2010 15:50:28 +0000
Subject: [PATCH] sh: mach-ecovec24: enable runtime PM for SDHI
Message-Id: <1293637828-8817-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables runtime PM for SDHI on ecovec.
Tested with a b43 based SDIO card.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
This patch applies on top of:
	[4/6] sh: sh7724 Enable SDIO IRQs
		https://patchwork.kernel.org/patch/437471/

 arch/sh/boards/mach-ecovec24/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 36d7ca7..0f0bd63 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -476,7 +476,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.set_pwr	= sdhi0_set_pwr,
-	.tmio_caps      = MMC_CAP_SDIO_IRQ,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -518,7 +518,7 @@ static void sdhi1_set_pwr(struct platform_device *pdev, int state)
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
-	.tmio_caps      = MMC_CAP_SDIO_IRQ,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD,
 	.set_pwr	= sdhi1_set_pwr,
 };
 
-- 
1.7.2.3

