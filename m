From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 17 Jan 2014 08:07:16 +0000
Subject: Re: [PATCH 1/2] ARM: dts: r8a7790: Add SATA nodes to r8a7790.dtsi
Message-Id: <4666091.1ZoyuYu7lu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

On Thursday 16 January 2014 00:42:23 Valentine wrote:
> On 01/15/2014 04:02 AM, Simon Horman wrote:
> > On Tue, Jan 14, 2014 at 10:04:12PM +0400, Valentine wrote:
> >> On 01/14/2014 09:23 PM, Laurent Pinchart wrote:
> >>> Hi Valentine,
> 
> Hi Simon, Laurent,
> 
> >>> Thank you for the patch.
> >>> 
> >>> On Tuesday 14 January 2014 21:05:30 Valentine Barshak wrote:
> >>>> This adds SATA[01] device nodes to r8a7790.dtsi
> >>>> 
> >>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>>> ---
> >>>> 
> >>>>   arch/arm/boot/dts/r8a7790.dtsi | 18 ++++++++++++++++++
> >>>>   1 file changed, 18 insertions(+)
> >>>> 
> >>>> diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> >>>> b/arch/arm/boot/dts/r8a7790.dtsi index b2c2845..f2f5394 100644
> >>>> --- a/arch/arm/boot/dts/r8a7790.dtsi
> >>>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> >>>> @@ -400,6 +400,24 @@
> >>>>   		status = "disabled";
> >>>>   	};
> >>>> 
> >>>> +	sata0: sata@ee300000 {
> >>>> +		compatible = "renesas,sata-r8a7790";
> >>>> +		reg = <0 0xee300000 0 0x2000>;
> >>>> +		interrupt-parent = <&gic>;
> >>>> +		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
> >>>> +		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
> >>> 
> >>> If I'm not mistaken the RCar SATA DT bindings don't document the clocks
> >>> property.
> >> 
> >> Yes, they don't, cause at that time the clocks were not supported.
> >> 
> >>> Could you please submit a patch to fix that ?
> >> 
> >> I could, but the patch that adds the description is still available only
> >> in the for-3.14 branch of the libata repo.
> > 
> > I think you could provide a patch to update the bindings (documentation),
> > which is not part of this series, which applies to that branch.
> 
> Okay.
> 
> > And once that has been acked or merged then this series could
> > be taken in parallel.
> > 
> >> The other thing is that the clocks are not yet included in the
> >> r8a7779.dtsi, a snippet from which is used as an example of SATA
> >> bindings.
> > 
> > So the bindings (documentation) includes an example which is not present
> > in r8a7779.dtsi?  That sounds sane to me as there is no question
> > of a run-time dependency being a problem.
> 
> The documentation includes an example of the R8A7779 SATA binding
> cause it was the only SoC supporting the SATA at that time.
> 
> The problem is that the DT clock bindings are not supported on R8A7779.
> So we should either wait for them to become supported on R8A7779 or
> we may want to change the example to one of the Gen2 variants.
> 
> > But where is the patch to add the clocks to r8a7779.dtsi?
> 
> Probably, has not been done yet. I guess, there's no DT clock support on
> r8a7779 yet.
> 
> Laurent, do you have any patches for r8a7779?

I don't, sorry. I could work on it, but if I remember correctly CCF support 
for r8a7779 is on someone else's to-do list (I don't remember who though, 
Magnus, would you like to comment on that ?).

> > Is it "ARM: shmobile: r8a7790: Add SATA clocks to device tree" which
> > I queued up yesterday?
> 
> Nope, for the fact it adds the clocks to R8A7790, not R8A7779.
> 
> >> So we probably have to wait until both are available in 3.14.

-- 
Regards,

Laurent Pinchart

