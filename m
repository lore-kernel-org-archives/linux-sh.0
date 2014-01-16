From: Simon Horman <horms@verge.net.au>
Date: Thu, 16 Jan 2014 00:07:20 +0000
Subject: Re: [PATCH 1/2] ARM: dts: r8a7790: Add SATA nodes to r8a7790.dtsi
Message-Id: <20140116000717.GA12550@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 16, 2014 at 12:42:23AM +0400, Valentine wrote:
> On 01/15/2014 04:02 AM, Simon Horman wrote:
> >On Tue, Jan 14, 2014 at 10:04:12PM +0400, Valentine wrote:
> >>On 01/14/2014 09:23 PM, Laurent Pinchart wrote:
> >>>Hi Valentine,
> 
> Hi Simon, Laurent,
> 
> >>>
> >>>Thank you for the patch.
> >>>
> >>>On Tuesday 14 January 2014 21:05:30 Valentine Barshak wrote:
> >>>>This adds SATA[01] device nodes to r8a7790.dtsi
> >>>>
> >>>>Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>>>---
> >>>>  arch/arm/boot/dts/r8a7790.dtsi | 18 ++++++++++++++++++
> >>>>  1 file changed, 18 insertions(+)
> >>>>
> >>>>diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> >>>>index b2c2845..f2f5394 100644
> >>>>--- a/arch/arm/boot/dts/r8a7790.dtsi
> >>>>+++ b/arch/arm/boot/dts/r8a7790.dtsi
> >>>>@@ -400,6 +400,24 @@
> >>>>  		status = "disabled";
> >>>>  	};
> >>>>
> >>>>+	sata0: sata@ee300000 {
> >>>>+		compatible = "renesas,sata-r8a7790";
> >>>>+		reg = <0 0xee300000 0 0x2000>;
> >>>>+		interrupt-parent = <&gic>;
> >>>>+		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
> >>>>+		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
> >>>
> >>>If I'm not mistaken the RCar SATA DT bindings don't document the clocks
> >>>property.
> >>
> >>Yes, they don't, cause at that time the clocks were not supported.
> >>
> >>>Could you please submit a patch to fix that ?
> >>
> >>I could, but the patch that adds the description is still available only
> >>in the for-3.14 branch of the libata repo.
> >
> >I think you could provide a patch to update the bindings (documentation),
> >which is not part of this series, which applies to that branch.
> 
> Okay.
> 
> >
> >And once that has been acked or merged then this series could
> >be taken in parallel.
> >
> >>The other thing is that the clocks are not yet included in the r8a7779.dtsi,
> >>a snippet from which is used as an example of SATA bindings.
> >
> >So the bindings (documentation) includes an example which is not present in
> >r8a7779.dtsi?  That sounds sane to me as there is no question
> >of a run-time dependency being a problem.
> 
> The documentation includes an example of the R8A7779 SATA binding
> cause it was the only SoC supporting the SATA at that time.
> 
> The problem is that the DT clock bindings are not supported on R8A7779.
> So we should either wait for them to become supported on R8A7779 or
> we may want to change the example to one of the Gen2 variants.

I think that changing the example to use a Gen2 variant with clocks
sounds like a good plan.

> >But where is the patch to add the clocks to r8a7779.dtsi?
> 
> Probably, has not been done yet. I guess, there's no DT clock support on r8a7779 yet.
> 
> Laurent, do you have any patches for r8a7779?
> 
> >Is it "ARM: shmobile: r8a7790: Add SATA clocks to device tree" which
> >I queued up yesterday?
> 
> Nope, for the fact it adds the clocks to R8A7790, not R8A7779.

Of course! Sorry for mixing up 90 and 79.

> 
> >
> >>
> >>So we probably have to wait until both are available in 3.14.
> >>
> >>Thanks,
> >>Val.
> 
> Thanks,
> Val.
> 
> >>
> >>>
> >>>There's no need to delay this patch set.
> >>>for-3.14
> >>>>+		status = "disabled";
> >>>>+	};
> >>>>+
> >>>>+	sata1: sata@ee500000 {
> >>>>+		compatible = "renesas,sata-r8a7790";
> >>>>+		reg = <0 0xee500000 0 0x2000>;
> >>>>+		interrupt-parent = <&gic>;
> >>>>+		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
> >>>>+		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
> >>>>+		status = "disabled";
> >>>>+	};
> >>>>+
> >>>>  	clocks {
> >>>>  		#address-cells = <2>;
> >>>>  		#size-cells = <2>;
> >>
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
