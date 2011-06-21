From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 21 Jun 2011 08:03:25 +0000
Subject: [PATCH] sh: fix compile error using sh7757lcr_defconfig
Message-Id: <4E00504D.90901@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the complie error in ehci-hcd.c because it needs an additional
configuration.

  CC      drivers/usb/host/ehci-hcd.o
drivers/usb/host/ehci-hcd.c:1288:2: error: #error "missing bus glue for ehci-hcd"
make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
make[2]: *** [drivers/usb/host] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/configs/sh7757lcr_defconfig |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 33ddb13..cfde98d 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -9,7 +9,6 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_SLAB=y
@@ -39,8 +38,6 @@ CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -56,18 +53,19 @@ CONFIG_SH_ETH=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=3
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_SPI=y
 CONFIG_SPI_SH=y
 # CONFIG_HWMON is not set
-CONFIG_MFD_SH_MOBILE_SDHI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_SH=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_SH=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-- 
1.7.1
