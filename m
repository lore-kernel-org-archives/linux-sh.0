From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Feb 2011 07:40:34 +0000
Subject: [PATCH 7/7] sh: update sh7757lcr_defconfig
Message-Id: <4D675CF2.3070502@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

- enable SPI bus, MTD, MMCIF, SD, USB host, and USB storage.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/configs/sh7757lcr_defconfig |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 5f7f667..fa0ecf8 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -38,7 +38,15 @@ CONFIG_IPV6=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
+CONFIG_MTD=y
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_VITESSE_PHY=y
 CONFIG_NET_ETHERNET=y
@@ -53,8 +61,17 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=3
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_SH=y
 # CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_MFD_SH_MOBILE_SDHI=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_TMIO=y
+CONFIG_MMC_SH_MMCIF=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_ISO9660_FS=y
-- 
1.7.1
