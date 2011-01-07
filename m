From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 Jan 2011 10:26:26 +0000
Subject: sh: update sh7757lcr_defconfig
Message-Id: <4D26EA52.8050005@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

 - disable the 8250 driver (fix the build error on sh7757lcr)
 - enable sh_eth driver

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/configs/sh7757lcr_defconfig |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 273f3fa..5f7f667 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -39,21 +39,15 @@ CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
-CONFIG_PHYLIB=y
 CONFIG_VITESSE_PHY=y
-CONFIG_MDIO_BITBANG=y
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
+CONFIG_SH_ETH=y
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_WLAN is not set
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=3
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
@@ -63,7 +57,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-CONFIG_INOTIFY=y
 CONFIG_ISO9660_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
@@ -76,10 +69,8 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_FTRACE is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.1

