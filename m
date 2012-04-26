From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Apr 2012 06:35:59 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: armadillo800eva: defconfig update
Message-Id: <20120426063557.GC27134@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bomfuove.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bomfuove.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 25, 2012 at 08:57:13PM -0700, Kuninori Morimoto wrote:
> This patch enable USBFunc/SHDI/MMCIF,
> remove debug settings,
> and cleanuped by c2330e286f68f1c408b4aa6515ba49d57f05beae script
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  arch/arm/configs/armadillo800eva_defconfig |   25 ++++++++++++-------------
>  1 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 0d20749..ddc9fe6 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -10,7 +10,6 @@ CONFIG_LOG_BUF_SHIFT
>  CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_SYSFS_DEPRECATED_V2=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> -CONFIG_KALLSYMS_ALL=y
>  CONFIG_SLAB=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> @@ -63,6 +62,7 @@ CONFIG_BLK_DEV_DM=y
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_BROADCOM is not set
>  # CONFIG_NET_VENDOR_CHELSIO is not set
> +# CONFIG_NET_VENDOR_CIRRUS is not set
>  # CONFIG_NET_VENDOR_FARADAY is not set
>  # CONFIG_NET_VENDOR_INTEL is not set
>  # CONFIG_NET_VENDOR_MARVELL is not set
> @@ -70,6 +70,7 @@ CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_NATSEMI is not set
>  CONFIG_SH_ETH=y
>  # CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
>  # CONFIG_NET_VENDOR_STMICRO is not set
>  # CONFIG_WLAN is not set
>  # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> @@ -106,7 +107,15 @@ CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_SOC_SH4_FSI=y
>  # CONFIG_HID_SUPPORT is not set
> -# CONFIG_USB_SUPPORT is not set
> +CONFIG_USB=y
> +# CONFIG_USB_DEVICE_CLASS is not set
> +CONFIG_USB_RENESAS_USBHS=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_RENESAS_USBHS_UDC=y
> +CONFIG_USB_ETH=m
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHI=y
> +CONFIG_MMC_SH_MMCIF=y
>  CONFIG_UIO=y
>  CONFIG_UIO_PDRV_GENIRQ=y
>  # CONFIG_DNOTIFY is not set
> @@ -124,17 +133,7 @@ CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ISO8859_1=y
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set
>  # CONFIG_ENABLE_MUST_CHECK is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
> -CONFIG_DEBUG_KERNEL=y
> -CONFIG_LOCKUP_DETECTOR=y
> -CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> -# CONFIG_DETECT_HUNG_TASK is not set
> -# CONFIG_SCHED_DEBUG is not set
> -CONFIG_DEBUG_KMEMLEAK=y
> -CONFIG_DEBUG_SPINLOCK=y
> -CONFIG_DEBUG_INFO=y
> -# CONFIG_FTRACE is not set
> +# CONFIG_ARM_UNWIND is not set
>  CONFIG_CRYPTO=y
>  CONFIG_CRYPTO_CBC=y
>  CONFIG_CRYPTO_MD5=y
> -- 
> 1.7.5.4
> 
