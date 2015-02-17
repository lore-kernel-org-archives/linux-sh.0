From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Feb 2015 01:47:53 +0000
Subject: [PATCH 6/8 v5] spi: sh-msiof: remove slave_id settings for DMAEngine
Message-Id: <87twyls3xm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Current sh-msiof sets dma_slave_config :: slave_id field for DMAEngine,
but it is no longer needed. Let's remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
v4 -> v5

 - no change

 drivers/spi/spi-sh-msiof.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e57eec0..bcc7c63 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1030,7 +1030,6 @@ static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	}
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.slave_id = id;
 	cfg.direction = dir;
 	if (dir = DMA_MEM_TO_DEV) {
 		cfg.dst_addr = port_addr;
-- 
1.7.9.5

