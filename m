From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Jan 2012 10:22:22 +0000
Subject: [PATCH 2/7] dma: shdma: prepare for simple DMA conversion
Message-Id: <Pine.LNX.4.64.1201181112170.28782@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>

By placing an anonymous union at the top of struct sh_dmae_slave we can
transparently prepare all drivers for the upcoming simple DMA conversion.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/sh_dma.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index db637b9..1b14cf4 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -10,12 +10,16 @@
 #ifndef SH_DMA_H
 #define SH_DMA_H
 
-#include <linux/list.h>
+#include <linux/dma-simple.h>
 #include <linux/dmaengine.h>
+#include <linux/list.h>
 
 /* Used by slave DMA clients to request DMA to/from a specific peripheral */
 struct sh_dmae_slave {
-	unsigned int			slave_id; /* Set by the platform */
+	union {
+		unsigned int		slave_id; /* Set by the platform */
+		struct dma_simple_slave	simple_slave;
+	};
 	struct device			*dma_dev; /* Set by the platform */
 	const struct sh_dmae_slave_config	*config;  /* Set by the driver */
 };
-- 
1.7.2.5

