From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 28 Sep 2013 20:11:28 +0000
Subject: [PATCH 1/2] ARM: shmobile: bockw: enable HPB-DMAC in defconfig
Message-Id: <201309290011.28982.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable HPB-DMAC driver in 'bockw_defconfig'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against 'renesas-devel-20130927v2' tag of the 'renesas.git' repo.

 arch/arm/configs/bockw_defconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/configs/bockw_defconfig
=================================--- renesas.orig/arch/arm/configs/bockw_defconfig
+++ renesas/arch/arm/configs/bockw_defconfig
@@ -108,6 +108,8 @@ CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RX8581=y
+CONFIG_DMADEVICES=y
+CONFIG_RCAR_HPB_DMAE=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
