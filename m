From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 18 Sep 2015 12:58:27 +0000
Subject: Re: [PATCH/RFC v3 3/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <55FC0A73.6060906@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442556314-10512-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1442556314-10512-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 9/18/2015 9:05 AM, Simon Horman wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> [horms: minor updates]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[...]

> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 5bae2cc0c61e..4fb141230f0c 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
[...]
> @@ -56,3 +61,31 @@
>
>   	status = "okay";
>   };
> +
> +&avb {
> +	pinctrl-0 = <&avb_pins>;
> +	pinctrl-names = "default";
> +	renesas,no-ether-link;
> +	phy-reset-gpio = <&gpio2 10 0>;

    Undocumented prop. You were going to delete it from the binding example.

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
> +		reg = <0>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +

    This line is hardly needed...

> +};

MBR, Sergei

