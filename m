From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 22 Mar 2008 17:43:25 +0000
Subject: [PATCH] 0/3 - Add support for VMU flash memory and update maple
Message-Id: <1206207805.6324.13.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dwmw2 <dwmw2@infradead.org>, Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@users.sourceforge.net>, MTD <linux-mtd@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

OK, second iteration of this - have added more comments and, I hope,
addressed all or nearly all of people's comments.

This adds support for the flash memory portion of the "visual memory
unit" on the SEGA Dreamcast.

Changelogs on the patches but, in summary:

On the maple bus side: 

- adds a mutex to ensure device is only addressed once per maple bus
cycle (and so avoiding corruption of the linked list of packets waiting
for transmission).

- properly uses the existing lock on the waiting packet queue and cleans
up the way the linked lists (of waiting and processed packets) are
handled.

For the device:

- relies on the mutex to ensure block reads and writes are handled
properly - normally the bus driver will unlock the mutex once a waiting
packet has been processed

- implements support for partitions. There are rumours such devices
exist - they are supported in the specification. But I've never seen
one!


There is code to follow (eventually) to implement the FAT based
filesystem used by the Dreamcast to save to these devices, but they
should be usable as small flash devices with other filesystems too.

(See http://mc.pp.se/dc/vms/flashmem.html for more details on the
hardware etc)

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>


