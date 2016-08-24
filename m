From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Aug 2016 21:44:44 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160824214444.GZ15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <1909939.rYmWMrdImI@wuerfel>
 <20160824205225.GY15995@brightrain.aerifal.cx>
 <20160824212212.GB1775@remoulade>
In-Reply-To: <20160824212212.GB1775@remoulade>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>

On Wed, Aug 24, 2016 at 10:22:13PM +0100, Mark Rutland wrote:
> On Wed, Aug 24, 2016 at 04:52:26PM -0400, Rich Felker wrote:
> > On Wed, Aug 24, 2016 at 10:01:08PM +0200, Arnd Bergmann wrote:
> > > On Wednesday, August 24, 2016 1:40:01 PM CEST Rich Felker wrote:
> > > > I actually tried multiple times to find good resources on policy for
> > > > which form to prefer, but didn't have much luck. My understanding is
> > > > that __raw_writel/__raw_readl always performs a native-endian
> > > > load/store, whereas writel/readl behavior depends on cpu endianness
> > > > and whether the arch declares that "pci bus" (that was the term I
> > > > found in the source, not relevant here) io is endian-swapped or not.
> > > > Can you give me a better explanation of why we might prefer one form
> > > > or the other?
> > > 
> > > In general, a portable driver should use readl/writel because they
> > > are defined to have the behavior that x86 provides, which is what
> > > most developers understand best. Compared to __raw_readl/__raw_writel,
> > > it guarantees
> > > 
> > > - correct endianess (in most cases, exceptions see below)
> > > - does not leak out of spinlocks
> > 
> > Not even normal non-volatile accesses can leak across spinlocks;
> > they're memory+compiler barriers.
> 
> Note that Arnd was talking in general, about cross-architectural guarantees.
> 
> Across architectures, not all barriers are equivalent. On some architectures,
> the barriers used by spinlocks don't necessarily order accesses across
> disparate memory types (i.e. DRAM and IO), or might not guarantee that the
> ordering is consistent to observers other than (coherent) CPUs. Hence a
> portable driver should care about this distinction.
> 
> If they're equivalent for you, you may as well use the portably stronger form,
> as it's less likely to surprise others.

*nod* Understood.

> > > - accesses are word-sized, the compiler cannot split them into
> > >   byte accesses, or merge subsequent accesses into larger words
> > 
> > Based on my reading of the code that's also true for the raw ones. At
> > least GCC interprets volatile as disallowing split/combined
> > loads/stores when the hardware supports the nominal load/store size,
> > and this seems to agree with the intent of the C standard that
> > volatile be usable for memory-mapped devices..
> > 
> > > - ordering against dma_map_*/dma_unmap_*/dma_sync_* is maintained
> > 
> > Aren't they barriers too?
> 
> As above, not all barriers are equivalent. Your architecture may provide
> stronger (or weaker) guarantees than others.

OK.

> > > The __raw_* accessors are used as building blocks for
> > > readl/outl/ioread32/ioread32_be/readl_relaxed/... and they can
> > > usually be used safely on device RAM such as framebuffers but
> > > not much else in portable code. Some architectures also use the
> > > __raw_* accessors for MMIO registers, but that code is generally
> > > not portable.
> > 
> > My concern is that, depending on some arcane defines, readl/writel
> > could start doing byte-reversal of values since the CPU is big-endian.
> > arch/sh seems to have them defined in such a way that this doesn't
> > happen, but I was hoping to avoid depending on that. If you think it's
> > safe to assume they do the right thing, though, I'm okay with it. If
> > anything breaks when we try a little-endian version of the CPU/SoC
> > later I can go back and fix it.
> 
> I guess this really depends on the expectations you have w.r.t. the endianness
> of devices vs the endianness of CPUs. If you expect the two to always be
> matched, please add a comment in the driver to that effect.
> 
> As Arnd and others mentioned, the vastly common case is that the endianness of
> CPUs and devices is not fixed to each other, and devices are typically
> little-endian.

Since it's not used in other designs, I can't say anything meaningful
about how it hypothetically might be, but the intent on all current
and currently-planned systems is that 32-bit loads/stores be performed
using values that are meaningful as values on the cpu, i.e. with no
byte swapping regardless of cpu endianness. The current hardware is
designed as big-endian, and the proposed patches for supporting little
endian just involve flipping the low bits of the address for 16- and
8-bit accesses (not relevant to mmio registers that are only
accessible in 32-bit units).

> > > Endianess is always more complicated than one thinks, and it's
> > > handled differently across architectures, sometimes because of
> > > hardware differences, sometimes for historic reasons that differ
> > > only in the Linux implementation.
> > > 
> > > A large majority of devices are fixed to little-endian MMIO
> > > registers (as recommended by PCI), so that is a good default.
> > > 
> > > Exceptions to this are:
> > > 
> > > * Some architectures (e.g. PowerPC) typically run big-endian code,
> > >   and hardware designers decided to make the MMIO registers the
> > >   same. In this case, you can generally use ioread32_be/iowrite32_be.
> > 
> > This is something like our case, but the mmio registers are accessed
> > as 32-bit values and the endianness does not come into play. 
> 
> This really depends on you endianness model, bus, etc. The above sounds like
> BE32 rather than BE8, assuming I've understood correctly, which is an unusual
> case nowadays.

I'm not familiar with those classifications, but from what I can tell,
BE32 describes it correctly. I'll see if I can get someone to verify
this. Is there a reason it's not widely used anymore? Perhaps
something related to supporting misaligned word-sized loads/stores?

Rich
