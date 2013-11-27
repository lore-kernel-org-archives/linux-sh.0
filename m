From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 00:39:15 +0000
Subject: [PATCH] spi: sh-msiof: Fix warnings due to improper casts
Message-Id: <1385512755-11765-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Cast pointers to unsigned long instead of unsigned int. This fixes
warnings on platforms where pointers have a different size than int.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index c74298c..35930e9 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -421,7 +421,7 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 	}
 
 	/* use spi->controller data for CS (same strategy as spi_gpio) */
-	gpio_set_value((unsigned)spi->controller_data, value);
+	gpio_set_value((unsigned long)spi->controller_data, value);
 
 	if (is_on = BITBANG_CS_INACTIVE) {
 		if (test_and_clear_bit(0, &p->flags)) {
-- 
1.8.3.2

