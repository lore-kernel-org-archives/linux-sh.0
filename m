From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 05 Feb 2015 14:47:20 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <3123706.0uzRSh2T1u@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Thursday 05 February 2015 15:35:29 Sergei Shtylyov wrote:
> On 2/5/2015 3:17 PM, Laurent Pinchart wrote:
> >>>>>> Enable the ethernet controller for the Alt board. Pin muxing entries
> >>>>>> are currently left out as r8a7794 pin control support isn't available
> >>>>>> yet. We thus rely on the boot loader to configure ethernet pins for
> >>>>>> now.
> >>>>>> 
> >>>>>> Signed-off-by: Laurent Pinchart
> >>>>>> <laurent.pinchart+renesas@ideasonboard.com>
> >>>>>> ---
> >>>>>> 
> >>>>>>     arch/arm/boot/dts/r8a7794-alt.dts | 13 +++++++++++++
> >>>>>>     1 file changed, 13 insertions(+)
> >>>>>> 
> >>>>>> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts
> >>>>>> b/arch/arm/boot/dts/r8a7794-alt.dts index 0d848e605071..25bf434433b1
> >>>>>> 100644
> >>>>>> --- a/arch/arm/boot/dts/r8a7794-alt.dts
> >>>>>> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
> >>>>>> @@ -43,6 +43,19 @@
> >>>>>> 
> >>>>>>         status = "okay";
> >>>>>>     
> >>>>>>     };
> >>>>>> 
> >>>>>> +&ether {
> >>>>>> +    phy-handle = <&phy1>;
> >>>>>> +    renesas,ether-link-active-low;
> >>>>>> +    status = "okay";
> >>>>>> +
> >>>>>> +    phy1: ethernet-phy@1 {
> >>>>>> +        reg = <1>;
> >>>>>> +        interrupt-parent = <&irqc0>;
> >>>>>> +        interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> >>>>> 
> >>>>> The hardware manual tells me the PHY uses IRQ8#, not IRQ0#.
> >>>> 
> >>>> I don't have the complete Alt schematics.
> >>> 
> >>> I don't have *any* Alt schematics, only SILK.
> >> 
> >> And SILK also has the PHY IRQ connected to IRQ8#.
> >> 
> >>>> I've double-checked the block
> >>>> diagram and it mentions "GP1_24(IRQ)"
> >>> 
> >>> GP1_24 is connected to the PHY's RST# pin, according to the hardware
> >>> manual. Which seems bad to me -- we hardly needed such kind of reset
> >>> with the device tree. :-/ Hopefully, U-Boot leaves it high...
> >>> 
> >>>> next to the PHY. This patch is thus
> >>>> incorrect, but where did you find a mention of IRQ8 ?
> >>> 
> >>> In the Alt hardware manual, rev. 0.04. :-)
> >> 
> >> Mentioned in several places there.
> >> 
> >> Probably it makes sense to compare the dates of our documents. The
> >> aforementioned manual is dated June 4, 2014.
> > 
> > The block diagram I have mentions "Rev0.04 Nov 22, 2013", as well as
> > "PRELIMINARY". Let's use IRQ8 then. IRQ0 is clearly wrong anyway, and we
> > can always fix this later if the hardware manual is wrong.
> 
> Note that the PHY IRQ can be verified by looking at /proc/interrupts. If
> you e.g. use NFS root with the Ethernet cable already inserted, there
> should be exactly one interrupt registered, corresponding to the link-up
> event. I have verified IRQ8# on SILK this way.

I was planning to try that. I only have remote access to the board, requiring 
a better internet connection than the flaky 3G I have right now. I should be 
able to perform tests in the next couple of days.

-- 
Regards,

Laurent Pinchart

