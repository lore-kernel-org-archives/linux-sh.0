From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 20 Mar 2008 22:34:02 +0000
Subject: Re: [PATCH] 2/2 mtd: Add support for the Dreamcast VMU flash
Message-Id: <1206052442.6274.26.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1205879413.6250.13.camel@localhost.localdomain>
	 <1205880554.6250.25.camel@localhost.localdomain>
	 <1205880982.6250.32.camel@localhost.localdomain>
	 <20080320141018.34127f0d.akpm@linux-foundation.org>
In-Reply-To: <20080320141018.34127f0d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dwmw2@infradead.org, greg@kroah.com, lethal@linux-sh.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-mtd@vger.kernel.org


On Thu, 2008-03-20 at 14:10 -0700, Andrew Morton wrote:

> If this error is taken, vmu_flash_write() (at least) will not call
> maple_vmu_write_block() and hence mdev->mq->sem never gets up()ed.  As far
> as I can tell.
> 
> Also, when this function is called from vmu_flash_read_char() I can't see
> where mdev->mq->sem gets up()ed ever.  But I didn't look too hard.
> 

It's not an issue - the bus will report "a no reply" at the end of the
bus read and that will result in an automatic up.


<snip>
> > +
> > +	for (x = 0; x < card->writecnt; x++) {
> > +		/* take the lock to protect the contents of sendbuf */
> > +		locking = down_interruptible(&mdev->mq->sem);
> > +		if (locking) {
> > +			error = -EBUSY;
> > +			goto fail_nolock;
> > +		}
> 
> Confused.  Where within this loop does the up(&mdev->mq->sem) happen?
> 

It's in the bus code.


> > +		((unsigned long *)sendbuf)[1] > > +			cpu_to_be32(partition << 24 | x << 16 | num);
> > +		memcpy(sendbuf + 8, buf + phaselen * x, phaselen);
> > +		mdev->mq->sendbuf = sendbuf;
> > +		/* wait for the mutex to be available */
> > +		maple_add_packet(mdev->mq);
> 
> Within here, I guess, via a workqueue or timer function?


It's handled in a workqueue in the main bus code, yes.

