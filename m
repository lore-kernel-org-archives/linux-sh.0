From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2015 10:40:33 +0000
Subject: Re: [PATCH 1/4] usb: renesas_usbhs: fix spinlock recursion by usbhsf_dma_complete()
Message-Id: <CAMuHMdXkPciXDbEp97FbD8Q3S6KxvoZexAO3EYYg3-KsL7dg2g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423469774-6532-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1423469774-6532-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1423469774-6532-2-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Shimoda-san,

On Mon, Feb 9, 2015 at 9:16 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The usbhsf_pkt_handler(pipe, USBHSF_PKT_DMA_DONE) in usbhsf_dma_complete()
> will call the complete function of a usb gadget driver finally.
> According to the gadget.h, "The function will always be called with
> interrupts disabled".
>
> So, this patch adds a local_irq_save/local_irq_restore in the
> usbhsf_dma_complete() because a dmaengine driver may call this
> callback function when interrupts enabled (e.g. in tasklet).
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/renesas_usbhs/fifo.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
> index d891bff..b1440d0 100644
> --- a/drivers/usb/renesas_usbhs/fifo.c
> +++ b/drivers/usb/renesas_usbhs/fifo.c
> @@ -1165,11 +1165,14 @@ static void usbhsf_dma_complete(void *arg)
>         struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
>         struct device *dev = usbhs_priv_to_dev(priv);
>         int ret;
> +       unsigned long flags;
>
> +       local_irq_save(flags);

Adding "local_irq_save()" without a spinlock is usually not correct.
I'm a bit confused here. usbhsf_pkt_handler() itself calls

        usbhs_lock(priv, flags);

which is actually

        spin_lock_irqsave(usbhs_priv_to_lock(priv), flags)

so it does disable interrupts internally?

Or is this about protecting the call to

        pkt->done(priv, pkt);

at the end of usbhsf_pkt_handler(), which is done after releasing the
spinlock?

Still, that would need some better protection, as local_irq_save() disables
interrupts only on the CPU it's running on, not on other CPUs in a
multiprocessor system.

>         ret = usbhsf_pkt_handler(pipe, USBHSF_PKT_DMA_DONE);
>         if (ret < 0)
>                 dev_err(dev, "dma_complete run_error %d : %d\n",
>                         usbhs_pipe_number(pipe), ret);
> +       local_irq_restore(flags);
>  }
>
>  void usbhs_fifo_clear_dcp(struct usbhs_pipe *pipe)
> --
> 1.7.9.5

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
