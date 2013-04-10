From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 10 Apr 2013 22:19:45 +0000
Subject: [PATCH 2/6] DMA: shdma: shdma_chan_filter() has to be in shdma-base.h
Message-Id: <1365632389-2249-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

shdma_chan_filter() is a function, provided by the shdma-base.c module,
move its declaration to the appropriate header.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 include/linux/sh_dma.h     |    2 --
 include/linux/shdma-base.h |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index b64d6be..4e83f3e 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -99,6 +99,4 @@ struct sh_dmae_pdata {
 #define CHCR_TE	0x00000002
 #define CHCR_IE	0x00000004
 
-bool shdma_chan_filter(struct dma_chan *chan, void *arg);
-
 #endif
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index a3728bf..9a93897 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -122,5 +122,6 @@ void shdma_chan_remove(struct shdma_chan *schan);
 int shdma_init(struct device *dev, struct shdma_dev *sdev,
 		    int chan_num);
 void shdma_cleanup(struct shdma_dev *sdev);
+bool shdma_chan_filter(struct dma_chan *chan, void *arg);
 
 #endif
-- 
1.7.2.5

