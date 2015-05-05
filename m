From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 May 2015 09:27:21 +0000
Subject: Re: [PATCH v2 08/15] ARM: shmobile: add r8a7793 SoC device tree
Message-Id: <CAMuHMdVYwQPDWb5ukcnRGV7yQFAKTUr8RMEy9pW3HM0og=VZvg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1430403544-26742-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-9-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Kazuya Mizuguchi <kazuya.mizuguchi.ks-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Ulrich,

On Thu, Apr 30, 2015 at 4:18 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> r8a7793 device tree including clock descriptions.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> [uli: collapsed BSP revisions into a single commit, edited for style]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: devicetree@vger.kernel.org

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -0,0 +1,1376 @@

> +       timer {
> +               compatible = "arm,armv7-timer";
> +               interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <1 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <1 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <1 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +       };

No cmt0, cmt1?

> +       irqc0: interrupt-controller@e61c0000 {
> +               compatible = "renesas,irqc-r8a7793", "renesas,irqc";
> +               #interrupt-cells = <2>;
> +               interrupt-controller;
> +               reg = <0 0xe61c0000 0 0x200>;
> +               interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 1 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 2 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 3 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 12 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 13 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 14 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 15 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 16 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 17 IRQ_TYPE_LEVEL_HIGH>;

clocks = <&mstp4_clks R8A7793_CLK_IRQC>;

> +       };

> +       audmapp: dma-controller@0xec740000 {
> +               compatible = "renesas,rcar-audmapp";
> +               #dma-cells = <1>;
> +
> +               reg = <0 0xec740000 0 0x200>;
> +       };

The audmapp node is obsolete.
There's no driver anymore for "renesas,rcar-audmapp".


> +       sdhi0: sd@ee100000 {
> +               compatible = "renesas,sdhi-r8a7793";
> +               reg = <0 0xee100000 0 0x200>;

Length should be 0x328 for sdhi0.

> +               dma-names = "tx", "rx";
> +               interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
> +               cap-uhs-sdr104;
> +               cap-uhs-sdr50;
> +               dma-xmit-sz = <32>;
> +               renesas,clk-rate = <195000000>;
> +               renesas,mmc-scc-tapnum = <8>;
> +               renesas,pfcs = <0xe6060000 0x8c>;
> +               renesas,id = <0>;

Undocumented properties not supported in upstream, likewise for sdh[12].
Please look at r8a7791.dtsi.

> +               status = "disabled";
> +       };


> +       clocks {

> +               /* Fixed factor clocks */

> +               zg_clk: zg_clk {
> +                       compatible = "fixed-factor-clock";
> +                       clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
> +                       #clock-cells = <0>;
> +                       clock-div = <5>;

r8a7791 uses <3>.
But upon closer look, the zg is configurable for 3 or 5 through the
GPUCKCR register on both '91 and '93. so this is wrong on both.

> +                       clock-mult = <1>;
> +                       clock-output-names = "zg";
> +               };

> +               /* Gate clocks */

> +               mstp5_clks: mstp5_clks@e6150144 {
> +                       compatible = "renesas,r8a7793-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
> +                       clocks = <&zs_clk>, <&zs_clk>, <&extal_clk>, <&p_clk>;

r8a7791 has hp_clk (High Speed Peripheral Clock) instead of zs_clk (AXI clock)
as the parent clock for the audio DMA controllers.
As audio DMA is connected to the APB, not to the AXI bus, hp_clk looks correct.

> +                       #clock-cells = <1>;
> +                       clock-indices = <R8A7793_CLK_AUDIO_DMAC0
> +                                       R8A7793_CLK_AUDIO_DMAC1
> +                                       R8A7793_CLK_THERMAL
> +                                       R8A7793_CLK_PWM>;
> +                       clock-output-names > +                               "audmac0", "audmac1", "thermal", "pwm";
> +               };

> +       msiof0: spi@e6e20000 {
> +               compatible = "renesas,msiof-r8a7793";
> +               reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;

Please drop the second register bank, which is obsolete.
Likewise for msiof[12].

> +       rcar_sound: sound@0xec500000 {

Bogus "0x" after "@".

> +               #sound-dai-cells = <1>;
> +               compatible =  "renesas,rcar_sound-r8a7793", "renesas,rcar_sound-gen2", "renesas,rcar_sound";

Please drop "renesas,rcar_sound";

Probably more changes to the audio are needed. Please look at r8a7791.dtsi, or
wait for Morimoto-san to comment.


> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a7793-clock.h

Missing:

    /* MSTP4 */
    #define R8A7793_CLK_IRQC               7

> +
> +/* MSTP5 */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
