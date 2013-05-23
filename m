From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 23 May 2013 03:14:33 +0000
Subject: [PATCH 01/17 v2] spi: hspi: fixup long delay time
Message-Id: <87bo824cbu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current HSPI driver is using msleep(20) on hspi_status_check_timeout(),
but it was too long delay for SPI device.
Bock-W board SPI access was too slow without this patch.
This patch uses udelay(10) for it.

Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 drivers/spi/spi-sh-hspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 60cfae5..eab593e 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -89,7 +89,7 @@ static int hspi_status_check_timeout(struct hspi_priv *hspi, u32 mask, u32 val)
 		if ((mask & hspi_read(hspi, SPSR)) = val)
 			return 0;
 
-		msleep(20);
+		udelay(10);
 	}
 
 	dev_err(hspi->dev, "timeout\n");
-- 
1.7.9.5

