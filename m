From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 18 Feb 2013 19:33:50 +0000
Subject: [PATCH v2 4/4] ARM: mach-shmobile: marzen: add SATA support
Message-Id: <201302182334.15982.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add SATA support to marzen_defconfig.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
No changes since v1.

 arch/arm/configs/marzen_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/configs/marzen_defconfig
=================================--- renesas.orig/arch/arm/configs/marzen_defconfig
+++ renesas/arch/arm/configs/marzen_defconfig
@@ -49,6 +49,10 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_ATA_SFF=y
+CONFIG_ATA_BMDMA=y
+CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_FARADAY is not set
