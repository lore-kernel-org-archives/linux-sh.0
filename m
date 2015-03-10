From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Mar 2015 16:24:17 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: Remove emev2 platform_device_id entry
Message-Id: <3341846.uKjR1IUGkO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 10 March 2015 12:14:39 Geert Uytterhoeven wrote:
> The emev2 platform is now DT-only, the driver doesn't need to match
> platform devices by name anymore. Remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> The emev2 platform never had pinctrl support for non-DT.
> 
>  drivers/pinctrl/sh-pfc/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 656745f545442d58..0e6083fc3563f4a5 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -579,9 +579,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
>  }
> 
>  static const struct platform_device_id sh_pfc_id_table[] = {
> -#ifdef CONFIG_PINCTRL_PFC_EMEV2
> -	{ "pfc-emev2", (kernel_ulong_t)&emev2_pinmux_info },
> -#endif
>  #ifdef CONFIG_PINCTRL_PFC_R8A73A4
>  	{ "pfc-r8a73a4", (kernel_ulong_t)&r8a73a4_pinmux_info },
>  #endif

-- 
Regards,

Laurent Pinchart

