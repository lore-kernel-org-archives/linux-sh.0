From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Jan 2015 09:59:03 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: fix NULL pointer dereference in dma_release_channel()
Message-Id: <CAMuHMdWoARjqvUv5HGSuSF92nSrNWgzqMjb_xVJh7mkdcObGkQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422601103-1144-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1422601103-1144-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Fri, Jan 30, 2015 at 7:58 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch fixes an issue that the following commit causes NULL
> pointer dereference in dma_release_channel().
>  "usb: renesas_usbhs: add support for requesting DT DMA"
>  (commit id abd2dbf6bb1b5f3a03a8c76b1a8879da1dd30caa)

Thanks for your patch!

> The usbhsf_dma_init_dt() should set fifo->{t,r}x_chan to NULL if
> dma_request_slave_channel_reason() returns IS_ERR value.
> Otherwise, usbhsf_dma_quit() will call dma_release_channel(), and then
> NULL pointer dereference happens.

I guess it also causes other problems?
The return value of usbhsf_dma_chan_get() is not checked for an error
code in many callsites.

> Reported-by: Simon Horman <horms@verge.net.au>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
> This patch is based on Felipe's usb.git / testing/next branch.
> (commit id }b3990cb707ff91cd6507d53a0a730afe97)
>
>  drivers/usb/renesas_usbhs/fifo.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
> index 4c086b1..d891bff 100644
> --- a/drivers/usb/renesas_usbhs/fifo.c
> +++ b/drivers/usb/renesas_usbhs/fifo.c
> @@ -1072,7 +1072,11 @@ static void usbhsf_dma_init_pdev(struct usbhs_fifo *fifo)
>  static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo)
>  {
>         fifo->tx_chan = dma_request_slave_channel_reason(dev, "tx");
> +       if (IS_ERR(fifo->tx_chan))
> +               fifo->tx_chan = NULL;
>         fifo->rx_chan = dma_request_slave_channel_reason(dev, "rx");
> +       if (IS_ERR(fifo->rx_chan))
> +               fifo->rx_chan = NULL;
>  }

My first thought was: shouldn't it be handled in usbhsf_dma_init() instead,
so it applies to both the legacy platform data and the DT case?

But apparently dma_request_channel() returns NULL on failure, while
dma_request_slave_channel_reason() returns an error code. Oh well...

Remapping the error to NULL does mean the driver doesn't handle
-EPROBE_DEFER, but that's tricky with DMA engines anyway, cfr. commit
55f5f9862a31e2ac ("i2c: sh_mobile: rework deferred probing")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
