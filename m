From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Jan 2008 01:27:43 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom CDROM drive on SEGA Dreamcast
Message-Id: <20080117012743.GD14107@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1200007549.6349.16.camel@localhost.localdomain> <1200088609.6213.3.camel@localhost.localdomain> <20080112053630.0ccb290e.akpm@linux-foundation.org> <1200351607.6196.4.camel@localhost.localdomain> <1200352635.6196.8.camel@localhost.localdomain> <1200527877.6243.3.camel@localhost.localdomain>
In-Reply-To: <1200527877.6243.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jan 16, 2008 at 11:57:57PM +0000, Adrian McMenamin wrote:
> 
> On Mon, 2008-01-14 at 23:17 +0000, Adrian McMenamin wrote:
> > On Mon, 2008-01-14 at 23:00 +0000, Adrian McMenamin wrote:
> > > From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > >  
> > > This patch adds support for the GD-Rom drive, SEGA's proprietary
> > > implementation of an IDE CD Rom for the SEGA Dreamcast. This driver
> > > implements Sega's Packet Interface (SPI) - at least partially. It will
> > > also read disks in SEGA's propreitary GD format.
> > > 
> > > Unlike previous drivers (which were never in mainline) this uses DMA and
> > > not PIO to read disks. It is a new driver, not a refactoring of old
> > > drivers. 
> > > 
> > > Hopefully this patch addresses some issues that have been raised by
> > > Andrew. Jens previously ack'ed this, but I've left that off (though the
> > > IO code hasn't really been touched).
> > >  
> > > Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > >  
> > > (Jens - this awaits your ack before going in Paul's queue for the 2.6.25
> > > window)
> > >  
> > 
> I think I have now removed all the whitespace issues.
> 
> Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
Looks better. __devexit/__devexit_p()?
