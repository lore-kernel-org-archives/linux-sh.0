From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 23:49:20 +0000
Subject: [PATCH 1/3] iommu/shmobile: Depend on ARCH_SHMOBILE
Message-Id: <1396482562-1851-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Paul Bolle <pebolle@tiscali.nl>

From: Paul Bolle <pebolle@tiscali.nl>

Commit 78a2e12f51d9 ("iommu: shmobile: Enable driver compilation with
COMPILE_TEST") added an optional dependency on SH_MOBILE. But that
Kconfig symbol doesn't exist. It seems ARCH_SHMOBILE was intended. Use
that.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 79bbc21..df56e4c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -207,7 +207,7 @@ config SHMOBILE_IOMMU
 	bool "IOMMU for Renesas IPMMU/IPMMUI"
 	default n
 	depends on ARM
-	depends on SH_MOBILE || COMPILE_TEST
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	select SHMOBILE_IPMMU
-- 
1.8.3.2

