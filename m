From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 08 Dec 2015 10:59:20 +0000
Subject: Re: [PATCH v2 4/9] i2c: rcar: switch to i2c generic dt parsing
Message-Id: <1449572360.30729.31.camel@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
	 <1449567473-2084-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449567473-2084-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Tue, 2015-12-08 at 10:37 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Switch to the new generic functions. Plain convert, no functionality
> added yet.

One style nitpick.

> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-
> rcar.c
> index d4322a9096786f..c663f4389bf898 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -162,12 +162,15 @@ static int rcar_i2c_bus_barrier(struct
> rcar_i2c_priv *priv)
>  	return -EBUSY;
>  }
>  
> -static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, u32
> bus_speed)
> +static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
> struct i2c_timings *t)
>  {
>  	u32 scgd, cdf, round, ick, scl, cdf_width;
>  	unsigned long rate;
>  	struct device *dev = rcar_i2c_priv_to_dev(priv);
>  
> +	/* Fall back to previously used values if not supplied */
> +	t->bus_freq_hz = t->bus_freq_hz ?: 100000;

On one hand it seems enough space to put one more t->bus_freq_hz, on
the other why not

if (!t->bus_freq_hz)
  = 100000;

I think a bit better to maintain latter.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

