From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 20:18:36 +0000
Subject: [PATCH 1/7] dmaengine: sh: Rework Kconfig and Makefile
Message-Id: <1405455522-20676-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Separate helpers and drivers in the Kconfig and Makefile to improve
readability and move the CONFIG_OF dependency from the Makefile to
Kconfig.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/Kconfig  | 24 +++++++++++++++++++-----
 drivers/dma/sh/Makefile | 14 +++++++++++---
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 0f71981..383b21f 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -2,21 +2,39 @@
 # DMA engine configuration for sh
 #
 
+#
+# DMA Engine Helpers
+#
+
 config SH_DMAE_BASE
 	bool "Renesas SuperH DMA Engine support"
-	depends on (SUPERH && SH_DMA) || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on !SUPERH || SH_DMA
 	depends on !SH_DMA_API
 	default y
 	select DMA_ENGINE
 	help
 	  Enable support for the Renesas SuperH DMA controllers.
 
+#
+# DMA Controllers
+#
+
 config SH_DMAE
 	tristate "Renesas SuperH DMAC support"
 	depends on SH_DMAE_BASE
 	help
 	  Enable support for the Renesas SuperH DMA controllers.
 
+if SH_DMAE
+
+config SH_DMAE_R8A73A4
+	def_bool y
+	depends on ARCH_R8A73A4
+	depends on CONFIG_OF
+
+endif
+
 config SUDMAC
 	tristate "Renesas SUDMAC support"
 	depends on SH_DMAE_BASE
@@ -34,7 +52,3 @@ config RCAR_AUDMAC_PP
 	depends on SH_DMAE_BASE
 	help
 	  Enable support for the Renesas R-Car Audio DMAC Peripheral Peripheral controllers.
-
-config SHDMA_R8A73A4
-	def_bool y
-	depends on ARCH_R8A73A4 && SH_DMAE != n
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 1ce88b2..0b13b8e 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -1,10 +1,18 @@
+#
+# DMA Engine Helpers
+#
+
 obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
-obj-$(CONFIG_SH_DMAE) += shdma.o
+
+#
+# DMA Controllers
+#
+
 shdma-y := shdmac.o
-ifeq ($(CONFIG_OF),y)
 shdma-$(CONFIG_SHDMA_R8A73A4) += shdma-r8a73a4.o
-endif
 shdma-objs := $(shdma-y)
+obj-$(CONFIG_SH_DMAE) += shdma.o
+
 obj-$(CONFIG_SUDMAC) += sudmac.o
 obj-$(CONFIG_RCAR_HPB_DMAE) += rcar-hpbdma.o
 obj-$(CONFIG_RCAR_AUDMAC_PP) += rcar-audmapp.o
-- 
1.8.5.5

