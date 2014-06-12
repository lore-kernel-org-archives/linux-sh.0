From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 12 Jun 2014 09:42:17 +0000
Subject: [PATCH v2 01/07] mmc: sdhi: enable .dma_rx_offset for platform prototype
Message-Id: <20140612094217.4132.43070.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

.dma_rx_offset is caring only DT today.
THis patch cares it via platform

Not for upstream merge.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[damm+renesas@opensource.se: Extracted from tarball, adjusted patch
title to remove "Local" and added "Not for upstream merge" comment]
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - None

 drivers/mmc/host/sh_mobile_sdhi.c  |    1 +
 include/linux/mmc/sh_mobile_sdhi.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 91c6399..d65b3ca 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -195,6 +195,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->capabilities |= p->tmio_caps;
 		mmc_data->capabilities2 |= p->tmio_caps2;
 		mmc_data->cd_gpio = p->cd_gpio;
+		dma_priv->dma_rx_offset = p->dma_rx_offset;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
 			/*
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index 68927ae..5f11afc 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -25,6 +25,7 @@ struct sh_mobile_sdhi_info {
 	unsigned long tmio_caps2;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
 	unsigned int cd_gpio;
+	dma_addr_t dma_rx_offset;
 
 	/* callbacks for board specific setup code */
 	int (*init)(struct platform_device *pdev,
-- 
1.7.9.5

