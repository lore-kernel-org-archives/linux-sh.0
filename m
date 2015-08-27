From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Aug 2015 10:40:01 +0000
Subject: Re: [PATCH/RFC 07/10] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <55DEE901.1010001@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 8/27/2015 12:24 PM, Simon Horman wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> [horms: updated filename to salvator-x; updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 34 ++++++++++++++++++++++
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  1 +
>   2 files changed, 35 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 88cc34819e6a..e8d940cc831a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
[...]
> @@ -103,3 +108,32 @@
>   &ohci2 {
>   	status = "okay";
>   };
> +
> +&avb {
> +	pinctrl-0 = <&avb_pins>;
> +	pinctrl-names = "default";
> +	renesas,no-ether-link;
> +	renesas,phy = <0>;

    What's that for? :-)

> +	phy-reset-gpio = <&gpio2 10 0>;
> +	phy-handle = <&phy0>;
> +	status = "okay";
> +
> +	phy0: ethernet-phy@0 {
> +		rxc-skew-ps = <900>;
> +		rxdv-skew-ps = <0>;
> +		rxd0-skew-ps = <0>;
> +		rxd1-skew-ps = <0>;
> +		rxd2-skew-ps = <0>;
> +		rxd3-skew-ps = <0>;
> +		txc-skew-ps = <900>;
> +		txen-skew-ps = <0>;
> +		txd0-skew-ps = <0>;
> +		txd1-skew-ps = <0>;
> +		txd2-skew-ps = <0>;
> +		txd3-skew-ps = <0>;

    Hm, and the PHY driver can parse all this?

> +		reg = <0>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +};
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 01502f4d2f5f..42c2eaa8167a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -372,4 +372,5 @@
>   			status = "disabled";
>   		};
>   	};
> +
>   };

    Stray newline?

MBR, Sergei

