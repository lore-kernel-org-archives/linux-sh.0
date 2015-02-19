From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:42:35 +0000
Subject: [PATCH 03/03] ARM: shmobile: Adjust arm64 defconfig to include DU/VSP1
Message-Id: <20150219014235.1795.20336.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the arm64 defconfig to include DU and VSP1.
Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm64/configs/defconfig |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- 0001/arch/arm64/configs/defconfig
+++ work/arch/arm64/configs/defconfig	2015-02-19 08:00:33.055507232 +0900
@@ -98,9 +98,20 @@ CONFIG_GPIO_XGENE=y
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_FB=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
+CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_VSP1=y
+CONFIG_DRM=y
+CONFIG_DRM_I2C_ADV7511=y
+CONFIG_DRM_RCAR_DU=y
+CONFIG_DRM_RCAR_HDMI=y
+CONFIG_DRM_RCAR_LVDS=y
 CONFIG_FB_ARMCLCD=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
