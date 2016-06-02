From: Rich Felker <dalias@libc.org>
Date: Thu, 02 Jun 2016 01:34:07 +0000
Subject: Re: [PATCH v3 04/12] of: add J-Core timer bindings
Message-Id: <20160602013407.GA12184@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <5341dfbb085d5647ebb6fe4390ca329b63e0e03d.1464148904.git.dalias@libc.org>
 <20160601135852.GA17217@rob-hp-laptop>
 <20160601175307.GC10893@brightrain.aerifal.cx>
 <CAL_JsqJYyvdc06v2+R=Wnmkk-cO7ZFq=7uGOhPxXdL0UfEu-iA@mail.gmail.com>
In-Reply-To: <CAL_JsqJYyvdc06v2+R=Wnmkk-cO7ZFq=7uGOhPxXdL0UfEu-iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Wed, Jun 01, 2016 at 05:36:19PM -0500, Rob Herring wrote:
> On Wed, Jun 1, 2016 at 12:53 PM, Rich Felker <dalias@libc.org> wrote:
> > On Wed, Jun 01, 2016 at 08:58:52AM -0500, Rob Herring wrote:
> >> On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> >> > Signed-off-by: Rich Felker <dalias@libc.org>
> >> > ---
> >> >  .../devicetree/bindings/timer/jcore,pit.txt        | 28 ++++++++++++++++++++++
> >> >  1 file changed, 28 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/timer/jcore,pit.txt b/Documentation/devicetree/bindings/timer/jcore,pit.txt
> >> > new file mode 100644
> >> > index 0000000..96c6815
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/timer/jcore,pit.txt
> >> > @@ -0,0 +1,28 @@
> >> > +J-Core Programmable Interval Timer and Clocksource
> >> > +
> >> > +Required properties:
> >> > +
> >> > +- compatible: Must be "jcore,pit".
> >> > +
> >> > +- reg: Memory region for timer/clocksource registers.
> >> > +
> >> > +- interrupts: An interrupt to assign for the timer. The actual pit
> >> > +  core is integrated with the aic and allows the timer interrupt
> >> > +  assignment to be programmed by software, but this property is
> >> > +  required in order to reserve an interrupt number that doesn't
> >> > +  conflict with other devices.
> >> > +
> >> > +Optional properties:
> >> > +
> >> > +- cpu-offset: For SMP, the per-cpu offset to the local timer
> >> > +  programming memory range.
> >> > +
> >> > +
> >> > +Example:
> >> > +
> >> > +timer@200 {
> >> > +   compatible = "jcore,pit";
> >> > +   reg = < 0x200 0x30 >;
> >> > +   cpu-offset = < 0x300 >;
> >>
> >> This is outside the reg range. Perhaps reg should include each range of
> >> per cpu registers.
> >
> > In the hardware, each timer instance is mapped independently so
> > there's no fundamental reason they need to be mapped sufficiently
> > close that it would make sense for a single virtual mapping to cover
> > them all. This doesn't matter for nommu but it would with mmu in the
> > future. In the driver I've updated it to ioremap each percpu instance
> > separately (as its own memory range) using the cpu-offset applied to
> > the range obtained from "reg". Is this acceptable (in which case I
> > suppose the binding needs to be documented that "reg" just covers the
> > cpu0 instance's range)? Do you think it would be preferable to have
> > multiple "reg" ranges indexed by cpu instead of cpu-offset?
> 
> Yes. Either reg should cover the full range of addresses or you should
> have multiple reg values with one for each cpu. I prefer the latter as
> it doesn't create a custom property for expressing register addresses.

OK, let's lean towards going with the latter then. It's more flexible
and allows any placement of the maps; the offset per cpu does not have
to be constant. It also makes the driver code simpler since of_iomap
can be used directly rather than requiring of_address_to_resource,
physical address arithmetic arithmetic, and ioremap on the results. Is
there any precedent for using multiple reg ranges for percpu register
instances like this? Anything else they've been used for?

> > In theory it would even be possible to just require a DT node per
> > cpulocal timer, but I didn't see a good way to make the bindings
> > represent the relationship to cpus or to make the driver handle irqs
> > correctly for such a setup, so I'd need a viable proposal for how that
> > could be done to even consider such an approach.
> 
> Yeah, there's not really a standard way to map per cpu blocks to cpus.
> We could, but doesn't really seem necessary here.
> 
> For the irqs, percpu irqs doesn't help you?

What I mean is that, if there were a separate device node and driver
instance per cpu, they'd all want to register the same irq just to
handle it on their own cpu, so we'd have a lot of spurious handlers
running. The right way to model this, I think, would be as a virtual
irqchip that's the irq parent of all the timer nodes, and that
multiplexes the real irq to one virq per cpu (where the current cpu id
becomes the irq number in its irq domain). But that's a lot of virtual
infrastructure just for the sake of modelling each percpu timer as its
own DT node and I don't think it makes sense to do it that way.

Rich
