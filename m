From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 17 Oct 2013 16:41:40 +0000
Subject: Re: [PATCH v2 2/2] sh_eth: add device tree support
Message-Id: <20131017164140.GL24056@e106331-lin.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070343.25640.sergei.shtylyov@cogentembedded.com>
 <522E3770.9020305@wwwdotorg.org>
 <522F2F3A.5070406@cogentembedded.com>
 <522F37A7.90804@wwwdotorg.org>
 <522F5E67.8070006@cogentembedded.com>
 <522F7BF1.80100@wwwdotorg.org>
 <522F93A5.6010709@cogentembedded.com>
 <522F9B65.1020606@wwwdotorg.org>
 <525F1637.3040709@cogentembedded.com>
In-Reply-To: <525F1637.3040709@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Magnus Damm <magnus.damm@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "nobuhiro.iwamatsu.yj@renesas.com" <nobuhiro.iwamatsu.yj@renesas.com>, "rob@landley.net" <rob@landley.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On Wed, Oct 16, 2013 at 11:41:59PM +0100, Sergei Shtylyov wrote:
> Hello.

Hello,

> 
> On 09/11/2013 02:21 AM, Stephen Warren wrote:
> 
> >>>>>>> Do you need any clocks properties, IP block reset signals, power
> >>>>>>> domains?
> 
> >>>>>>       Currently not.
> 
> >>>>> What does "currently" mean? Does that mean that the Linux driver simply
> >>>>> doesn't touch those entities at present?
> 
> >>>>      There's Ether clock but the driver doesn't manipulate it directly,
> >>>> assumingly it does this thru the runtime PM interface. As for the
> >>>> others, I simply don't know.
> 
> >>> If there's a clock, it should be represented in DT, even if the kernel
> >>> somehow gets access to the clock through some means other than parsing
> >>> DT.
> 
> >>     Frankly speaking, I don't see the point.
> 
> > To be honest, that doesn't exactly make me care about reviewing the
> > binding then.
> 
>     Well, that would seem to make my task easier unless you mean that you'd 
> just NAK my further attempts of pushing this patch. :-)
>     It seems somewhat unfair to require clock DT support for the Ethernet 
> driver (which doesn't even use clocks directly), while R-Car I2C driver DT 
> support has been queued successfully at the same time (this driver uses clock 
> API directly).

To me it seems entirely fair that to support a device we require support
for the devices it depends upon.

The fact that the R-Car I2C driver doesn't acquire its clocks from DT is
a deficiency of the R-Car I2C binding and driver that should be fixed.
It does not excuse making the same mistake again.

We know now that we will have to describe the clocks at some point in
the future. Taking a shortcut now by relying on the board files to
provide the clocks or assuming they're handled elsewhere, and not
providing a way to provide them via the DT is lazy and actively harmful.

We _will_ have to change this in future, we know exactly how we will
have to change it, and we know that said changes will break previously
working DTBs. People _will_ complain when their board no longer
functions, and if we're serious about not having functional regressions,
we cannot remove all the ad-hoc support code that allows the incomplete
device trees to boot a useful kernel.

The current approach for converting platforms to device tree is a train
wreck, and the practice of relying on board files during the conversion
is fundamentally flawed. It allows us to take shortcuts today that we
know will cause pain for everyone further down the line, rather than
ensuring everything is working and stable from the outset.

We've admittedly been inconsistent in the review of bindings. That is a
procedural failing that we need to sort out, but that's orthogonal to
the issue at hand.

> 
> >>>>> If so, that's not enough to say
> >>>>> that those entities should not be described in the DT binding. We
> >>>>> should
> >>>>> strive to make the binding completely describe all aspects of the HW,
> >>>>> irrespective of whether a particular driver happens to use that
> >>>>> information at present.
> 
> >>>> There's no DT representation for the clocks in SH-Mobile subarch yet.
> >>>> The same applies to the other entities you mentioned.
> 
> >>> You can still write the binding to say that the appropriate clock
> >>> property must be present; the overall format of this property won't be
> >>> affected by the representation chosen for the SH-Mobile clocks.
> 
> >>     Where can I find an example of such property, independent of the
> >> parent clock node? All I could find with quick search refers with a
> >> phandle to a clock node (we don't have now).
> 
> > All clock property definitions are independent of the source of the clock.
> 
> > Now the actual value you put in the DT file is dependent on which source
> > it's describing.
> 
>     AFAIU, we'd need the "root" clock node still to which the clock properties 
> would refer via phandle.

The binding for the device is independent from the source.The binding
can say:

- clocks: A list of clock-specifiers. Should contain a clock-specifier
          for each entry in clock-names
- clock-names: A list of strings. Should contain (in any order):
    * "apb_pclk" for the clock driving the AMBA interface (optional)
    * "refclk" for the reference clock
    * "syncclk" for the synchronisation clock, if wired up (optional)

The implementation of the clock sources has no bearing on the consumer.

The driver can do its best to try to make something work with the clocks
it is given. Some clocks may be necessary because we really need to know
their rate to do anything useful with the hardware. Some we might be
able to ignore if not present (e.g. we just assume they're always on).
Some we might not need now (maybe we don't use a portion of a device),
but might use in future.

You must have some reference manual for the hardware, so you should know
the set of clock inputs the hardware has. If you know that, you can add
the clock inputs to the binding.

> 
> >>> It seems like it'd be best to get the basic resources (like clocks)
> >>> represented in DT before trying to build blocks that use them.
> 
> >>     We don't use them directly. And we need the Ether device tree support *now*,
> >> while clock-related work will probably take months (there are plans to switch Sh-Mobile to CCF in like 6 months).
> 
> > What/who is "we".
> 
>     Our customer Renesas, and therefore we, Cogent Embedded. Note that clock 
> DT support is not the part of our tasks.

There are plenty of businesses involved in Linux development. Note that
their commercial interests do not justify the addition of infrastructure
with known problems. Note that maintaining DT support is part of my
tasks.

> 
> > If it's just a matter of the driver-vs-runtime-pm
> > code, then it's not relevant.
> 
> > I don't think needing something now is a good excuse.
> 
>     Hm, perhaps we still can do things in the planned order? Magnus, could you 
> clarify again what are the plans on clock DT support for the R8A777x/R8A779x SoCs?
>     I'm still hoping we can deal with the Ethernet DT support first and then 
> we'd add the clock property to the binding when it would become availble.

I would hope that in future we build DT support without crutches. If $X
depends on $Y, get $Y working, then get $X working.

Thanks,
Mark.
