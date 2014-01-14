From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 14 Jan 2014 02:26:00 +0000
Subject: [PATCH 4/4] ARM: shmobile: lager: add sound support on defconfig
Message-Id: <8761pnguyx.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/lager_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 89b6e71..38b3bb0 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -100,6 +100,10 @@ CONFIG_VIDEO_RCAR_VIN=y
 CONFIG_VIDEO_ADV7180=y
 CONFIG_DRM=y
 CONFIG_DRM_RCAR_DU=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_RCAR=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-- 
1.7.9.5

