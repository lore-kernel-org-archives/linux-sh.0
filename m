From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2015 07:25:57 +0000
Subject: Re: [PATCH 1/1] spi: Re-do correctly function name and 'ret' return value
Message-Id: <CAMuHMdWm2i-48mOUFCcFuXEAyFimkW+Yw7wdzgOa8rOgpfbMWw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1429857656-8348-1-git-send-email-cm-hiep@jinso.co.jp>
	<1429857656-8348-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1429857656-8348-2-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Hiep-san,

On Fri, Apr 24, 2015 at 8:40 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>
> qspi_trigger_transfer_out_int function should be qspi_trigger_transfer_out_in
> without "t". "ret" value in rspi_dma_check_then_transfer should be returned
> insteeds of returning zero. It just returns qspi_trigger_transfer_out_in() value
> in qspi_transfer_out_in().

Thanks for your patch!

I guess Mark will want you to split this in 3 separate patches, as it does 3
different things...

> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> ---
>  drivers/spi/spi-rspi.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 186924a..9304a6d 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -670,7 +670,7 @@ static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
>                 int ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
>                                         xfer->rx_buf ? &xfer->rx_sg : NULL);
>                 if (ret != -EAGAIN)
> -                       return 0;
> +                       return ret;
>         }
>
>         return -EAGAIN;

Upon closer look, you can just drop the "if" check, and return "ret"
unconditionally. Or better, drop "ret", and just use

        return rspi_dma_transfer(...);

To reduce indentation, the function can be rewritten like:

static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
                                         struct spi_transfer *xfer)
{
        if (!rspi->master->can_dma || !__rspi_can_dma(rspi, xfer))
                return -EAGAIN;

        /* rx_buf can be NULL on RSPI on SH in TX-only Mode */
        return rspi_dma_transfer(rspi, &xfer->tx_sg,
                                        xfer->rx_buf ? &xfer->rx_sg : NULL);
}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
