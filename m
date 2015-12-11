From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 11 Dec 2015 18:15:18 +0000
Subject: Re: [PATCH 3/3] media: adv7604: update timings on change of input signal
Message-Id: <566B12B6.6020408@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449849893-14865-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1449849893-14865-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1449849893-14865-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, lars@metafoo.de, william.towle@codethink.co.uk

Hello.

On 12/11/2015 07:04 PM, Ulrich Hecht wrote:

> Without this, g_crop will always return the boot-time state.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>   drivers/media/i2c/adv7604.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
> index 1bfa9f3..d7d0bb7 100644
> --- a/drivers/media/i2c/adv7604.c
> +++ b/drivers/media/i2c/adv7604.c
> @@ -1975,6 +1975,15 @@ static int adv76xx_isr(struct v4l2_subdev *sd, u32 status, bool *handled)
>
>   		v4l2_subdev_notify_event(sd, &adv76xx_ev_fmt);
>
> +		/* update timings */
> +		if (adv76xx_query_dv_timings(sd, &state->timings)
> +		    = -ENOLINK) {

    Please don't put the binary operators on the continuation line, leave them 
at the end of he broken up line.

[...]

MBR, Sergei

