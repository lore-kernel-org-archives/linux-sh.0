From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Jul 2013 07:06:17 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
Message-Id: <Pine.LNX.4.64.1307080833390.19819@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Mon, 8 Jul 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Fri, Jul 5, 2013 at 5:41 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Fri, 5 Jul 2013, Magnus Damm wrote:
> >
> >> Hi Guennadi,
> >>
> >> On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
> >> <g.liakhovetski@gmx.de> wrote:
> >
> > [snip]
> >
> >> > +       sdhi0: sdhi@ee100000 {
> >> > +               compatible = "renesas,r8a7740-sdhi";
> >> > +               reg = <0 0xee100000 0 0x100>;
> >> > +               interrupt-parent = <&gic>;
> >> > +               interrupts = <0 165 4>;
> >> > +               cap-sd-highspeed;
> >> > +               status = "disabled";
> >> > +       };
> >> > +
> >> > +       sdhi1: sdhi@ee120000 {
> >> > +               compatible = "renesas,r8a7740-sdhi";
> >> > +               reg = <0 0xee120000 0 0x100>;
> >> > +               interrupt-parent = <&gic>;
> >> > +               interrupts = <0 166 4>;
> >> > +               cap-sd-highspeed;
> >> > +               status = "disabled";
> >> > +       };
> >> > +
> >> > +       sdhi2: sdhi@ee140000 {
> >> > +               compatible = "renesas,r8a7740-sdhi";
> >> > +               reg = <0 0xee140000 0 0x100>;
> >> > +               interrupt-parent = <&gic>;
> >> > +               interrupts = <0 167 4>;
> >> > +               cap-sd-highspeed;
> >> > +               status = "disabled";
> >> > +       };
> >>
> >> And now we're here again using "r8a7740" for SDHI on r8a73a4.
> >
> > Would this be ok:
> >
> >                 compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";
> 
> At least it is better. Thanks.
> 
> I prefer "renesas,r8a73a4-sdhi" only, but the above is acceptable to
> me as long as we remember to add "renesas,r8a73a4-sdhi" to the SDHI
> driver that keeps old behaviour before updating "renesas,r8a7740-sdhi"
> with features that may break r8a73a4.

I don't think that would make sense. The whole purpose of adding the 
compatible string to DT was to avoid touching the driver _unless_ needed. 
I.e. unless we do know SDHI on the new SoC has a feature that we want to 
support and we know, that all DTs out there contain the required 
compatibility string, so, now we can just hook to it in the driver and all 
platforms will start using that feature magically. If you anyway want to 
add _every_ new SoC compatibility to _every_ related driver, I don't think 
using two compatibility strings would make sense.

And no, I don't think "omap2," "omap3," "omap4" strings in OMAP drivers is 
a good example - as you know, those are SoC classes, not specific SoC 
versions. Using "generation 5," "generation 6" etc., or whatever you would 
prefer to call them, might be acceptable, but I'd really prefer to avoid 
adding every SoC to every driver.

Another option would certainly be to bite the bullet and admit, that going 
the compatibility string way was a mistake and add a binding for the SDHI 
wait-idle feature and keep both in the driver. That way we add redundancy 
to the driver - at least until we decide to finally remove the 
compatibility string. But at least we can transfer all mainline platforms 
to use the binding parameter.

> Maybe we should simply add per-soc bindings to the driver to avoid
> future potential issues?

A real binding - not a compatibility string? No, don't think I like this 
either.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
