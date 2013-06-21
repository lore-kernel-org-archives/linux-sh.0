From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 21 Jun 2013 08:11:56 +0000
Subject: Re: [PATCH 7/9] ARM: shmobile: APE6EVM: add MMCIF and SDHI DT nodes
Message-Id: <31904796.gG5nkGRezn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi and Magnus,

On Friday 21 June 2013 09:48:43 Guennadi Liakhovetski wrote:
> On Fri, 21 Jun 2013, Magnus Damm wrote:
> > On Fri, Jun 21, 2013 at 3:33 PM, Guennadi Liakhovetski wrote:
> > > On Fri, 21 Jun 2013, Magnus Damm wrote:
> > >> On Fri, Jun 21, 2013 at 6:10 AM, Guennadi Liakhovetski wrote:
> > >> > On Wed, 19 Jun 2013, Magnus Damm wrote:
> > >> >> On Fri, May 17, 2013 at 11:55 PM, Guennadi Liakhovetski wrote:
> > >> >> > This patch adds all MMCIF and SDHI devices to r8a73a4.dtsi in the
> > >> >> > "disabled" state, those of them, available on APE6EVM, are then
> > >> >> > added to the board DT. This version assignes fixed regulators to
> > >> >> > all the interfaces, in future versions support for regulators
> > >> >> > should be added.
> > >> >> > 
> > >> >> > Signed-off-by: Guennadi Liakhovetski
> > >> >> > <g.liakhovetski+renesas@gmail.com>
> > >> >> 
> > >> >> Thanks for your work on this. In general I'm happy to see your
> > >> >> 
> > >> >> progress but I wonder about the following:
> > >> >> > --- a/arch/arm/boot/dts/r8a73a4.dtsi
> > >> >> > +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> > >> >> > @@ -98,4 +98,49 @@
> > >> >> > 
> > >> >> >                 gpio-controller;
> > >> >> >                 #gpio-cells = <2>;
> > >> >> >         
> > >> >> >         };
> > >> >> > 
> > >> >> > +
> > >> >> > +       mmcif0: mmcif@ee200000 {
> > >> >> > +               compatible = "renesas,sh-mmcif";
> > >> >> > +               reg = <0 0xee200000 0 0x100>;
> > >> >> > +               interrupt-parent = <&gic>;
> > >> >> > +               interrupts = <0 169 0x4>;
> > >> >> > +               reg-io-width = <4>;
> > >> >> > +               status = "disabled";
> > >> >> > +       };
> > >> >> > +
> > >> >> > +       mmcif1: mmcif@ee220000 {
> > >> >> > +               compatible = "renesas,sh-mmcif";
> > >> >> > +               reg = <0 0xee220000 0 0x100>;
> > >> >> > +               interrupt-parent = <&gic>;
> > >> >> > +               interrupts = <0 170 0x4>;
> > >> >> > +               reg-io-width = <4>;
> > >> >> > +               status = "disabled";
> > >> >> > +       };
> > >> >> > +
> > >> >> > +       sdhi0: sdhi@ee100000 {
> > >> >> > +               compatible = "renesas,r8a7740-sdhi";
> > >> >> > +               reg = <0 0xee100000 0 0x100>;
> > >> >> > +               interrupt-parent = <&gic>;
> > >> >> > +               interrupts = <0 165 4>;
> > >> >> > +               cap-sd-highspeed;
> > >> >> > +               status = "disabled";
> > >> >> > +       };
> > >> >> 
> > >> >> Here you use the "r8a7740-sdhi" compatible string on the r8a73a4
> > >> >> SoC. Sorry to say this but to me this seems like the first steps
> > >> >> toward a future binary compatibility mess.
> > >> >> 
> > >> >> Others seem to handle this differently. For instance, in
> > >> >> drivers/mmc/host/omap_hsmmc.c there are separate compatible strings
> > >> >> for omap2 and omap3.
> > >> >> 
> > >> >> As I stated before, I prefer to see using a compatible string based
> > >> >> on the version of the IP block, or if we have to use the SoC name
> > >> >> then use the name of the actual SoC used.
> > >> >> 
> > >> >> What is the common way to deal with the compatible strings? Just use
> > >> >> an existing one if it happens to match? Seems a lot like copy-paste
> > >> >> integration to me with the added benefit of forever binary
> > >> >> compatibility.
> > >> >> 
> > >> >> Perhaps we have agreed on something already? Care to remind me? =)
> > >> > 
> > >> > Indeed this has been discussed extensively:
> > >> > 
> > >> > http://thread.gmane.org/gmane.linux.kernel.mmc/19136/focus248
> > >> 
> > >> Yes, I know that, but did we also come to a conclusion how to handle
> > >> the compatible string in case we have several SoCs that happen to have
> > >> similar compatible hardware block versions?
> > >> 
> > >> It seems that the SDHI driver has one compatible string for sh7372,
> > >> and when we remove sh7372 SoC support in the future it will be easy to
> > >> remove that too. But how about r8a7740? If we have multiple different
> > >> SoCs that use same SoC compatible string (r8a7740 in this case) then
> > >> how can we age out these strings?
> > >> 
> > >> My take on this that if you use the SoC name for the compatible string
> > >> then you should also keep on updating the driver with this information
> > >> so the DTS for the SoC can use the correct SoC name.
> > > 
> > > A quote from the above link:
> > > 
> > > "the next best solution would be naming it
> > > after the chip that first used a particular version of that IP block,
> > > like "renesas,shmobile1234-sdhi". The device tree include file for
> > > shmobile5678 should then list the sdhi part as being compatible with
> > > the "reneasas,shmobile1234-sdhi" if they are the same, or as
> > > a separate "reneasas,shmobile5678-sdhi" if they behave in a different
> > > way."
> > 
> > Thanks for the quote. I can now see clearly about shmoble5678 and
> > shmobile1234.
> > 
> > I hate to be difficult, but I disagree. =)
> > 
> > Perhaps my logic is flawed, but if I understand the above then we are
> > supposed to put DTS device nodes with compatible strings based on
> > current driver behaviour?
> > 
> > I see one problem with that. Say that a certain new hardware feature
> > is included in one SoC, but the driver does not yet implement it. And
> > perhaps the driver developer does not understand the difference fully
> > when the device node is added to the DTS. Then won't we end up in a
> > situation where people may roll out DTBs in products and that would
> > not allow us to enable the feature later in the driver with a software
> > update? Now, if we always used shmobile5678 for shmobile5678 then we
> > would never have any problems.
> 
> My preference still lies with specific per-feature driver bindings like in
> my original implementation. Adding compatible strings to every driver for
> every new SoC seems an absolute no-go to me.

Isn't it an existing practice used by many DT bindings in the upstream kernel 
?

> But with per-feature driver bindings you would have exactly the same
> problem: if you later add support for a new feature to the driver, and that
> feature is present on older SoCs, the only way to enable it would be to
> replace the DT.
>
> > Of course, I prefer to use a version number for the hardware IP block
> > instead of the SoC.

Let's start with the obvious. Could we get those version numbers ?

> > This since this is not a SoC property.

Probably not directly applicable to the MMCIF and SDHI, when it comes to how 
IP are integrated in an SoC some of the IP-specific properties are actually 
SoC-specific. For instance on R9A7790 the Video Signal Processor can output 
directly to the Display Unit, the way this is configured on both IP cores 
depend not only on the IP version, but is specific to the R8A7790. I will thus 
use SoC-specific compatible strings for those drivers.

> > But if we now must be using SoC compatible strings then I think we should
> > do it in a sane way that would reduce or risk of shooting ourself it the
> > foot.
> > 
> > As I pointed out earlier, the MMC drivers from other vendors seem to
> > use compatible strings with names per-SoC or per-SoC-family. This even
> > though they don't seem to handle any difference from a software
> > perspective.
> > 
> > So it seems to me that exactly how to handle this varies from place to
> > place.

-- 
Regards,

Laurent Pinchart

