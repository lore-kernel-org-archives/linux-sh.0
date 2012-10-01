From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 01 Oct 2012 03:08:54 +0000
Subject: [PATCH] ARM: shmobile: mackerel: defconfig update
Message-Id: <87ehlirirj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables following devices by default
 - I2C
 - HDMI
 - USB (host/gadget)
 - ALSA (FSI)
 - DMAEngine

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/mackerel_defconfig |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 306a2e2..7b79a0b 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -70,17 +70,31 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=8
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 # CONFIG_MFD_SUPPORT is not set
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_SH_MOBILE_LCDC=y
+CONFIG_FB_SH_MOBILE_HDMI=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_ARM is not set
+CONFIG_SND_SOC_SH4_FSI=y
+CONFIG_USB=y
+CONFIG_USB_RENESAS_USBHS_HCD=y
+CONFIG_USB_RENESAS_USBHS=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_RENESAS_USBHS_UDC=y
+CONFIG_DMADEVICES=y
+CONFIG_SH_DMAE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.7.9.5

