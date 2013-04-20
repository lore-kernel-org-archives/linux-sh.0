From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 20 Apr 2013 20:38:43 +0000
Subject: [PATCH 5/5] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in defconfig
Message-Id: <201304210038.43857.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304210013.46110.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304210013.46110.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add the VIN and ML86V7667 drivers to 'bockw_defconfig'.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/configs/bockw_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)

Index: renesas/arch/arm/configs/bockw_defconfig
=================================--- renesas.orig/arch/arm/configs/bockw_defconfig
+++ renesas/arch/arm/configs/bockw_defconfig
@@ -76,6 +76,13 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HWMON is not set
 CONFIG_I2C=y
 CONFIG_I2C_RCAR=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_VIDEO_RCAR_VIN=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ML86V7667=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
