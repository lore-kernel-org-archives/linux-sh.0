From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 01 Mar 2015 12:20:36 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Remove r8a7791 platform_device_id entry
Message-Id: <2835545.eWQKaR4OxL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1424016101-10111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424016101-10111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

Could you please pick this patch up for v4.1 ?

On Sunday 15 February 2015 18:01:41 Laurent Pinchart wrote:
> The r8a7791 platform is now DT-only, the driver doesn't need to match
> platform devices by name anymore. Remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index a56280814a3f..e2c442b64a2c 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -597,9 +597,6 @@ static const struct platform_device_id sh_pfc_id_table[]
> = { #ifdef CONFIG_PINCTRL_PFC_R8A7790
>  	{ "pfc-r8a7790", (kernel_ulong_t)&r8a7790_pinmux_info },
>  #endif
> -#ifdef CONFIG_PINCTRL_PFC_R8A7791
> -	{ "pfc-r8a7791", (kernel_ulong_t)&r8a7791_pinmux_info },
> -#endif
>  #ifdef CONFIG_PINCTRL_PFC_SH7203
>  	{ "pfc-sh7203", (kernel_ulong_t)&sh7203_pinmux_info },
>  #endif

-- 
Regards,

Laurent Pinchart

