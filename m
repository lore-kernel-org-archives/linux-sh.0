From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 22 Jan 2009 00:18:05 +0000
Subject: [PATCH] Migo-R defconfig include ov772x, tw9910
Message-Id: <uiqo8kvql.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch updates the Migo-R defconfig to include
ov772x camera and tw9910 video driver

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/configs/migor_defconfig |   42 ++++++++++++++++++++++++++++++--------
 1 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 76380ce..77fe31c 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.28
-# Fri Jan  9 17:09:35 2009
+# Linux kernel version: 2.6.29-rc1
+# Thu Jan 22 09:16:16 2009
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -45,8 +45,12 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-# CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
+
+#
+# Control Group support
+#
+# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -389,6 +393,7 @@ CONFIG_WIRELESS_EXT=y
 CONFIG_WIRELESS_EXT_SYSFS=y
 # CONFIG_LIB80211 is not set
 # CONFIG_MAC80211 is not set
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -411,6 +416,7 @@ CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 CONFIG_MTD_CMDLINE_PARTS=y
 # CONFIG_MTD_AR7_PARTS is not set
@@ -458,9 +464,7 @@ CONFIG_MTD_CFI_UTIL=y
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_PHYSMAP_START=0xffffffff
-CONFIG_MTD_PHYSMAP_LEN=0
-CONFIG_MTD_PHYSMAP_BANKWIDTH=0
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -488,6 +492,12 @@ CONFIG_MTD_NAND_PLATFORM=y
 # CONFIG_MTD_ONENAND is not set
 
 #
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+# CONFIG_MTD_QINFO_PROBE is not set
+
+#
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
@@ -587,6 +597,10 @@ CONFIG_SMC91X=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_IWLWIFI_LEDS is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -761,6 +775,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
 # CONFIG_REGULATOR is not set
 
 #
@@ -806,9 +821,9 @@ CONFIG_SOC_CAMERA=y
 # CONFIG_SOC_CAMERA_MT9M111 is not set
 # CONFIG_SOC_CAMERA_MT9T031 is not set
 # CONFIG_SOC_CAMERA_MT9V022 is not set
-# CONFIG_SOC_CAMERA_TW9910 is not set
-CONFIG_SOC_CAMERA_PLATFORM=y
-# CONFIG_SOC_CAMERA_OV772X is not set
+CONFIG_SOC_CAMERA_TW9910=y
+# CONFIG_SOC_CAMERA_PLATFORM is not set
+CONFIG_SOC_CAMERA_OV772X=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
 # CONFIG_DAB is not set
@@ -866,11 +881,13 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_PXA25X is not set
 # CONFIG_USB_GADGET_PXA27X is not set
 # CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_IMX is not set
 CONFIG_USB_GADGET_M66592=y
 CONFIG_USB_M66592=y
 CONFIG_SUPERH_BUILT_IN_M66592=y
 # CONFIG_USB_GADGET_AMD5536UDC is not set
 # CONFIG_USB_GADGET_FSL_QE is not set
+# CONFIG_USB_GADGET_CI13XXX is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
@@ -883,6 +900,11 @@ CONFIG_USB_G_SERIAL=y
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_USB_CDC_COMPOSITE is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
@@ -961,6 +983,7 @@ CONFIG_UIO_PDRV_GENIRQ=y
 CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY is not set
 # CONFIG_QUOTA is not set
@@ -1004,6 +1027,7 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_EFS_FS is not set
 # CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_OMFS_FS is not set
-- 
1.5.6.3

