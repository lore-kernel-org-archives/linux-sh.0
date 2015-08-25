From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Aug 2015 06:58:09 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: tidyup SSI resource region
Message-Id: <87egir7t9g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oahx5c3a.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oahx5c3a.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> >> > --- a/arch/arm/boot/dts/r8a7778.dtsi
> >> > +++ b/arch/arm/boot/dts/r8a7778.dtsi
> >> > @@ -239,7 +239,7 @@
> >> >                 #sound-dai-cells = <1>;
> >> >                 compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1";
> >> >                 reg =   <0xffd90000 0x1000>,    /* SRU */
> >> > -                       <0xffd91000 0x1240>,    /* SSI */
> >> > +                       <0xffd91000 0x270>,     /* SSI */
> >>
> >> Why not 0x240?
> >
> > 0x240 can't care channel 9
> > I forgot why it used 0x1240, not 0x1270
> 
> According to my documentation, r8a7778 has channels 0-8, r8a7779 has 0-9.
> So I'd expect 0x240 on r8a7778, and 0x280 on r8a7779.
> 
> Still, 10 * 0x40 = 0x280, not 0x270.

Grr... my bad.
Thanks
