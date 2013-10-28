From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Oct 2013 23:46:57 +0000
Subject: [PATCH 09/19] mmc: sh_mmcif: Enable the driver on all ARM platforms
Message-Id: <1383004027-25036-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 51957d4..1f3a0c1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -588,7 +588,7 @@ config MMC_DW_PCI
 
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
-	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
+	depends on MMC_BLOCK && (SUPERH || ARM)
 	help
 	  This selects the MMC Host Interface controller (MMCIF).
 
-- 
1.8.1.5

