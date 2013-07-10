From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 10 Jul 2013 02:09:12 +0000
Subject: [PATCH] dmaengine: shdma: fix a build failure on platforms with no DMA support
Message-Id: <1373422152-29976-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On platforms with no support for the shdma dmaengine driver build is
currently failing with

drivers/built-in.o: In function `sh_mobile_sdhi_probe':
drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'

Fix the breakage by defining shdma_chan_filter to NULL in such
configurations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
[horms+renesas@verge.net.au: Apply change to shdma-base.h instead of sh_dma.h]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/shdma-base.h | 4 ++++
 1 file changed, 4 insertions(+)

Hi Vinod,

please consider this fix from Guennadi for v3.11 which I have rebased on top of
next-20130709. It fixes a build problem on a number of shmobile defconfigs
including bockw.

diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 382cf71..5b1c984 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -124,6 +124,10 @@ void shdma_chan_remove(struct shdma_chan *schan);
 int shdma_init(struct device *dev, struct shdma_dev *sdev,
 		    int chan_num);
 void shdma_cleanup(struct shdma_dev *sdev);
+#if IS_ENABLED(CONFIG_SH_DMAE_BASE)
 bool shdma_chan_filter(struct dma_chan *chan, void *arg);
+#else
+#define shdma_chan_filter NULL
+#endif
 
 #endif
-- 
1.8.2.1

