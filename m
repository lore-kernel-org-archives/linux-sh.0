From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Feb 2015 11:03:45 +0000
Subject: Re: [PATCH 01/02] ARM: shmobile: Drop DU deps to allow 64-bit build
Message-Id: <CAMuHMdWbhtn6JRQUYQBnAGRHgYSpuNGRUb5F=Mf=eFKxbDesZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150219010825.1660.31402.sendpatchset@little-apple>
In-Reply-To: <20150219010825.1660.31402.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Feb 19, 2015 at 2:08 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/drivers/gpu/drm/rcar-du/Kconfig
> +++ work/drivers/gpu/drm/rcar-du/Kconfig        2015-02-19 05:59:44.585533280 +0900
> @@ -1,7 +1,6 @@
>  config DRM_RCAR_DU
>         tristate "DRM Support for R-Car Display Unit"
> -       depends on DRM && ARM

If it already builds fine on other architectures, you can just drop
the dependency
on ARM above? After that, people can enable COMPILE_TEST to get access to
this driver.

> -       depends on ARCH_SHMOBILE || COMPILE_TEST
> +       depends on DRM
>         select DRM_KMS_HELPER
>         select DRM_KMS_CMA_HELPER
>         select DRM_GEM_CMA_HELPER

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
