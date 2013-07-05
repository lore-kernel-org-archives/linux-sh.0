From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 09:01:10 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: r8a7790: add MMCIF and SDHI DT templates
Message-Id: <Pine.LNX.4.64.1307051057200.28169@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970334-21485-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970334-21485-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 5 Jul 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > This adds DT templates for all MMCIF and SDHI controllers on r8a7790.
> > They are added with status="disabled". To use them platform-specific
> > DTs have to enable the required ones.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >  arch/arm/boot/dts/r8a7790.dtsi |   56 ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 56 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> > index 339d9b1..18d818f 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -54,4 +54,60 @@
> >                 interrupt-parent = <&gic>;
> >                 interrupts = <0 0 4>, <0 1 4>, <0 2 4>, <0 3 4>;
> >         };
> > +
> > +       /* No MMC_CAP_UHS_DDR50 (dual data rate) capability on r8a7790! */
> > +       mmcif0: mmcif@ee200000 {
> > +               compatible = "renesas,sh-mmcif";
> > +               reg = <0 0xee200000 0 0x100>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 169 0x4>;
> > +               reg-io-width = <4>;
> > +               status = "disabled";
> > +       };
> 
> Can please you tell me which kernel configuration i need to enable to
> make the comment above affect the MMCIF driver so DDR50 support is
> disabled?

The above comment means, that r8a7790 platforms shouldn't set 
MMC_CAP_UHS_DDR50 capability for MMCIF interfaces. In the platform data 
this would be done by oring it to struct sh_mmcif_plat_data::caps. 
Currently there is no way to set this capability in DT, so, that comment 
doesn't have any effect here. But this possibility will most likely be 
added to DT at some point. So, this comment is here as a reminder. But we 
can remove it too, if you prefer.

Thanks
Guennadi

> 
> > +       mmcif1: mmcif@ee220000 {
> > +               compatible = "renesas,sh-mmcif";
> > +               reg = <0 0xee220000 0 0x100>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 170 0x4>;
> > +               reg-io-width = <4>;
> > +               status = "disabled";
> > +       };
> 
> The I/O mem resource size of MMCIF0 and MMCIF1 seems wrong here too.
> 
> > +       sdhi0: sdhi@ee100000 {
> > +               compatible = "renesas,r8a7740-sdhi";
> > +               reg = <0 0xee100000 0 0x100>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 165 4>;
> > +               cap-sd-highspeed;
> > +               status = "disabled";
> > +       };
> > +
> > +       sdhi1: sdhi@ee120000 {
> > +               compatible = "renesas,r8a7740-sdhi";
> > +               reg = <0 0xee120000 0 0x100>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 166 4>;
> > +               cap-sd-highspeed;
> > +               status = "disabled";
> > +       };
> > +
> > +       /* What are SDHI2 C2 and SDHI3 C2 controllers? */
> 
> 42?
> 
> I think you can drop this comment.
> 
> > +       sdhi2: sdhi@ee140000 {
> > +               compatible = "renesas,r8a7740-sdhi";
> > +               reg = <0 0xee140000 0 0x100>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 167 4>;
> > +               cap-sd-highspeed;
> > +               status = "disabled";
> > +       };
> > +
> > +       sdhi3: sdhi@ee160000 {
> > +               compatible = "renesas,r8a7740-sdhi";
> > +               reg = <0 0xee160000 0 0x100>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 168 4>;
> > +               cap-sd-highspeed;
> > +               status = "disabled";
> > +       };
> 
> Same thing as r8a73a4 here wrt to r8a7740.
> 
> Thanks,
> 
> / magnus
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
