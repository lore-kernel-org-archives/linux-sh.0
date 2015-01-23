From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 23 Jan 2015 00:49:11 +0000
Subject: Re: [PATCH 03/11] ARM: shmobile: r8a7778: Common clock framework DT description
Message-Id: <874mrigw1t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert, Ulrich,

> > --- a/arch/arm/boot/dts/r8a7778.dtsi
> > +++ b/arch/arm/boot/dts/r8a7778.dtsi
> 
> > +               mstp0_clks: mstp0_clks@ffc80030 {
> > +                       compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> > +                       reg = <0xffc80030 4>;
(snip)
> > +                       >;
> > +                       clock-output-names > > +                               "i2c0", "i2c1", "i2c2", "i2c3", "scif0",
> > +                               "scif1", "scif2", "scif3", "scif4", "scif5",
> > +                               "tmu0", "tmu1", "tmu2", "ssi0", "ssi1",
> > +                               "ssi2", "ssi3", "sru", "hspi";
> 
> On r8a7790, we use "ssi%u", on r8a7791, we use "ssi.%u"?
(snip)
> > +                       clock-output-names > > +                               "scu0", "scu1", "scu2", "scu3", "scu4",
> > +                               "scu5", "scu6", "scu7", "scu8";
> 
> On r8a7790, we use "scu-src%u", on r8a7791, we use "src.%u"?
> 
> Shall we use "sru-src%u" or "src.%u" here?

I guess
 mstp  node is using "ssi%u"  / "scu-src%u"
 sound node is using "ssi.%u" / "src.%u"



Best regards
---
Kuninori Morimoto
