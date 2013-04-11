From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Apr 2013 03:00:20 +0000
Subject: Re: [PATCH/RFC 6/6] ARM: shmobile: kzm9g-reference: add DMA channels to the MMCIF DT
Message-Id: <20130411030020.GF21037@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
 <1365632389-2249-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1365632389-2249-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Thu, Apr 11, 2013 at 12:19:49AM +0200, Guennadi Liakhovetski wrote:
> The MMCIF driver can use DMA for data transfer, add suitable
> Device Tree bindings.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi Guennadi, this seems reasonable to me.

I guess the best thing is for you to repost it once the pre-requisites
are in place.

> ---
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index ed9dd45..e1d0d5d 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -156,6 +156,9 @@
>  	bus-width = <8>;
>  	vmmc-supply = <&reg_1p8v>;
>  	status = "okay";
> +	dmas = <&dma0 0xd1
> +		&dma0 0xd2>;
> +	dma-names = "tx", "rx";
>  };
>  
>  &sdhi0 {
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
