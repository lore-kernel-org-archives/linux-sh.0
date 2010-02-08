From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Feb 2010 01:24:13 +0000
Subject: Re: [PATCH 2/4] sh: separate DMA headers, used by the legacy and the dmaengine drivers
Message-Id: <20100208012413.GA21065@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 05, 2010 at 10:33:55AM +0100, Guennadi Liakhovetski wrote:
> Thanks for the review. A general question first: many of the headers in 
> this patch are DMAC specific, not just SuperH DMA specific, are there no 
> other DMA controllers on DH? Can there ever be any other ones? If so, 
> maybe we have to choose more specific names, than just dma-register.h or 
> dmaengine.h... However, so far I don't see any other SH DMA controller 
> implementations in the kernel - apart from device-specific ones (like 
> video in / out).
> 
In general all of the on-chip DMACs for system DMA are variations on the
ancient Hitachi DMAC. Some contain more complex features than others (ie,
native scatter-gather, chained transfers, etc, etc.) but they're all
effectively rolled from the same block.

The hordes of other DMACs that find their way in to the design end up
being fairly specific, and will never be suitable for a generic
framework. The corner cases are engines that cascade off of fixed on-chip
DMAC channels and behave like conventional ISA DMA, but no one has built
a system like that since the Dreamcast.

> On Thu, 4 Feb 2010, Paul Mundt wrote:
> > Even then, these definitions are specific to Hitachi/Renesas-style
> > on-chip DMACs, so they're not really common across the architecture (this
> > is why we have dma-sh.h instead of stashing everything in dma.h, although
> > in retrospect I could have chosen a better name).
> 
> Sorry, don't understand. How does putting a file under arch/sh in the "sh" 
> namespace (dma-sh.h) add any information about its scope?
> 
It's a bit confusing, but that particular block has always been fairly
standard SH IP. Having said that, it's not implemented by all of the
CPUs, and it's a wholly optional component for the architecture. Others,
like the ST parts, have their own controllers that have little in common
with the generic SH one. All of the Hitachi/Renesas SH parts evolved from
the old Hitachi DMAC. 

> > > +#define SHDMA_MIX_IRQ	(1 << 0)
> > > +
> > With the IRQs being passed through platform data, there shouldn't be any
> > need for this anymore. If the driver wants to use it internally for
> > differentiating between muxed vs split out IRQs that's fine, but the
> > platform data shouldn't care.
> 
> Actually, do you have an idea why some platforms want or have to use this 
> shared IRQ scheme? I see 7780 and 7785 using it, although they do have an 
> IRQ assigned to each channel, the only exception seems to be 7780, which 
> shares 1 DMA Address Error IRQ between both controllers, but this flag 
> also multiplexes all channel IRQs... How would you prefer to decide, when 
> to share IRQs without this flag? Check if IRQs of channel 0 and channel 1 
> are equal? Or just set the IRQF_SHARED flag always?
> 
The shared interrupt scheme is to deal with CPUs that have multiple IRQ
vectors backed by a single masking source. Given that there's no ability
to mask one vector without disabling all of them, we only request_irq()
for each unique masking source and make it shared for the cases where
there are multiple vectors sharing it. This will always be CPU-specific,
so you need to check the intc tables for a specific subtype to figure out
what it can and can't support.

Comparing the interrupt numbers is not sufficient, since they'll be
different. The IRQs are all unique, and are not muxed, they just can't be
masked individually. We could pass the IRQ flow information in through
the IRQ resource (ie, IORESOURCE_IRQ | IRQF_SHARED), but more than likely
most CPUs are going to have this issue, so just using IRQF_SHARED as a
default should be fine, too.

> > > +#define CHCR_TS_LOW_MASK	0x18
> > > +#define CHCR_TS_LOW_SHIFT	3
> > > +#define CHCR_TS_HIGH_MASK	0
> > > +#define CHCR_TS_HIGH_SHIFT	0
> > > +
> > > +#define DMAOR_INIT	DMAOR_DME
> > > +
> > These should all be part of the platform data.
> 
> Well, I've spent quite a bit of time thinking about it, and even at first 
> implemented it like that... But then I decided, that this is something, 
> that the driver itself can know. I decided, that the proper separation 
> between platform data and platform-specific driver knowledge would be - 
> everything, that concerns controller's integration into the system, like 
> address ranges, interrupt numbers, belongs to platform data, but if 
> internal register layout differs between platforms, I thought, that should 
> be driver's internal knowledge. But if you disagree I can switch it over, 
> no problem. Besides, at least so far, this is not per-controller, but 
> per-platform specifics.
> 
Internal register layout will never vary between platforms because the
controller itself is wholly a property of the SoC. Different on-chip
DMACs might have different layouts, but again, all of that is known at
the time that the CPU definitions are being written up. Other than things
like pinmux, the platform itself has very little say about what goes on
with the DMACs.

There are corner cases like the Dreamcast that use reserved bits in
certain system registers to get cascade working, but these should be
treated as the abominations that they are rather than penalizing systems
that aren't crap.

The pros of having all of this as platform data far outweigh any cons.
The few systems that have a problem with this quite frankly brought it on
themselves, and is nothing you should be concerning yourself with.

> Besides, these macros are also used by the legacy driver, so, we would end 
> up with a duplication. They are also used to define TS_INDEX2VAL()...
> 
Duplication is fine. The legacy driver is its own thing entirely, nothing
in the new driver should be pandering to it. The new driver gives us a
chance to dump all of the legacy garbage and do things right, the fringe
systems that are using the legacy bits can live with duplication. They're
also unlikely to ever support the new driver.

> > > +enum {
> > > +	XMIT_SZ_8BIT		= 0,
> > > +	XMIT_SZ_16BIT		= 1,
> > > +	XMIT_SZ_32BIT		= 2,
> > > +	XMIT_SZ_64BIT		= 7,
> > > +	XMIT_SZ_128BIT		= 3,
> > > +	XMIT_SZ_256BIT		= 4,
> > > +	XMIT_SZ_128BIT_BLK	= 0xb,
> > > +	XMIT_SZ_256BIT_BLK	= 0xc,
> > > +};
> > > +
> > > +/* log2(size / 8) - used to calculate number of transfers */
> > > +#define TS_SHIFT {			\
> > > +	[XMIT_SZ_8BIT]		= 0,	\
> > > +	[XMIT_SZ_16BIT]		= 1,	\
> > > +	[XMIT_SZ_32BIT]		= 2,	\
> > > +	[XMIT_SZ_64BIT]		= 3,	\
> > > +	[XMIT_SZ_128BIT]	= 4,	\
> > > +	[XMIT_SZ_256BIT]	= 5,	\
> > > +	[XMIT_SZ_128BIT_BLK]	= 4,	\
> > > +	[XMIT_SZ_256BIT_BLK]	= 5,	\
> > > +}
> > > +
> > > +#define TS_INDEX2VAL(i)	((((i) & 3) << CHCR_TS_LOW_SHIFT) | \
> > > +			 ((((i) >> 2) & 3) << CHCR_TS_HIGH_SHIFT))
> > > +
> > We see that the complex case is a superset, suggesting that it's
> > worthwhile to make this common.
> 
> Not for all, SH4 has it different, there 0 means 64-byte transfers. But 
> that's for the enum. The array itself is _obviously_ identical - it's just 
> the bit-shift for each transfer size - just as my own comment is saying;) 
> So, yes, that one can be made common.
> 
That's ok, as long as it's just one or two CPU families that have such
variations we can just ifdef them in place. If it gets out of hand beyond
that, then that too should be shoved in to platform data.

> > This XMIT_SZ_xxx enum should be moved in to the upper level so all CPUs
> > have visibility of it, and at the same time should be converted to shifts
> > to permit platform data to have an xmit_sz_valid bitmap or something
> > similar.
> 
> I think, you misunderstood it. The enum lists CHCR TS bitfield values, so, 
> we cannot arbitrarily define it. As for validity check - this array is 
> only used at one 
> 
I think you misunderstood my comment. My point is that since the TS_SHIFT
is effectively common we could just represent that with a bitmap and then
convert the valid sizes to bit positions for indicating which of the
values is valid for that CPU. A simple wrapper around that to map it out
to the proper CHCR layout would then take care of handling CPU-specific
differences dynamically, which in turn would permit us to kill off all of
this crap from the headers.
