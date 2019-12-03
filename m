From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Dec 2019 15:29:17 +0000
Subject: Re: [PATCH] drivers: Fix boot problem on SuperH
Message-Id: <CAMuHMdWFpHsGk9V-nRaDOP-sjh5DWsGtHNGZ_jm3J3BFYd6KqA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191203144631.6629-1-linux@roeck-us.net>
In-Reply-To: <20191203144631.6629-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>

Hi G=C3=BCnter,

On Tue, Dec 3, 2019 at 3:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
> SuperH images crash too eearly to display any console output. Bisect
> points to commit 507fd01d5333 ("drivers: move the early platform device
> support to arch/sh"). An analysis of that patch suggests that
> early_platform_cleanup() is now called at the wrong time. Restoring its
> call point fixes the problem.
>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Fixes: 507fd01d5333 ("drivers: move the early platform device support to =
arch/sh")
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

> --- a/arch/sh/drivers/platform_early.c
> +++ b/arch/sh/drivers/platform_early.c
> @@ -325,9 +325,9 @@ int __init sh_early_platform_driver_probe(char *class=
_str,
>  }
>
>  /**
> - * sh_early_platform_cleanup - clean up early platform code
> + * early_platform_cleanup - clean up early platform code
>   */
> -static int __init sh_early_platform_cleanup(void)
> +void early_platform_cleanup(void)

This function should be __init...

>  {
>         struct platform_device *pd, *pd2;
>
> @@ -337,11 +337,4 @@ static int __init sh_early_platform_cleanup(void)
>                 list_del(&pd->dev.devres_head);
>                 memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_hea=
d));
>         }
> -
> -       return 0;
>  }
> -/*
> - * This must happen once after all early devices are probed but before p=
robing
> - * real platform devices.
> - */
> -subsys_initcall(sh_early_platform_cleanup);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7c532548b0a6..3ba153e356ee 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1325,10 +1325,14 @@ struct device *platform_find_device_by_driver(str=
uct device *start,
>  }
>  EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
>
> +void __weak early_platform_cleanup(void) { }

... and this one, too.

Sorry for failing to notice that before.
Back to fixing more SH...

> +
>  int __init platform_bus_init(void)
>  {
>         int error;
>
> +       early_platform_cleanup();
> +
>         error =3D device_register(&platform_bus);
>         if (error) {
>                 put_device(&platform_bus);

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
