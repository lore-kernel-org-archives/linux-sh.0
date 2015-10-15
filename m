From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Thu, 15 Oct 2015 07:34:05 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <561F56ED.6070409@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

Thanks for your patch.

On 10/15/2015 1:59 PM, Simon Horman wrote:
> Boot mode register driver for R-Car Gen2.
>
> If running on a supported platform it reads the boot mode register and
> records it using the boot mode register infrastructure established by an
> earlier patch.
>
> rcar_gen2_init_boot_mode() is exported allow it to be explicitly called in
> cases where the boot mode register is needed before init calls are made.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   drivers/misc/boot-mode-reg/Kconfig     |  8 +++++
>   drivers/misc/boot-mode-reg/Makefile    |  1 +
>   drivers/misc/boot-mode-reg/rcar-gen2.c | 61 ++++++++++++++++++++++++++++++++++
>   include/misc/boot-mode-reg.h           |  3 ++
>   4 files changed, 73 insertions(+)
>   create mode 100644 drivers/misc/boot-mode-reg/rcar-gen2.c
>
> diff --git a/drivers/misc/boot-mode-reg/Kconfig b/drivers/misc/boot-mode-reg/Kconfig
> index 806eba24238f..4731edf8a9db 100644
> --- a/drivers/misc/boot-mode-reg/Kconfig
> +++ b/drivers/misc/boot-mode-reg/Kconfig
> @@ -9,3 +9,11 @@ config BOOT_MODE_REG_CORE
>   	help
>   	  Say Y here to allow support for drivers to read boot mode
>   	  registers and make the value available to other subsystems.
> +
> +config BOOT_MODE_REG_RCAR_GEN2
> +	tristate "Boot Mode Register Driver for Renesas R-Car Gen2 SoCs"
> +	default n
> +	select BOOT_MODE_REG_CORE
> +	help
> +	  Say Y here to allow support for reading the boot mode register
> +	  on Renesas R-Car Gen2 SoCs.
> diff --git a/drivers/misc/boot-mode-reg/Makefile b/drivers/misc/boot-mode-reg/Makefile
> index 19134b20a7f1..d097fd0164aa 100644
> --- a/drivers/misc/boot-mode-reg/Makefile
> +++ b/drivers/misc/boot-mode-reg/Makefile
> @@ -4,3 +4,4 @@
>   #
>
>   obj-$(CONFIG_BOOT_MODE_REG_CORE)	+= core.o
> +obj-$(CONFIG_BOOT_MODE_REG_RCAR_GEN2)	+= rcar-gen2.o
> diff --git a/drivers/misc/boot-mode-reg/rcar-gen2.c b/drivers/misc/boot-mode-reg/rcar-gen2.c
> new file mode 100644
> index 000000000000..0f1a06fcf094
> --- /dev/null
> +++ b/drivers/misc/boot-mode-reg/rcar-gen2.c
> @@ -0,0 +1,61 @@
> +/*
> + * R-Car Gen2 Boot Mode Register Driver
> + *
> + * Copyright (C) 2015 Simon Horman
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <misc/boot-mode-reg.h>
> +
> +#define MODEMR 0xe6160060
> +
> +static int __init rcar_gen2_read_mode_pins(void)
> +{
> +	void __iomem *modemr;
> +	int err = -ENOMEM;
> +	static u32 mode;
> +
> +	modemr = ioremap_nocache(MODEMR, 4);
> +	if (!modemr) {
> +		pr_err("failed to map boot mode register");
> +		goto err;
> +	}
> +	mode = ioread32(modemr);
> +	iounmap(modemr);
> +
> +	err = boot_mode_reg_set(mode);
> +err:
> +	if (err)
> +		pr_err("failed to initialise boot mode");
> +	return err;
> +}
> +
> +int __init rcar_gen2_init_boot_mode(void)
> +{
> +	if (of_machine_is_compatible("renesas,r8a7790") ||
> +	    of_machine_is_compatible("renesas,r8a7791") ||
> +	    of_machine_is_compatible("renesas,r8a7792") ||
> +	    of_machine_is_compatible("renesas,r8a7793") ||
> +	    of_machine_is_compatible("renesas,r8a7794"))
> +		return rcar_gen2_read_mode_pins();
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(boot_mode_set);

Could you tell me the purpose of this ?
There's no such function name in this file.

> +early_initcall(rcar_gen2_init_boot_mode);
> +
> +MODULE_LICENSE("GPL");

The license should be GPLv2 to match with the paragraph at top of this 
file, right ?

> +MODULE_AUTHOR("Simon Horman <horms@verge.net.au>");
> +MODULE_DESCRIPTION("R-Car Gen2 Boot Mode Register Driver");
> diff --git a/include/misc/boot-mode-reg.h b/include/misc/boot-mode-reg.h
> index 34ee653279a4..f8fea0ea5a3e 100644
> --- a/include/misc/boot-mode-reg.h
> +++ b/include/misc/boot-mode-reg.h
> @@ -21,4 +21,7 @@
>   int boot_mode_reg_get(u32 *mode);
>   int boot_mode_reg_set(u32 mode);
>
> +/* Allow explicit initialisation before initcalls */
> +int rcar_gen2_init_boot_mode(void);
> +
>   #endif
>
