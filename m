From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 26 Jul 2011 18:51:01 +0000
Subject: [PATCH 2/2] USB / Renesas: Fix build issue related to struct scatterlist
Message-Id: <201107262051.02019.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201107262049.15333.rjw@sisk.pl>
In-Reply-To: <201107262049.15333.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix build issue caused by undefined struct scatterlist in
drivers/usb/renesas_usbhs/fifo.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/usb/renesas_usbhs/fifo.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/usb/renesas_usbhs/fifo.c
=================================--- linux-2.6.orig/drivers/usb/renesas_usbhs/fifo.c
+++ linux-2.6/drivers/usb/renesas_usbhs/fifo.c
@@ -16,6 +16,7 @@
  */
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/scatterlist.h>
 #include "./common.h"
 #include "./pipe.h"
 

