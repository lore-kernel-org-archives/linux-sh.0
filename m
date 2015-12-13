From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 18:30:33 +0000
Subject: Re: [PATCH 3/3] media: adv7604: update timings on change of input signal
Message-Id: <3320423.YrUk0MXGBk@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1449849893-14865-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1449849893-14865-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1449849893-14865-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, lars@metafoo.de, william.towle@codethink.co.uk

Hi Ulrich,

Thank you for the patch.

On Friday 11 December 2015 17:04:53 Ulrich Hecht wrote:
> Without this, g_crop will always return the boot-time state.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/media/i2c/adv7604.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
> index 1bfa9f3..d7d0bb7 100644
> --- a/drivers/media/i2c/adv7604.c
> +++ b/drivers/media/i2c/adv7604.c
> @@ -1975,6 +1975,15 @@ static int adv76xx_isr(struct v4l2_subdev *sd, u32
> status, bool *handled)
> 
>  		v4l2_subdev_notify_event(sd, &adv76xx_ev_fmt);
> 
> +		/* update timings */
> +		if (adv76xx_query_dv_timings(sd, &state->timings)
> +		    = -ENOLINK) {

Nitpicking, I would write this as

		ret = adv76xx_query_dv_timings(sd, &state->timings);
		if (ret = -ENOLINK) {

to make it more explicit that the function has side effects. Functions called 
inside an if () statement are often assumed (at least by me) to perform checks 
only and not modify their parameters.

> +			/* no signal, fall back to default timings */
> +			const struct v4l2_dv_timings cea640x480 > +				V4L2_DV_BT_CEA_640X480P59_94;
> +			state->timings = cea640x480;

You can write this as

			state->timings = (struct v4l2_dv_timings)
				V4L2_DV_BT_CEA_640X480P59_94;

without using a local variable.

(And now that I mention that I wonder whether the definition of 
V4L2_DV_BT_CEA_640X480P59_94 should be updated to include the (struct 
v4l2_dv_timings))

> +		}
> +
>  		if (handled)
>  			*handled = true;
>  	}

-- 
Regards,

Laurent Pinchart

