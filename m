From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 28 Sep 2013 20:12:33 +0000
Subject: [PATCH 2/2] ARM: shmobile: marzen: enable HPB-DMAC in defconfig
Message-Id: <201309290012.34072.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308090144.03912.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308090144.03912.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable HPB-DMAC driver in 'marzen_defconfig'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against 'renesas-devel-20130927v2' tag of the 'renesas.git' repo.

 arch/arm/configs/marzen_defconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/configs/marzen_defconfig
=================================--- renesas.orig/arch/arm/configs/marzen_defconfig
+++ renesas/arch/arm/configs/marzen_defconfig
@@ -106,6 +106,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_DMADEVICES=y
+CONFIG_RCAR_HPB_DMAE=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
