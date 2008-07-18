From: Ben Dooks <ben-linux@fluff.org>
Date: Fri, 18 Jul 2008 08:04:57 +0000
Subject: Re: [PATCH 04/05] i2c-sh_mobile: IORESOURCE_CLK support
Message-Id: <20080718080457.GM24620@fluff.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20080718074002.32713.73442.sendpatchset@rx1.opensource.se> <20080718074036.32713.92629.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080718074036.32713.92629.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, gregkh@suse.de, lethal@linux-sh.org, i2c@lm-sensors.org, akpm@linux-foundation.org

On Fri, Jul 18, 2008 at 04:40:36PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch makes the i2c-sh_mobile driver get the clock name from the
> struct resource with type IORESOURCE_CLK provided by the platform data.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  drivers/i2c/busses/i2c-sh_mobile.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- 0001/drivers/i2c/busses/i2c-sh_mobile.c
> +++ work/drivers/i2c/busses/i2c-sh_mobile.c	2008-07-18 14:56:40.000000000 +0900
> @@ -390,13 +390,19 @@ static int sh_mobile_i2c_probe(struct pl
>  	int size;
>  	int ret;
>  
> +	res = platform_get_resource(dev, IORESOURCE_CLK, 0);
> +	if (res = NULL || res->name = NULL) {
> +		dev_err(&dev->dev, "cannot find CLK resource\n");
> +		return -ENOENT;
> +	}
> +
>  	pd = kzalloc(sizeof(struct sh_mobile_i2c_data), GFP_KERNEL);
>  	if (pd = NULL) {
>  		dev_err(&dev->dev, "cannot allocate private data\n");
>  		return -ENOMEM;
>  	}
>  
> -	pd->clk = clk_get(&dev->dev, "peripheral_clk");

I think that is working correctly and there isn't really any
need to change this. The clk_get is supplied the device that
it needs the clock for, and the name of the clock needed.

> +	pd->clk = clk_get(&dev->dev, res->name);
>  	if (IS_ERR(pd->clk)) {
>  		dev_err(&dev->dev, "cannot get peripheral clock\n");
>  		ret = PTR_ERR(pd->clk);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
