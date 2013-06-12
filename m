From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:08:08 +0000
Subject: Re: [PATCH 3/3 v4] ARM: shmobile: bockw defconfig: add MMCIF support
Message-Id: <20130612140807.GE32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738so6pk8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738so6pk8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 11, 2013 at 07:16:58PM -0700, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued up in the defconfig branch.

> ---
> v3 -> v4
> 
>  - based on renesas-next-20130611v2
> 
>  arch/arm/configs/bockw_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
> index 55e00ff..845f5cd 100644
> --- a/arch/arm/configs/bockw_defconfig
> +++ b/arch/arm/configs/bockw_defconfig
> @@ -94,6 +94,7 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_RCAR_PHY=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHI=y
> +CONFIG_MMC_SH_MMCIF=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_RX8581=y
>  CONFIG_UIO=y
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
