From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 25 Jul 2014 14:40:49 +0000
Subject: [PATCH 5/6] usb: phy: Add Renesas R-Car Gen2 USB PHY support for r8a7794
Message-Id: <1406299250-23975-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index e253fa0..c1f55040 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -204,13 +204,13 @@ config USB_RCAR_PHY
 
 config USB_RCAR_GEN2_PHY
 	tristate "Renesas R-Car Gen2 USB PHY support"
-	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
+	depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7794 || COMPILE_TEST
 	select USB_PHY
 	help
 	  Say Y here to add support for the Renesas R-Car Gen2 USB PHY driver.
 	  It is typically used to control internal USB PHY for USBHS,
 	  and to configure shared USB channels 0 and 2.
-	  This driver supports R8A7790 and R8A7791.
+	  This driver supports R8A7790, R8A7791 and R8A7794.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called phy-rcar-gen2-usb.
-- 
1.8.4.5

