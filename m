From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 12 Dec 2012 14:38:16 +0000
Subject: [PATCH 12/14] mmc: sh-mmcif: reset DMA completion immediately before starting DMA
Message-Id: <1355323098-18061-13-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

DMA completion can be signalled from the DMA callback and from the error
handler. If both are called, the completion struct can enter an
inconsistent state. To prevent this move completion initialisation
immediately before activating DMA.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 03493e4..1dd7fc0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -419,8 +419,6 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 	if (ret < 0)
 		goto ecfgrx;
 
-	init_completion(&host->dma_complete);
-
 	return;
 
 ecfgrx:
@@ -1061,6 +1059,12 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 	if (!data)
 		return false;
 
+	/*
+	 * Completion can be signalled from DMA callback and error, so, have to
+	 * reset here, before setting .dma_active
+	 */
+	init_completion(&host->dma_complete);
+
 	if (data->flags & MMC_DATA_READ) {
 		if (host->chan_rx)
 			sh_mmcif_start_dma_rx(host);
-- 
1.7.2.5

