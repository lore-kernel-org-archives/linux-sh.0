From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Apr 2014 12:37:58 +0000
Subject: [PATCH] ARM: shmobile: Enable VSP1 in shmobile_defconfig
Message-Id: <20140408123758.9749.1753.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Both r8a7790 and r8a7791 have multiple on-chip VSP1 devices, so
enable the VSP1 driver by default in the shmobile_defconfig.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-devel-v3.14-20140408

 arch/arm/configs/shmobile_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- 0001/arch/arm/configs/shmobile_defconfig
+++ work/arch/arm/configs/shmobile_defconfig	2014-04-08 19:20:42.000000000 +0900
@@ -92,10 +92,14 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_PLATFORM=y
 CONFIG_VIDEO_RCAR_VIN=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_VSP1=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=y
 CONFIG_DRM=y
