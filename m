From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Oct 2013 23:47:05 +0000
Subject: [PATCH 17/19] spi: sh_hspi: Enable the driver on all ARM platforms
Message-Id: <1383004027-25036-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a69b740..ab98033 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -426,7 +426,7 @@ config SPI_SH_SCI
 
 config SPI_SH_HSPI
 	tristate "SuperH HSPI controller"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARM || COMPILE_TEST
 	help
 	  SPI driver for SuperH HSPI blocks.
 
-- 
1.8.1.5

