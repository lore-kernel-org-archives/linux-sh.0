From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Sep 2014 12:20:13 +0000
Subject: Re: [PATCH 02/03] ARM: shmobile: sh73a0: Add Multiplatform support
Message-Id: <20140904122009.GB30392@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904022856.26216.25574.sendpatchset@w520>
In-Reply-To: <20140904022856.26216.25574.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 04, 2014 at 08:01:53PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Sep 4, 2014 at 3:51 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Sep 04, 2014 at 11:28:56AM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >>
> >> Enable sh73a0 Multiplatform support for the generic sh73a0
> >> machine vector. No board support is enabled, and the board
> >> code for KZM9G DT Reference is left by itself.
> >
> > This appears to overlap with:
> >
> > [PATCH v2 03/10] ARM: shmobile: sh73a0: common clock framework board support
> 
> So it seems. I propose that Ulrich will focus on getting the sh73a0
> drivers/clk bits merged, while I fix up the generic sh73a0
> multiplatform support in parallel.
> 
> Can you make sure the CMT bits get sorted out independently?

Ok. So the implication is that I can take this series once
you've respun it for the minor #ifdef problem that I pointed out
earlier today?

Sure, but it can't be entirely independent as the CMT need a clock.
I believe there are two options.

1. Add CMT first, using legacy clocks.
   Then later update it to use CCF.

2. Add CMT after CCF

Which to you prefer?
