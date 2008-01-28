From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jan 2008 05:53:10 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom CDROM drive on SEGA Dreamcast
Message-Id: <20080128055310.GA7574@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1200007549.6349.16.camel@localhost.localdomain> <1200088609.6213.3.camel@localhost.localdomain> <20080112053630.0ccb290e.akpm@linux-foundation.org> <1200351607.6196.4.camel@localhost.localdomain> <1200352635.6196.8.camel@localhost.localdomain> <1200527877.6243.3.camel@localhost.localdomain> <20080117012743.GD14107@linux-sh.org> <1200609006.6253.1.camel@localhost.localdomain> <20080118005633.GA14945@linux-sh.org> <20080127213323.470d6a3b.akpm@linux-foundation.org>
In-Reply-To: <20080127213323.470d6a3b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Jens Axboe <jens.axboe@oracle.com>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, Jan 27, 2008 at 09:33:23PM -0800, Andrew Morton wrote:
> On Fri, 18 Jan 2008 09:56:33 +0900 Paul Mundt <lethal@linux-sh.org> wrote:
> 
> > On Thu, Jan 17, 2008 at 10:30:06PM +0000, Adrian McMenamin wrote:
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
> > > I hope I've fixed all the white space and other issues now!
> > > 
> > > Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > > 
> > Looks good to me. I'll add it to my queue unless Andrew has any glaring
> > objections.
> 
> Looks like a driver to me, but Jens is mostly-cdrom-maintainer.

Indeed, his Acked-by was already collected, so I've added it to my tree.
