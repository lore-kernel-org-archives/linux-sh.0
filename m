From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jan 2016 01:57:33 +0000
Subject: Re: [PATCH 2/2] ARM: dts: r8a7790: add iommus to dmac0 and dmac1
Message-Id: <20160118015733.GH1905@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Niklas,

On Mon, Jan 11, 2016 at 03:17:47AM +0100, Niklas Söderlund wrote:
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

I am marking this patch as Deffered pending acceptance of the
driver change which is patch 1/2 of this series. If I am mistaken
and it is appropriate to queue up this patch now for v4.6 then
please don't hesitate to let me know.

> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index e07ae5d..23af349 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -294,6 +294,21 @@
>  		power-domains = <&cpg_clocks>;
>  		#dma-cells = <1>;
>  		dma-channels = <15>;
> +		iommus = <&ipmmu_ds 0>,
> +			 <&ipmmu_ds 1>,
> +			 <&ipmmu_ds 2>,
> +			 <&ipmmu_ds 3>,
> +			 <&ipmmu_ds 4>,
> +			 <&ipmmu_ds 5>,
> +			 <&ipmmu_ds 6>,
> +			 <&ipmmu_ds 7>,
> +			 <&ipmmu_ds 8>,
> +			 <&ipmmu_ds 9>,
> +			 <&ipmmu_ds 10>,
> +			 <&ipmmu_ds 11>,
> +			 <&ipmmu_ds 12>,
> +			 <&ipmmu_ds 13>,
> +			 <&ipmmu_ds 14>;
>  	};
>  
>  	dmac1: dma-controller@e6720000 {
> @@ -325,6 +340,21 @@
>  		power-domains = <&cpg_clocks>;
>  		#dma-cells = <1>;
>  		dma-channels = <15>;
> +		iommus = <&ipmmu_ds 15>,
> +			 <&ipmmu_ds 16>,
> +			 <&ipmmu_ds 17>,
> +			 <&ipmmu_ds 18>,
> +			 <&ipmmu_ds 19>,
> +			 <&ipmmu_ds 20>,
> +			 <&ipmmu_ds 21>,
> +			 <&ipmmu_ds 22>,
> +			 <&ipmmu_ds 23>,
> +			 <&ipmmu_ds 24>,
> +			 <&ipmmu_ds 25>,
> +			 <&ipmmu_ds 26>,
> +			 <&ipmmu_ds 27>,
> +			 <&ipmmu_ds 28>,
> +			 <&ipmmu_ds 29>;
>  	};
>  
>  	audma0: dma-controller@ec700000 {
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
