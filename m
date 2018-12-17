From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:46:23 +0000
Subject: Re: [PATCH 11/15] pinctrl: sh-pfc: Print actual field width for variable-width fields
Message-Id: <20181217144618.a6omxq2y4acydp75@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-12-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-12-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:10PM +0100, Geert Uytterhoeven wrote:
> The debug code in sh_pfc_write_config_reg() prints the width of the
> field being modified.
> 
> However, registers with a variable-width field layout are identified by
> pinmux_cfg_reg.field_width being zero, hence zeroes are printed instead
> of the actual field widths.
> 
> Fix this by printing the Hamming height of the field mask instead, which
> is correct for both fixed-width and variable-width fields.

s/height/width ?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pinctrl/sh-pfc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index a10f7050a74f35ff..f1cfcc8c65446662 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -221,7 +221,7 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
>  
>  	dev_dbg(pfc->dev, "write_reg addr = %x, value = 0x%x, field = %u, "
>  		"r_width = %u, f_width = %u\n",
> -		crp->reg, value, field, crp->reg_width, crp->field_width);
> +		crp->reg, value, field, crp->reg_width, hweight32(mask));
>  
>  	mask = ~(mask << pos);
>  	value = value << pos;
> -- 
> 2.17.1
> 
