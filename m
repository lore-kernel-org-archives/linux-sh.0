From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 23 Feb 2015 13:07:18 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Fix order of restart and clear status
Message-Id: <b0a6dd2b593f2f891946ef910c876b48@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1424011396-3492-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1424011396-3492-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi,

On 2015-02-15 15:43, Yoshihiro Kaneko wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>
> In case of repeated START condition, the restart has to be kicked
> before clear status (MSR register). If it is kicked after clear 
> status,
> R-Car I2C may transfer data (TXD register) or receive data (RXD 
> register)
> instead of transferring slave address (MAR register).
>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks for the patch!

I wondered if we couldn't always kick the start/restart before clearing 
the status register?
I am not sure if this simulates the flaw accurately, but I inserted a 
udelay(500)
in the original code after clearing the status register. Then, I 
couldn't access
the audio codec on my Lager board anymore. By always first "kicking" 
and then
clearing, access was possible again. But as said, I am not sure if my 
scenario
matches yours. Have you considered to treat start and repeated start 
the same
and always kick the condition before clearing the status?

Kind regards,

    Wolfram

> ---
>
> This patch is based on i2c/for-next branch of Wolfram Sang's linux 
> tree.
>
>  drivers/i2c/busses/i2c-rcar.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c 
> b/drivers/i2c/busses/i2c-rcar.c
> index 71a6e07..96c349f 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -2,6 +2,7 @@
>   * Driver for the Renesas RCar I2C unit
>   *
>   * Copyright (C) 2014 Wolfram Sang <wsa@sang-engineering.com>
> + * Copyright (C) 2013-2014 Renesas Electronics Corporation
>   *
>   * Copyright (C) 2012-14 Renesas Solutions Corp.
>   * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> @@ -99,6 +100,7 @@
>  #define ID_DONE		(1 << 2)
>  #define ID_ARBLOST	(1 << 3)
>  #define ID_NACK		(1 << 4)
> +#define ID_FIRST_MSG	(1 << 5)
>
>  enum rcar_i2c_type {
>  	I2C_RCAR_GEN1,
> @@ -125,6 +127,7 @@ struct rcar_i2c_priv {
>  #define rcar_i2c_is_recv(p)		((p)->msg->flags & I2C_M_RD)
>
>  #define rcar_i2c_flags_set(p, f)	((p)->flags |= (f))
> +#define rcar_i2c_flags_clr(p, f)	((p)->flags &= ~(f))
>  #define rcar_i2c_flags_has(p, f)	((p)->flags & (f))
>
>  #define LOOP_TIMEOUT	1024
> @@ -257,8 +260,14 @@ static void rcar_i2c_prepare_msg(struct
> rcar_i2c_priv *priv)
>  	int read = !!rcar_i2c_is_recv(priv);
>
>  	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
> -	rcar_i2c_write(priv, ICMSR, 0);
> -	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
> +	if (rcar_i2c_flags_has(priv, ID_FIRST_MSG)) {	/* start */
> +		rcar_i2c_write(priv, ICMSR, 0);
> +		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
> +		rcar_i2c_flags_clr(priv, ID_FIRST_MSG);
> +	} else {	/* restart */
> +		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
> +		rcar_i2c_write(priv, ICMSR, 0);
> +	}
>  	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
>  }
>
> @@ -524,6 +533,8 @@ static int rcar_i2c_master_xfer(struct 
> i2c_adapter *adap,
>  		priv->msg	= &msgs[i];
>  		priv->pos	= 0;
>  		priv->flags	= 0;
> +		if (i = 0)
> +			rcar_i2c_flags_set(priv, ID_FIRST_MSG);
>  		if (i = num - 1)
>  			rcar_i2c_flags_set(priv, ID_LAST_MSG);

