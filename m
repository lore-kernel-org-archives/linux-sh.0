From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Feb 2010 09:05:23 +0000
Subject: Re: [PATCH 2/4] sh: separate DMA headers, used by the legacy and
Message-Id: <Pine.LNX.4.64.1002080842560.4463@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 8 Feb 2010, Paul Mundt wrote:

> On Fri, Feb 05, 2010 at 10:33:55AM +0100, Guennadi Liakhovetski wrote:

...

> > > > +#define SHDMA_MIX_IRQ	(1 << 0)
> > > > +
> > > With the IRQs being passed through platform data, there shouldn't be any
> > > need for this anymore. If the driver wants to use it internally for
> > > differentiating between muxed vs split out IRQs that's fine, but the
> > > platform data shouldn't care.
> > 
> > Actually, do you have an idea why some platforms want or have to use this 
> > shared IRQ scheme? I see 7780 and 7785 using it, although they do have an 
> > IRQ assigned to each channel, the only exception seems to be 7780, which 
> > shares 1 DMA Address Error IRQ between both controllers, but this flag 
> > also multiplexes all channel IRQs... How would you prefer to decide, when 
> > to share IRQs without this flag? Check if IRQs of channel 0 and channel 1 
> > are equal? Or just set the IRQF_SHARED flag always?
> > 
> The shared interrupt scheme is to deal with CPUs that have multiple IRQ
> vectors backed by a single masking source. Given that there's no ability
> to mask one vector without disabling all of them, we only request_irq()
> for each unique masking source and make it shared for the cases where
> there are multiple vectors sharing it. This will always be CPU-specific,
> so you need to check the intc tables for a specific subtype to figure out
> what it can and can't support.
> 
> Comparing the interrupt numbers is not sufficient, since they'll be
> different. The IRQs are all unique, and are not muxed, they just can't be
> masked individually. We could pass the IRQ flow information in through
> the IRQ resource (ie, IORESOURCE_IRQ | IRQF_SHARED), but more than likely
> most CPUs are going to have this issue, so just using IRQF_SHARED as a
> default should be fine, too.

The point is, that the original driver checked for the SHDMA_MIX_IRQ flag, 
and if it was set, it used only one IRQ number for all channels and the 
error interrupt. So, it affects not only whether IRQF_SHARED is used, but 
also what IRQs are requested. If we use different IRQ numbers in platform 
data, then we need a way to tell the driver, that only the first one has 
to be used. Otherwise we can either specify the same IRQ number already in 
platform data, or we do request those different IRQs, in which case the 
intc driver will know to use the same mask bit, but then we don't need 
IRQF_SHARED?

> > > > +#define CHCR_TS_LOW_MASK	0x18
> > > > +#define CHCR_TS_LOW_SHIFT	3
> > > > +#define CHCR_TS_HIGH_MASK	0
> > > > +#define CHCR_TS_HIGH_SHIFT	0
> > > > +
> > > > +#define DMAOR_INIT	DMAOR_DME
> > > > +
> > > These should all be part of the platform data.
> > 
> > Well, I've spent quite a bit of time thinking about it, and even at first 
> > implemented it like that... But then I decided, that this is something, 
> > that the driver itself can know. I decided, that the proper separation 
> > between platform data and platform-specific driver knowledge would be - 
> > everything, that concerns controller's integration into the system, like 
> > address ranges, interrupt numbers, belongs to platform data, but if 
> > internal register layout differs between platforms, I thought, that should 
> > be driver's internal knowledge. But if you disagree I can switch it over, 
> > no problem. Besides, at least so far, this is not per-controller, but 
> > per-platform specifics.
> > 
> Internal register layout will never vary between platforms because the
> controller itself is wholly a property of the SoC. Different on-chip
> DMACs might have different layouts, but again, all of that is known at
> the time that the CPU definitions are being written up.

Yes, sorry, s/per-platform/per-SoC/. And no, I wasn't aware, that 
different DMAC instances on one SoC can have different register layouts. 
Just like SCIFs then;)

> Other than things
> like pinmux, the platform itself has very little say about what goes on
> with the DMACs.
> 
> There are corner cases like the Dreamcast that use reserved bits in
> certain system registers to get cascade working, but these should be
> treated as the abominations that they are rather than penalizing systems
> that aren't crap.
> 
> The pros of having all of this as platform data far outweigh any cons.
> The few systems that have a problem with this quite frankly brought it on
> themselves, and is nothing you should be concerning yourself with.
> 
> > Besides, these macros are also used by the legacy driver, so, we would end 
> > up with a duplication. They are also used to define TS_INDEX2VAL()...
> > 
> Duplication is fine. The legacy driver is its own thing entirely, nothing
> in the new driver should be pandering to it. The new driver gives us a
> chance to dump all of the legacy garbage and do things right, the fringe
> systems that are using the legacy bits can live with duplication. They're
> also unlikely to ever support the new driver.
> 
> > > > +enum {
> > > > +	XMIT_SZ_8BIT		= 0,
> > > > +	XMIT_SZ_16BIT		= 1,
> > > > +	XMIT_SZ_32BIT		= 2,
> > > > +	XMIT_SZ_64BIT		= 7,
> > > > +	XMIT_SZ_128BIT		= 3,
> > > > +	XMIT_SZ_256BIT		= 4,
> > > > +	XMIT_SZ_128BIT_BLK	= 0xb,
> > > > +	XMIT_SZ_256BIT_BLK	= 0xc,
> > > > +};
> > > > +
> > > > +/* log2(size / 8) - used to calculate number of transfers */
> > > > +#define TS_SHIFT {			\
> > > > +	[XMIT_SZ_8BIT]		= 0,	\
> > > > +	[XMIT_SZ_16BIT]		= 1,	\
> > > > +	[XMIT_SZ_32BIT]		= 2,	\
> > > > +	[XMIT_SZ_64BIT]		= 3,	\
> > > > +	[XMIT_SZ_128BIT]	= 4,	\
> > > > +	[XMIT_SZ_256BIT]	= 5,	\
> > > > +	[XMIT_SZ_128BIT_BLK]	= 4,	\
> > > > +	[XMIT_SZ_256BIT_BLK]	= 5,	\
> > > > +}
> > > > +
> > > > +#define TS_INDEX2VAL(i)	((((i) & 3) << CHCR_TS_LOW_SHIFT) | \
> > > > +			 ((((i) >> 2) & 3) << CHCR_TS_HIGH_SHIFT))
> > > > +
> > > We see that the complex case is a superset, suggesting that it's
> > > worthwhile to make this common.
> > 
> > Not for all, SH4 has it different, there 0 means 64-byte transfers. But 
> > that's for the enum. The array itself is _obviously_ identical - it's just 
> > the bit-shift for each transfer size - just as my own comment is saying;) 
> > So, yes, that one can be made common.
> > 
> That's ok, as long as it's just one or two CPU families that have such
> variations we can just ifdef them in place. If it gets out of hand beyond
> that, then that too should be shoved in to platform data.
> 
> > > This XMIT_SZ_xxx enum should be moved in to the upper level so all CPUs
> > > have visibility of it, and at the same time should be converted to shifts
> > > to permit platform data to have an xmit_sz_valid bitmap or something
> > > similar.
> > 
> > I think, you misunderstood it. The enum lists CHCR TS bitfield values, so, 
> > we cannot arbitrarily define it. As for validity check - this array is 
> > only used at one 
> > 
> I think you misunderstood my comment. My point is that since the TS_SHIFT
> is effectively common we could just represent that with a bitmap and then
> convert the valid sizes to bit positions for indicating which of the
> values is valid for that CPU. A simple wrapper around that to map it out
> to the proper CHCR layout would then take care of handling CPU-specific
> differences dynamically, which in turn would permit us to kill off all of
> this crap from the headers.

Well, let's see: TS_INDEX2VAL() (and indirectly CHCR_TS_*_SHIFT), and 
XMIT_SZ_* are used to initialise .chcr field in platform arrays of struct 
sh_dmae_slave_config. So, unless we sant to calculate those fields at 
run-time, these have to stay macros. I can add a validity bitmask, but 
let's otherwise preserve macros, shall we? But if you say register layout 
can be different on different controllers, shall we also be prepared for 
different CHCR internal structure? Then yes, we have to pass all that info 
in platform data, including the ts_shift array. Shall we do that? And keep 
all the macros local to platform code.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
