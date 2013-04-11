From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 11 Apr 2013 04:51:28 +0000
Subject: [PATCH v6 1/2] dma: sh: add Kconfig
Message-Id: <51664150.6040508@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds Kconfig in the drivers/dma/sh.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v6:
  - There is a new patch, but I say v6.

 drivers/dma/Kconfig    |   10 +---------
 drivers/dma/sh/Kconfig |   11 +++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)
 create mode 100644 drivers/dma/sh/Kconfig

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index dec088d..37ee004 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -171,15 +171,7 @@ config TEGRA20_APB_DMA
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
diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
new file mode 100644
index 0000000..7e85ad6
--- /dev/null
+++ b/drivers/dma/sh/Kconfig
@@ -0,0 +1,11 @@
+#
+# DMA engine configuration for sh
+#
+
+config SH_DMAE
+	tristate "Renesas SuperH DMAC support"
+	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
+	depends on !SH_DMA_API
+	select DMA_ENGINE
+	help
+	  Enable support for the Renesas SuperH DMA controllers.
-- 
1.7.1
