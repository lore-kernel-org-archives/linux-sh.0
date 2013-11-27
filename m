From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 00:41:45 +0000
Subject: [PATCH 2/3] spi: rcar: Fix pointer cast in the remove function
Message-Id: <1385512906-13108-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The platform driver data is set to point to the rspi_data structure at
probe time. Calling spi_master_get() on the pointer is just plain wrong
and only works by chance. Fix it by using the platform driver data
directly.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/spi-rspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a3dca1d..621be5d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -885,14 +885,13 @@ static void rspi_release_dma(struct rspi_data *rspi)
 
 static int rspi_remove(struct platform_device *pdev)
 {
-	struct rspi_data *rspi = spi_master_get(platform_get_drvdata(pdev));
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	spi_unregister_master(rspi->master);
 	rspi_release_dma(rspi);
 	free_irq(platform_get_irq(pdev, 0), rspi);
 	clk_put(rspi->clk);
 	iounmap(rspi->addr);
-	spi_master_put(rspi->master);
 
 	return 0;
 }
-- 
1.8.3.2

