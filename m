From: Simon Horman <horms@verge.net.au>
Date: Tue, 20 Oct 2015 01:41:54 +0000
Subject: Re: [PATCH/RFT 2/7] media: soc_camera pad-aware driver initialisation
Message-Id: <20151020014154.GB13721@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1445263660-6945-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1445263660-6945-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 19, 2015 at 04:07:35PM +0200, Ulrich Hecht wrote:
> From: William Towle <william.towle@codethink.co.uk>
> 
> Add detection of source pad number for drivers aware of the media
> controller API, so that the combination of soc_camera and rcar_vin
> can create device nodes to support modern drivers such as adv7604.c
> (for HDMI on Lager) and the converted adv7180.c (for composite)
> underneath.
> 
> Building rcar_vin gains a dependency on CONFIG_MEDIA_CONTROLLER, in
> line with requirements for building the drivers associated with it.
> 
> Signed-off-by: William Towle <william.towle@codethink.co.uk>
> Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>

[snip]

> diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
> index 9087fed..fa459c0 100644
> --- a/drivers/media/platform/soc_camera/soc_camera.c
> +++ b/drivers/media/platform/soc_camera/soc_camera.c
> @@ -1303,6 +1303,10 @@ static int soc_camera_probe_finish(struct soc_camera_device *icd)
>  		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>  	};
>  	struct v4l2_mbus_framefmt *mf = &fmt.format;
> +#if defined(CONFIG_MEDIA_CONTROLLER)
> +	struct media_pad pad;
> +	int pad_idx;
> +#endif
>  	int ret;
>  
>  	sd->grp_id = soc_camera_grp_id(icd);
> @@ -1321,9 +1325,23 @@ static int soc_camera_probe_finish(struct soc_camera_device *icd)
>  	}
>  
>  	/* At this point client .probe() should have run already */
> +	icd->src_pad_idx = 0;
> +#if defined(CONFIG_MEDIA_CONTROLLER)
> +	for (pad_idx = 0; pad_idx < sd->entity.num_pads; pad_idx++)
> +		if (sd->entity.pads[pad_idx].flags
> +				= MEDIA_PAD_FL_SOURCE)
> +			break;
> +	if (pad_idx >= sd->entity.num_pads)
> +		goto eusrfmt;
> +
> +	icd->src_pad_idx = pad_idx;
> +#endif

I wonder if the #ifdefs above could be migrated to
a new function that has a dummy implementation for the not case.
I suspect the result would be a bit cleaner.

> +
>  	ret = soc_camera_init_user_formats(icd);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		icd->src_pad_idx = -1;
>  		goto eusrfmt;
> +	}
>  
>  	icd->field = V4L2_FIELD_ANY;
>  

[snip]
