From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jan 2008 10:17:15 +0000
Subject: Re: set_dma_addr missing ?
Message-Id: <20080128101715.GB8546@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
In-Reply-To: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 28, 2008 at 11:00:33AM +0100, Francis Moreau wrote:
> On Jan 28, 2008 10:09 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Mon, Jan 28, 2008 at 09:48:59AM +0100, Francis Moreau wrote:
> > > I have a DMA controller, which has very little in common with ISA DMA
> > > as you said.  I'd like to use it from a generic driver. Which API
> > > should I use then ?
> > >
> > Well, there are two options, either using the existing SH DMA API, or
> > trying to hook something in through the dmaengine API.
> 
> Woh ! I completely missed the dmaengine API. All DMA documentations I found
> were about the DMA-mapping API or the old ISA DMA API.
> 
There's accurate kernel documentation now? When did we start doing that? ;-)

> > The latter is the way that we'll be moving in the near future, but we
> > do still need to keep compatability with the existing SH DMA API
> > around in order to avoid breaking the existing in-tree users.
> 
> Great. Does that mean that all drivers found in arch/sh/drivers/dma/ will
> be converted to use the damengine API except for dma-isa.c ?
> 
That's the plan, yes. DMABRG will probably need some special handling,
but that's pretty isolated. The ST40 DMACs will also prove to be a source
of irritation, so it's still going to take some iterations before
everything is happily migrated. I'll probably start with the SH DMAC (or
the assorted Dreamcast DMACs) and work back from there.

> > You may wish to poke around arch/sh/drivers/dma/. There are lots of
> > greppable things you can find in the rest of tree that show the API,
> > in-tree users, etc. Post if you have any problems.
> 
> I'll take a deep look into this.
> 
> Do you know when the move will happen ?
> 
We are working on 2.6.25 now, so this work will target 2.6.26 at the
absolute earliest. It really depends on how much other stuff goes through
the merge window to see how long we're going to be stuck trying to get
2.6.25 in to reasonable shape.

Once we're in to -rc2 or so I'll see about starting up the 2.6.26
development queue and we can start prioritizing at that point. It is on
the TODO list at least, along with far too many other things there aren't
enough time in the year for.

> BTW, I asked some questions about the DMA API on LKML. Here is the
> pointer if you're interested:
> 
> http://lkml.org/lkml/2008/1/28/65
> 
Thanks, I vaguely recall having read this when it went by, but I'll dig
in to my archives again to make sure I didn't miss anything.
