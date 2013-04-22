From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 22 Apr 2013 09:07:54 +0000
Subject: [PATCH 1/2 v7] dma: sh: add Kconfig
Message-Id: <5174FDEA.9050301@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds Kconfig in the drivers/dma/sh.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v7:
  - rebase this patch on the current remotes/origin/next branch of slave-dma.git.

 drivers/dma/Kconfig    |   10 +---------
 drivers/dma/sh/Kconfig |   11 +++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)
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
