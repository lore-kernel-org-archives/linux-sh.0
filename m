From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Aug 2016 20:52:26 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160824205225.GY15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <1909939.rYmWMrdImI@wuerfel>
In-Reply-To: <1909939.rYmWMrdImI@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <Marc.Zyngier@arm.com>

On Wed, Aug 24, 2016 at 10:01:08PM +0200, Arnd Bergmann wrote:
> On Wednesday, August 24, 2016 1:40:01 PM CEST Rich Felker wrote:
> > On Wed, Aug 24, 2016 at 06:42:05PM +0200, Daniel Lezcano wrote:
> > > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > > > index 5677886..3210ca5 100644
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > > > @@ -407,6 +407,15 @@ config SYS_SUPPORTS_SH_TMU
> > > >  config SYS_SUPPORTS_EM_STI
> > > >          bool
> > > >  
> > > > +config CLKSRC_JCORE_PIT
> > > > +   bool "J-Core PIT timer driver"
> > > > +   depends on OF && (SUPERH || COMPILE_TEST)
> > > 
> > > Even if this is correct, for the sake of consistency, it is preferable
> > > to change it to:
> > > 
> > >       bool "J-Core PIT timer driver" if COMPILE_TEST
> > >       depends on SUPERH
> > >       select CLKSRC_OF
> > 
> > Is this functionally equivalent? If so that's non-obvious to me. What
> > about the dropped OF dependency? The intent is that the option should
> > always be available for SUPERH targets using OF, otherwise only
> > available with COMPILE_TEST.
> 
> I think your version is correct here, Daniel made a mistake with the
> SUPERH dependency. Another way to write it would be
> 
> config CLKSRC_JCORE_PIT
>    bool "J-Core PIT timer driver" if COMPILE_TEST && !JCORE
>    depends on OF
> 	default JCORE
> 
> to make it impossible to disable when JCORE is set, but
> user-visible on all other architectures, SUPERH or otherwise.

There's no JCORE config item and in theory you don't even need to pick
CPU_J2 if you don't want SMP; CPU_SH2 should work. In practice the
legacy hw support needs to be converted over to device tree still, but
the goal has been to _avoid_ introducing soc/board/model specific
config stuff and move the arch to completely DT-based.

> > > > +static int jcore_pit_set(unsigned long delta, struct jcore_pit *pit)
> > > > +{
> > > > +   jcore_pit_disable(pit);
> > > > +   __raw_writel(delta, pit->base + REG_THROT);
> > > > +   __raw_writel(pit->enable_val, pit->base + REG_PITEN);
> > > > +   return 0;
> > > 
> > > Why do you need to use __raw_writel ?
> > > 
> > > s/__raw_writel/writel/
> > 
> > I actually tried multiple times to find good resources on policy for
> > which form to prefer, but didn't have much luck. My understanding is
> > that __raw_writel/__raw_readl always performs a native-endian
> > load/store, whereas writel/readl behavior depends on cpu endianness
> > and whether the arch declares that "pci bus" (that was the term I
> > found in the source, not relevant here) io is endian-swapped or not.
> > Can you give me a better explanation of why we might prefer one form
> > or the other?
> 
> In general, a portable driver should use readl/writel because they
> are defined to have the behavior that x86 provides, which is what
> most developers understand best. Compared to __raw_readl/__raw_writel,
> it guarantees
> 
> - correct endianess (in most cases, exceptions see below)
> - does not leak out of spinlocks

Not even normal non-volatile accesses can leak across spinlocks;
they're memory+compiler barriers.

> - accesses are word-sized, the compiler cannot split them into
>   byte accesses, or merge subsequent accesses into larger words

Based on my reading of the code that's also true for the raw ones. At
least GCC interprets volatile as disallowing split/combined
loads/stores when the hardware supports the nominal load/store size,
and this seems to agree with the intent of the C standard that
volatile be usable for memory-mapped devices..

> - ordering against dma_map_*/dma_unmap_*/dma_sync_* is maintained

Aren't they barriers too?

> The __raw_* accessors are used as building blocks for
> readl/outl/ioread32/ioread32_be/readl_relaxed/... and they can
> usually be used safely on device RAM such as framebuffers but
> not much else in portable code. Some architectures also use the
> __raw_* accessors for MMIO registers, but that code is generally
> not portable.

My concern is that, depending on some arcane defines, readl/writel
could start doing byte-reversal of values since the CPU is big-endian.
arch/sh seems to have them defined in such a way that this doesn't
happen, but I was hoping to avoid depending on that. If you think it's
safe to assume they do the right thing, though, I'm okay with it. If
anything breaks when we try a little-endian version of the CPU/SoC
later I can go back and fix it.

> Endianess is always more complicated than one thinks, and it's
> handled differently across architectures, sometimes because of
> hardware differences, sometimes for historic reasons that differ
> only in the Linux implementation.
> 
> A large majority of devices are fixed to little-endian MMIO
> registers (as recommended by PCI), so that is a good default.
> 
> Exceptions to this are:
> 
> * Some architectures (e.g. PowerPC) typically run big-endian code,
>   and hardware designers decided to make the MMIO registers the
>   same. In this case, you can generally use ioread32_be/iowrite32_be.

This is something like our case, but the mmio registers are accessed
as 32-bit values and the endianness does not come into play. Sub-word
accesses just don't work at all for most of the mmio devices. This
will remain the same if/when we add little endian builds (there's work
on this on the jcore list).

Rich
