From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 07:51:17 +0000
Subject: Re: [PATCH 1/2] sh-pfc: Share common PORTCR macro definition
Message-Id: <20131128075116.GI24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385430334-12141-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385430334-12141-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 26, 2013 at 02:45:33AM +0100, Laurent Pinchart wrote:
> The macro is defined identically in four different locations. Share it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 11 -----------
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 11 -----------
>  drivers/pinctrl/sh-pfc/pfc-sh7372.c  | 11 -----------
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 10 ----------
>  drivers/pinctrl/sh-pfc/sh_pfc.h      |  3 +--
>  5 files changed, 1 insertion(+), 45 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> index d25fd4e..d76cc34 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> @@ -2061,17 +2061,6 @@ static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(sdhi2),
>  };
>  
> -#undef PORTCR
> -#define PORTCR(nr, reg)							\
> -	{								\
> -		PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
> -			_PCRH(PORT##nr##_IN, 0, 0, PORT##nr##_OUT),	\
> -				PORT##nr##_FN0, PORT##nr##_FN1,		\
> -				PORT##nr##_FN2, PORT##nr##_FN3,		\
> -				PORT##nr##_FN4, PORT##nr##_FN5,		\
> -				PORT##nr##_FN6, PORT##nr##_FN7 }	\
> -	}
> -
>  static const struct pinmux_cfg_reg pinmux_config_regs[] = {
>  	PORTCR(0, 0xe6050000),
>  	PORTCR(1, 0xe6050001),
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> index 009174d..7ac0065 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -3234,17 +3234,6 @@ static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(tpu0),
>  };
>  
> -#undef PORTCR
> -#define PORTCR(nr, reg)							\
> -	{								\
> -		PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
> -			_PCRH(PORT##nr##_IN, 0, 0, PORT##nr##_OUT),	\
> -				PORT##nr##_FN0, PORT##nr##_FN1,		\
> -				PORT##nr##_FN2, PORT##nr##_FN3,		\
> -				PORT##nr##_FN4, PORT##nr##_FN5,		\
> -				PORT##nr##_FN6, PORT##nr##_FN7 }	\
> -	}
> -
>  static const struct pinmux_cfg_reg pinmux_config_regs[] = {
>  	PORTCR(0,	0xe6050000), /* PORT0CR */
>  	PORTCR(1,	0xe6050001), /* PORT1CR */
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
> index 70b522d..4fea6ce 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
> @@ -2118,17 +2118,6 @@ static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(usb1),
>  };
>  
> -#undef PORTCR
> -#define PORTCR(nr, reg)							\
> -	{								\
> -		PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
> -			_PCRH(PORT##nr##_IN, 0, 0, PORT##nr##_OUT),     \
> -				PORT##nr##_FN0, PORT##nr##_FN1,		\
> -				PORT##nr##_FN2, PORT##nr##_FN3,		\
> -				PORT##nr##_FN4, PORT##nr##_FN5,		\
> -				PORT##nr##_FN6, PORT##nr##_FN7 }	\
> -	}
> -
>  static const struct pinmux_cfg_reg pinmux_config_regs[] = {
>  	PORTCR(0,	0xE6051000), /* PORT0CR */
>  	PORTCR(1,	0xE6051001), /* PORT1CR */
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> index 7e278a9..b81b56e 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> @@ -3138,16 +3138,6 @@ static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(usb),
>  };
>  
> -#undef PORTCR
> -#define PORTCR(nr, reg)							\
> -	{								\
> -		PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
> -			_PCRH(PORT##nr##_IN, 0, 0, PORT##nr##_OUT),	\
> -				PORT##nr##_FN0, PORT##nr##_FN1,		\
> -				PORT##nr##_FN2, PORT##nr##_FN3,		\
> -				PORT##nr##_FN4, PORT##nr##_FN5,		\
> -				PORT##nr##_FN6, PORT##nr##_FN7 }	\
> -	}
>  static const struct pinmux_cfg_reg pinmux_config_regs[] = {
>  	PORTCR(0, 0xe6050000), /* PORT0CR */
>  	PORTCR(1, 0xe6050001), /* PORT1CR */
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
> index 11bd0d9..8a494e5 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -304,8 +304,7 @@ struct sh_pfc_soc_info {
>  #define PORTCR(nr, reg)							\
>  	{								\
>  		PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
> -			_PCRH(PORT##nr##_IN, PORT##nr##_IN_PD,		\
> -			      PORT##nr##_IN_PU, PORT##nr##_OUT),	\
> +			_PCRH(PORT##nr##_IN, 0, 0, PORT##nr##_OUT),	\
>  				PORT##nr##_FN0, PORT##nr##_FN1,		\
>  				PORT##nr##_FN2, PORT##nr##_FN3,		\
>  				PORT##nr##_FN4, PORT##nr##_FN5,		\
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
