From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 05 Mar 2015 08:57:38 +0000
Subject: Re: [PATCH 1/4] pinctrl: sh-pfc: Do not overwrite bias configuration
Message-Id: <3714484.i8UOlazLrF@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be> <1425058685-12956-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425058685-12956-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 27 February 2015 18:38:02 Geert Uytterhoeven wrote:
> After the last user of the in_pd/in_pu bias parameters of the _PCRH()
> macro was removed in commit 80da8e02d22caaef ("sh-pfc: r8a7740: Add bias
> (pull-up/down) pinconf support"), bias parameters are supposed to be
> configured using the generic pinctl mechanism, which calls the
> .set_bias() method.
> 
> However, the PORTCR() macro still represents the control register as
> consisting of two 4-bit fields. Hence the bias configuration in the
> uppermost 2 bits is always overwritten with zeroes when a pin is
> configured for GPIO, disabling any previously configured bias.
> 
> Use the variable config register macro instead, to represent the
> register as having 4 fields, and to make sure only the input/output
> control and function fields are touched.
> 
> This affects R-Mobile APE6 (r8a73a4), R-Mobile A1 (r8a7740), SH-Mobile
> AP4 (sh7372), and SH-Mobile AG5 (sh73a0).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Tested on r8a73a4/ape6evm, which requires a pull-up bias for the
> GPIO switches.
> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index c83728626906c16c..ed5cf4192fa1a2d0
> 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -302,20 +302,21 @@ struct sh_pfc_soc_info {
>  /*
>   * PORTnCR macro
>   */
> -#define _PCRH(in, in_pd, in_pu, out)	\
> -	0, (out), (in), 0,		\
> -	0, 0, 0, 0,			\
> -	0, 0, (in_pd), 0,		\
> -	0, 0, (in_pu), 0
> -
>  #define PORTCR(nr, reg)							\
>  	{								\
> -		PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
> -			_PCRH(PORT##nr##_IN, 0, 0, PORT##nr##_OUT),	\
> -				PORT##nr##_FN0, PORT##nr##_FN1,		\
> -				PORT##nr##_FN2, PORT##nr##_FN3,		\
> -				PORT##nr##_FN4, PORT##nr##_FN5,		\
> -				PORT##nr##_FN6, PORT##nr##_FN7 }	\
> +		PINMUX_CFG_REG_VAR("PORT" nr "CR", reg, 8, 2, 2, 1, 3) {\
> +			/* PULMD[1:0], handled by .set_bias() */	\
> +			0, 0, 0, 0,					\
> +			/* IE and OE */					\
> +			0, PORT##nr##_OUT, PORT##nr##_IN, 0,		\
> +			/* SEC, not supported */			\
> +			0, 0,						\
> +			/* PTMD[2:0] */					\
> +			PORT##nr##_FN0, PORT##nr##_FN1,			\
> +			PORT##nr##_FN2, PORT##nr##_FN3,			\
> +			PORT##nr##_FN4, PORT##nr##_FN5,			\
> +			PORT##nr##_FN6, PORT##nr##_FN7			\
> +		}							\
>  	}
> 
>  #endif /* __SH_PFC_H */

-- 
Regards,

Laurent Pinchart

