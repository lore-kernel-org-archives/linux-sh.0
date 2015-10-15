From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Oct 2015 07:03:49 +0000
Subject: Re: [PATCH/RFC 1/6] boot-mode-reg: Add core
Message-Id: <CAMuHMdXRWN-q=Qz=8fK3eYbC+pY_n0cW7VmPUafsExAumySrdA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 15, 2015 at 8:59 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- /dev/null
> +++ b/drivers/misc/boot-mode-reg/core.c
> @@ -0,0 +1,78 @@
> +/*
> + * Boot Mode Register
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
> +#include <asm/errno.h>
> +
> +#include <linux/export.h>
> +#include <linux/module.h>
> +
> +#include <misc/boot-mode-reg.h>
> +
> +static DEFINE_MUTEX(boot_mode_mutex);
> +static bool boot_mode_is_set;
> +static u32 boot_mode;
> +
> +/**
> + * boot_mode_reg_get() - retrieve boot mode register value
> + * @mode: implementation-dependent boot mode register value
> + *
> + * Retrieves the boot mode register value previously registered
> + * using boot_mode_reg_set().
> + *
> + * return: 0 on success
> + */
> +int boot_mode_reg_get(u32 *mode)
> +{
> +       int err = -ENOENT;
> +
> +       mutex_lock(&boot_mode_mutex);
> +       if (!boot_mode_is_set)
> +               goto err;
> +       *mode = boot_mode;
> +       err = 0;
> +err:
> +       mutex_unlock(&boot_mode_mutex);
> +       return 0;

return err;

> +}
> +EXPORT_SYMBOL_GPL(boot_mode_get);
> +
> +/**
> + * boot_mode_reg_set() - record boot mode register value
> + * @mode: implementation-dependent boot mode register value
> + *
> + * Records the boot mode register value which may subsequently
> + * be retrieved using boot_mode_reg_get().
> + *
> + * return: 0 on success
> + */
> +int boot_mode_reg_set(u32 mode)
> +{
> +       int err = -EBUSY;
> +
> +       mutex_lock(&boot_mode_mutex);
> +       if (boot_mode_is_set && boot_mode != mode)
> +               goto err;
> +       boot_mode = mode;
> +       boot_mode_is_set = true;
> +       err = 0;
> +err:
> +       mutex_unlock(&boot_mode_mutex);
> +       return 0;

return err;

> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
