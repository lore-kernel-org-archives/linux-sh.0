From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 04 Nov 2014 13:14:16 +0000
Subject: Re: [PATCH 04/10] ARM: shmobile: r8a7791: Add DU node to device tree
Message-Id: <5458D128.1070903@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
 <8eefac2d6620642e8c44bf4acbf442c7d89f39d8.1415058552.git.horms+renesas@verge.net.au>
In-Reply-To: <8eefac2d6620642e8c44bf4acbf442c7d89f39d8.1415058552.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/4/2014 4:50 AM, Simon Horman wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Add the DU device with a disabled state. Boards that want to enable the
> DU need to specify the output topology

   Same question as for the previous patch.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7791.dtsi | 69 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index e06c11f..e4a7170 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -637,6 +637,75 @@
>   		status = "disabled";
>   	};
>
> +	vsp1@fe928000 {
> +		compatible = "renesas,vsp1";
> +		reg = <0 0xfe928000 0 0x8000>;
> +		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
> +
> +		renesas,has-lut;
> +		renesas,has-sru;
> +		renesas,#rpf = <5>;
> +		renesas,#uds = <3>;
> +		renesas,#wpf = <4>;
> +	};
> +
> +	vsp1@fe930000 {
> +		compatible = "renesas,vsp1";
> +		reg = <0 0xfe930000 0 0x8000>;
> +		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
> +
> +		renesas,has-lif;
> +		renesas,has-lut;
> +		renesas,#rpf = <4>;
> +		renesas,#uds = <1>;
> +		renesas,#wpf = <4>;
> +	};
> +
> +	vsp1@fe938000 {
> +		compatible = "renesas,vsp1";
> +		reg = <0 0xfe938000 0 0x8000>;
> +		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
> +
> +		renesas,has-lif;
> +		renesas,has-lut;
> +		renesas,#rpf = <4>;
> +		renesas,#uds = <1>;
> +		renesas,#wpf = <4>;
> +	};
[...]

WBR, Sergei

