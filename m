From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Aug 2013 13:23:01 +0000
Subject: [PATCH] DMA: sudmac: fix compiler warning
Message-Id: <Pine.LNX.4.64.1308021520150.28012@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>

Fix the following compiler warning:

drivers/dma/sh/sudmac.c: In function 'sudmac_chan_remove':
drivers/dma/sh/sudmac.c:302: warning: unused variable 'sc'

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/sudmac.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
index 2a8e3c2..4600b42 100644
--- a/drivers/dma/sh/sudmac.c
+++ b/drivers/dma/sh/sudmac.c
@@ -299,8 +299,6 @@ static void sudmac_chan_remove(struct sudmac_device *su_dev)
 	int i;
 
 	shdma_for_each_chan(schan, &su_dev->shdma_dev, i) {
-		struct sudmac_chan *sc = to_chan(schan);
-
 		BUG_ON(!schan);
 
 		shdma_chan_remove(schan);
-- 
1.7.2.5

