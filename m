From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 16 Feb 2009 08:07:23 +0000
Subject: Re: [RFC][PATCH] filesystem: VMUFAT filesystem
Message-Id: <1234771643.6628.8.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1234646219.6609.37.camel@localhost.localdomain>
	 <20090216031523.GA16824@linux-sh.org>
In-Reply-To: <20090216031523.GA16824@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

On Mon, 2009-02-16 at 12:15 +0900, Paul Mundt wrote:
> On Sat, Feb 14, 2009 at 09:16:59PM +0000, Adrian McMenamin wrote:
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/fs.h>
> > +#include <linux/slab.h>
> > +#include <linux/blkdev.h>
> > +#include <linux/buffer_head.h>
> > +#include <linux/mtd/mtd.h>
> > +#include "vmufat.h"
> > +
> Why do you have an mtd include?


Ah, a left over from when this was first written and tied to the
hardware

...
> > +
> > +	bh->b_data[z + 0x10] = bcd_from_u8(century);
> > +	u8year = year + 80;
> > +	if (u8year > 99)
> > +		u8year = u8year - 100;
> > +
> > +	bh->b_data[z + 0x11] = bcd_from_u8(u8year);
> > +	bh->b_data[z + 0x12] = bcd_from_u8((__u8) month);
> > +	bh->b_data[z + 0x13] > > +	    bcd_from_u8((__u8) day - day_n[month - 1] + 1);
> > +	bh->b_data[z + 0x14] > > +	    bcd_from_u8((__u8) ((unix_date / 3600) % 24));
> > +	bh->b_data[z + 0x15] = bcd_from_u8((__u8) ((unix_date / 60) % 60));
> > +	bh->b_data[z + 0x16] = bcd_from_u8((__u8) (unix_date % 60));
> > +
> This should be abstracted out in to a separate function, and you can get
> rid of most of this hand-rolled time mangling by using the rtc lib
> routines.
> 
> Additionally, all of the bcd conversion code is superfluous, since you
> can include linux/bcd.h and use bin2bcd and bcd2bin directly.
> 

Another left over. In the 2.4 kernel there were several bespoke bcd
conversion functions and I just wrote another one and didn't even think
to check if a generic one had been added to the 2.6 kernel.


> > +	sb->s_blocksize_bits = log_2;
> 
> ilog2()?


Again, from what I can see this wasn't available kernel wide back in the
2.4 days.
> 
> I've tried to skip over the bits already noted by Evgeniy, but you may
> have already fixed up some of the issues noted above anyways.
> 
> Also, in the next iteration of this patch, please do not break the Cc
> list and send multiple times to different lists, it makes it very
> difficult to follow what is going on, especially if the threads of
> conversation diverge.


Thanks. I have already fixed some of this, as you say. Will get on with
tidying the rest of it.

