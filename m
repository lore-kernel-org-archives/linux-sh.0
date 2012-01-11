From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Jan 2012 07:27:35 +0000
Subject: [PATCH v4 1/6] dmaengine: shdma: add IRQ resource name definition macros
Message-Id: <4F0D39E7.4020102@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SH DMAC has an ERROR IRQ and channel IRQs. So, the defination
macros are used as the resource name, and the resource name will be
used to detect each IRQ by the driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v4:
  - add defination macros for IRQ resource first.

 include/linux/sh_dma.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index cb2dd11..a6c82cc 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -13,6 +13,10 @@
 #include <linux/list.h>
 #include <linux/dmaengine.h>

+/* resource name of IORESOURCE_IRQ */
+#define SH_DMA_IRQ_ERROR	"error"
+#define SH_DMA_IRQ_CHANNEL	"channel"
+
 /* Used by slave DMA clients to request DMA to/from a specific peripheral */
 struct sh_dmae_slave {
 	unsigned int			slave_id; /* Set by the platform */
-- 
1.7.1
