From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 16 Jun 2014 14:24:23 +0000
Subject: Re: [PATCH v3 10/19] clocksource: sh_tmu: Add DT support
Message-Id: <1555850.ye4YtlhbQA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1402763021-4067-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140616084832.GG11582@verge.net.au>
In-Reply-To: <20140616084832.GG11582@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Monday 16 June 2014 17:48:32 Simon Horman wrote:
> On Sat, Jun 14, 2014 at 06:23:32PM +0200, Laurent Pinchart wrote:
> > Document DT bindings and parse them in the TMU driver.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../devicetree/bindings/timer/renesas,tmu.txt      | 40 +++++++++++++++++
> >  drivers/clocksource/sh_tmu.c                       | 45 +++++++++++++----
> >  2 files changed, 77 insertions(+), 8 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/timer/renesas,tmu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> > b/Documentation/devicetree/bindings/timer/renesas,tmu.txt new file mode
> > 100644
> > index 0000000..2392e89
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> > @@ -0,0 +1,40 @@
> > +* Renesas R-Car Timer Unit (TMU)
> > +
> > +The TMU is a 32-bit timer/counter with configurable clock inputs and
> > +programmable compare match.
> > +
> > +Channels share hardware resources but their counter and compare match
> > value
> > +are independent. The TMU hardware supports up to three channels.
> > +
> > +Required Properties:
> > +
> > +  - compatible: must contain "renesas,tmu"
> > +
> > +  - reg: base address and length of the registers block for the timer
> > module.
> > +
> > +  - interrupts: interrupt-specifier for the timer, one per channel.
> > +
> > +  - clocks: a list of phandle + clock-specifier pairs, one for each entry
> > +    in clock-names.
> > +  - clock-names: must contain "fck" for the functional clock.
> > +
> > +Optional Properties:
> > +
> > +  - #renesas,channels: number of channels implemented by the timer, must
> > be 2
> > +    or 3 (if not specified the value defaults to 3).
> > +
> > +
> > +Example: R8A7779 (R-Car H1) TMU0 node
> > +
> > +	tmu0: timer@ffd80000 {
> > +		compatible = "renesas,tmu";
> > +		reg = <0xffd80000 0x30>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
> > +		clock-names = "fck";
> > +
> > +		#renesas,channels = <3>;
> > +	};
> 
> As per my feedback for "[PATCH v3 14/19] ARM: shmobile: r8a7779: Add TMU
> devices to DT" I believe the IRQ values should be 32, 33 and 34, not 40,
> 41, 42. I realise this is just an example but I feel that I should mention
> it.

Sure, I'll fix that, and remove the interrupt-parent property.

-- 
Regards,

Laurent Pinchart

