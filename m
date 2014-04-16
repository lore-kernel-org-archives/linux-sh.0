From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Apr 2014 06:03:09 +0000
Subject: [PATCH 4/7] ARM: shmobile: Enable USBHS gadget support in shmobile_defconfig
Message-Id: <41551f3d7d9a37b55a6f84d77200bfe29d42c466.1397627278.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397627278.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397627278.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

The renesas_usbhs driver provides USB gadget support for most Renesas
platforms. To increase hardware support enable the driver in the
shmobile_defconfig multiplatform configuration.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
1.8.5.2

