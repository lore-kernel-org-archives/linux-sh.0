From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 21 May 2015 11:58:30 +0000
Subject: [PATCH] DMA: shdma: r8a73a4: Make dma_ts_shift[] static
Message-Id: <1432209510-20449-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

dma_ts_shift[] isn't used outside this source file. All other users use
the definition from arch/arm/mach-shmobile/dma-register.h.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/shdma-r8a73a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma-r8a73a4.c b/drivers/dma/sh/shdma-r8a73a4.c
index 4fb99970a3ea9b56..96ea3828c3eb8213 100644
--- a/drivers/dma/sh/shdma-r8a73a4.c
+++ b/drivers/dma/sh/shdma-r8a73a4.c
@@ -11,7 +11,7 @@
 
 #include "shdma-arm.h"
 
-const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
+static const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
 
 static const struct sh_dmae_slave_config dma_slaves[] = {
 	{
-- 
1.9.1

