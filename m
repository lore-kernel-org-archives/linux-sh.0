From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 07:49:32 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: fixup I2C device on defconfig
Message-Id: <20131128074926.GH24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87iovgorng.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iovgorng.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 25, 2013 at 05:53:16PM -0800, Kuninori Morimoto wrote:
> R-Car H2 needs I2C_CAR, not I2C_SH_MOBILE
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/configs/lager_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
> index 35b7cb7..883443f 100644
> --- a/arch/arm/configs/lager_defconfig
> +++ b/arch/arm/configs/lager_defconfig
> @@ -80,7 +80,7 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_I2C=y
>  CONFIG_I2C_GPIO=y
> -CONFIG_I2C_SH_MOBILE=y
> +CONFIG_I2C_RCAR=y
>  CONFIG_GPIO_SH_PFC=y
>  CONFIG_GPIOLIB=y
>  CONFIG_GPIO_RCAR=y

Thanks, I have queued this up.
