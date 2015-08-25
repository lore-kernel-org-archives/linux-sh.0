From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2015 08:58:16 +0000
Subject: Re: [PATCH] gpio: rcar: Enable r8a7795 for ARM64
Message-Id: <CAMuHMdVGZyM7b3ONvrVF6-excdV094miUt97rSp-AVigH_CFoA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8737z77ok8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8737z77ok8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Morimoto-san,

On Tue, Aug 25, 2015 at 10:39 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> 8cd1470("gpio: rcar: Add r8a7795 (R-Car H3) support") adds
> GPIO support for r8a7795. r8a7795 based on CONFIG_ARM64.
> This patch enables r8a7795 on ARM64.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b4fc9e4..5d083f7 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -356,7 +356,7 @@ config GPIO_PXA
>
>  config GPIO_RCAR
>         tristate "Renesas R-Car GPIO"
> -       depends on ARM && (ARCH_SHMOBILE || COMPILE_TEST)
> +       depends on (ARM || ARM64) && (ARCH_SHMOBILE || COMPILE_TEST)

As this driver seems to compile fine on non-ARM, what about relaxing the
dependency to

    depends on ARCH_SHMOBILE || COMPILE_TEST

instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
