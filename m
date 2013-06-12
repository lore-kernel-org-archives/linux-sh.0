From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Jun 2013 02:14:53 +0000
Subject: [PATCH 1/3 v4] ARM: shmobile: bockw defconfig: add RTC RX8581 support
Message-Id: <8761xk6pnq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - based on renesas-next-20130611v2

 arch/arm/configs/bockw_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index d662608..cb7638d 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -86,6 +86,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_RX8581=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.7.9.5

