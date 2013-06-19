From: Simon Horman <horms@verge.net.au>
Date: Wed, 19 Jun 2013 12:23:49 +0000
Subject: Re: [PATCH] sh-pfc: Guard DT parsing with #ifdef CONFIG_OF
Message-Id: <20130619122349.GC32292@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371641162-18833-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1371641162-18833-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 19, 2013 at 01:26:02PM +0200, Laurent Pinchart wrote:
> Fix a compilation error caused by pinconf_generic_parse_dt_config() not
> being defined on !CONFIG_OF platforms by guarding the whole DT node
> parsing code with #ifdef CONFIG_OF.
> 
> Defining a pinconf_generic_parse_dt_config() on !CONFIG_OF would have
> been possible as well, but would have resulted in a larger code size on
> !CONFIG_OF platforms (such as arch/sh).
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/pinctrl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> This fixes a compilation error in the pinctrl next branch and should go to
> v3.11 through the pinctrl tree.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
> index 2cf2347..bc8b028 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -74,6 +74,7 @@ static void sh_pfc_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
>  	seq_printf(s, "%s", DRV_NAME);
>  }
>  
> +#ifdef CONFIG_OF
>  static int sh_pfc_map_add_config(struct pinctrl_map *map,
>  				 const char *group_or_pin,
>  				 enum pinctrl_map_type type,
> @@ -270,14 +271,17 @@ done:
>  
>  	return ret;
>  }
> +#endif /* CONFIG_OF */
>  
>  static const struct pinctrl_ops sh_pfc_pinctrl_ops = {
>  	.get_groups_count	= sh_pfc_get_groups_count,
>  	.get_group_name		= sh_pfc_get_group_name,
>  	.get_group_pins		= sh_pfc_get_group_pins,
>  	.pin_dbg_show		= sh_pfc_pin_dbg_show,
> +#ifdef CONFIG_OF
>  	.dt_node_to_map		= sh_pfc_dt_node_to_map,
>  	.dt_free_map		= sh_pfc_dt_free_map,
> +#endif
>  };
>  
>  static int sh_pfc_get_functions_count(struct pinctrl_dev *pctldev)
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
