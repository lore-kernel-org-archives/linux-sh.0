From: Simon Horman <horms@verge.net.au>
Date: Wed, 03 Aug 2011 06:08:54 +0000
Subject: [PATCH] mmc: sdhi, mmcif: zboot: Correct clock disable logic
Message-Id: <1312351734-4426-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This corrects a logic-error that I made in the original implementation.

An alternate patch would be to just remove these lines and
leave the clock running as it is reconfigured later on during
boot anyway.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/compressed/mmcif-sh7372.c |    2 +-
 arch/arm/boot/compressed/sdhi-sh7372.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/compressed/mmcif-sh7372.c
index b6f61d9..672ae95 100644
--- a/arch/arm/boot/compressed/mmcif-sh7372.c
+++ b/arch/arm/boot/compressed/mmcif-sh7372.c
@@ -82,7 +82,7 @@ asmlinkage void mmc_loader(unsigned char *buf, unsigned long len)
 
 
 	/* Disable clock to MMC hardware block */
-	__raw_writel(__raw_readl(SMSTPCR3) & (1 << 12), SMSTPCR3);
+	__raw_writel(__raw_readl(SMSTPCR3) | (1 << 12), SMSTPCR3);
 
 	mmc_update_progress(MMC_PROGRESS_DONE);
 }
diff --git a/arch/arm/boot/compressed/sdhi-sh7372.c b/arch/arm/boot/compressed/sdhi-sh7372.c
index d403a8b..d279294 100644
--- a/arch/arm/boot/compressed/sdhi-sh7372.c
+++ b/arch/arm/boot/compressed/sdhi-sh7372.c
@@ -85,7 +85,7 @@ asmlinkage void mmc_loader(unsigned short *buf, unsigned long len)
 		goto err;
 
         /* Disable clock to SDHI1 hardware block */
-        __raw_writel(__raw_readl(SMSTPCR3) & (1 << 13), SMSTPCR3);
+        __raw_writel(__raw_readl(SMSTPCR3) | (1 << 13), SMSTPCR3);
 
 	mmc_update_progress(MMC_PROGRESS_DONE);
 
-- 
1.7.5.4

