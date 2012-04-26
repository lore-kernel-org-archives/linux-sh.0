From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Apr 2012 06:36:10 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: kzm9g: defconfig update
Message-Id: <20120426063610.GD27134@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87aa1zuotw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aa1zuotw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 25, 2012 at 08:58:06PM -0700, Kuninori Morimoto wrote:
> This patch enable GPIO-KEY/FSI,
> and remove debug settings,
> and be cleanuped by c2330e286f68f1c408b4aa6515ba49d57f05beae script
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  arch/arm/configs/kzm9g_defconfig |   24 +++++++++++++++++-------
>  1 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
> index 164c5d2..4bbea36 100644
> --- a/arch/arm/configs/kzm9g_defconfig
> +++ b/arch/arm/configs/kzm9g_defconfig
> @@ -22,6 +22,7 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
>  CONFIG_ARCH_SHMOBILE=y
> +CONFIG_KEYBOARD_GPIO_POLLED=y
>  CONFIG_ARCH_SH73A0=y
>  CONFIG_MACH_KZM9G=y
>  CONFIG_MEMORY_START=0x41000000
> @@ -67,8 +68,6 @@ CONFIG_INPUT_SPARSEKMAP=y
>  # CONFIG_INPUT_MOUSEDEV is not set
>  CONFIG_INPUT_EVDEV=y
>  # CONFIG_KEYBOARD_ATKBD is not set
> -CONFIG_KEYBOARD_GPIO=y
> -CONFIG_KEYBOARD_SH_KEYSC=y
>  # CONFIG_INPUT_MOUSE is not set
>  CONFIG_INPUT_TOUCHSCREEN=y
>  CONFIG_TOUCHSCREEN_ST1232=y
> @@ -79,13 +78,22 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_I2C_CHARDEV=y
>  CONFIG_I2C_SH_MOBILE=y
> -CONFIG_POWER_SUPPLY=y
> +CONFIG_GPIO_PCF857X=y
>  # CONFIG_HWMON is not set
>  CONFIG_FB=y
>  CONFIG_FB_SH_MOBILE_LCDC=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_LOGO=y
>  CONFIG_FB_SH_MOBILE_MERAM=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +# CONFIG_SND_SUPPORT_OLD_API is not set
> +# CONFIG_SND_VERBOSE_PROCFS is not set
> +# CONFIG_SND_DRIVERS is not set
> +# CONFIG_SND_ARM is not set
> +# CONFIG_SND_USB is not set
> +CONFIG_SND_SOC=y
> +CONFIG_SND_SOC_SH4_FSI=y
>  # CONFIG_HID_SUPPORT is not set
>  CONFIG_USB=y
>  CONFIG_USB_DEVICEFS=y
> @@ -115,11 +123,13 @@ CONFIG_NFS_V4_1=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ISO8859_1=y
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DETECT_HUNG_TASK=y
> -CONFIG_DEBUG_INFO=y
> +# CONFIG_ENABLE_WARN_DEPRECATED is not set
> +# CONFIG_ENABLE_MUST_CHECK is not set
> +# CONFIG_SCHED_DEBUG is not set
> +# CONFIG_DEBUG_PREEMPT is not set
> +# CONFIG_DEBUG_BUGVERBOSE is not set
>  # CONFIG_FTRACE is not set
> -CONFIG_DEBUG_USER=y
> +# CONFIG_ARM_UNWIND is not set
>  CONFIG_CRYPTO=y
>  CONFIG_CRYPTO_CBC=y
>  CONFIG_CRYPTO_MD5=y
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
