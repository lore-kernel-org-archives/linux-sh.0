From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 03:43:11 +0000
Subject: Re: [PATCH 1/2] sh-pfc: r8a7740: Fix pin bias setup
Message-Id: <20131205034311.GA20388@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385652004-7117-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385652004-7117-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Nov 28, 2013 at 04:20:03PM +0100, Laurent Pinchart wrote:
> When computing the pin configuration register offset the bias setup code
> erroneously compares the pin number range with the loop index instead of
> the pin number. Fix it.

this appears to be a bug-fix. If you haven't queued this up already
could you consider adding something like this to the changelog?
Likewise for "[2/2] sh-pfc: sh7372: Fix pin bias setup".

This resolves a problem that was added when bias pinconf support was added
by 80da8e02d22caaef ("sh-pfc: r8a7740: Add bias (pull-up/down) pinconf
support") in v3.10-rc3.

> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> index 009174d..bc5eb45 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -3720,7 +3720,7 @@ static void __iomem *r8a7740_pinmux_portcr(struct sh_pfc *pfc, unsigned int pin)
>  		const struct r8a7740_portcr_group *group >  			&r8a7740_portcr_offsets[i];
>  
> -		if (i <= group->end_pin)
> +		if (pin <= group->end_pin)
>  			return pfc->window->virt + group->offset + pin;
>  	}
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
