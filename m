From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 06 Aug 2014 12:59:04 +0000
Subject: [PATCH 07/12] spi: sh-msiof: Configure DMA slave bus width
Message-Id: <1407329949-5695-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, dmaengine@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The new Renesas R-Car Gen2 DMA Controller driver (rcar-dmac) requires
explicit configuration of the DMA slave bus width.
Hardcode the DMA transfer size to 4 bytes, as MSIOF DMA is limited to
32-bit words.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 887c2084130f..b19cbb4cb4a0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -987,10 +987,13 @@ static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.slave_id = id;
 	cfg.direction = dir;
-	if (dir = DMA_MEM_TO_DEV)
+	if (dir = DMA_MEM_TO_DEV) {
 		cfg.dst_addr = port_addr;
-	else
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
 		cfg.src_addr = port_addr;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	}
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret) {
-- 
1.9.1

