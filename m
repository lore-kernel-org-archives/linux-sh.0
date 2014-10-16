From: Simon Horman <horms@verge.net.au>
Date: Thu, 16 Oct 2014 05:25:32 +0000
Subject: Re: [PATCH] media: soc_camera: rcar_vin: Enable VSYNC field toggle mode
Message-Id: <20141016052531.GJ1265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1413267956-8342-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1413267956-8342-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>

[CC Mauro Carvalho Chehab]

On Tue, Oct 14, 2014 at 03:25:56PM +0900, Yoshihiro Kaneko wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> 
> By applying this patch, it sets to VSYNC field toggle mode not only
> at the time of progressive mode but at the time of an interlace mode.
> 
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

If the series needs reposting to a different CC list -
e.g. including Mauro - please let Kaneko-san or myself know.

> ---
> 
> This patch is against master branch of linuxtv.org/media_tree.git.
> 
>  drivers/media/platform/soc_camera/rcar_vin.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
> index 5196c81..bf97ed6 100644
> --- a/drivers/media/platform/soc_camera/rcar_vin.c
> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
> @@ -108,6 +108,7 @@
>  #define VNDMR2_VPS		(1 << 30)
>  #define VNDMR2_HPS		(1 << 29)
>  #define VNDMR2_FTEV		(1 << 17)
> +#define VNDMR2_VLV_1		(1 << 12)
>  
>  #define VIN_MAX_WIDTH		2048
>  #define VIN_MAX_HEIGHT		2048
> @@ -828,7 +829,7 @@ static int rcar_vin_set_bus_param(struct soc_camera_device *icd)
>  	if (ret < 0 && ret != -ENOIOCTLCMD)
>  		return ret;
>  
> -	val = priv->field = V4L2_FIELD_NONE ? VNDMR2_FTEV : 0;
> +	val = VNDMR2_FTEV | VNDMR2_VLV_1;
>  	if (!(common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW))
>  		val |= VNDMR2_VPS;
>  	if (!(common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW))
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
