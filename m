From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Sep 2013 06:46:05 +0000
Subject: Re: [RFC 04/10] i2c: rcar: modify I2C driver
Message-Id: <20130904064602.GA7233@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-5-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-5-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 30, 2013 at 02:37:38PM +0200, Ulrich Hecht wrote:
> From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> 
> This patch modify calculate for clock in I2C driver.

Hi,

could we have a slightly clearer subject for this patch.

> 
> Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 17 +++++++++++++++--
>  include/linux/i2c/i2c-rcar.h  |  4 ++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 0fc5858..c4fb69c 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -221,15 +221,28 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
>  				    struct device *dev)
>  {
>  	struct clk *clkp = clk_get(NULL, "peripheral_clk");
> +	struct i2c_rcar_platform_data *pdata = dev->platform_data;
>  	u32 scgd, cdf;
>  	u32 round, ick;
>  	u32 scl;
> +	u32 cdf_width;
> +	u32 flags = pdata ? pdata->flags : 0;
>  
>  	if (!clkp) {
>  		dev_err(dev, "there is no peripheral_clk\n");
>  		return -EIO;
>  	}
>  
> +	switch (flags & I2C_RCAR_FLAGS_ICCCR_MASK) {
> +	default:
> +	case I2C_RCAR_FLAGS_ICCCR_IS_2BIT:
> +		cdf_width = 2;
> +		break;
> +	case I2C_RCAR_FLAGS_ICCCR_IS_3BIT:
> +		cdf_width = 3;
> +		break;
> +	}
> +
>  	/*
>  	 * calculate SCL clock
>  	 * see
> @@ -245,7 +258,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
>  	 * clkp : peripheral_clk
>  	 * F[]  : integer up-valuation
>  	 */
> -	for (cdf = 0; cdf < 4; cdf++) {
> +	for (cdf = 0; cdf < (1 << cdf_width); cdf++) {
>  		ick = clk_get_rate(clkp) / (1 + cdf);
>  		if (ick < 20000000)
>  			goto ick_find;
> @@ -287,7 +300,7 @@ scgd_find:
>  	/*
>  	 * keep icccr value
>  	 */
> -	priv->icccr = (scgd << 2 | cdf);
> +	priv->icccr = (scgd << (cdf_width) | cdf);
>  
>  	return 0;
>  }
> diff --git a/include/linux/i2c/i2c-rcar.h b/include/linux/i2c/i2c-rcar.h
> index 496f5c2..572a6e5 100644
> --- a/include/linux/i2c/i2c-rcar.h
> +++ b/include/linux/i2c/i2c-rcar.h
> @@ -5,6 +5,10 @@
>  
>  struct i2c_rcar_platform_data {
>  	u32 bus_speed;
> +	u32 flags;
> +#define I2C_RCAR_FLAGS_ICCCR_MASK	(0xF << 0)
> +#define I2C_RCAR_FLAGS_ICCCR_IS_2BIT	(0 << 0) /* default */
> +#define I2C_RCAR_FLAGS_ICCCR_IS_3BIT	(1 << 0)
>  };
>  
>  #endif /* __I2C_R_CAR_H__ */
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
