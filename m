From: Simon Horman <horms@verge.net.au>
Date: Mon, 25 Nov 2013 02:42:37 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: lager: add gpio regulator support on defconfig
Message-Id: <20131125024235.GA2786@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvqqxlsd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvqqxlsd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 11:21:26PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/configs/lager_defconfig |    1 +
>  1 file changed, 1 insertion(+)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
> index 35dc8b2..35b7cb7 100644
> --- a/arch/arm/configs/lager_defconfig
> +++ b/arch/arm/configs/lager_defconfig
> @@ -89,6 +89,7 @@ CONFIG_THERMAL=y
>  CONFIG_RCAR_THERMAL=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_GPIO=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RCAR_DU=y
>  # CONFIG_USB_SUPPORT is not set
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
