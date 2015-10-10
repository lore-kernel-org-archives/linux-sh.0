From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 10 Oct 2015 19:14:45 +0000
Subject: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <1444504485-25790-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Actviate HDMI output of the RCar DU (and LVDS while we are here).
Enable the HDMI encoder chip found on Lager/Koelsch boards.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This is the final bit needed to get HDMI output with an shmobile_defconfig
built kernel. The other bits were renesas-devel-20151008-v4.3-rc4 plus some I2C
patches, which are already in my for-next or soon in my for-current branches.
The complete branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rcar-hdmi-output

Tested with a Lager board and using both I2C/IIC. Based on my testings in
Dublin with a Koelsch board, I'd be very surprised if it fails with Koelsch.
Laurent may prove me wrong ;)

 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 0bdeb4925be477..3aef019c0de789 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -140,7 +140,10 @@ CONFIG_VIDEO_RENESAS_VSP1=y
 CONFIG_VIDEO_ADV7180=y
 CONFIG_VIDEO_ML86V7667=y
 CONFIG_DRM=y
+CONFIG_DRM_I2C_ADV7511=y
 CONFIG_DRM_RCAR_DU=y
+CONFIG_DRM_RCAR_HDMI=y
+CONFIG_DRM_RCAR_LVDS=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
2.1.4

