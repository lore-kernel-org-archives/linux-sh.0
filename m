From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 00:41:44 +0000
Subject: [PATCH 1/3] spi: rcar: Fix uninitialized variable warning
Message-Id: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org

The transfer data length variable is set based on the desired access
size, without a default case. This results in a compiler warning, even
though the access size is always set to a supported value. Create a
default case to silence the warning.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/spi-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 58449ad..a3dca1d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -268,7 +268,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 		spcmd = SPCMD_SPB_8BIT;
 	else if (access_size = 16)
 		spcmd = SPCMD_SPB_16BIT;
-	else if (access_size = 32)
+	else
 		spcmd = SPCMD_SPB_32BIT;
 
 	spcmd |= SPCMD_SCKDEN | SPCMD_SLNDEN | SPCMD_SSLKP | SPCMD_SPNDEN;
-- 
1.8.3.2

