From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Tue, 18 Mar 2008 22:30:13 +0000
Subject: [PATCH] 0/2 Add support for maple "Visual Memory Unit" on SEGA
Message-Id: <1205879413.6250.13.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dwmw2@infradead.org, Greg KH <greg@kroah.com>, Paul Mundt <lethal@linux-sh.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, linux-mtd@vger.kernel.org

The VMU is a small (approx 128K) hotpluggable flash device on the SEGA Dreamcast.

To get this to work I have had to rewrite parts of the maple bus driver - some of that
is bug fixing (in the sense that the bus driver was not allowing proper probing, just
forcing the load of the appropriate driver) - the main functional change is to add a
semaphore to the maple device (to ensure that devices can properly inject maple packets
into the queue of packets waiting to be dispatched via DMA to the devices themselves).

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>


 drivers/mtd/maps/Kconfig     |   14 +
 drivers/mtd/maps/Makefile    |    1 +
 drivers/mtd/maps/vmu_flash.c |  746 ++++++++++++++++++++++++++++++++++++++++++
 drivers/sh/maple/maple.c     |  113 ++++---
 include/linux/maple.h        |    2 +


