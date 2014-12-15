From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 15 Dec 2014 14:01:11 +0000
Subject: [PATCH/RFC] spi: sh-msiof: Add runtime PM lock in initializing
Message-Id: <1418652071-6396-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

SH-MSIOF driver is enabled autosuspend API of spi framework.
But autosuspend framework doesn't work during initializing.
So runtime PM lock is added in SH-MSIOF driver initializing.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the for-next branch of Mark Brown's spi tree.

 drivers/spi/spi-sh-msiof.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 3f36540..1405293 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -480,6 +480,8 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 	struct device_node	*np = spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
 
+	pm_runtime_get_sync(&p->pdev->dev);
+
 	if (!np) {
 		/*
 		 * Use spi->controller_data for CS (same strategy as spi_gpio),
@@ -498,6 +500,9 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 	if (spi->cs_gpio >= 0)
 		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 
+
+	pm_runtime_put_sync(&p->pdev->dev);
+
 	return 0;
 }
 
-- 
1.9.1

