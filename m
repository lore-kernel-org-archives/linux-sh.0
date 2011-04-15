From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:04:12 +0000
Subject: [PATCH 2/2] sh: update SDHI configuration symbols in defconfigs
Message-Id: <Pine.LNX.4.64.1104152003190.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/sh/configs/ecovec24_defconfig  |    2 +-
 arch/sh/configs/sh7757lcr_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 8d13e8a..911e30c 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -115,7 +115,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_FILE_STORAGE=m
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
-CONFIG_MMC_TMIO=y
+CONFIG_MMC_SDHI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_UIO=y
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index fa0ecf8..33ddb13 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -70,7 +70,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
-CONFIG_MMC_TMIO=y
+CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.2.5

