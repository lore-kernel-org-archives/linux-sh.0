From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 27 Aug 2013 09:31:18 +0000
Subject: [PATCH] DMA: shdma: fix compiler warning after a bad merge
Message-Id: <Pine.LNX.4.64.1308271130360.11515@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

A recent merge commit

commit ba1e06e3dff9a0bb0758d169e50cbb04a67a402c
Author: Vinod Koul <vinod.koul@intel.com>

    Merge branch 'topic/sh' into next

introduced a compiler warning:

drivers/dma/sh/shdmac.c: In function 'sh_dmae_probe':
drivers/dma/sh/shdmac.c:697: warning: assignment discards qualifiers from pointer target type

This patch re-adds the dropped "const" qualifier and fixes the warning.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/shdmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index dcd344e..1069e88 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -684,7 +684,7 @@ MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
 
 static int sh_dmae_probe(struct platform_device *pdev)
 {
-	struct sh_dmae_pdata *pdata;
+	const struct sh_dmae_pdata *pdata;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAE_MAX_CHANNELS] = {};
 	int errirq, chan_irq[SH_DMAE_MAX_CHANNELS];
-- 
1.7.2.5

