From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Apr 2013 15:53:54 +0000
Subject: [PATCH] ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig
Message-Id: <Pine.LNX.4.64.1304031752440.10531@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

An AS3711 PMIC is used on kzm9g to supply CPU power and LCD backlight.
This patch enables it in board defconfig.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/configs/kzm9g_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index f6e585b..1ad0280 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -84,9 +84,12 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_GPIO_PCF857X=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_AS3711=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_AS3711=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
+CONFIG_BACKLIGHT_AS3711=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_FB_SH_MOBILE_MERAM=y
-- 
1.7.2.5

