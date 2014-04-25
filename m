From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 25 Apr 2014 16:18:38 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: armadillo800eva defconfig: Enable REGULATOR_GPIO and LEDS_GPIO
Message-Id: <1398442718-31476-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1365425547-10391-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365425547-10391-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable missing options for devices in platform data and/or DT:
  - REGULATOR_GPIO
  - LEDS_GPIO (and its dependencies)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop config refresh

 arch/arm/configs/armadillo800eva_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 065adddeee3e..d9675c68a399 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -96,6 +96,7 @@ CONFIG_I2C_GPIO=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
@@ -127,6 +128,9 @@ CONFIG_USB_ETH=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
-- 
1.7.9.5

