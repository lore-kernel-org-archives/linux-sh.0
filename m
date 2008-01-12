From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 12 Jan 2008 11:57:43 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom CDROM drive on  SEGA Dreamcast
Message-Id: <20080112115740.GH6258@kernel.dk>
List-Id: <linux-sh.vger.kernel.org>
References: <1200007549.6349.16.camel@localhost.localdomain> <1200088609.6213.3.camel@localhost.localdomain>
In-Reply-To: <1200088609.6213.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Jan 11 2008, Adrian McMenamin wrote:
> 
> On Thu, 2008-01-10 at 23:25 +0000, Adrian McMenamin wrote:
> > From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > 
> > This patch adds support for the GD-Rom drive, SEGA's proprietary implementation of an IDE CD Rom for the SEGA Dreamcast. This driver implements Sega's Packet Interface (SPI) - at least partially. It will also read disks in SEGA's propreitary GD format.
> > 
> > Unlike previous drivers (which were never in mainline) this uses DMA and not PIO to read disks. It is a new driver, not a refactoring of old drivers. 
> > 
> > Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > 
> > (Jens - this awaits your ack before going in Paul's queue for the 2.6.25 window)
> > 
> > --------
> > 
> > 
> 
> Unfortunately, there was one small mistake (a repeated assignment), in
> the patch posted yesterday. Here is a corrected version.
> 
> Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

The io handling looks ok to me now.

Acked-by: Jens Axboe <jens.axboe@oracle.com>

-- 
Jens Axboe

