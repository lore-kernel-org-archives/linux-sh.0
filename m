From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 06 May 2015 16:26:07 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7740: Fix typo SCIFAB in comment
Message-Id: <1630235.T45TlTl3Ab@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1430750446-8302-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430750446-8302-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 04 May 2015 16:40:46 Geert Uytterhoeven wrote:
> The last serial port is called "SCIFB", not "SCIFAB".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index
> b486e9d20cc2f7cb..d0bb1459783a16d2 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -258,7 +258,7 @@ enum {
>  	/* SCIFA7 */
>  	SCIFA7_TXD_MARK,	SCIFA7_RXD_MARK,
> 
> -	/* SCIFAB */
> +	/* SCIFB */
>  	SCIFB_SCK_PORT190_MARK, /* MSEL5CR_17_0 */
>  	SCIFB_RXD_PORT191_MARK,
>  	SCIFB_TXD_PORT192_MARK,

-- 
Regards,

Laurent Pinchart

