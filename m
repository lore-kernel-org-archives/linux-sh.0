From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 24 Sep 2013 16:12:29 +0000
Subject: Re: [PATCH 3/3] media: rcar_vin: Add RGB888_1X24 input format support
Message-Id: <Pine.LNX.4.64.1309241807260.22197@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-4-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-4-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 24 Sep 2013, Valentine Barshak wrote:

> This adds V4L2_MBUS_FMT_RGB888_1X24 input format support
> which is used by the ADV7612 chip.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  drivers/media/platform/soc_camera/rcar_vin.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
> index cf81e02..0f04cff 100644
> --- a/drivers/media/platform/soc_camera/rcar_vin.c
> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
> @@ -68,6 +68,7 @@
>  #define VNMC_INF_YUV8_BT656	(0 << 16)
>  #define VNMC_INF_YUV8_BT601	(1 << 16)
>  #define VNMC_INF_YUV16		(5 << 16)
> +#define VNMC_INF_RGB888		(6 << 16)
>  #define VNMC_VUP		(1 << 10)
>  #define VNMC_IM_ODD		(0 << 3)
>  #define VNMC_IM_ODD_EVEN	(1 << 3)
> @@ -235,7 +236,7 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
>  	struct soc_camera_device *icd = priv->ici.icd;
>  	struct rcar_vin_cam *cam = icd->host_priv;
>  	u32 vnmc, dmr, interrupts;
> -	bool progressive = false, output_is_yuv = false;
> +	bool progressive = false, output_is_yuv = false, input_is_yuv = false;
>  
>  	switch (priv->field) {
>  	case V4L2_FIELD_TOP:
> @@ -269,11 +270,17 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
>  	case V4L2_MBUS_FMT_YUYV8_1X16:
>  		/* BT.601/BT.1358 16bit YCbCr422 */
>  		vnmc |= VNMC_INF_YUV16;
> +		input_is_yuv = true;
>  		break;
>  	case V4L2_MBUS_FMT_YUYV8_2X8:
>  		/* BT.656 8bit YCbCr422 or BT.601 8bit YCbCr422 */
>  		vnmc |= priv->pdata->flags & RCAR_VIN_BT656 ?
>  			VNMC_INF_YUV8_BT656 : VNMC_INF_YUV8_BT601;
> +		input_is_yuv = true;
> +		break;
> +	case V4L2_MBUS_FMT_RGB888_1X24:
> +		vnmc |= VNMC_INF_RGB888;
> +		break;
>  	default:
>  		break;
>  	}

This is actually not related to this patch, but I just looked at the 
driver again - at the rcar_vin_setup() function, the

	/* output format */
	switch (icd->current_fmt->host_fmt->fourcc) {

selection. The default case of that switch statement returns an error, 
whereas the driver claims to support a pass-through mode. That looks like 
a ubg to me, but it should be fixed in a separate patch.

Thanks
Guennadi

> @@ -316,7 +323,7 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
>  	vnmc |= VNMC_VUP;
>  
>  	/* If input and output use the same colorspace, use bypass mode */
> -	if (output_is_yuv)
> +	if (input_is_yuv = output_is_yuv)
>  		vnmc |= VNMC_BPS;
>  
>  	/* progressive or interlaced mode */
> @@ -1002,6 +1009,7 @@ static int rcar_vin_get_formats(struct soc_camera_device *icd, unsigned int idx,
>  	switch (code) {
>  	case V4L2_MBUS_FMT_YUYV8_1X16:
>  	case V4L2_MBUS_FMT_YUYV8_2X8:
> +	case V4L2_MBUS_FMT_RGB888_1X24:
>  		if (cam->extra_fmt)
>  			break;
>  
> -- 
> 1.8.3.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
