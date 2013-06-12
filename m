From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:08:02 +0000
Subject: Re: [PATCH 2/3 v4] ARM: shmobile: bockw defconfig: add M25P80 support
Message-Id: <20130612140800.GD32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874nd46pks.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nd46pks.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 11, 2013 at 07:16:38PM -0700, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued up in the defconfig branch.

> ---
> v3 -> v4
> 
>  - based on renesas-next-20130611v2
> 
>  arch/arm/configs/bockw_defconfig |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
> index cb7638d..55e00ff 100644
> --- a/arch/arm/configs/bockw_defconfig
> +++ b/arch/arm/configs/bockw_defconfig
> @@ -49,6 +49,12 @@ CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_STANDALONE is not set
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
> +CONFIG_MTD=y
> +CONFIG_MTD_CHAR=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_CFI=y
> +CONFIG_MTD_CFI_AMDSTD=y
> +CONFIG_MTD_M25P80=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_NETDEVICES=y
> @@ -76,6 +82,8 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
>  # CONFIG_HWMON is not set
>  CONFIG_I2C=y
>  CONFIG_I2C_RCAR=y
> +CONFIG_SPI=y
> +CONFIG_SPI_SH_HSPI=y
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_EHCI_HCD=y
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
