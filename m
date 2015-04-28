From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2015 09:02:05 +0000
Subject: Re: [PATCH 1/3] spi: Re-do the returning value of rspi_dma_check_then_transfer
Message-Id: <CAMuHMdU8fHW9SCHPTpjwQMfsQc7Qn3F29-P2tsi_j-4Pjp_QCg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>
	<1430200551-20708-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1430200551-20708-2-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Hiep-san,

On Tue, Apr 28, 2015 at 7:55 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> To reduce indentation and complex of code, insteeds of returning zero,
> the function rspi_dma_check_then_transfer should be returned
> rspi_dma_transfer directly after checking error.

Thanks for the update!

Unfortunately it doesn't compile...

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -665,15 +665,12 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
>  static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
>                                          struct spi_transfer *xfer)
>  {
> -       if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
> -               /* rx_buf can be NULL on RSPI on SH in TX-only Mode */
> -               int ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
> -                                       xfer->rx_buf ? &xfer->rx_sg : NULL);
> -               if (ret != -EAGAIN)
> -                       return 0;
> -       }
> +       if (!rspi->master->can_dma || !__rspi_can_dma(rspi, xfer)) {

Superfluous opening curly brace.
Please compile and run test your patches.
Thanks!

> +               return -EAGAIN;
>
> -       return -EAGAIN;
> +       /* rx_buf can be NULL on RSPI on SH in TX-only Mode */
> +       return rspi_dma_transfer(rspi, &xfer->tx_sg,
> +                                       xfer->rx_buf ? &xfer->rx_sg : NULL);
>  }
>
>  static int rspi_common_transfer(struct rspi_data *rspi,




-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
