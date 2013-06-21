From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 Jun 2013 06:33:14 +0000
Subject: Re: [PATCH 7/9] ARM: shmobile: APE6EVM: add MMCIF and SDHI DT nodes
Message-Id: <Pine.LNX.4.64.1306210831580.27277@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Fri, 21 Jun 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Fri, Jun 21, 2013 at 6:10 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Wed, 19 Jun 2013, Magnus Damm wrote:
> >
> >> Hi Guennadi,
> >>
> >> On Fri, May 17, 2013 at 11:55 PM, Guennadi Liakhovetski
> >> <g.liakhovetski@gmx.de> wrote:
> >> > This patch adds all MMCIF and SDHI devices to r8a73a4.dtsi in the "disabled"
> >> > state, those of them, available on APE6EVM, are then added to the board DT.
> >> > This version assignes fixed regulators to all the interfaces, in future
> >> > versions support for regulators should be added.
> >> >
> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >>
> >> Thanks for your work on this. In general I'm happy to see your
> >> progress but I wonder about the following:
> >>
> >> > --- a/arch/arm/boot/dts/r8a73a4.dtsi
> >> > +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> >> > @@ -98,4 +98,49 @@
> >> >                 gpio-controller;
> >> >                 #gpio-cells = <2>;
> >> >         };
> >> > +
> >> > +       mmcif0: mmcif@ee200000 {
> >> > +               compatible = "renesas,sh-mmcif";
> >> > +               reg = <0 0xee200000 0 0x100>;
> >> > +               interrupt-parent = <&gic>;
> >> > +               interrupts = <0 169 0x4>;
> >> > +               reg-io-width = <4>;
> >> > +               status = "disabled";
> >> > +       };
> >> > +
> >> > +       mmcif1: mmcif@ee220000 {
> >> > +               compatible = "renesas,sh-mmcif";
> >> > +               reg = <0 0xee220000 0 0x100>;
> >> > +               interrupt-parent = <&gic>;
> >> > +               interrupts = <0 170 0x4>;
> >> > +               reg-io-width = <4>;
> >> > +               status = "disabled";
> >> > +       };
> >> > +
> >> > +       sdhi0: sdhi@ee100000 {
> >> > +               compatible = "renesas,r8a7740-sdhi";
> >> > +               reg = <0 0xee100000 0 0x100>;
> >> > +               interrupt-parent = <&gic>;
> >> > +               interrupts = <0 165 4>;
> >> > +               cap-sd-highspeed;
> >> > +               status = "disabled";
> >> > +       };
> >>
> >> Here you use the "r8a7740-sdhi" compatible string on the r8a73a4 SoC.
> >> Sorry to say this but to me this seems like the first steps toward a
> >> future binary compatibility mess.
> >>
> >> Others seem to handle this differently. For instance, in
> >> drivers/mmc/host/omap_hsmmc.c there are separate compatible strings
> >> for omap2 and omap3.
> >>
> >> As I stated before, I prefer to see using a compatible string based on
> >> the version of the IP block, or if we have to use the SoC name then
> >> use the name of the actual SoC used.
> >>
> >> What is the common way to deal with the compatible strings? Just use
> >> an existing one if it happens to match? Seems a lot like copy-paste
> >> integration to me with the added benefit of forever binary
> >> compatibility.
> >>
> >> Perhaps we have agreed on something already? Care to remind me? =)
> >
> > Indeed this has been discussed extensively:
> >
> > http://thread.gmane.org/gmane.linux.kernel.mmc/19136/focus248
> 
> Yes, I know that, but did we also come to a conclusion how to handle
> the compatible string in case we have several SoCs that happen to have
> similar compatible hardware block versions?
> 
> It seems that the SDHI driver has one compatible string for sh7372,
> and when we remove sh7372 SoC support in the future it will be easy to
> remove that too. But how about r8a7740? If we have multiple different
> SoCs that use same SoC compatible string (r8a7740 in this case) then
> how can we age out these strings?
> 
> My take on this that if you use the SoC name for the compatible string
> then you should also keep on updating the driver with this information
> so the DTS for the SoC can use the correct SoC name.

A quote from the above link:

"the next best solution would be naming it
after the chip that first used a particular version of that IP block,
like "renesas,shmobile1234-sdhi". The device tree include file for
shmobile5678 should then list the sdhi part as being compatible with
the "reneasas,shmobile1234-sdhi" if they are the same, or as
a separate "reneasas,shmobile5678-sdhi" if they behave in a different
way."

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
