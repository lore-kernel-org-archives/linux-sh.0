From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jun 2014 09:35:47 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <87fvjjitqm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>
	<20140603214226.GA2520@sirena.org.uk>
	<87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
	<538EE0BE.5030304@codethink.co.uk>
	<87zjhrj3gc.wl%kuninori.morimoto.gx@renesas.com>
	<539033ED.4010604@codethink.co.uk>
In-Reply-To: <539033ED.4010604@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Mark Brown <broonie@kernel.org>, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-sh@vger.kernel.org


Hi Violeta

> > SSI(ALL) bit mean "this bit is always required for all SSI"
> > If you want to use SSI0, then, you need to enable "SSI(ALL) + SSI0" bit
> >
> 
> We have to force SSI(ALL) to stay always on on the DT with a special 
> property, like this:
> always-on = <0x00000020>;
> 
> we don't need to force SSI0 on, although it is necessary for audio that 
> this clock is on too.
> 
> The code for mstp10 correctly enables SSI0 *and* SSI(ALL). But it only 
> works when SSI(ALL) is forced on the DT.
(snip)
> Where index 5 is SSI(ALL) and index 15 is SSI0.
> We can observe that when we force SSI(ALL) on on the DT, then 
> clock_disable is called for SSI(ALL) before it enables again.
> But when we don't force SSI(ALL) to be on, then it only calls 
> clock_enable, but the register data is the same.
> 
> This looks like the correct behaviour, but in one case we have audio, 
> and in the other we don't.
> 
> I hope this clarifies the problem a bit more.

I understand your point on DT with SSI(ALL).
I didn't send R-Car sound DT support patch yet for some reasons.
But, R-Car sound clock needs trick.

 - SSI(ALL) is called via pm_runtime_xxx() from sound driver
 - SRC(ALL) is called as parent clock of SRCn clocks

This is implemented on legacy clock-r8a7790.c too.
So, I think "always-on" is not needed for sound driver.

My local DTS file is below.
(not enough maintenance though...)

It is very nice if you can wait for my DT patches,
since R-Car sound driver is very complex / needs some trick etc...

     mstp10_clks: mstp10_clks@e6150998 {
                compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
                reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
                clocks = <&p_clk>, /* parent of SCU */
                        <&p_clk>,
                        <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
                        <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
                        <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
                        <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
                        <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
                        <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
                        <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>,
                        <&mstp10_clks R8A7790_CLK_SCU>, <&mstp10_clks R8A7790_CLK_SCU>;
                  #clock-cells = <1>;
                clock-indices = <
                        R8A7790_CLK_SCU
                        R8A7790_CLK_SSI
                        R8A7790_CLK_SSI9 R8A7790_CLK_SSI8 R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
                        R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2 R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
                        R8A7790_CLK_DVC1 R8A7790_CLK_DVC0
                        R8A7790_CLK_SRC9 R8A7790_CLK_SRC8 R8A7790_CLK_SRC7 R8A7790_CLK_SRC6 R8A7790_CLK_SRC5
                        R8A7790_CLK_SRC4 R8A7790_CLK_SRC3 R8A7790_CLK_SRC2 R8A7790_CLK_SRC1 R8A7790_CLK_SRC0
                >;
                clock-output-names                         "scu", "ssi",
                        "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
                        "ssi4", "ssi3", "ssi2", "ssi1", "ssi0",
                        "dvc1", "dvc0",
                        "src9", "src8", "src7", "src6", "src5",
                        "src4", "src3", "src2", "src1", "src0";
        };

...

rcar_sound: rcar_sound@0xec500000 {
        #sound-dai-cells = <1>;
        compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
        interrupt-parent = <&gic>;
        reg =   <0 0xec500000 0 0x1000>, /* SCU */
                <0 0xec5a0000 0 0x100>,  /* ADG */
                <0 0xec540000 0 0x1000>, /* SSIU */
                <0 0xec541000 0 0x1280>; /* SSI */
        clocks = <&mstp10_clks R8A7790_CLK_SSI>,
                <&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
                <&mstp10_clks R8A7790_CLK_SSI7>, <&mstp10_clks R8A7790_CLK_SSI6>,
                <&mstp10_clks R8A7790_CLK_SSI5>, <&mstp10_clks R8A7790_CLK_SSI4>,
                <&mstp10_clks R8A7790_CLK_SSI3>, <&mstp10_clks R8A7790_CLK_SSI2>,
                <&mstp10_clks R8A7790_CLK_SSI1>, <&mstp10_clks R8A7790_CLK_SSI0>,
                <&mstp10_clks R8A7790_CLK_SRC9>, <&mstp10_clks R8A7790_CLK_SRC8>,
                <&mstp10_clks R8A7790_CLK_SRC7>, <&mstp10_clks R8A7790_CLK_SRC6>,
                <&mstp10_clks R8A7790_CLK_SRC5>, <&mstp10_clks R8A7790_CLK_SRC4>,
                <&mstp10_clks R8A7790_CLK_SRC3>, <&mstp10_clks R8A7790_CLK_SRC2>,
                <&mstp10_clks R8A7790_CLK_SRC1>, <&mstp10_clks R8A7790_CLK_SRC0>,
                <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
        clock-names = "ssi",
                        "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
                        "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
                        "src.9", "src.8", "src.7", "src.6", "src.5",
                        "src.4", "src.3", "src.2", "src.1", "src.0",
                        "clk_a", "clk_b", "clk_c", "clk_i";
       ...
