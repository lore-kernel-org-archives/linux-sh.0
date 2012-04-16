From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Apr 2012 01:55:04 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: sh7372 CEU supports up to 8188x8188 images
Message-Id: <20120416015504.GA15753@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1203141600210.25284@axis700.grange>
 <Pine.LNX.4.64.1203141601060.25284@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1203141601060.25284@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org

On Wed, Mar 14, 2012 at 04:02:24PM +0100, Guennadi Liakhovetski wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
> 
> This patch we can push some time after the first one in this series gets 
> in, no breakage is caused.
> 
>  arch/arm/mach-shmobile/board-ap4evb.c   |    2 ++
>  arch/arm/mach-shmobile/board-mackerel.c |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index aab0a34..f67aa03 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -1009,6 +1009,8 @@ static struct sh_mobile_ceu_companion csi2 = {
>  
>  static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
>  	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
> +	.max_width = 8188,
> +	.max_height = 8188,
>  	.csi2 = &csi2,
>  };
>  
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index 9b42fbd..f790772 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -1270,6 +1270,8 @@ static void mackerel_camera_del(struct soc_camera_device *icd)
>  
>  static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
>  	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
> +	.max_width = 8188,
> +	.max_height = 8188,
>  };
>  
>  static struct resource ceu_resources[] = {
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
