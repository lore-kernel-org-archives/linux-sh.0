From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Jun 2019 07:59:11 +0000
Subject: Re: [PATCH] sh: prevent warnings when using iounmap
Message-Id: <CAMuHMdXhVNGsEsUbmzYiFJcDN2uR5WFEFT5qdHdo0pF=0BGphA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190622114208.24427-1-sam@ravnborg.org>
In-Reply-To: <20190622114208.24427-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>

Hi Sam,

On Sat, Jun 22, 2019 at 1:45 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> When building drm/exynos for sh, as part of an allmodconfig build,
> the following warning triggered:
>
>   exynos7_drm_decon.c: In function ‘decon_remove’:
>   exynos7_drm_decon.c:769:24: warning: unused variable ‘ctx’
>     struct decon_context *ctx = dev_get_drvdata(&pdev->dev);
>
> The ctx variable is only used as argument to iounmap().
>
> In sh - allmodconfig CONFIG_MMU is not defined
> so it ended up in:
>
> \#define __iounmap(addr)        do { } while (0)
> \#define iounmap                __iounmap
>
> Fix the warning by introducing a static inline
> function for iounmap.
> This is similar to several other architectures.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Thanks for your patch!

> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -369,7 +369,11 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
>
>  #define ioremap_nocache        ioremap
>  #define ioremap_uc     ioremap
> -#define iounmap                __iounmap
> +
> +static inline void iounmap(void __iomem *addr)
> +{
> +       __iounmap(addr);
> +}

The alternative would be to make __iounmap() static inline, which may be
better from the viewpoint of consistency within this header file.

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
