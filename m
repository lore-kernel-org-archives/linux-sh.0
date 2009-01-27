From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 27 Jan 2009 02:46:12 +0000
Subject: [PATCH] ap325 defconfig include ov772x
Message-Id: <uljsxcvd8.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch updates the ap325 defconfig to include
ov772x camera driver.
Old camera is still supported.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/configs/ap325rxa_defconfig |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 5c423fa..352f87d 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.28
-# Fri Jan  9 16:54:19 2009
+# Linux kernel version: 2.6.29-rc2
+# Tue Jan 27 11:45:08 2009
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -45,12 +45,12 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT
-# CONFIG_CGROUPS is not set
 CONFIG_GROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
 # CONFIG_RT_GROUP_SCHED is not set
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -378,6 +378,7 @@ CONFIG_WIRELESS=y
 # CONFIG_WIRELESS_EXT is not set
 # CONFIG_LIB80211 is not set
 # CONFIG_MAC80211 is not set
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -400,6 +401,7 @@ CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 CONFIG_MTD_CMDLINE_PARTS=y
 # CONFIG_MTD_AR7_PARTS is not set
@@ -447,9 +449,7 @@ CONFIG_MTD_CFI_UTIL=y
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_PHYSMAP_START=0xffffffff
-CONFIG_MTD_PHYSMAP_LEN=0
-CONFIG_MTD_PHYSMAP_BANKWIDTH=0
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -480,6 +480,12 @@ CONFIG_MTD_NAND_SH_FLCTL=y
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
 CONFIG_MTD_UBI=y
@@ -607,6 +613,10 @@ CONFIG_SMSC911X=y
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
@@ -790,6 +800,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
 # CONFIG_REGULATOR is not set
 
 #
@@ -837,7 +848,7 @@ CONFIG_SOC_CAMERA=y
 # CONFIG_SOC_CAMERA_MT9V022 is not set
 # CONFIG_SOC_CAMERA_TW9910 is not set
 CONFIG_SOC_CAMERA_PLATFORM=y
-# CONFIG_SOC_CAMERA_OV772X is not set
+CONFIG_SOC_CAMERA_OV772X=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
 # CONFIG_DAB is not set
@@ -1012,6 +1023,7 @@ CONFIG_FS_POSIX_ACL=y
 CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -1060,6 +1072,7 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_JFFS2_FS is not set
 # CONFIG_UBIFS_FS is not set
 # CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_OMFS_FS is not set
-- 
1.5.6.3

