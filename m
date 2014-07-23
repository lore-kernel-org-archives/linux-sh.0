From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 Jul 2014 02:45:10 +0000
Subject: [PATCH 11/11][RFC] ARM: shmobile: multiplatform: add R-Car DMAC support on defconfig
Message-Id: <87oawgu72j.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/shmobile_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d6bdfde..4d23848 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -134,6 +134,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_RCAR_AUDMAC_PP=y
+CONFIG_RCAR_DMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
-- 
1.7.9.5

