From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 03 Feb 2014 01:43:46 +0000
Subject: [PATCH] spi: rspi: fix build error when CONFIG_OF is not set
Message-Id: <52EEF452.4060205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This patch fixes an issue that the following build error happens when
the CONFIG_OF is not set:

drivers/spi/spi-rspi.c: In function 'rspi_probe':
drivers/spi/spi-rspi.c:1203:26: error: 'rspi_of_match' undeclared (first use in this function)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on the latest origin/topic/rspi branch in the spi.git.

 drivers/spi/spi-rspi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 34ad4bc..e5cfc3d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1164,6 +1164,7 @@ static int rspi_parse_dt(struct device *dev, struct spi_master *master)
 	return 0;
 }
 #else
+#define rspi_of_match	NULL
 static inline int rspi_parse_dt(struct device *dev, struct spi_master *master)
 {
 	return -EINVAL;
-- 
1.7.1
