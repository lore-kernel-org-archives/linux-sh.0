From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 08:41:39 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
Message-Id: <Pine.LNX.4.64.1307051039330.28169@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 5 Jul 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:

[snip]

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
> > +       sdhi2: sdhi@ee140000 {
> > +               compatible = "renesas,r8a7740-sdhi";
> > +               reg = <0 0xee140000 0 0x100>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 167 4>;
> > +               cap-sd-highspeed;
> > +               status = "disabled";
> > +       };
> 
> And now we're here again using "r8a7740" for SDHI on r8a73a4.

Would this be ok:

		compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";

Thanks
Guennadi

> I don't think you have full documentation for the SDHI block, do you?
> So please don't assume it is compatible with r8a7740 just because it
> happens to work for you.

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
