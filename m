From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 15 Jun 2011 06:14:11 +0000
Subject: [PATCH 4/5] dmaengine: shdma: tidyup parameter change method on
Message-Id: <w3pboxz62q4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/dma/shdma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index f7b3c06..19fd18d 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -169,8 +169,9 @@ static void dmae_start(struct sh_dmae_chan *sh_chan)
 {
 	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
 
+	chcr &= ~CHCR_TE;
 	chcr |= CHCR_DE | CHCR_IE;
-	sh_dmae_writel(sh_chan, chcr & ~CHCR_TE, CHCR);
+	sh_dmae_writel(sh_chan, chcr, CHCR);
 }
 
 static void dmae_halt(struct sh_dmae_chan *sh_chan)
-- 
1.7.4.1

