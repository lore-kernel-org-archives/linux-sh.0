From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Jan 2015 04:17:15 +0000
Subject: [PATCH 5/8 v2] spi: rspi: remove slave_id settings for DMAEngine
Message-Id: <87egqqaxvi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Current rspi sets dma_slave_config :: slave_id field for DMAEngine,
but it is no longer needed. Let's remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - separate into shdma and others

 drivers/spi/spi-rspi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2071f78..6cbcdc0 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -918,7 +918,6 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 	}
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.slave_id = id;
 	cfg.direction = dir;
 	if (dir = DMA_MEM_TO_DEV) {
 		cfg.dst_addr = port_addr;
-- 
1.7.9.5

