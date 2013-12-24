From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Date: Tue, 24 Dec 2013 09:49:30 +0000
Subject: [PATCH 1/5] spi: rspi: Use dev_get_platdata() instead of raw dev.platform_data access
Message-Id: <1387878574-21445-2-git-send-email-geert+renesas@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
In-Reply-To: <1387878574-21445-1-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index b04835d809f5..08861b5db893 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -899,7 +899,7 @@ static int rspi_probe(struct platform_device *pdev)
 	struct rspi_data *rspi;
 	int ret, irq;
 	char clk_name[16];
-	struct rspi_plat_data *rspi_pd = pdev->dev.platform_data;
+	struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
 	const struct spi_ops *ops;
 	const struct platform_device_id *id_entry = pdev->id_entry;
 
-- 
1.7.9.5

