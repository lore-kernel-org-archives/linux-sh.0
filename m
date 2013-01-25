From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:02:53 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: armadillo: defconfig: Enable CEU
Message-Id: <1359079374-25032-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359079374-25032-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359079374-25032-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Update the defconfig to enable the CEU camera.

It appears that it was previously enabled but an
update is required for Kconfig changes.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index f9e2701..0b98100 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -90,14 +90,11 @@ CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
-# CONFIG_RC_CORE is not set
-# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
-# CONFIG_V4L_USB_DRIVERS is not set
+CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_MT9T112=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
-# CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SH_MOBILE_HDMI=y
-- 
1.7.10.4

