From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 16 Dec 2012 17:25:51 +0000
Subject: [PATCH/WIP/RFC 05/14] ARM: iommu: Include linux/kref.h in asm/dma-iommu.h
Message-Id: <1355678760-27357-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
 <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The dma_iommu_mapping structure defined in asm/dma-iommu.h embeds a
struct kref, include the appropriate header file.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/include/asm/dma-iommu.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 799b094..666d8a8 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -7,6 +7,7 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 #include <linux/kmemcheck.h>
+#include <linux/kref.h>
 
 struct dma_iommu_mapping {
 	/* iommu specific data */
-- 
1.7.8.6

