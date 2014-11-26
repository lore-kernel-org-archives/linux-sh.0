From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Nov 2014 22:01:07 +0000
Subject: Re: [PATCH 4/5] drm/rcar-du: fix error return code
Message-Id: <2892924.lmSyP4ZfXU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1416748278-22881-1-git-send-email-Julia.Lawall@lip6.fr> <1416748278-22881-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1416748278-22881-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Julia,

Thank you for the patch.

On Sunday 23 November 2014 14:11:17 Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Propagate the error code on failure.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> 
> ret = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've applied the patch to my tree and sent a pull request.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c index 088bfd8..23cc910 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -586,7 +586,7 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp,
> unsigned int index)
> 
>  	if (irq < 0) {
>  		dev_err(rcdu->dev, "no IRQ for CRTC %u\n", index);
> -		return ret;
> +		return irq;
>  	}
> 
>  	ret = devm_request_irq(rcdu->dev, irq, rcar_du_crtc_irq, irqflags,

-- 
Regards,

Laurent Pinchart

