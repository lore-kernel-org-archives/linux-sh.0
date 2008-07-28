From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 23:57:27 +0000
Subject: Re: [PATCH] sh/maple: clean maple bus code
Message-Id: <20080728235727.GE28055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1217288656.6875.26.camel@localhost.localdomain>
In-Reply-To: <1217288656.6875.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Jul 29, 2008 at 12:44:16AM +0100, Adrian McMenamin wrote:
>  static struct mapleq *maple_allocq(struct maple_device *mdev)
>  {
>  	struct mapleq *mq;
>  
>  	mq = kmalloc(sizeof(*mq), GFP_KERNEL);
>  	if (!mq)
> -		return NULL;
> +		goto failed_nomem;
>  
>  	mq->dev = mdev;
>  	mq->recvbufdcsp = kmem_cache_zalloc(maple_queue_cache, GFP_KERNEL);
>  	mq->recvbuf = (void *) P2SEGADDR(mq->recvbufdcsp);
> -	if (!mq->recvbuf) {
> -		kfree(mq);
> -		return NULL;
> -	}
> +	if (!mq->recvbuf)
> +		goto failed_p2;

This is really the wrong thing to check, you want to be checking
mq->recvbufdcsp here, as kmem_cache_zalloc() will return an error, while
P2SEGADDR() casts away. I expect that if you toss a NULL pointer or
something similar at it you will just get the P2 base back anyways, it
was never intended for error cases.

I expect you will also want to document your locking strategy in detail
at the top of the file. You do have some corner cases that are handled
that are not immediately obvious at first glance, it would be good to
spell it out explicitly.
