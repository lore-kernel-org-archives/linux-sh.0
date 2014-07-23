From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 Jul 2014 02:45:01 +0000
Subject: [PATCH 10/11][RFC] ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
Message-Id: <87ppgwu72s.wl%kuninori.morimoto.gx@renesas.com>
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
index 6bc85a5..d6bdfde 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -133,6 +133,7 @@ CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
+CONFIG_RCAR_AUDMAC_PP=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
-- 
1.7.9.5

