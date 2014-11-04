From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Nov 2014 00:10:10 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7794: Add VIN clock to device tree
Message-Id: <20141104001010.GA20174@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414648736-31412-1-git-send-email-horms+renesas@verge.net.au>
 <1414648736-31412-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1414648736-31412-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 30, 2014 at 02:58:55PM +0900, Simon Horman wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> 
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7794.dtsi            | 6 +++---
>  include/dt-bindings/clock/r8a7794-clock.h | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)

I have queued up this patch (but not the other twi in the series).

> 
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index d348dee..08c50c8 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -516,13 +516,13 @@
>  		mstp8_clks: mstp8_clks@e6150990 {
>  			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
>  			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> -			clocks = <&p_clk>;
> +			clocks = <&zg_clk>, <&zg_clk>, <&p_clk>;
>  			#clock-cells = <1>;
>  			renesas,clock-indices = <
> -				R8A7794_CLK_ETHER
> +				R8A7794_CLK_VIN1 R8A7794_CLK_VIN0 R8A7794_CLK_ETHER
>  			>;
>  			clock-output-names > -				"ether";
> +				"vin1", "vin0", "ether";
>  		};
>  		mstp11_clks: mstp11_clks@e615099c {
>  			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
> diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
> index 29a6789..7d49531 100644
> --- a/include/dt-bindings/clock/r8a7794-clock.h
> +++ b/include/dt-bindings/clock/r8a7794-clock.h
> @@ -62,6 +62,8 @@
>  #define R8A7794_CLK_SCIF0		21
>  
>  /* MSTP8 */
> +#define R8A7794_CLK_VIN1		10
> +#define R8A7794_CLK_VIN0		11
>  #define R8A7794_CLK_ETHER		13
>  
>  /* MSTP9 */
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
