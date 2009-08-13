From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Aug 2009 03:17:21 +0000
Subject: Re: sh7785 cache question
Message-Id: <20090813031721.GF2701@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A7A9C73.1070000@siemens.com>
In-Reply-To: <4A7A9C73.1070000@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 06, 2009 at 01:03:47PM +0400, Valentin R Sitsikov wrote:
> So my question is why still all cache related code for the sh-7785 in 
> these instructions have effective address as operand instead of
> 0xF4XXXXXX ?
> 
[snip]

> Also It is interesting if there any plans for remove associative write 
> operation to memory mapped OC address array?
> 
This has mostly been a compatibility thing, as these new methods do not
work on older parts while at the same time the associated write still
works with current parts, even though it's less than optimal and will
likely go away in the future.

Currently there are a few cases that need to be handled:

	- icbi based I-cache flushing, especially for SMP parts where
	  broadcast invalidation is not handled by hardware.

	- decoupled I-cache and D-cache flushing, mostly for parts with
	  D-cache coherency that still need to maintain the I-cache bits.

	- D-cache flushing overloads for platforms that prefer using more
	  optimized routines.

These are things that I am presently working on in the sh/cachetlb topic
branch getting things tidied up for highmem and variable SH-X3 cache
configurations, which in turn will also benefit SH-X2 cores when
everything is done. It's a bit slow going due to the amount of heavy
testing and benchmarking that needs to be done every step of the way, but
it's slowly getting there.

Feel free to poke around at the topic branch if this is an area you are
interested in playing with, otherwise it should see a 2.6.32 merge.
