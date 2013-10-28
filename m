From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Oct 2013 23:46:56 +0000
Subject: [PATCH 08/19] mmc: sdhi: Enable the driver on all ARM platforms
Message-Id: <1383004027-25036-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/Kconfig        | 2 +-
 drivers/mmc/host/tmio_mmc_dma.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..51957d4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -479,7 +479,7 @@ config MMC_TMIO
 
 config MMC_SDHI
 	tristate "SH-Mobile SDHI SD/SDIO controller support"
-	depends on SUPERH || ARCH_SHMOBILE
+	depends on SUPERH || ARM
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 65edb4a..535bc35 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -28,7 +28,7 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 	if (!host->chan_tx || !host->chan_rx)
 		return;
 
-#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
+#if defined(CONFIG_SUPERH) || defined(CONFIG_ARM)
 	/* Switch DMA mode on or off - SuperH specific? */
 	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
 #endif
-- 
1.8.1.5

