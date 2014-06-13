From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Jun 2014 07:47:06 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7791: add audio clock on DTSI
Message-Id: <20140613074703.GB15286@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwdienzg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwdienzg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 11, 2014 at 09:44:04PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> audio_clk_a/b/c are required from sound driver
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up.

> ---
>  arch/arm/boot/dts/r8a7791.dtsi |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index b639006..f3b6219 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -532,6 +532,29 @@
>  			clock-output-names = "extal";
>  		};
>  
> +		/*
> +		 * The external audio clocks are configured as 0 Hz fixed frequency clocks by
> +		 * default. Boards that provide audio clocks should override them.
> +		 */
> +		audio_clk_a: audio_clk_a {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +			clock-output-names = "audio_clk_a";
> +		};
> +		audio_clk_b: audio_clk_b {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +			clock-output-names = "audio_clk_b";
> +		};
> +		audio_clk_c: audio_clk_c {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +			clock-output-names = "audio_clk_c";
> +		};
> +
>  		/* Special CPG clocks */
>  		cpg_clocks: cpg_clocks@e6150000 {
>  			compatible = "renesas,r8a7791-cpg-clocks",
> -- 
> 1.7.9.5
> 
