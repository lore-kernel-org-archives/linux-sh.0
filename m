From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 14 Jul 2011 16:39:06 +0000
Subject: [PATCH 1/2] mmc: tmio: fix a recently introduced bug in DMA code
Message-Id: <Pine.LNX.4.64.1107141838050.10688@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1107141828470.10688@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1107141828470.10688@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Simon Horman <horms@verge.net.au>

A recent commit "mmc: tmio: Share register access functions" has swapped
arguments of a macro and broken DMA with TMIO MMC. This patch fixes the
arguments back.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index f24a029..7e86662 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -26,7 +26,7 @@ static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
 	/* Switch DMA mode on or off - SuperH specific? */
-	sd_ctrl_write16(host, enable ? 2 : 0, CTL_DMA_ENABLE);
+	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
 #endif
 }
 
-- 
1.7.2.5

