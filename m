From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 11:28:36 +0000
Subject: [PATCH 3/6] spi: spi-sh-msiof: do not manage PM clocks manually
Message-Id: <Pine.LNX.4.64.1204181324590.30514@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On sh-mobile platforms the bus clock frequency for the MSIOF unit is
obtained from the same clock, as the one, that runtime power-manages the
controller. The MSIOF driver has to access that clock directly,
bypassing the runtime PM framework, to get its frequency, but it
shouldn't enable or disable it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi-sh-msiof.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1f466bc..502ca7a 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -407,10 +407,8 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 		value = (is_on = BITBANG_CS_ACTIVE) ? 0 : 1;
 
 	if (is_on = BITBANG_CS_ACTIVE) {
-		if (!test_and_set_bit(0, &p->flags)) {
+		if (!test_and_set_bit(0, &p->flags))
 			pm_runtime_get_sync(&p->pdev->dev);
-			clk_enable(p->clk);
-		}
 
 		/* Configure pins before asserting CS */
 		sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
@@ -423,10 +421,8 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 	gpio_set_value((unsigned)spi->controller_data, value);
 
 	if (is_on = BITBANG_CS_INACTIVE) {
-		if (test_and_clear_bit(0, &p->flags)) {
-			clk_disable(p->clk);
+		if (test_and_clear_bit(0, &p->flags))
 			pm_runtime_put(&p->pdev->dev);
-		}
 	}
 }
 
-- 
1.7.2.5

