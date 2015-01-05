From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Jan 2015 00:46:02 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: Correct SDHI clock node names
Message-Id: <20150105004602.GG2817@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1420418648-7815-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1420418648-7815-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 05, 2015 at 09:44:08AM +0900, Simon Horman wrote:
> Correct the SDHI clock node names to match their labels
> and the documentation.
> 
> This has no run-time affect as the clock nodes are not currently used.
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

This patch is based on renesas-devel-20141231-v3.19-rc2

> ---
>  arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index 8f78da5..9856e9c 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -294,14 +294,14 @@
>  					     "lb", "qspi", "sdh", "sd0", "z";
>  		};
>  		/* Variable factor clocks */
> -		sd1_clk: sd2_clk@e6150078 {
> +		sd1_clk: sd1_clk@e6150078 {
>  			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
>  			reg = <0 0xe6150078 0 4>;
>  			clocks = <&pll1_div2_clk>;
>  			#clock-cells = <0>;
>  			clock-output-names = "sd1";
>  		};
> -		sd2_clk: sd3_clk@e615007c {
> +		sd2_clk: sd2_clk@e615007c {
>  			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
>  			reg = <0 0xe615007c 0 4>;
>  			clocks = <&pll1_div2_clk>;
> -- 
> 2.1.3
> 
