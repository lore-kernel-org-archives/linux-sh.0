From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 22 Apr 2014 16:39:06 +0000
Subject: Re: [PATCH] sh-pfc: r8a7790: Fix definition of IPSR5
Message-Id: <2172750.fMdy2nvht6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398180483-10651-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1398180483-10651-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
Cc: Linus Walleij <linus.walleij@linaro.org>, Guido Piasenza <gpiasenza@soft-in.com>, Linux-SH <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Phil,

Thank you for the patch.

On Tuesday 22 April 2014 16:28:03 Phil Edworthy wrote:
> From: Guido Piasenza <gpiasenza@soft-in.com>
> 
> The extra entry in the table makes SCIFA0_B, and all peripherals after it,
> fail.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 4809371..dbf2ef9 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -4795,7 +4795,7 @@ static const struct pinmux_cfg_reg
> pinmux_config_regs[] = { /* IP5_23_21 [3] */
>  		FN_WE1_N, FN_IERX, FN_CAN1_RX, FN_VI1_G4,
>  		FN_VI1_G4_B, FN_VI2_R6, FN_SCIFA0_CTS_N_B,
> -		FN_IERX_C, 0,
> +		FN_IERX_C,

I would have put that last entry at the end of the previous line, to have four 
entries on both lines.

>  		/* IP5_20_18 [3] */
>  		FN_WE0_N, FN_IECLK, FN_CAN_CLK,
>  		FN_VI2_VSYNC_N, FN_SCIFA0_TXD_B, FN_VI2_VSYNC_N_B, 0, 0,

-- 
Regards,

Laurent Pinchart

