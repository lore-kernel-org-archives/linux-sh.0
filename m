From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 04 Nov 2014 01:50:13 +0000
Subject: [PATCH 22/23 v3] ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
Message-Id: <874muf91k1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change

 arch/arm/configs/shmobile_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b32afae..a2de58e 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -145,6 +145,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
+CONFIG_RCAR_AUDMAC_PP=y
 CONFIG_RCAR_DMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
-- 
1.7.9.5

