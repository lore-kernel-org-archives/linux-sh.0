From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 09 Dec 2014 10:53:45 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <CAMuHMdW7Y_OXWySwxDch82gcGv0fyFPQAxXwSFKQz-QbDN4cPQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
	<1415355104-2031-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1415355104-2031-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

On Fri, Nov 7, 2014 at 11:11 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -727,6 +886,21 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
>         if (ret)
>                 return ret;
>
> +       /* Init DMA */
> +       sg_init_table(&pd->sg, 1);
> +       pd->dma_direction = DMA_NONE;
> +       ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
> +                                            res->start + ICDR, &pd->dma_rx);
> +       if (ret = -EPROBE_DEFER)
> +               return ret;
> +
> +       ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
> +                                            res->start + ICDR, &pd->dma_tx);
> +       if (ret = -EPROBE_DEFER) {
> +               sh_mobile_i2c_release_dma(pd);
> +               return ret;
> +       }
> +

If the DTS contains "dma" and "dma-names" properties, but CONFIG_RCAR_DMAC
is disabled, sh_mobile_i2c_request_dma_chan() returns -EPROBE_DEFER,
and the driver fails to initialize.

If I remove the "dma" and "dma-names" properties, the driver does fall back
to PIO mode.

I think this is a regression.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
