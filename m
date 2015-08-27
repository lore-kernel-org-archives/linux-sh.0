From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 27 Aug 2015 10:16:46 +0000
Subject: Re: [PATCH/RFC 01/10] arm64: dts: r8a7795: add GPIO nodes
Message-Id: <CAO3366zdU2aD-y4BHpOSk2cU+c9FSU629DdO4ezCMFEtKaU4hQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks for the patch.

On Thu, Aug 27, 2015 at 11:24 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [horms: broken out of a larger patch; moved to soc node]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 104 +++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 9fba8be62025..a608eb92a172 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -52,6 +52,110 @@
>                                         (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
>
> +               gpio0: gpio@e6050000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6050000 0 0x50>;
> +                       interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 0 32>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&mstp9_clks R8A7795_CLK_GPIO0>;
> +               };
> +
[...]
> +               gpio5: gpio@e6055000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6055000 0 0x50>;
> +                       interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 160 32>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&mstp9_clks R8A7795_CLK_GPIO5>;
> +               };
> +
> +               gpio6: gpio@e6055400 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6055400 0 0x50>;
> +                       interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 192 32>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&mstp9_clks R8A7795_CLK_GPIO5>;

This should say R8A7795_CLK_GPIO6...

> +               };
> +
> +               gpio7: gpio@e6055800 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6055800 0 0x50>;
> +                       interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 224 32>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&mstp9_clks R8A7795_CLK_GPIO5>;

...and this R8A7795_CLK_GPIO7.

CU
Uli
