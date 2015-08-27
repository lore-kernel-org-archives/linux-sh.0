From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Aug 2015 10:41:33 +0000
Subject: Re: [PATCH/RFC 06/10] arm64: dts: r8a7795: add EthernetAVB device node
Message-Id: <55DEE95D.7070600@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-7-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-7-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 8/27/2015 12:24 PM, Simon Horman wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> [horms: moved to soc node; updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 0b435d8274e4..01502f4d2f5f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -263,6 +263,16 @@
>   			reg = <0 0xe6060000 0 0x50c>;
>   		};
>
> +		avb: ethernet@e6800000 {
> +			compatible = "renesas,etheravb-r8a7795";
> +			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
> +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;

    Two interrupts?

> +			clocks = <&mstp8_clks R8A7795_CLK_AVB>;
> +			phy-mode = "rgmii-id";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>   		scif2: serial@e6e88000 {
>   			compatible = "renesas,scif-r8a7795", "renesas,scif";
>   			reg = <0 0xe6e88000 0 64>;
> @@ -362,5 +372,4 @@
>   			status = "disabled";
>   		};
>   	};
> -
>   };

    Hm?

MBR, Sergei

