From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 05 Jun 2008 12:21:00 +0000
Subject: [PATCH] usb: r8a66597-hcd: Add support for SH7723 USB host
Message-Id: <4847DA2C.3040606@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R8A66597 is similar to SH7723 USB 2.0 Host/Function module.
In addition, the USB of SH7366 is compatible with SH7723.
It can support SH7723 USB host by changing Kconfig.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/usb/host/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -up a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
--- a/drivers/usb/host/Kconfig	2008-06-05 20:26:17.000000000 +0900
+++ b/drivers/usb/host/Kconfig	2008-06-05 20:25:16.000000000 +0900
@@ -301,10 +301,10 @@ config USB_R8A66597_HCD

 config SUPERH_ON_CHIP_R8A66597
 	boolean "Enable SuperH on-chip USB like the R8A66597"
-	depends on USB_R8A66597_HCD && CPU_SUBTYPE_SH7366
+	depends on USB_R8A66597_HCD && (CPU_SUBTYPE_SH7366 || CPU_SUBTYPE_SH7723)
 	help
 	   Renesas SuperH processor has USB like the R8A66597.
-	   This driver supported processor is SH7366.
+	   This driver supported processors are SH7366 and SH7723.

 config USB_WHCI_HCD
 	tristate "Wireless USB Host Controller Interface (WHCI) driver"
Common subdirectories: a/drivers/usb/host/whci and b/drivers/usb/host/whci
