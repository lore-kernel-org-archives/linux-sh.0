From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2015 08:01:50 +0000
Subject: Re: [PATCH 2/2] spi: rspi: Remove obsolete qspi platform_device_id entry
Message-Id: <CAMuHMdUEWmNKreYcMOyJZjBiL_raG37BdSTAnFGg_W-jqOuV1Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
	<1435064527-11786-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064527-11786-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Jun 23, 2015 at 3:02 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
> board support"), R-Car Gen2 SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/spi/spi-rspi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 56216b205e0f2c34..3e82b84c9ed48b2f 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -1295,7 +1295,6 @@ error1:
>
>  static const struct platform_device_id spi_driver_ids[] = {
>         { "rspi",       (kernel_ulong_t)&rspi_ops },
> -       { "qspi",       (kernel_ulong_t)&qspi_ops },
>         {},
>  };

qspi_ops is still used for DT matching, but rspi_of_match[] is protected
by #ifdef CONFIG_OF, so this may lead to compiler warnings.

Please drop this one, will fix.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
