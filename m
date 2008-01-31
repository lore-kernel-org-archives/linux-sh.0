From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Jan 2008 04:19:39 +0000
Subject: Re: slab cache allocator problem?
Message-Id: <20080131041939.GA12926@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1201645404.6269.7.camel@localhost.localdomain>
In-Reply-To: <1201645404.6269.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 29, 2008 at 10:23:24PM +0000, Adrian McMenamin wrote:
> Then allocate objects like this:
> 
> 	mq->recvbufdcsp = kmem_cache_zalloc(maple_queue_cache, GFP_KERNEL);
> 	mq->recvbuf = (void *) P2SEGADDR(mq->recvbufdcsp);
> 
[snip]

> 
> But when I allocate and free them via hotplugging maple devices, I get
> things like this (after what appears to be a random number of
> hotplugs):
> 
This sort of abuse of P2SEGADDR is really not what you want to be doing
in the first place. I'd really like to just get rid of the P1/P2SEGADDR
wrappers completely, as people do nothing but abuse them, and more often
than not depend on the wrappers to deal with all of their problems,
rather than thinking about what they actually want to do.

If you need to do a cacheflush after the copy, then do so explicitly. You
can probably even get away with just doing an invalidation in the read
path and a write-back in the write path, which will be faster than always
accessing it uncached. Trying to hack around dealing with the cache
management directly is nasty at best.

My guess is that ->recvbufdcsp is hitting a cached slab object that still
has cachelines associated with it which you are hitting after a few
iterations. The way to fix this is to make the cache management explicit,
both for ->recvbufdcsp and ->recvbuf. I would also wager that once this
is done, you should be able to do away with ->recvbufdcsp completely and
just use ->recvbuf.
