From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 27 Dec 2007 12:49:39 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom device
Message-Id: <1198759779.6170.4.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60712261726l28960f69u2eb2756a6f5176e1@mail.gmail.com>
	 <20071227081822.GA22693@linux-sh.org>
In-Reply-To: <20071227081822.GA22693@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org


On Thu, 2007-12-27 at 17:18 +0900, Paul Mundt wrote:
> On Thu, Dec 27, 2007 at 01:26:47AM +0000, Adrian McMenamin wrote:

> 
> > +		/* now seek to take the request spinlock
> > + 		 * before handling ending the request */
> > +		spin_lock(&gdrom_lock);
> > +		list_del_init(&req->queuelist);
> > +		blk_requeue_request(gd.gdrom_rq, req);
> > +		if (err)
> > +			end_request(req, 0);
> > +		else
> > +			end_request(req, 1);
> > +	}
> > +	spin_unlock(&gdrom_lock);
> > +	kfree(read_command);
> > +}	
> > +
> This locking is all over the place. What is this lock supposed to be
> accomplishing?
> -

I have to hold the lock to access the request queue. As the linked list
of deferred requests is under the control of code also protected by the
lock, it is also held to ensure manipulation of that list is serialised.

The first step of the loop manipulates that linked list - so it is held
as we re-iterate over the loop.

This is pretty much the way Jens recommended I do it.

