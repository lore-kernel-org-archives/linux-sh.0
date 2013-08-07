From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 07 Aug 2013 17:26:27 +0000
Subject: Re: [PATCH 5/5] ARM: shmobile: lager: Add Display Unit support
Message-Id: <52028343.7010206@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 08/07/2013 08:19 PM, Laurent Pinchart wrote:

> Only the VGA output is currently supported.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/configs/lager_defconfig     |  2 ++
>   arch/arm/mach-shmobile/board-lager.c | 42 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)

> diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
> index e777ef2..35bff5e 100644
> --- a/arch/arm/configs/lager_defconfig
> +++ b/arch/arm/configs/lager_defconfig
> @@ -89,6 +89,8 @@ CONFIG_THERMAL=y
>   CONFIG_RCAR_THERMAL=y
>   CONFIG_REGULATOR=y
>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_DRM=y
> +CONFIG_DRM_RCAR_DU=y
>   # CONFIG_USB_SUPPORT is not set
>   CONFIG_MMC=y
>   CONFIG_MMC_SDHI=y

    Should be in a separate patch.

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 4872939..357f329 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -28,6 +28,7 @@
>   #include <linux/mmc/sh_mmcif.h>
>   #include <linux/pinctrl/machine.h>
>   #include <linux/platform_data/gpio-rcar.h>
> +#include <linux/platform_data/rcar-du.h>
>   #include <linux/platform_device.h>
>   #include <linux/regulator/fixed.h>
>   #include <linux/regulator/machine.h>
> @@ -38,6 +39,38 @@
>   #include <asm/mach-types.h>
>   #include <asm/mach/arch.h>
>
[...]
> +static struct rcar_du_platform_data lager_du_pdata = {

    Should be annotated with '__initdata'.

> +	.encoders = lager_du_encoders,
> +	.num_encoders = ARRAY_SIZE(lager_du_encoders),
> +};
> +

WBR, Sergei

