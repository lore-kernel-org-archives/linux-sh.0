From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 26 Jul 2011 18:50:23 +0000
Subject: [PATCH 1/2] MMC / TMIO: Fix build issue related to struct scatterlist
Message-Id: <201107262050.23379.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201107262049.15333.rjw@sisk.pl>
In-Reply-To: <201107262049.15333.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix build issue caused by undefined struct scatterlist in
drivers/mmc/host/tmio_mmc.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/mmc/host/tmio_mmc.h      |    1 +
 drivers/usb/renesas_usbhs/fifo.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6/drivers/mmc/host/tmio_mmc.h
=================================--- linux-2.6.orig/drivers/mmc/host/tmio_mmc.h
+++ linux-2.6/drivers/mmc/host/tmio_mmc.h
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/scatterlist.h>
 
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001

