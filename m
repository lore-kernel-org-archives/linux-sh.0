From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Feb 2010 02:34:18 +0000
Subject: Re: [PATCH 2/4] sh: separate DMA headers, used by the legacy and the dmaengine drivers
Message-Id: <20100209023418.GE14586@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 08, 2010 at 10:05:23AM +0100, Guennadi Liakhovetski wrote:
> On Mon, 8 Feb 2010, Paul Mundt wrote:
> > The shared interrupt scheme is to deal with CPUs that have multiple IRQ
> > vectors backed by a single masking source. Given that there's no ability
> > to mask one vector without disabling all of them, we only request_irq()
> > for each unique masking source and make it shared for the cases where
> > there are multiple vectors sharing it. This will always be CPU-specific,
> > so you need to check the intc tables for a specific subtype to figure out
> > what it can and can't support.
> > 
> > Comparing the interrupt numbers is not sufficient, since they'll be
> > different. The IRQs are all unique, and are not muxed, they just can't be
> > masked individually. We could pass the IRQ flow information in through
> > the IRQ resource (ie, IORESOURCE_IRQ | IRQF_SHARED), but more than likely
> > most CPUs are going to have this issue, so just using IRQF_SHARED as a
> > default should be fine, too.
> 
> The point is, that the original driver checked for the SHDMA_MIX_IRQ flag, 
> and if it was set, it used only one IRQ number for all channels and the 
> error interrupt. So, it affects not only whether IRQF_SHARED is used, but 
> also what IRQs are requested. If we use different IRQ numbers in platform 
> data, then we need a way to tell the driver, that only the first one has 
> to be used. Otherwise we can either specify the same IRQ number already in 
> platform data, or we do request those different IRQs, in which case the 
> intc driver will know to use the same mask bit, but then we don't need 
> IRQF_SHARED?
> 
I thought that's what I said? We only request_irq() once for a unique
masking source, yes. I don't see precisely what is difficult about this,
there are multiple IRQ resources that can be passed in, if we only get a
single one then we can infer that we only request_irq() once, and at the
same time we can derive the flow control information from the resource
flags.

Whether or not IRQF_SHARED needs to be used or not depends on the CPU
configuration. Just because the DMA events happen to share a masking
source doesn't mean that they are the only ones using it. Most of masking
sources relate to a bit range in a masking register somewhere, and
whatever those bit positions relate to is up to the hardware designers.
Many of the DMA IRQs will share a mask range with IRQs that have no
relationship to the DMA engine at all, so we have no choice but to permit
sharing of the mask source in those cases.

Only the CPU can know what sort of configuration it requires, which is
why the CPU setup code is the only place where the IRQ flow control
information should be specified. Infering too much from the driver side
is going to be pretty fragile, since the driver isn't going to have
enough information to really make flow control decisions on its own.

> > Internal register layout will never vary between platforms because the
> > controller itself is wholly a property of the SoC. Different on-chip
> > DMACs might have different layouts, but again, all of that is known at
> > the time that the CPU definitions are being written up.
> 
> Yes, sorry, s/per-platform/per-SoC/. And no, I wasn't aware, that 
> different DMAC instances on one SoC can have different register layouts. 
> Just like SCIFs then;)
> 
Fortunately they're a bit more consistent than SCI/SCIF! I don't think
any of the mass produced CPUs have had to suffer through this mixing and
matching thing yet, but it's certainly something we should try and be
prepared for.

> > I think you misunderstood my comment. My point is that since the TS_SHIFT
> > is effectively common we could just represent that with a bitmap and then
> > convert the valid sizes to bit positions for indicating which of the
> > values is valid for that CPU. A simple wrapper around that to map it out
> > to the proper CHCR layout would then take care of handling CPU-specific
> > differences dynamically, which in turn would permit us to kill off all of
> > this crap from the headers.
> 
> Well, let's see: TS_INDEX2VAL() (and indirectly CHCR_TS_*_SHIFT), and 
> XMIT_SZ_* are used to initialise .chcr field in platform arrays of struct 
> sh_dmae_slave_config. So, unless we sant to calculate those fields at 
> run-time, these have to stay macros.

Yes, this is why I mentioned several times that these should be
calculated dynamically. ie, runtime. Given that these macros are already
used in runtime calculation, it really doesn't matter if we make the CHCR
calculation a bit heavier, at the end of the day the ability to kill off
all of those macros makes things a lot more flexible and easier to
maintain going forward.

Having written most of those macros initially, I can assure you that they
were never intended to deal with subtype variations. The original DMA
code had precisely 2 variations, the SH-3 DMA controller and the SH-4.
The Dreamcast built on top of that, and then as soon as SH-4A started,
everyone decided to have a field day with the DMA blocks. None of the
original code was ever intended to deal with the sort of subtype
variation that we have to deal with today, and almost all of that code
predates things like the driver model and all of the DMA interfaces
besides the ISA one.

You really would have been better off just rm -fr'ing all of the old code
before starting out with this series, as you seem to have built up some
sort of attachment to legacy crap that wants to be killed off completely.
These macros are not something we want to preserve unless we really need
to. Making things easier on the legacy code and avoiding some duplication
to that extent is not sufficient grounds for keeping the macros alive.

> But if you say register layout can be different on different
> controllers, shall we also be prepared for different CHCR internal
> structure? Then yes, we have to pass all that info in platform data,
> including the ts_shift array. Shall we do that? And keep all the macros
> local to platform code.
> 
That's probably going to be the easiest solution, given that even with
CPU families we see variations between subtypes. The case of individual
CPU subtypes mixing and matching different versions of the same block is
a corner case, but if we can dynamically support something like that,
then we're in pretty good shape for any abomination the hardware folks
decide to throw at us.

You should be happy you got stuck with one of the moderately sane CPUs.. :-)
