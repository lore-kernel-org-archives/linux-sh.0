From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Aug 2015 18:53:47 +0000
Subject: Re: [PATCH 08/17 v6][RFC] arm64: renesas: r8a7795: Add SCIF2 support
Message-Id: <20150820185342.GC18990@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bne2b9fv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bne2b9fv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2015 at 09:26:47AM +0000, Kuninori Morimoto wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> 
> This patch enables SCIF2
> Gaku Inami <gaku.inami.xw@bp.renesas.com> created original patch,
> and Kuninori updated DTSI
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v5 -> v6
> 
>  - cpg has #clock-cells
> 
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 21 +++++++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index f013814..7bf9f56 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -49,10 +49,23 @@
>  		};
>  
>  		cpg_clocks: cpg_clocks@e6150000 {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#clock-cells = <1>;
> +			ranges;
> +
>  			compatible = "renesas,r8a7795-cpg-clocks",
>  				     "renesas,rcar-gen3-cpg-clocks";
>  			reg = <0 0xe6150000 0 0x1000>;
>  			clocks = <&extal_clk>;
> +
> +			mstp3_clks: mstp3_clks@e615013c {
> +				compatible = "renesas,r8a7795-mstp-clocks",
> +				             "renesas,cpg-mstp-clocks";
> +				reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
> +				clocks =  <&s3d4_clks>;
> +				renesas,clock-indices = <R8A7795_CLK_SCIF2>;
> +			};
>  		};
>  	};

Is it intentional that the clock-output-names property is not present in
the mstp3_clks node? It was present in the previous revision of this patch.

[snip]
