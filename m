From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 23 Apr 2013 11:00:06 +0000
Subject: [PATCH v8 1/2] dma: sh: add Kconfig
Message-Id: <517669B6.7040801@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds Kconfig in the drivers/dma/sh. This patch also adds
a new config "SH_DMAE_BASE" and the "config SH_DMAE" depends on it.
Since some drivers (e.g. sh_mmcif.c) depends on shdma-base.c if
CONFIG_DMA_ENGINE=y, the "config SH_DMAE_BASE" is set as "bool".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v8:
  - add a new config "SH_DMAE_BASE".
  - the original config "SH_DMAE" depends on "SH_DMAE_BASE".

 drivers/dma/Kconfig     |   10 +---------
 drivers/dma/Makefile    |    2 +-
 drivers/dma/sh/Kconfig  |   18 ++++++++++++++++++
 drivers/dma/sh/Makefile |    2 +-
 4 files changed, 21 insertions(+), 11 deletions(-)
 create mode 100644 drivers/dma/sh/Kconfig

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index afe5b19..e992489 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -172,15 +172,7 @@ config TEGRA20_APB_DMA
 	  This DMA controller transfers data from memory to peripheral fifo
 	  or vice versa. It does not support memory to memory data transfer.

-
-
-config SH_DMAE
-	tristate "Renesas SuperH DMAC support"
-	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
-	depends on !SH_DMA_API
-	select DMA_ENGINE
-	help
-	  Enable support for the Renesas SuperH DMA controllers.
+source "drivers/dma/sh/Kconfig"

 config COH901318
 	bool "ST-Ericsson COH901318 DMA support"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 268e626..a2b0df5 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_DW_DMAC) += dw_dmac.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_MX3_IPU) += ipu/
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
-obj-$(CONFIG_SH_DMAE) += sh/
+obj-$(CONFIG_SH_DMAE_BASE) += sh/
 obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
 obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
new file mode 100644
index 0000000..2407998
--- /dev/null
+++ b/drivers/dma/sh/Kconfig
@@ -0,0 +1,18 @@
+#
+# DMA engine configuration for sh
+#
+
+config SH_DMAE_BASE
+	bool "Renesas SuperH DMA Engine support"
+	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
+	depends on !SH_DMA_API
+	default y
+	select DMA_ENGINE
+	help
+	  Enable support for the Renesas SuperH DMA Engine.
+
+config SH_DMAE
+	tristate "Renesas SuperH DMAC support"
+	depends on SH_DMAE_BASE
+	help
+	  Enable support for the Renesas SuperH DMA controllers.
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 54ae957..eceaf46 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_SH_DMAE) += shdma-base.o
+obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o
 obj-$(CONFIG_SH_DMAE) += shdma.o
-- 
1.7.1
