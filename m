From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Apr 2013 23:55:11 +0000
Subject: Re: [PATCH v2] sh-pfc: r8a7778: Fix outdated GPIO_FN comments
Message-Id: <87ip3cx0o3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1366715285-5963-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366715285-5963-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> Function GPIOs have been removed, remove comments that refer to them.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> index b1925cc..72f7a3c 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -376,19 +376,19 @@ enum {
>  	AVS1_MARK,
>  	AVS2_MARK,
>  
> -	VI0_R0_C_MARK,  /* see GPIO_FN_VI0_R0_A */
> -	VI0_R1_C_MARK,  /* see GPIO_FN_VI0_R1_A */
> -	VI0_R2_C_MARK,  /* see GPIO_FN_VI0_R2_A */
> -	/* VI0_R3_C_MARK,  see GPIO_FN_VI0_R3_A */
> -	VI0_R4_C_MARK,  /* see GPIO_FN_VI0_R4_A */
> -	VI0_R5_C_MARK,  /* see GPIO_FN_VI0_R5_A */
> -
> -	VI0_R0_D_MARK,  /* see GPIO_FN_VI0_R0_B */
> -	VI0_R1_D_MARK,  /* see GPIO_FN_VI0_R1_B */
> -	VI0_R2_D_MARK,  /* see GPIO_FN_VI0_R2_B */
> -	VI0_R3_D_MARK,  /* see GPIO_FN_VI0_R3_B */
> -	VI0_R4_D_MARK,  /* see GPIO_FN_VI0_R4_B */
> -	VI0_R5_D_MARK,  /* see GPIO_FN_VI0_R5_B */
> +	VI0_R0_C_MARK,		/* see sel_vi0 */
> +	VI0_R1_C_MARK,		/* see sel_vi0 */
> +	VI0_R2_C_MARK,		/* see sel_vi0 */
> +	/* VI0_R3_C_MARK, */
> +	VI0_R4_C_MARK,		/* see sel_vi0 */
> +	VI0_R5_C_MARK,		/* see sel_vi0 */
> +
> +	VI0_R0_D_MARK,		/* see sel_vi0 */
> +	VI0_R1_D_MARK,		/* see sel_vi0 */
> +	VI0_R2_D_MARK,		/* see sel_vi0 */
> +	VI0_R3_D_MARK,		/* see sel_vi0 */
> +	VI0_R4_D_MARK,		/* see sel_vi0 */
> +	VI0_R5_D_MARK,		/* see sel_vi0 */
>  
>  	/* IPSR0 */
>  	PRESETOUT_MARK,	PWM1_MARK,	AUDATA0_MARK,
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Best regards
---
Kuninori Morimoto
