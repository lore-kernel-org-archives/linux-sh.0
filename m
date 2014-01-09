From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 09 Jan 2014 14:29:57 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7790: Add SATA clocks to device tree
Message-Id: <52CEB265.3070501@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/07/2014 12:22 PM, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Tested-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Thanks,
Val.

> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index ae7d77e..26ec957 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -707,13 +707,16 @@
>   		mstp8_clks: mstp8_clks@e6150990 {
>   			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>   			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> -			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>;
> +			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
> +				 <&zs_clk>, <&zs_clk>;
>   			#clock-cells = <1>;
>   			renesas,clock-indices = <
>   				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
> -				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
> +				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER R8A7790_CLK_SATA1
> +				R8A7790_CLK_SATA0
>   			>;
> -			clock-output-names = "vin3", "vin2", "vin1", "vin0", "ether";
> +			clock-output-names > +				"vin3", "vin2", "vin1", "vin0", "ether", "sata1", "sata0";
>   		};
>   		mstp9_clks: mstp9_clks@e6150994 {
>   			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>

