From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 28 Sep 2014 23:15:59 +0000
Subject: Re: [PATCH] i2c: rcar: remove sign-compare flaw
Message-Id: <1990855.9bK888YyIm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1411207657-23707-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1411207657-23707-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Wolfram,

Thank you for the patch.

On Saturday 20 September 2014 12:07:37 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> gcc rightfully says:
> 
> drivers/i2c/busses/i2c-rcar.c:198:10: warning: comparison between signed and
> unsigned integer expressions [-Wsign-compare]
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/i2c/busses/i2c-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 4c6fa78063fb..1eed463662c4 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -195,7 +195,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv
> *priv, */
>  	rate = clk_get_rate(priv->clk);
>  	cdf = rate / 20000000;
> -	if (cdf >= 1 << cdf_width) {
> +	if (cdf >= 1U << cdf_width) {
>  		dev_err(dev, "Input clock %lu too high\n", rate);
>  		return -EIO;
>  	}

-- 
Regards,

Laurent Pinchart

