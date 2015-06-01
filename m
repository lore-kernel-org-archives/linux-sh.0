From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 01 Jun 2015 09:37:40 +0000
Subject: Re: [PATCH v4 2/4] ARM: shmobile: add r8a7793 minimal SoC device tree
Message-Id: <CAMuHMdXr3BxULQohYo1U0RuW8SRTtb5Ge_ypAbByW8vuRWs=PA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432826157-6414-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1432826157-6414-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432826157-6414-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ulrich,

On Thu, May 28, 2015 at 5:15 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Minimal r8a7793 device tree including one CPU core, interrupt controllers,
> timers, two serial ports, and the Ethernet controller, plus the required
> clock descriptions.

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -0,0 +1,368 @@

> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       enable-method = "renesas,r8a7793";

I don't think we need the enable-method in a minimal tree, do we?

> +       clocks {

> +               /* Gate clocks */
> +               mstp1_clks: mstp1_clks@e6150134 {
> +                       compatible = "renesas,r8a7793-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
> +                       clocks = <&zs_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
> +                                <&zg_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>,
> +                                <&p_clk>, <&p_clk>, <&rclk_clk>, <&cp_clk>,
> +                                <&zs_clk>, <&zs_clk>, <&zs_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7793_CLK_VCP0 R8A7793_CLK_VPC0
> +                               R8A7793_CLK_SSP1 R8A7793_CLK_TMU1
> +                               R8A7793_CLK_3DG R8A7793_CLK_2DDMAC
> +                               R8A7793_CLK_FDP1_1 R8A7793_CLK_FDP1_0
> +                               R8A7793_CLK_TMU3 R8A7793_CLK_TMU2
> +                               R8A7793_CLK_CMT0 R8A7793_CLK_TMU0
> +                               R8A7793_CLK_VSP1_DU1 R8A7793_CLK_VSP1_DU0
> +                               R8A7793_CLK_VSP1_S
> +                       >;
> +                       clock-output-names > +                               "vcp0", "vpc0", "ssp_dev", "tmu1",
> +                               "pvrsrvkm", "tddmac", "fdp1", "fdp0",
> +                               "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
> +                               "vsp1-du0", "vsps";
> +               };
> +               mstp3_clks: mstp3_clks@e615013c {
> +                       compatible = "renesas,r8a7793-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
> +                       clocks = <&cp_clk>, <&sd3_clk>, <&sd2_clk>,
> +                                <&cpg_clocks R8A7793_CLK_SD0>, <&mmc0_clk>,
> +                                <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>,
> +                                <&rclk_clk>, <&hp_clk>, <&hp_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7793_CLK_TPU0 R8A7793_CLK_SDHI2
> +                               R8A7793_CLK_SDHI1 R8A7793_CLK_SDHI0
> +                               R8A7793_CLK_MMCIF0 R8A7793_CLK_IIC0
> +                               R8A7793_CLK_PCIEC R8A7793_CLK_IIC1
> +                               R8A7793_CLK_SSUSB R8A7793_CLK_CMT1
> +                               R8A7793_CLK_USBDMAC0 R8A7793_CLK_USBDMAC1
> +                       >;
> +                       clock-output-names > +                               "tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0",
> +                               "i2c7", "pciec", "i2c8", "ssusb", "cmt1",
> +                               "usbdmac0", "usbdmac1";
> +               };
> +               mstp4_clks: mstp4_clks@e6150140 {
> +                       compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
> +                       clocks = <&cp_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <R8A7793_CLK_IRQC>;
> +                       clock-output-names = "irqc";
> +               };
> +               mstp7_clks: mstp7_clks@e615014c {
> +                       compatible = "renesas,r8a7793-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> +                       clocks = <&mp_clk>,  <&hp_clk>, <&zs_clk>, <&p_clk>,
> +                                <&p_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
> +                                <&p_clk>, <&p_clk>, <&p_clk>, <&zx_clk>,
> +                                <&zx_clk>, <&zx_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7793_CLK_EHCI R8A7793_CLK_HSUSB
> +                               R8A7793_CLK_HSCIF2 R8A7793_CLK_SCIF5
> +                               R8A7793_CLK_SCIF4 R8A7793_CLK_HSCIF1
> +                               R8A7793_CLK_HSCIF0 R8A7793_CLK_SCIF3
> +                               R8A7793_CLK_SCIF2 R8A7793_CLK_SCIF1
> +                               R8A7793_CLK_SCIF0 R8A7793_CLK_DU1
> +                               R8A7793_CLK_DU0 R8A7793_CLK_LVDS0
> +                       >;
> +                       clock-output-names > +                               "ehci", "hsusb", "hscif2", "scif5", "scif4",
> +                               "hscif1", "hscif0", "scif3", "scif2",
> +                               "scif1", "scif0", "du1", "du0", "lvds0";
> +               };
> +               mstp8_clks: mstp8_clks@e6150990 {
> +                       compatible = "renesas,r8a7793-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> +                       clocks = <&zx_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
> +                                <&p_clk>, <&zs_clk>, <&zs_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7793_CLK_IPMMU_SGX R8A7793_CLK_VIN2
> +                               R8A7793_CLK_VIN1 R8A7793_CLK_VIN0
> +                               R8A7793_CLK_ETHER R8A7793_CLK_SATA1
> +                               R8A7793_CLK_SATA0
> +                       >;
> +                       clock-output-names > +                               "ipmmu_sgx", "vin2", "vin1", "vin0", "ether",
> +                               "sata1", "sata0";
> +               };
> +       };

I don't see the rationele behind keeping some mstp clocks, and others not,
for a miminal dtsi.

Anyway, it's up to Simon. The other bits have to be added later anyway...

The rest looks fine to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
