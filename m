From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 24 Aug 2016 20:01:08 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <1909939.rYmWMrdImI@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org> <57BDCE5D.2050609@linaro.org> <20160824174001.GW15995@brightrain.aerifal.cx>
In-Reply-To: <20160824174001.GW15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <Marc.Zyngier@arm.com>

On Wednesday, August 24, 2016 1:40:01 PM CEST Rich Felker wrote:
> On Wed, Aug 24, 2016 at 06:42:05PM +0200, Daniel Lezcano wrote:
> > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > > index 5677886..3210ca5 100644
> > > --- a/drivers/clocksource/Kconfig
> > > +++ b/drivers/clocksource/Kconfig
> > > @@ -407,6 +407,15 @@ config SYS_SUPPORTS_SH_TMU
> > >  config SYS_SUPPORTS_EM_STI
> > >          bool
> > >  
> > > +config CLKSRC_JCORE_PIT
> > > +   bool "J-Core PIT timer driver"
> > > +   depends on OF && (SUPERH || COMPILE_TEST)
> > 
> > Even if this is correct, for the sake of consistency, it is preferable
> > to change it to:
> > 
> >       bool "J-Core PIT timer driver" if COMPILE_TEST
> >       depends on SUPERH
> >       select CLKSRC_OF
> 
> Is this functionally equivalent? If so that's non-obvious to me. What
> about the dropped OF dependency? The intent is that the option should
> always be available for SUPERH targets using OF, otherwise only
> available with COMPILE_TEST.

I think your version is correct here, Daniel made a mistake with the
SUPERH dependency. Another way to write it would be

config CLKSRC_JCORE_PIT
   bool "J-Core PIT timer driver" if COMPILE_TEST && !JCORE
   depends on OF
	default JCORE

to make it impossible to disable when JCORE is set, but
user-visible on all other architectures, SUPERH or otherwise.

> > > +static int jcore_pit_set(unsigned long delta, struct jcore_pit *pit)
> > > +{
> > > +   jcore_pit_disable(pit);
> > > +   __raw_writel(delta, pit->base + REG_THROT);
> > > +   __raw_writel(pit->enable_val, pit->base + REG_PITEN);
> > > +   return 0;
> > 
> > Why do you need to use __raw_writel ?
> > 
> > s/__raw_writel/writel/
> 
> I actually tried multiple times to find good resources on policy for
> which form to prefer, but didn't have much luck. My understanding is
> that __raw_writel/__raw_readl always performs a native-endian
> load/store, whereas writel/readl behavior depends on cpu endianness
> and whether the arch declares that "pci bus" (that was the term I
> found in the source, not relevant here) io is endian-swapped or not.
> Can you give me a better explanation of why we might prefer one form
> or the other?

In general, a portable driver should use readl/writel because they
are defined to have the behavior that x86 provides, which is what
most developers understand best. Compared to __raw_readl/__raw_writel,
it guarantees

- correct endianess (in most cases, exceptions see below)
- does not leak out of spinlocks
- accesses are word-sized, the compiler cannot split them into
  byte accesses, or merge subsequent accesses into larger words
- ordering against dma_map_*/dma_unmap_*/dma_sync_* is maintained

The __raw_* accessors are used as building blocks for
readl/outl/ioread32/ioread32_be/readl_relaxed/... and they can
usually be used safely on device RAM such as framebuffers but
not much else in portable code. Some architectures also use the
__raw_* accessors for MMIO registers, but that code is generally
not portable.

Endianess is always more complicated than one thinks, and it's
handled differently across architectures, sometimes because of
hardware differences, sometimes for historic reasons that differ
only in the Linux implementation.

A large majority of devices are fixed to little-endian MMIO
registers (as recommended by PCI), so that is a good default.

Exceptions to this are:

* Some architectures (e.g. PowerPC) typically run big-endian code,
  and hardware designers decided to make the MMIO registers the
  same. In this case, you can generally use ioread32_be/iowrite32_be.

* Some devices have configurable endianess with a device specific
  register. 
  Sometimes those registers are set to match the CPU endianess,
  but for Linux it tends to be better to just set them to
  little-endian and use readl/writel

* Some drivers are configurable at HW synthesis time, and we have
  a mix of devices. If you have this, you usually need to support
  both ways in the driver with a helper function that uses ioread32
  or ioread32_be depending on the configuration. This can be done
  using either compile-time or runtime configuration.

* Some SoCs have boot-time configurable endianess and enforce that
  MMIO registers and the CPU always use the same way. We are
  inconsistent in handling those, I'd recommend creating a header
  file for that SoC that defines vendor specific helper functions.

* Some (usually very old) SoCs have configurable endianess, but
  don't actually change the behavior of the SoC or the MMIO devices,
  but only flip the address lines on the memory interface.
  This is similar to the previous one, but has additional problems
  with FIFO registers. You generally cannot use portable drivers
  here.

	Arnd
