From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 10:00:26 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: r8a7790: add MMCIF and SDHI DT templates
Message-Id: <Pine.LNX.4.64.1307051145360.29855@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970334-21485-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970334-21485-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 5 Jul 2013, Magnus Damm wrote:

> On Fri, Jul 5, 2013 at 6:01 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Fri, 5 Jul 2013, Magnus Damm wrote:
> >
> >> Hi Guennadi,
> >>
> >> On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
> >> <g.liakhovetski@gmx.de> wrote:
> >> > This adds DT templates for all MMCIF and SDHI controllers on r8a7790.
> >> > They are added with status="disabled". To use them platform-specific
> >> > DTs have to enable the required ones.
> >> >
> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >> > ---
> >> >  arch/arm/boot/dts/r8a7790.dtsi |   56 ++++++++++++++++++++++++++++++++++++++++
> >> >  1 files changed, 56 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> >> > index 339d9b1..18d818f 100644
> >> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> >> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> >> > @@ -54,4 +54,60 @@
> >> >                 interrupt-parent = <&gic>;
> >> >                 interrupts = <0 0 4>, <0 1 4>, <0 2 4>, <0 3 4>;
> >> >         };
> >> > +
> >> > +       /* No MMC_CAP_UHS_DDR50 (dual data rate) capability on r8a7790! */
> >> > +       mmcif0: mmcif@ee200000 {
> >> > +               compatible = "renesas,sh-mmcif";
> >> > +               reg = <0 0xee200000 0 0x100>;
> >> > +               interrupt-parent = <&gic>;
> >> > +               interrupts = <0 169 0x4>;
> >> > +               reg-io-width = <4>;
> >> > +               status = "disabled";
> >> > +       };
> >>
> >> Can please you tell me which kernel configuration i need to enable to
> >> make the comment above affect the MMCIF driver so DDR50 support is
> >> disabled?
> >
> > The above comment means, that r8a7790 platforms shouldn't set
> > MMC_CAP_UHS_DDR50 capability for MMCIF interfaces. In the platform data
> > this would be done by oring it to struct sh_mmcif_plat_data::caps.
> > Currently there is no way to set this capability in DT, so, that comment
> > doesn't have any effect here. But this possibility will most likely be
> > added to DT at some point. So, this comment is here as a reminder. But we
> > can remove it too, if you prefer.
> 
> If I understand you correctly then in case of DT this capability isn't
> available at this time.

Yes, you understand correctly.

> Obviously we need to add support for these features also in the case
> of DT. We would not want to have the DT case to be left
> half-implemented. If we would leave it half implemented then we could
> never move from C to DT for board support.

Sure, step by step in the order of priorities.

> What is your proposed plan forward to implement this DT capability? Or
> are patches queued up already?

I do quite a bit of development in the MMC area, but I don't have access 
to full MMC/SD standards, so, I'm not sure what that specific feature 
does. I heard opinions about those similar features being redundant and 
deducible from other interface parameters like clock rate etc. So, I can 
certainly propose a patch that simply sets that (and other) capability, 
when a certain property is found, but I think it'd be better if someone 
with a complete information would do that. I could throw in an RFC and see 
reaction and ask for advise, of course. But without information such an 
attempt would probably require a few rounds and thus would take some time.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
