From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Jul 2014 00:45:34 +0000
Subject: [PATCH 3/3] dmaengine: shdma: Use defines instead of hardcoded numbers
Message-Id: <0cdbee33ea42bfd5f61f824e258a1a0944dd2a27.1405557829.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/dma/sh/shdma-arm.h | 4 ++--
 drivers/dma/sh/shdmac.c    | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdma-arm.h b/drivers/dma/sh/shdma-arm.h
index a2b8258..a1b0ef4 100644
--- a/drivers/dma/sh/shdma-arm.h
+++ b/drivers/dma/sh/shdma-arm.h
@@ -45,7 +45,7 @@ enum {
 	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
 	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
 
-#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
-#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | RS_ERS | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | RS_ERS | TS_INDEX2VAL((xmit_sz)))
 
 #endif
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 1a6f659..58eb857 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -239,9 +239,8 @@ static void dmae_init(struct sh_dmae_chan *sh_chan)
 {
 	/*
 	 * Default configuration for dual address memory-memory transfer.
-	 * 0x400 represents auto-request.
 	 */
-	u32 chcr = DM_INC | SM_INC | 0x400 | log2size_to_chcr(sh_chan,
+	u32 chcr = DM_INC | SM_INC | RS_AUTO | log2size_to_chcr(sh_chan,
 						   LOG2_DEFAULT_XFER_SIZE);
 	sh_chan->xmit_shift = calc_xmit_shift(sh_chan, chcr);
 	chcr_write(sh_chan, chcr);
-- 
2.0.0

