From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 29 Apr 2015 11:53:22 +0000
Subject: Re: [PATCH 2/2] pinctrl: sh-pfc: Remove r8a73a4 platform_device_id entry
Message-Id: <21370155.oZX1erNtOU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216107-31501-1-git-send-email-geert+renesas@glider.be> <1430216107-31501-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430216107-31501-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 28 April 2015 12:15:07 Geert Uytterhoeven wrote:
> As of commit 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
> legacy platform"), r8a73a4 is only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 7b2c9495c3832410..287a3d048a5e1cf9 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -579,9 +579,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
>  }
> 
>  static const struct platform_device_id sh_pfc_id_table[] = {
> -#ifdef CONFIG_PINCTRL_PFC_R8A73A4
> -	{ "pfc-r8a73a4", (kernel_ulong_t)&r8a73a4_pinmux_info },
> -#endif
>  #ifdef CONFIG_PINCTRL_PFC_R8A7740
>  	{ "pfc-r8a7740", (kernel_ulong_t)&r8a7740_pinmux_info },
>  #endif

-- 
Regards,

Laurent Pinchart

