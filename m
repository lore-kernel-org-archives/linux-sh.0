From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 06 Aug 2014 12:58:59 +0000
Subject: [PATCH 02/12] spi: rspi: Remove unneeded semicolon
Message-Id: <1407329949-5695-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, dmaengine@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Introduced by commit 426ef76dd8a394a0e04d096941cd9acb49539a3e ("spi:
rspi: Add DT support").

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ad87a98f8f68..a4d8d3cf2912 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1084,7 +1084,7 @@ static int rspi_probe(struct platform_device *pdev)
 			master->num_chipselect = rspi_pd->num_chipselect;
 		else
 			master->num_chipselect = 2; /* default */
-	};
+	}
 
 	/* ops parameter check */
 	if (!ops->set_config_register) {
-- 
1.9.1

