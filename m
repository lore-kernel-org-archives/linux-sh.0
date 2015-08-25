From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2015 09:00:21 +0000
Subject: Re: [PATCH] gpio: rcar: Enable support for ARM64
Message-Id: <CAMuHMdUjL1LzeU9Epnb5OdV+adKhjw=fDp1OjjgmXM=_UA=Adg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440493005-6598-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1440493005-6598-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 25, 2015 at 10:56 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Enables the R-Car GPIO driver on ARM64.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 8f1fe73..2256b2f 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -356,7 +356,7 @@ config GPIO_PXA
>
>  config GPIO_RCAR
>         tristate "Renesas R-Car GPIO"
> -       depends on ARM && (ARCH_SHMOBILE || COMPILE_TEST)
> +       depends on (ARM || ARM64) && (ARCH_SHMOBILE || COMPILE_TEST)

Same comment as to the identical patch Morimoto-san just posted:

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
