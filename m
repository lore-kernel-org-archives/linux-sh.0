From: Rich Felker <dalias@libc.org>
Date: Wed, 01 Jun 2016 21:53:49 +0000
Subject: Re: [PATCH v3 04/12] of: add J-Core timer bindings
Message-Id: <20160601215349.GD10893@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <5341dfbb085d5647ebb6fe4390ca329b63e0e03d.1464148904.git.dalias@libc.org>
 <20160601135852.GA17217@rob-hp-laptop>
 <20160601175307.GC10893@brightrain.aerifal.cx>
In-Reply-To: <20160601175307.GC10893@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Wed, Jun 01, 2016 at 01:53:07PM -0400, Rich Felker wrote:
> On Wed, Jun 01, 2016 at 08:58:52AM -0500, Rob Herring wrote:
> > On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> > > Signed-off-by: Rich Felker <dalias@libc.org>
> > > ---
> > >  .../devicetree/bindings/timer/jcore,pit.txt        | 28 ++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/timer/jcore,pit.txt b/Documentation/devicetree/bindings/timer/jcore,pit.txt
> > > new file mode 100644
> > > index 0000000..96c6815
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/timer/jcore,pit.txt
> > > @@ -0,0 +1,28 @@
> > > +J-Core Programmable Interval Timer and Clocksource
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: Must be "jcore,pit".
> > > +
> > > +- reg: Memory region for timer/clocksource registers.
> > > +
> > > +- interrupts: An interrupt to assign for the timer. The actual pit
> > > +  core is integrated with the aic and allows the timer interrupt
> > > +  assignment to be programmed by software, but this property is
> > > +  required in order to reserve an interrupt number that doesn't
> > > +  conflict with other devices.
> > > +
> > > +Optional properties:
> > > +
> > > +- cpu-offset: For SMP, the per-cpu offset to the local timer
> > > +  programming memory range.
> > > +
> > > +
> > > +Example:
> > > +
> > > +timer@200 {
> > > +	compatible = "jcore,pit";
> > > +	reg = < 0x200 0x30 >;
> > > +	cpu-offset = < 0x300 >;
> > 
> > This is outside the reg range. Perhaps reg should include each range of 
> > per cpu registers.
> 
> In the hardware, each timer instance is mapped independently so
> there's no fundamental reason they need to be mapped sufficiently
> close that it would make sense for a single virtual mapping to cover
> them all. This doesn't matter for nommu but it would with mmu in the
> future. In the driver I've updated it to ioremap each percpu instance
> separately (as its own memory range) using the cpu-offset applied to
> the range obtained from "reg". Is this acceptable (in which case I
> suppose the binding needs to be documented that "reg" just covers the
> cpu0 instance's range)? Do you think it would be preferable to have
> multiple "reg" ranges indexed by cpu instead of cpu-offset?
> 
> In theory it would even be possible to just require a DT node per
> cpulocal timer, but I didn't see a good way to make the bindings
> represent the relationship to cpus or to make the driver handle irqs
> correctly for such a setup, so I'd need a viable proposal for how that
> could be done to even consider such an approach.

As a bit more background: the current mappings at 0xabcd0200 and
0xabcd0500 seem to have been chosen to maintain address-level
compatibility with existing non-smp builds (0xabcd0200) while avoiding
stepping on unrelated nearby mmio ranges -- uarts 1 and 2 were at
0xabcd0300 and 0xabcd0400 on systems with multiple uarts. Eventually
these can all be moved arbitrarily and put in a more logical
arrangement once everything is using device tree, but for the time
being, compatibility with non-DT kernels is still needed.

Rich
