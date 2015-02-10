From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2015 10:45:56 +0000
Subject: Re: [PATCH 4/4] usb: renesas_usbhs: add support for USB-DMAC
Message-Id: <CAMuHMdV0T_5f+nnYoDRcR+Zm8_-ALP9ShJw3GGBnR9iNGUfEGw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423469774-6532-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1423469774-6532-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1423469774-6532-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, USB list <linux-usb@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Shimoda-san,

On Mon, Feb 9, 2015 at 9:16 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Some Renesas SoCs have the USB-DMAC. It is able to terminate transfers
> when a short packet is received, even if less bytes than the transfer
> counter size have been received. Also, it is able to send a short
> packet even if the packet size is not multiples of 8bytes.
>
> Since the previous code has used the interruption of USBHS controller
> when receiving packets even if this driver has used a dmac, a lot of
> interruptions has happened. This patch will reduce such interruptions.
>
> This patch allows to use the USB-DMAC on R-Car H2 and M2.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c

> @@ -487,6 +497,15 @@ static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
>         if (gpio > 0)
>                 dparam->enable_gpio = gpio;
>
> +       switch (dparam->type) {
> +       case USBHS_TYPE_R8A7790:
> +       case USBHS_TYPE_R8A7791:
> +               dparam->has_usb_dmac = 1;
> +               break;
> +       default:
> +               break;
> +       }
> +
>         return info;
>  }

>  struct usbhs_priv *usbhs_pdev_to_priv(struct platform_device *pdev);
> diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
> index 3b77a1b..1e7dc6e 100644
> --- a/drivers/usb/renesas_usbhs/fifo.c
> +++ b/drivers/usb/renesas_usbhs/fifo.c

> @@ -847,10 +849,13 @@ static int usbhsf_dma_prepare_push(struct usbhs_pkt *pkt, int *is_done)
>             usbhs_pipe_is_dcp(pipe))
>                 goto usbhsf_pio_prepare_push;
>
> -       if (len & 0x7) /* 8byte alignment */
> +       /* default: 8byte alignment */
> +       if (!usbhs_get_dparam(priv, has_usb_dmac) && len & 0x7)
>                 goto usbhsf_pio_prepare_push;

So the has_usb_dmac flags indicates that DMA addresses are not limited to
8-byte alignment.

Can't this be handled by looking at a dma_mask, as set by the DMAC?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
