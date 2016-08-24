From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 24 Aug 2016 22:54:06 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160824225405.GA3199@remoulade>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <1909939.rYmWMrdImI@wuerfel>
 <20160824205225.GY15995@brightrain.aerifal.cx>
 <20160824212212.GB1775@remoulade>
 <20160824214444.GZ15995@brightrain.aerifal.cx>
In-Reply-To: <20160824214444.GZ15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <Marc.Zyngier@arm.com>

On Wed, Aug 24, 2016 at 05:44:44PM -0400, Rich Felker wrote:
> On Wed, Aug 24, 2016 at 10:22:13PM +0100, Mark Rutland wrote:
> > On Wed, Aug 24, 2016 at 04:52:26PM -0400, Rich Felker wrote:
> > > On Wed, Aug 24, 2016 at 10:01:08PM +0200, Arnd Bergmann wrote:
> > > > On Wednesday, August 24, 2016 1:40:01 PM CEST Rich Felker wrote:
> > > > The __raw_* accessors are used as building blocks for
> > > > readl/outl/ioread32/ioread32_be/readl_relaxed/... and they can
> > > > usually be used safely on device RAM such as framebuffers but
> > > > not much else in portable code. Some architectures also use the
> > > > __raw_* accessors for MMIO registers, but that code is generally
> > > > not portable.
> > > 
> > > My concern is that, depending on some arcane defines, readl/writel
> > > could start doing byte-reversal of values since the CPU is big-endian.
> > > arch/sh seems to have them defined in such a way that this doesn't
> > > happen, but I was hoping to avoid depending on that. If you think it's
> > > safe to assume they do the right thing, though, I'm okay with it. If
> > > anything breaks when we try a little-endian version of the CPU/SoC
> > > later I can go back and fix it.
> > 
> > I guess this really depends on the expectations you have w.r.t. the endianness
> > of devices vs the endianness of CPUs. If you expect the two to always be
> > matched, please add a comment in the driver to that effect.
> > 
> > As Arnd and others mentioned, the vastly common case is that the endianness of
> > CPUs and devices is not fixed to each other, and devices are typically
> > little-endian.
> 
> Since it's not used in other designs, I can't say anything meaningful
> about how it hypothetically might be, but the intent on all current
> and currently-planned systems is that 32-bit loads/stores be performed
> using values that are meaningful as values on the cpu, i.e. with no
> byte swapping regardless of cpu endianness. The current hardware is
> designed as big-endian, and the proposed patches for supporting little
> endian just involve flipping the low bits of the address for 16- and
> 8-bit accesses (not relevant to mmio registers that are only
> accessible in 32-bit units).

Ok.

Generally speaking, it's preferable (to the Linux community) that devices has
some known fixed endianness, and that systems behave in a BE8 fashion (I'll
clarify that below per your prior question), i.e. not just flipping the low
bits of addresses.

That allows common infrastructure like readl/writel to be used consistently and
reliably, regardless of what peripherals are integrated into the system, and
regardless of the endianness of the CPUs. The kernel has to know which
endianness it is (for other reasons at least), and in general the endianness
swap that may be required in some cases is less of a performance const than any
infrastructure required to handle varied integration possibilities (e.g. LE,
BE, 'native'). It will also avoid having to modify each and every driver that
already use the existing infrastructure...

> > > > Endianess is always more complicated than one thinks, and it's
> > > > handled differently across architectures, sometimes because of
> > > > hardware differences, sometimes for historic reasons that differ
> > > > only in the Linux implementation.
> > > > 
> > > > A large majority of devices are fixed to little-endian MMIO
> > > > registers (as recommended by PCI), so that is a good default.
> > > > 
> > > > Exceptions to this are:
> > > > 
> > > > * Some architectures (e.g. PowerPC) typically run big-endian code,
> > > >   and hardware designers decided to make the MMIO registers the
> > > >   same. In this case, you can generally use ioread32_be/iowrite32_be.
> > > 
> > > This is something like our case, but the mmio registers are accessed
> > > as 32-bit values and the endianness does not come into play. 
> > 
> > This really depends on you endianness model, bus, etc. The above sounds like
> > BE32 rather than BE8, assuming I've understood correctly, which is an unusual
> > case nowadays.
> 
> I'm not familiar with those classifications, but from what I can tell,
> BE32 describes it correctly. 

I'm not sure if it's an ARM term or a more general one. See [1] for a
description. Per your description of flipping address lines, it sounds like
you're (planning on) implementing BE32.

> I'll see if I can get someone to verify this. Is there a reason it's not
> widely used anymore? Perhaps something related to supporting misaligned
> word-sized loads/stores?

For one thing, BE8 is self-consistent as you scale to larger word sizes, rather
than having to be special-cased at that boundary (i.e. one always has to endian
swap rather than only swap the 32-bit halves of a 64-bit load with BE32).

BE8 is generally seen as the 'true' big-endian, with BE32 being a particular
'middle-endian' variant [2]. Others are better equipped to provide rationale
and/or war stories...

Thanks,
Mark.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0290g/ch06s05s01.html
[2] https://en.wikipedia.org/wiki/Endianness#Middle-endian
