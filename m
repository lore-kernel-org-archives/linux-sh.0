From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Feb 2013 12:27:51 +0000
Subject: Re: [PATCH] sh-pfc: sh_pfc_probe() sizeof() fix
Message-Id: <8102667.Xm2M9ilSOB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130214122347.20778.10789.sendpatchset@w520>
In-Reply-To: <20130214122347.20778.10789.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 14 February 2013 21:23:47 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Fix sizeof() usage in sh-pfc/core.c to allocate space
> for the full data structure instead of a pointer.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Forgot to add my

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  Written against -next in renesas.git
> 
>  drivers/pinctrl/sh-pfc/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0001/drivers/pinctrl/sh-pfc/core.c
> +++ work/drivers/pinctrl/sh-pfc/core.c	2013-02-14 21:04:20.000000000 +0900
> @@ -495,7 +495,7 @@ static int sh_pfc_probe(struct platform_
>  	if (info = NULL)
>  		return -ENODEV;
> 
> -	pfc = devm_kzalloc(&pdev->dev, sizeof(pfc), GFP_KERNEL);
> +	pfc = devm_kzalloc(&pdev->dev, sizeof(*pfc), GFP_KERNEL);
>  	if (pfc = NULL)
>  		return -ENOMEM;
-- 
Regards,

Laurent Pinchart

