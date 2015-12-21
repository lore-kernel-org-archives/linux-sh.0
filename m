From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 21 Dec 2015 20:46:07 +0000
Subject: Re: [PATCH 3/5] pinctrl: sh-pfc: add missing of_node_put
Message-Id: <8848273.KV8URmu3um@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr> <1450715988-4770-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1450715988-4770-4-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Julia,

Thank you for the patch.

On Monday 21 December 2015 17:39:46 Julia Lawall wrote:
> for_each_child_of_node performs an of_node_get on each iteration, so a
> goto out of the loop requires an of_node_put.
> 
> A simplified version of the semantic patch that fixes this problem is as
> follows (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> local idexpression n;
> expression e,e1;
> identifier l;
> @@
> 
>  for_each_child_of_node(e1,n) {
>    ...
> (
>    of_node_put(n);
> 
>    e = n
> 
>    return n;
> 
> +  of_node_put(n);
> ?  goto l;
> )
>    ...
>  }
> l: ... when != n
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/pinctrl.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c
> b/drivers/pinctrl/sh-pfc/pinctrl.c index 863c3e3..87b0a59 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -273,8 +273,10 @@ static int sh_pfc_dt_node_to_map(struct pinctrl_dev
> *pctldev, for_each_child_of_node(np, child) {
>  		ret = sh_pfc_dt_subnode_to_map(pctldev, child, map, num_maps,
>  					       &index);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			of_node_put(child);
>  			goto done;
> +		}
>  	}
> 
>  	/* If no mapping has been found in child nodes try the config node. */

-- 
Regards,

Laurent Pinchart

