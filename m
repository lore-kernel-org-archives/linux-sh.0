From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2015 10:15:36 +0000
Subject: Re: [PATCH v2 1/4] usb: renesas_usbhs: fix spinlock suspected in a gadget complete function
Message-Id: <CAMuHMdXOkzznW_4KJwqiO5UgYXYN2tZ+2OEYwA+eQJF2S-Z8jQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1424051579-5060-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1424051579-5060-2-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Shimoda-san,

On Mon, Feb 16, 2015 at 2:52 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> According to the gadget.h, a "complete" function will always be called
> with interrupts disabled. However, sometimes usbhsg_queue_pop() function
> is called with interrupts enabled. So, this function should calls
> local_irq_save() before this calls the usb_gadget_giveback_request().
> Otherwise, there is possible to cause a spinlock suspected in a gadget
> complete function.

I still feel uneasy about adding the call to local_irq_save(), as the need for
this is usually an indicator of another locking problem.

Unfortunately I know next to nothing about the USB gadget subsystem, so some
help from the USB gadget experts would be appreciated.

I had a look at other drivers, and it seems most drivers actually release
and reacquire a spinlock around the call to usb_gadget_giveback_request(),
i.e. they do:

    spin_unlock(...);
    usb_gadget_giveback_request(...);
    spin_lock();

This means they had already acquired the spinlock (and disabled interrupts!)
before, which looks much healthier to me.

There's only one driver that uses local_irq_save() (pxa27x_udc).

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/renesas_usbhs/mod_gadget.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
> index e0384af..104bddf 100644
> --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> @@ -126,11 +126,22 @@ static void usbhsg_queue_pop(struct usbhsg_uep *uep,
>         struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
>         struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
>         struct device *dev = usbhsg_gpriv_to_dev(gpriv);
> +       unsigned long flags;
>
>         dev_dbg(dev, "pipe %d : queue pop\n", usbhs_pipe_number(pipe));
>
>         ureq->req.status = status;
> +       /*
> +        * According to the gadget.h, a "complete" function will always be
> +        * called with interrupts disabled. However, sometimes this function
> +        * is called with interrupts enabled. (e.g. complete a DMAC transfer or
> +        * write data and done is set immediately when PIO.) So, this function
> +        * should calls local_irq_save() before this calls the
> +        * usb_gadget_giveback_request().
> +        */
> +       local_irq_save(flags);
>         usb_gadget_giveback_request(&uep->ep, &ureq->req);
> +       local_irq_restore(flags);
>  }
>
>  static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbhs_pkt *pkt)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
