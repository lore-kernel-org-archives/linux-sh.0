From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Jun 2014 07:48:37 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7790: add MSTP10 support on DTSI
Message-Id: <87fvjdcihv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > +               mstp10_clks: mstp10_clks@e6150998 {
> > +                       compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
> > +                       reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
> > +                       clocks = <&p_clk>, /* parent of SCU */
> > +                               <&p_clk>,
> > +                               <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
> > +                               <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>;
> > +
> > +                       #clock-cells = <1>;
> > +                       clock-indices = <
> > +                               R8A7790_CLK_SCU
> > +                               R8A7790_CLK_SSI
> > +                               R8A7790_CLK_SSI9 R8A7790_CLK_SSI8 R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
> > +                               R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2 R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
> > +                               R8A7790_CLK_DVC1 R8A7790_CLK_DVC0
> > +                               R8A7790_CLK_SRC9 R8A7790_CLK_SRC8 R8A7790_CLK_SRC7 R8A7790_CLK_SRC6 R8A7790_CLK_SRC5
> > +                               R8A7790_CLK_SRC4 R8A7790_CLK_SRC3 R8A7790_CLK_SRC2 R8A7790_CLK_SRC1 R8A7790_CLK_SRC0
> 
> I think we usually put these in numerical order here.

Do you mean R8A7790_CLK_SCU is out-of-order ?
If so, Unfortunately, we need put "R8A7790_CLK_SCU" before "R8A7790_CLK_SRCx",
because SCU(ALL) is parent clock of SRCn.

> > +#define R8A7790_CLK_DVC1               18
> > +#define R8A7790_CLK_DVC0               19
> 
> "#define R8A7790_CLK_SCU_CTU1x_MIX1 20" and
> "#define R8A7790_CLK_SCU_CTU0x_MIX0 21" are missing?

Yes, CTU/MIX is not supported at this point in sound driver.
I don't know I should add it or not

> > +/* MSTP10 */
> > +#define R8A7790_CLK_SSI                        5
> 
> Should this be called R8A7790_CLK_SSI_ALL?
(snip)
> > +#define R8A7790_CLK_SCU                        17
> 
> Should this be called R8A7790_CLK_SCU_ALL?
(snip)
> > +#define R8A7790_CLK_SRC9               22
> > +#define R8A7790_CLK_SRC8               23
> > +#define R8A7790_CLK_SRC7               24
> > +#define R8A7790_CLK_SRC6               25
> > +#define R8A7790_CLK_SRC5               26
> > +#define R8A7790_CLK_SRC4               27
> > +#define R8A7790_CLK_SRC3               28
> > +#define R8A7790_CLK_SRC2               29
> > +#define R8A7790_CLK_SRC1               30
> > +#define R8A7790_CLK_SRC0               31
> 
> Should these be called R8A7790_CLK_SCU_SRC[0-9]?

Using datasheet name will not create new confusion.
Thank you, will fix.
