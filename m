From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 12 Oct 2015 07:12:22 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: enable HDMI output for Renesas RCar
Message-Id: <1444633942-4131-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1429196897-18822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1429196897-18822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Actviate HDMI output of the RCar DU (and LVDS while we are here).
Enable the HDMI encoder chip found on Lager/Koelsch boards.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e682da3f9d429e..a5c6ebf39b0aba 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -440,6 +440,7 @@ CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_ML86V7667=m
 CONFIG_DRM=y
+CONFIG_DRM_I2C_ADV7511=m
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
 CONFIG_DRM_NXP_PTN3460=m
@@ -450,6 +451,8 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_RCAR_DU=m
+CONFIG_DRM_RCAR_HDMI=y
+CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_PANEL_SIMPLE=y
-- 
2.1.4

