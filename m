From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 04 Feb 2014 18:48:23 +0000
Subject: [PATCH 4/4] ARM: shmobile: koelsch: Enable VIN SoC camera in defconfig
Message-Id: <1391539703-5787-5-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables R-Car VIN SoC camera along with
the ADV7180 I2C decoder in koelsch_defconfig.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/configs/koelsch_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index c3b3c9d..96563fd 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -67,6 +67,13 @@ CONFIG_I2C_RCAR=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_VIDEO_RCAR_VIN=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ADV7180=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
-- 
1.8.3.1

