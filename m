From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 05 Mar 2015 09:03:23 +0000
Subject: Re: [PATCH 2/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <12083025.CFMfs0EISD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be> <1425058685-12956-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425058685-12956-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 27 February 2015 18:38:03 Geert Uytterhoeven wrote:
> Register and field widths are in the range 1..32. Storing them in the
> pinctrl data in (arrays of) unsigned long wastes space.
> 
> This decreases the size of a (32-bit) shmobile_defconfig kernel
> supporting 7 SoCs by 26460 bytes.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pinctrl/sh-pfc/core.c   |  2 +-
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index a56280814a3f884b..466b899ec78b15d7 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -210,7 +210,7 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
>  	sh_pfc_config_reg_helper(pfc, crp, field, &mapped_reg, &mask, &pos);
> 
>  	dev_dbg(pfc->dev, "write_reg addr = %lx, value = %ld, field = %ld, "
> -		"r_width = %ld, f_width = %ld\n",
> +		"r_width = %u, f_width = %u\n",
>  		crp->reg, value, field, crp->reg_width, crp->field_width);
> 
>  	mask = ~(mask << pos);
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index ed5cf4192fa1a2d0..6aeec8152ea674cf
> 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -69,9 +69,10 @@ struct pinmux_func {
>  };
> 
>  struct pinmux_cfg_reg {
> -	unsigned long reg, reg_width, field_width;
> +	unsigned long reg;

How about making reg a u32 ? It won't make a difference in practice on 32-bit 
systems, but it would be more explicit.

We could also save space by making reg a u16 and storing the register offset 
only instead of the full address (assuming it can always fit in 16 bits, which 
should be checked). We'll also need to support 64-bit systems at some point, 
and making reg a u64 would increase space waste.

> +	u8 reg_width, field_width;
>  	const u16 *enum_ids;
> -	const unsigned long *var_field_width;
> +	const u8 *var_field_width;
>  };
> 
>  #define PINMUX_CFG_REG(name, r, r_width, f_width) \
> @@ -80,12 +81,13 @@ struct pinmux_cfg_reg {
> 
>  #define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
>  	.reg = r, .reg_width = r_width,	\
> -	.var_field_width = (const unsigned long [r_width]) \
> +	.var_field_width = (const u8 [r_width]) \
>  		{ var_fw0, var_fwn, 0 }, \
>  	.enum_ids = (const u16 [])
> 
>  struct pinmux_data_reg {
> -	unsigned long reg, reg_width;
> +	unsigned long reg;
> +	u8 reg_width;
>  	const u16 *enum_ids;
>  };

-- 
Regards,

Laurent Pinchart

