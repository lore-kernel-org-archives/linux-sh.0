From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 28 Mar 2014 16:54:01 +0000
Subject: [PATCH] ARM: shmobile: Enable USBHS gadget support in shmobile_defconfig
Message-Id: <1396025641-30520-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The renesas_usbhs driver provides USB gadget support for most Renesas
platforms. To increase hardware support enable the driver in the
shmobile_defconfig multiplatform configuration.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/configs/shmobile_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 146ee70..c10e626 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -103,7 +103,11 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RCAR=y
+CONFIG_USB=y
 CONFIG_USB_RCAR_GEN2_PHY=y
+CONFIG_USB_RENESAS_USBHS=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_RENESAS_USBHS_UDC=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
-- 
1.8.4.5

