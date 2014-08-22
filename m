From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 22 Aug 2014 23:54:34 +0000
Subject: Re: [PATCH 08/11] i2c: rcar: remove spinlock
Message-Id: <53F7D83A.5030903@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de> <1401263086-13720-9-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-9-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hello.

On 05/28/2014 11:44 AM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>

> The i2c core has per-adapter locks, so no need to protect again.

    The core's lock is unable to protect from the IRQs. So I'm proposing to 
revert this patch. It's a pity I hadn't noticed this issue when the patch was 
posted.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/i2c/busses/i2c-rcar.c | 22 ----------------------
>   1 file changed, 22 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index e82d64b5acef..4b088e67f2fd 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
[...]
> @@ -110,7 +109,6 @@ struct rcar_i2c_priv {
>   	struct i2c_msg	*msg;
>   	struct clk *clk;
>
> -	spinlock_t lock;

    Needed a comment (that it protects the I2C registers).

[...]
> @@ -462,21 +454,14 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
>   {
>   	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
>   	struct device *dev = rcar_i2c_priv_to_dev(priv);
> -	unsigned long flags;
>   	int i, ret, timeout;
>
>   	pm_runtime_get_sync(dev);
>
> -	/*-------------- spin lock -----------------*/
> -	spin_lock_irqsave(&priv->lock, flags);
> -
>   	rcar_i2c_init(priv);
>   	/* start clock */
>   	rcar_i2c_write(priv, ICCCR, priv->icccr);
>
> -	spin_unlock_irqrestore(&priv->lock, flags);
> -	/*-------------- spin unlock -----------------*/
> -

    I'm afraid this unlock is misplaced, the code continues to access the 
registers.

>   	ret = rcar_i2c_bus_barrier(priv);

    Should probably unlock here instead?

>   	if (ret < 0)
>   		goto out;

WBR, Sergei

