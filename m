From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Jan 2015 15:37:25 +0000
Subject: [PATCH] spi: sh-msiof: Use async pm_runtime_put() in sh_msiof_spi_setup()
Message-Id: <1420645045-18804-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

There's no need to use the synchronous version.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 015760563ec77bf1 ("spi: sh-msiof: Add runtime PM lock in initializing")
---
Please note that 015760563ec77bf1 is marked for stable.

 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 3f7ea2d49456e754..050e9188df1b309c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -546,7 +546,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 
 
-	pm_runtime_put_sync(&p->pdev->dev);
+	pm_runtime_put(&p->pdev->dev);
 
 	return 0;
 }
-- 
1.9.1

