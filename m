From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Jun 2014 08:10:24 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7790: add MSTP10 support on DTSI
Message-Id: <CAMuHMdVJ0MiD_RBJWDJNRY_qnZFoceP01d_B7DCYY1bq9oL+mg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Jun 10, 2014 at 9:48 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > +               mstp10_clks: mstp10_clks@e6150998 {
>> > +                       compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>> > +                       reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
>> > +                       clocks = <&p_clk>, /* parent of SCU */
>> > +                               <&p_clk>,
>> > +                               <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
>> > +                               <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
>> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
>> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
>> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
>> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
>> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
>> > +                               <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>;
>> > +
>> > +                       #clock-cells = <1>;
>> > +                       clock-indices = <
>> > +                               R8A7790_CLK_SCU
>> > +                               R8A7790_CLK_SSI
>> > +                               R8A7790_CLK_SSI9 R8A7790_CLK_SSI8 R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
>> > +                               R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2 R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
>> > +                               R8A7790_CLK_DVC1 R8A7790_CLK_DVC0
>> > +                               R8A7790_CLK_SRC9 R8A7790_CLK_SRC8 R8A7790_CLK_SRC7 R8A7790_CLK_SRC6 R8A7790_CLK_SRC5
>> > +                               R8A7790_CLK_SRC4 R8A7790_CLK_SRC3 R8A7790_CLK_SRC2 R8A7790_CLK_SRC1 R8A7790_CLK_SRC0
>>
>> I think we usually put these in numerical order here.
>
> Do you mean R8A7790_CLK_SCU is out-of-order ?

I mean they should be in the same order as listed in
include/dt-bindings/clock/r8a7790-clock.h

> If so, Unfortunately, we need put "R8A7790_CLK_SCU" before "R8A7790_CLK_SRCx",
> because SCU(ALL) is parent clock of SRCn.

IC. I didn't look up the parent clock relations.
However, SCU_ALL = 17, while its children are 18-31, so numerical order
should be fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
