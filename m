From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 07:51:41 +0000
Subject: Re: [PATCH 2/2] sh-pfc: Fix PINMUX_GPIO macro
Message-Id: <20131128075141.GJ24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385430334-12141-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385430334-12141-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 26, 2013 at 02:45:34AM +0100, Laurent Pinchart wrote:
> Commit 7cbb0e55e27e ("sh-pfc: Don't duplicate argument to PINMUX_GPIO
> macro") erronesouly modified the PINMUX_GPIO macro in a way that
> resulted in all pins being named "name". Fix the macro to name the pins
> correctly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
> index 8a494e5..463ef21 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -254,7 +254,7 @@ struct sh_pfc_soc_info {
>  #define PINMUX_GPIO(_pin)						\
>  	[GPIO_##_pin] = {						\
>  		.pin = (u16)-1,						\
> -		.name = __stringify(name),				\
> +		.name = __stringify(GPIO_##_pin),			\
>  		.enum_id = _pin##_DATA,					\
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
