From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 May 2010 10:57:48 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc1
Message-Id: <20100518105748.GA3731@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100518092532.GA3050@linux-sh.org> <AANLkTim6t8oG-vdLKE918Sd2TFKJpSf5Bw2PTtSsD_Fh@mail.gmail.com> <20100518101500.GA3156@linux-sh.org> <AANLkTinIVjwrQ9gza2FIvZN5w4nm8ZjSUe836oRmWYG7@mail.gmail.com>
In-Reply-To: <AANLkTinIVjwrQ9gza2FIvZN5w4nm8ZjSUe836oRmWYG7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, magnus.damm@gmail.com, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Tue, May 18, 2010 at 04:21:37PM +0530, Jaswinder Singh Rajput wrote:
> On Tue, May 18, 2010 at 3:45 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> Hmm, so still it is between ARM and SH, so better option will be :
> 
Those were examples, we already have cases where blocks are shared across
more architectures than that.

> include/linux/sh_clk.h -> include/sh/clk.h
> include/linux/sh_dma.h -> include/sh/dma.h
> include/linux/sh_intc.h -> include/sh/intc.h
> 
> So when arm files will come then, then we can make it like this :
> 
The ARM use case is already there, today.

> include/arm/clk.h
> include/arm/dma.h
> include/arm/intc.h
> 
Did you even bother looking at the files and how they are used? We are
not going to duplicate identical files for each architecture.

> There are no doubts in future we will have asymmetrical processing,
> where we will use multiple architectures, so better make different
> directory for them instead of putting load on include/linux which
> already over-loaded.
> 
You seem to be ignoring the fact that we've had these use cases for years
already and that the current scheme has so far served us pretty well in
that regard. If we have headers for drivers that are used across multiple
architectures, then include/linux is ultimately the proper place for
them. We could shoe-horn them in to some sort of pseudo-architecture
thing in include/ but for what purpose?

Until you've actually read through the background mail on this and
actually looked at the code in question I see very little point in
continuing this thread. I'm of course open to suggestions on how to make
this sort of abstraction cleaner, but so far none of your suggestions are
relevant to the problem at hand.
