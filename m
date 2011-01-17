From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 17 Jan 2011 16:01:07 +0000
Subject: [PATCH] SPI: spi_sh_msiof: fix a wrong free_irq() parameter
Message-Id: <Pine.LNX.4.64.1101171700370.16051@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general@lists.sourceforge.net
Cc: linux-sh@vger.kernel.org

Without this fix reloading of the driver is impossible.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi_sh_msiof.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index d93b667..56f60c8 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -635,7 +635,7 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 	ret = spi_bitbang_stop(&p->bitbang);
 	if (!ret) {
 		pm_runtime_disable(&pdev->dev);
-		free_irq(platform_get_irq(pdev, 0), sh_msiof_spi_irq);
+		free_irq(platform_get_irq(pdev, 0), p);
 		iounmap(p->mapbase);
 		clk_put(p->clk);
 		spi_master_put(p->bitbang.master);
-- 
1.7.2.3

