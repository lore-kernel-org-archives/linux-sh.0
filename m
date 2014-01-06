From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Jan 2014 23:55:27 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Enable VIN along with ADV7180 decoder in defconfig
Message-Id: <20140106235527.GD1523@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1388990626-21460-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1388990626-21460-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 06, 2014 at 06:55:41PM +0400, Valentine Barshak wrote:
> This enables R-Car VIN SoC camera along with ADV7180 decoder,
> which can be found on Lager board, to lager_defconfig.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/configs/lager_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
> index 883443f..89b6e71 100644
> --- a/arch/arm/configs/lager_defconfig
> +++ b/arch/arm/configs/lager_defconfig
> @@ -90,6 +90,14 @@ CONFIG_RCAR_THERMAL=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_GPIO=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_SOC_CAMERA=y
> +CONFIG_SOC_CAMERA_PLATFORM=y
> +CONFIG_VIDEO_RCAR_VIN=y
> +# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> +CONFIG_VIDEO_ADV7180=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RCAR_DU=y
>  # CONFIG_USB_SUPPORT is not set
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
