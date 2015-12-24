From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 24 Dec 2015 11:42:40 +0000
Subject: Re: [PATCH v2 1/2] media: adv7604: implement get_selection
Message-Id: <2927121.d0aWWCy6Wl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1450794122-31293-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1450794122-31293-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1450794122-31293-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, lars@metafoo.de, william.towle@codethink.co.uk

Hi Ulrich,

Thank you for the patch.

On Tuesday 22 December 2015 15:22:01 Ulrich Hecht wrote:
> The rcar_vin driver relies on this.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/media/i2c/adv7604.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
> index be5980c..8ad5c28 100644
> --- a/drivers/media/i2c/adv7604.c
> +++ b/drivers/media/i2c/adv7604.c
> @@ -1885,6 +1885,26 @@ static int adv76xx_get_format(struct v4l2_subdev *sd,
> return 0;
>  }
> 
> +static int adv76xx_get_selection(struct v4l2_subdev *sd,
> +				 struct v4l2_subdev_pad_config *cfg,
> +				 struct v4l2_subdev_selection *sel)
> +{
> +	struct adv76xx_state *state = to_state(sd);
> +
> +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> +		return -EINVAL;
> +	/* Only CROP, CROP_DEFAULT and CROP_BOUNDS are supported */
> +	if (sel->target > V4L2_SEL_TGT_CROP_BOUNDS)
> +		return -EINVAL;
> +
> +	sel->r.left	= 0;
> +	sel->r.top	= 0;
> +	sel->r.width	= state->timings.bt.width;
> +	sel->r.height	= state->timings.bt.height;

This probably requires locking, but as the driver lacks locking support 
completely I can't blame you.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	return 0;
> +}
> +
>  static int adv76xx_set_format(struct v4l2_subdev *sd,
>  			      struct v4l2_subdev_pad_config *cfg,
>  			      struct v4l2_subdev_format *format)
> @@ -2415,6 +2435,7 @@ static const struct v4l2_subdev_video_ops
> adv76xx_video_ops = {
> 
>  static const struct v4l2_subdev_pad_ops adv76xx_pad_ops = {
>  	.enum_mbus_code = adv76xx_enum_mbus_code,
> +	.get_selection = adv76xx_get_selection,
>  	.get_fmt = adv76xx_get_format,
>  	.set_fmt = adv76xx_set_format,
>  	.get_edid = adv76xx_get_edid,

-- 
Regards,

Laurent Pinchart

