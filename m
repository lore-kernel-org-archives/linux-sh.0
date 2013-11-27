From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 01:18:26 +0000
Subject: [PATCH 04/15] iommu: shmobile: Enable driver compilation with COMPILE_TEST
Message-Id: <1385515117-23664-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This helps increasing build testing coverage.

The driver doesn't compile on non-ARM platforms due to usage of the ARM
DMA IOMMU API, restrict compilation to ARM.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3e7fdbb..79bbc21 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -207,6 +207,7 @@ config SHMOBILE_IOMMU
 	bool "IOMMU for Renesas IPMMU/IPMMUI"
 	default n
 	depends on ARM
+	depends on SH_MOBILE || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	select SHMOBILE_IPMMU
-- 
1.8.3.2

