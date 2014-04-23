From: Simon Horman <horms@verge.net.au>
Date: Wed, 23 Apr 2014 00:50:43 +0000
Subject: Re: [PATCH RFC 2/2] ARM: shmobile: armadillo800eva defconfig: Enable REGULATOR_GPIO and LEDS_GPIO
Message-Id: <20140423005043.GF5738@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398171667-24288-1-git-send-email-geert+renesas@glider.be>
 <1398171667-24288-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398171667-24288-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 22, 2014 at 03:01:07PM +0200, Geert Uytterhoeven wrote:
> Refresh armadillo800eva_defconfig, and enable missing options for devices
> in platform data and/or DT:
>   - REGULATOR_GPIO
>   - LEDS_GPIO

I would prefer if changes were made in a more incremental patch.

* A patch to enable LEDS_GPIO and REGULATOR_GPIO.
* Then a cleanup patch, if you really want to do that: but why?

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Do we want SHMOBILE_IOMMU, too? The help text says "If unsure, say N."
> If yes, is the default SHMOBILE_IOMMU_ADDRSIZE_2048MB OK?

I defer to Magnus on that one.

>  arch/arm/configs/armadillo800eva_defconfig |   17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 065adddeee3e..1e47212a63b8 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -1,4 +1,3 @@
> -CONFIG_EXPERIMENTAL=y
>  CONFIG_SYSVIPC=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
> @@ -18,9 +17,6 @@ CONFIG_MODULE_FORCE_UNLOAD=y
>  CONFIG_ARCH_SHMOBILE_LEGACY=y
>  CONFIG_ARCH_R8A7740=y
>  CONFIG_MACH_ARMADILLO800EVA=y
> -# CONFIG_SH_TIMER_TMU is not set
> -CONFIG_ARM_THUMB=y
> -CONFIG_CACHE_L2X0=y
>  CONFIG_ARM_ERRATA_430973=y
>  CONFIG_ARM_ERRATA_458693=y
>  CONFIG_ARM_ERRATA_460075=y
> @@ -34,7 +30,6 @@ CONFIG_ARM_ERRATA_754322=y
>  CONFIG_PL310_ERRATA_769419=y
>  CONFIG_ARM_ERRATA_775420=y
>  CONFIG_AEABI=y
> -# CONFIG_OABI_COMPAT is not set
>  CONFIG_FORCE_MAX_ZONEORDER
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
> @@ -66,7 +61,6 @@ CONFIG_MD=y
>  CONFIG_BLK_DEV_DM=y
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_BROADCOM is not set
> -# CONFIG_NET_VENDOR_CHELSIO is not set
>  # CONFIG_NET_VENDOR_CIRRUS is not set
>  # CONFIG_NET_VENDOR_FARADAY is not set
>  # CONFIG_NET_VENDOR_INTEL is not set
> @@ -74,6 +68,7 @@ CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_MICREL is not set
>  # CONFIG_NET_VENDOR_NATSEMI is not set
>  CONFIG_SH_ETH=y
> +# CONFIG_NET_VENDOR_SAMSUNG is not set
>  # CONFIG_NET_VENDOR_SEEQ is not set
>  # CONFIG_NET_VENDOR_SMSC is not set
>  # CONFIG_NET_VENDOR_STMICRO is not set
> @@ -91,18 +86,17 @@ CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_SH_SCI_NR_UARTS=9
>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
> -CONFIG_I2C=y
>  CONFIG_I2C_GPIO=y
>  CONFIG_I2C_SH_MOBILE=y
>  # CONFIG_HWMON is not set
>  CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_GPIO=y
>  CONFIG_MEDIA_SUPPORT=y
> -CONFIG_VIDEO_DEV=y
>  CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_V4L_PLATFORM_DRIVERS=y
>  CONFIG_SOC_CAMERA=y
> -CONFIG_SOC_CAMERA_MT9T112=y
>  CONFIG_VIDEO_SH_MOBILE_CEU=y
> +CONFIG_SOC_CAMERA_MT9T112=y
>  CONFIG_FB=y
>  CONFIG_FB_SH_MOBILE_LCDC=y
>  CONFIG_FB_SH_MOBILE_HDMI=y
> @@ -118,7 +112,6 @@ CONFIG_LOGO=y
>  # CONFIG_SND_DRIVERS is not set
>  # CONFIG_SND_ARM is not set
>  CONFIG_SND_SOC_SH4_FSI=y
> -# CONFIG_HID_SUPPORT is not set
>  CONFIG_USB=y
>  CONFIG_USB_RENESAS_USBHS=y
>  CONFIG_USB_GADGET=y
> @@ -127,6 +120,9 @@ CONFIG_USB_ETH=m
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHI=y
>  CONFIG_MMC_SH_MMCIF=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_S35390A=y
>  CONFIG_DMADEVICES=y
> @@ -150,7 +146,6 @@ CONFIG_NLS_ISO8859_1=y
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set
>  # CONFIG_ENABLE_MUST_CHECK is not set
>  # CONFIG_ARM_UNWIND is not set
> -CONFIG_CRYPTO=y
>  CONFIG_CRYPTO_CBC=y
>  CONFIG_CRYPTO_MD5=y
>  CONFIG_CRYPTO_DES=y
> -- 
> 1.7.9.5
> 
