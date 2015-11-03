From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 03 Nov 2015 14:28:11 +0000
Subject: Re: [PATCH v11 1/8] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
Message-Id: <20151103142810.GC4049@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-2-git-send-email-horms+renesas@verge.net.au>
 <20151015105820.GF8825@leverpostej>
 <CAMuHMdU00wJcrb7EsFjkKMw-gy04tXdGoyzPRNL-cjYZH8zneA@mail.gmail.com>
In-Reply-To: <CAMuHMdU00wJcrb7EsFjkKMw-gy04tXdGoyzPRNL-cjYZH8zneA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 21, 2015 at 03:34:39PM +0200, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Thu, Oct 15, 2015 at 12:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > +           gic: interrupt-controller@0xf1010000 {
> >> +                     compatible = "arm,gic-400";
> >> +                     #interrupt-cells = <3>;
> >> +                     #address-cells = <0>;
> >> +                     interrupt-controller;
> >> +                     reg = <0x0 0xf1010000 0 0x1000>,
> >> +                           <0x0 0xf1020000 0 0x2000>;
> >> +                     interrupts = <GIC_PPI 9
> >> +                                     (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
> >> +             };
> >
> > No GICH and GICV?
> 
> These seem to be defined in the "arm,gic-v3" DT bindings only, while this is
> an "arm,gic-400" (GICD_IIDR 0x0200043b)?

See the "GIC virtualization extensions (VGIC)" section in
Documentation/devicetree/bindings/arm/gic.txt

> I did notice hi6220.dtsi does have GICH and GICV, while it also claims
> to be an "arm,gic-400"...

That's fine, that's valid for any GICv2 with virtualization extensions.

> > Which exception level do CPUs boot at?
> 
> No idea.

For reference, the kernel should print it out just after booting all CPUs. e.g.
on Juno:

SMP: Total of 6 processors activated.
CPU: All CPU(s) started at EL2

Thanks,
Mark.
