From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 09:59:28 +0000
Subject: Re: [PATCH 03/11] ARM: shmobile: add r8a7793 SoC device tree
Message-Id: <CAMuHMdUi=r2dco8fOg746vAWQvy3p1YnfnXvO=8vNaWhw_zUjA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> r8a7793 device tree including clock descriptions.

Thanks for your patch!

I gave a few comments below, mostly by comparing with r8a7791.dtsi.
As r8a7793 is very similar to r8a7791 (does anyone compiled a list of the
differences?), perhaps it's best to just start from a copy of upstream
r8a7791.dtsi and r8a7791-clock.h?

> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> [uli: collapsed BSP revisions into a single commit, edited for style]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7793.dtsi            | 1402 +++++++++++++++++++++++++++++
>  include/dt-bindings/clock/r8a7793-clock.h |  158 ++++
>  2 files changed, 1560 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a7793.dtsi
>  create mode 100644 include/dt-bindings/clock/r8a7793-clock.h
>
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> new file mode 100644
> index 0000000..0530d4c
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7793.dtsi


> +       gic: interrupt-controller@f1001000 {
> +               compatible = "arm,cortex-a15-gic";
> +               #interrupt-cells = <3>;
> +               #address-cells = <0>;
> +               interrupt-controller;
> +               reg = <0 0xf1001000 0 0x1000>,
> +                       <0 0xf1002000 0 0x1000>,
> +                       <0 0xf1004000 0 0x2000>,
> +                       <0 0xf1006000 0 0x2000>;
> +               interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;

"GIC_CPU_MASK_SIMPLE(2)" (M2-W is dual-core, not quad-core).

> +       };


> +       timer {
> +               compatible = "arm,armv7-timer";
> +               interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <1 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <1 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;

"GIC_CPU_MASK_SIMPLE(2)" (M2-W is dual-core, not quad-core).

> +       };
> +

> +       audmapp: audio-dma-pp@0xec740000 {

dma-controller@...

> +               compatible = "renesas,rcar-audmapp";
> +               #dma-cells = <1>;
> +
> +               reg = <0 0xec740000 0 0x200>;
> +       };


> +               /* Variable factor clocks */
> +               sd1_clk: sd2_clk@e6150078 {

sd2_clk

> +                       compatible = "renesas,r8a7793-div6-clock",
> +                                    "renesas,cpg-div6-clock";
> +                       reg = <0 0xe6150078 0 4>;
> +                       clocks = <&pll1_div2_clk>;
> +                       #clock-cells = <0>;
> +                       clock-output-names = "sd1";

sd2

> +               };
> +               sd2_clk: sd3_clk@e615026c {

sd3_clk

> +                       compatible = "renesas,r8a7793-div6-clock",
> +                                    "renesas,cpg-div6-clock";
> +                       reg = <0 0xe615026c 0 4>;
> +                       clocks = <&pll1_div2_clk>;
> +                       #clock-cells = <0>;
> +                       clock-output-names = "sd2";

sd3

> +               };


> +               /* Gate clocks */
> +               mstp0_clks: mstp0_clks@e6150130 {
> +                       compatible = "renesas,r8a7793-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
> +                       clocks = <&mp_clk>;
> +                       #clock-cells = <1>;
> +                       renesas,clock-indices = <R8A7793_CLK_MSIOF0>;

"clock-indices" (everywhere)

> +                       clock-output-names = "msiof0";
> +               };


> +               mstp8_clks: mstp8_clks@e6150990 {
> +                       compatible = "renesas,r8a7793-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> +                       clocks = <&zx_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
> +                                <&p_clk>, <&zs_clk>, <&zs_clk>;
> +                       #clock-cells = <1>;
> +                       renesas,clock-indices = <
> +                               R8A7793_CLK_IPMMU_GP R8A7793_CLK_VIN2

R8A7793_CLK_IPMMU_SGX

> +                               R8A7793_CLK_VIN1 R8A7793_CLK_VIN0
> +                               R8A7793_CLK_ETHER R8A7793_CLK_SATA1
> +                               R8A7793_CLK_SATA0
> +                       >;
> +                       clock-output-names > +                               "ipmmu_gp", "vin2", "vin1", "vin0", "ether",

ipmmu_sgx

> +                               "sata1", "sata0";
> +               };

> diff --git a/include/dt-bindings/clock/r8a7793-clock.h b/include/dt-bindings/clock/r8a7793-clock.h
> new file mode 100644
> index 0000000..3ee0644
> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a7793-clock.h

> +/* MSTP0 */
> +#define R8A7793_CLK_MSIOF0             0
> +
> +/* MSTP1 */
> +#define R8A7793_CLK_VCP0               1
> +#define R8A7793_CLK_VPC0               3
> +#define R8A7793_CLK_SSP1               9
> +#define R8A7793_CLK_TMU1               11
> +#define R8A7793_CLK_PVRSRVKM           12

R8A7793_CLK_3DG

> +#define R8A7793_CLK_2DDMAC             15
> +#define R8A7793_CLK_FDP1               18

R8A7793_CLK_FDP1_1

> +#define R8A7793_CLK_FDP0               19

R8A7793_CLK_FDP1_0


> +/* MSTP8 */
> +#define R8A7793_CLK_IPMMU_GP           0

R8A7793_CLK_IPMMU_SGX

> +/* MSTP10 */
> +#define R8A7793_CLK_SSI                        5

R8A7793_CLK_SSI_ALL

> +#define R8A7793_CLK_SSI9               6
> +#define R8A7793_CLK_SSI8               7
> +#define R8A7793_CLK_SSI7               8
> +#define R8A7793_CLK_SSI6               9
> +#define R8A7793_CLK_SSI5               10
> +#define R8A7793_CLK_SSI4               11
> +#define R8A7793_CLK_SSI3               12
> +#define R8A7793_CLK_SSI2               13
> +#define R8A7793_CLK_SSI1               14
> +#define R8A7793_CLK_SSI0               15
> +#define R8A7793_CLK_SCU                        17

R8A7793_CLK_SCU_ALL

> +#define R8A7793_CLK_DVC1               18
> +#define R8A7793_CLK_DVC0               19

R8A7793_CLK_SCU_DVCx

> +#define R8A7793_CLK_SRC9               22
> +#define R8A7793_CLK_SRC8               23
> +#define R8A7793_CLK_SRC7               24
> +#define R8A7793_CLK_SRC6               25
> +#define R8A7793_CLK_SRC5               26
> +#define R8A7793_CLK_SRC4               27
> +#define R8A7793_CLK_SRC3               28
> +#define R8A7793_CLK_SRC2               29
> +#define R8A7793_CLK_SRC1               30
> +#define R8A7793_CLK_SRC0               31

R8A7793_CLK_SCU_SRCx

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
