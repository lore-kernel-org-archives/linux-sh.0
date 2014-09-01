From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Sep 2014 13:14:02 +0000
Subject: [PATCH] usb: renesas_usbhs: fix driver dependencies
Message-Id: <8246169.KgpDT6Hn5J@amdc1032>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Renesas USBHS controller support should be available only on
Renesas ARM SoCs and SuperH architecture.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 drivers/usb/renesas_usbhs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/usb/renesas_usbhs/Kconfig
=================================--- a/drivers/usb/renesas_usbhs/Kconfig	2014-07-30 14:31:51.883523522 +0200
+++ b/drivers/usb/renesas_usbhs/Kconfig	2014-09-01 14:25:42.028512490 +0200
@@ -5,6 +5,7 @@
 config USB_RENESAS_USBHS
 	tristate 'Renesas USBHS controller'
 	depends on USB_GADGET
+	depends on ARCH_SHMOBILE || ARCH_SH || COMPILE_TEST
 	default n
 	help
 	  Renesas USBHS is a discrete USB host and peripheral controller chip

