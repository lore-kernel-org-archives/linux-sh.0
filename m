From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 12:11:59 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: bockw: enable SDHI on defconfig
Message-Id: <20130418121158.GE13101@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <877gk1enw0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gk1enw0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 16, 2013 at 10:18:11PM -0700, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued-up this patch for v3.11 in the bockw-defconfig branch.

> ---
>  arch/arm/configs/bockw_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
> index 6524cdf..b74a4d4 100644
> --- a/arch/arm/configs/bockw_defconfig
> +++ b/arch/arm/configs/bockw_defconfig
> @@ -72,6 +72,8 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_HWMON is not set
>  # CONFIG_USB_SUPPORT is not set
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHI=y
>  CONFIG_UIO=y
>  CONFIG_UIO_PDRV_GENIRQ=y
>  # CONFIG_IOMMU_SUPPORT is not set
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
