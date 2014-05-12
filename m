From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 12 May 2014 23:02:16 +0000
Subject: [PATCH 6/6] DMA: shdma: Enable driver compilation with COMPILE_TEST
Message-Id: <1399935736-16854-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This helps increasing build testing coverage.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/dma/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index b4c8138..0f71981 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -4,7 +4,7 @@
 
 config SH_DMAE_BASE
 	bool "Renesas SuperH DMA Engine support"
-	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
+	depends on (SUPERH && SH_DMA) || ARCH_SHMOBILE || COMPILE_TEST
 	depends on !SH_DMA_API
 	default y
 	select DMA_ENGINE
-- 
1.8.5.5

