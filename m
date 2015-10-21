From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Oct 2015 23:10:52 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <131418014.1WnDGNUZcn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de> <1441311613-2681-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1441311613-2681-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Wolfram,

On Thursday 03 September 2015 22:20:09 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Setting up new messages was done in process context while handling a
> message was in interrupt context. Because of the HW design, this IP core
> is sensitive to timing, so the context switches were too expensive. Move
> this setup to interrupt context as well.
> 
> In my test setup, this fixed the occasional 'data byte sent twice' issue
> which a number of people have seen. It also fixes to send REP_START
> after a read message which was wrongly send as a STOP + START sequence
> before.

I'm afraid this patch has been found by git bisect to break HDMI on Koelsch 
:-( 

The regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val) call in 
drivers/gpu/drm/i2c/adv7511.c returns -ENXIO.

Reverting the patch on top of Geert's current drivers master branch fixes the 
problem.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 74 +++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 6e459a338ccc75..36c79301044b71 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -266,6 +266,13 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv
> *priv) rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
> }
> 
> +static void rcar_i2c_next_msg(struct rcar_i2c_priv *priv)
> +{
> +	priv->msg++;
> +	priv->msgs_left--;
> +	rcar_i2c_prepare_msg(priv);
> +}
> +
>  /*
>   *		interrupt functions
>   */
> @@ -308,21 +315,17 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv
> *priv, u32 msr) * [ICRXTX] -> [SHIFT] -> [I2C bus]
>  		 */
> 
> -		if (priv->flags & ID_LAST_MSG)
> +		if (priv->flags & ID_LAST_MSG) {
>  			/*
>  			 * If current msg is the _LAST_ msg,
>  			 * prepare stop condition here.
>  			 * ID_DONE will be set on STOP irq.
>  			 */
>  			rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
> -		else
> -			/*
> -			 * If current msg is _NOT_ last msg,
> -			 * it doesn't call stop phase.
> -			 * thus, there is no STOP irq.
> -			 * return ID_DONE here.
> -			 */
> -			return ID_DONE;
> +		} else {
> +			rcar_i2c_next_msg(priv);
> +			return 0;
> +		}
>  	}
> 
>  	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_SEND);
> @@ -366,7 +369,10 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv
> *priv, u32 msr) else
>  		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
> 
> -	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
> +	if (priv->pos = msg->len && !(priv->flags & ID_LAST_MSG))
> +		rcar_i2c_next_msg(priv);
> +	else
> +		rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
> 
>  	return 0;
>  }
> @@ -461,6 +467,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
> 
>  	/* Stop */
>  	if (msr & MST) {
> +		priv->msgs_left--; /* The last message also made it */
>  		rcar_i2c_flags_set(priv, ID_DONE);
>  		goto out;
>  	}
> @@ -500,35 +507,28 @@ static int rcar_i2c_master_xfer(struct i2c_adapter
> *adap, /* This HW can't send STOP after address phase */
>  		if (msgs[i].len = 0) {
>  			ret = -EOPNOTSUPP;
> -			break;
> -		}
> -
> -		/* init each data */
> -		priv->msg = &msgs[i];
> -		priv->msgs_left = num - i;
> -
> -		rcar_i2c_prepare_msg(priv);
> -
> -		time_left = wait_event_timeout(priv->wait,
> -					     rcar_i2c_flags_has(priv, ID_DONE),
> -					     adap->timeout);
> -		if (!time_left) {
> -			rcar_i2c_init(priv);
> -			ret = -ETIMEDOUT;
> -			break;
> -		}
> -
> -		if (rcar_i2c_flags_has(priv, ID_NACK)) {
> -			ret = -ENXIO;
> -			break;
> -		}
> -
> -		if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
> -			ret = -EAGAIN;
> -			break;
> +			goto out;
>  		}
> +	}
> 
> -		ret = i + 1; /* The number of transfer */
> +	/* init data */
> +	priv->msg = msgs;
> +	priv->msgs_left = num;
> +
> +	rcar_i2c_prepare_msg(priv);
> +
> +	time_left = wait_event_timeout(priv->wait,
> +				     rcar_i2c_flags_has(priv, ID_DONE),
> +				     num * adap->timeout);
> +	if (!time_left) {
> +		rcar_i2c_init(priv);
> +		ret = -ETIMEDOUT;
> +	} else if (rcar_i2c_flags_has(priv, ID_NACK)) {
> +		ret = -ENXIO;
> +	} else if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
> +		ret = -EAGAIN;
> +	} else {
> +		ret = num - priv->msgs_left; /* The number of transfer */
>  	}
>  out:
>  	pm_runtime_put(dev);

-- 
Regards,

Laurent Pinchart

