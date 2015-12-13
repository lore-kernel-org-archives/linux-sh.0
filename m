From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 18:56:01 +0000
Subject: Re: [PATCH/RFC 07/19] ARM: shmobile: r8a7793: add m2 clock to device tree
Message-Id: <2156854.cD7k6gAu9Y@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-8-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449802376-11301-8-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Thank you for the patch.

On Friday 11 December 2015 11:52:44 Simon Horman wrote:
> Declare m2 clock in r8a7793 device tree.
> 
> Based on similar work for the r8a7791 by Laurent Pinchart.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7793.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index 7179c3cba20a..99ee88e0e8be 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -809,6 +809,14 @@
>  			clock-mult = <1>;
>  			clock-output-names = "p";
>  		};
> +		m2_clk: m2_clk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
> +			#clock-cells = <0>;
> +			clock-div = <8>;
> +			clock-mult = <1>;
> +			clock-output-names = "m2";
> +		};
>  		rclk_clk: rclk_clk {
>  			compatible = "fixed-factor-clock";
>  			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;

-- 
Regards,

Laurent Pinchart

