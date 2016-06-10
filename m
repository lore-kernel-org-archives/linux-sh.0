From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 10 Jun 2016 12:16:56 +0000
Subject: Re: [PATCH 2/3] pinctrl: sh-pfc: Improve core and user API separation
Message-Id: <4919239.TD95LLyWB6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1465553103-6345-1-git-send-email-geert+renesas@glider.be> <1465553103-6345-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1465553103-6345-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 10 Jun 2016 12:05:02 Geert Uytterhoeven wrote:
> The Renesas Pin Function Controller uses two header files:
>   - sh_pfc.h, for use by both core code and SoC-specific drivers,
>   - core.h, for internal use by the core code only.
> 
> Several SoC-specific drivers include core.h, as they need the sh_pfc
> structure, which is passed explicitly to the various SoC-specific
> callbacks, and used there.
> 
> Hence move its definition from core.h to sh_pfc.h, and remove the
> inclusion of core.h from all SoC-specific files.

The idea behind sh_pfc.h is to store all structures and macros needed by the 
SoC drivers to define SoC data, in order to keep core.h clean. It you move 
most of core.h to sh_pfc.h I'd rather merge the two files.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pinctrl/sh-pfc/core.h        | 33 ---------------------------------
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  1 -
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  1 -
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  2 +-
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  1 -
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  1 -
>  drivers/pinctrl/sh-pfc/sh_pfc.h      | 30 +++++++++++++++++++++++++++++-
>  7 files changed, 30 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
> index 539ec7dc0b644dbe..9dde6ea5e28f3a1b 100644
> --- a/drivers/pinctrl/sh-pfc/core.h
> +++ b/drivers/pinctrl/sh-pfc/core.h
> @@ -10,48 +10,15 @@
>  #ifndef __SH_PFC_CORE_H__
>  #define __SH_PFC_CORE_H__
> 
> -#include <linux/compiler.h>
> -#include <linux/spinlock.h>
>  #include <linux/types.h>
> 
>  #include "sh_pfc.h"
> 
> -struct sh_pfc_window {
> -	phys_addr_t phys;
> -	void __iomem *virt;
> -	unsigned long size;
> -};
> -
> -struct sh_pfc_chip;
> -struct sh_pfc_pinctrl;
> -
>  struct sh_pfc_pin_range {
>  	u16 start;
>  	u16 end;
>  };
> 
> -struct sh_pfc {
> -	struct device *dev;
> -	const struct sh_pfc_soc_info *info;
> -	spinlock_t lock;
> -
> -	unsigned int num_windows;
> -	struct sh_pfc_window *windows;
> -	unsigned int num_irqs;
> -	unsigned int *irqs;
> -
> -	struct sh_pfc_pin_range *ranges;
> -	unsigned int nr_ranges;
> -
> -	unsigned int nr_gpio_pins;
> -
> -	struct sh_pfc_chip *gpio;
> -#ifdef CONFIG_SUPERH
> -	struct sh_pfc_chip *func;
> -#endif
> -
> -};
> -
>  int sh_pfc_register_gpiochip(struct sh_pfc *pfc);
>  int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c index
> d9d9228b15faf6f3..ff5655dee67e5649 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> @@ -21,7 +21,6 @@
>  #include <linux/kernel.h>
>  #include <linux/pinctrl/pinconf-generic.h>
> 
> -#include "core.h"
>  #include "sh_pfc.h"
> 
>  #define CPU_ALL_PORT(fn, pfx, sfx)					\
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index
> 7f7c8a6e76e88f29..35f436bcb849185a 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -22,7 +22,6 @@
>  #include <linux/kernel.h>
>  #include <linux/pinctrl/pinconf-generic.h>
> 
> -#include "core.h"
>  #include "sh_pfc.h"
> 
>  #define CPU_ALL_PORT(fn, pfx, sfx)					\
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c index
> 411d0887ba19bae6..18ef7042b3d1b047 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -23,7 +23,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/pinctrl/pinconf-generic.h>
> -#include "core.h"
> +
>  #include "sh_pfc.h"
> 
>  #define PORT_GP_PUP_1(bank, pin, fn, sfx)	\
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index
> 1537a0779399772f..b769c05480da681e 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -24,7 +24,6 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> 
> -#include "core.h"
>  #include "sh_pfc.h"
> 
>  /*
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c index
> 01abbd5b4e49a783..0c1a60c9a844c7ee 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> @@ -11,7 +11,6 @@
> 
>  #include <linux/kernel.h>
> 
> -#include "core.h"
>  #include "sh_pfc.h"
> 
>  #define CPU_ALL_PORT(fn, sfx)						\
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 332d379b302cba70..5732752667e2654a
> 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -13,6 +13,7 @@
> 
>  #include <linux/bug.h>
>  #include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/spinlock.h>
>  #include <linux/stringify.h>
> 
>  enum {
> @@ -182,7 +183,34 @@ struct pinmux_range {
>  	u16 force;
>  };
> 
> -struct sh_pfc;
> +struct sh_pfc_window {
> +	phys_addr_t phys;
> +	void __iomem *virt;
> +	unsigned long size;
> +};
> +
> +struct sh_pfc_pin_range;
> +
> +struct sh_pfc {
> +	struct device *dev;
> +	const struct sh_pfc_soc_info *info;
> +	spinlock_t lock;
> +
> +	unsigned int num_windows;
> +	struct sh_pfc_window *windows;
> +	unsigned int num_irqs;
> +	unsigned int *irqs;
> +
> +	struct sh_pfc_pin_range *ranges;
> +	unsigned int nr_ranges;
> +
> +	unsigned int nr_gpio_pins;
> +
> +	struct sh_pfc_chip *gpio;
> +#ifdef CONFIG_SUPERH
> +	struct sh_pfc_chip *func;
> +#endif
> +};
> 
>  struct sh_pfc_soc_operations {
>  	int (*init)(struct sh_pfc *pfc);

-- 
Regards,

Laurent Pinchart

