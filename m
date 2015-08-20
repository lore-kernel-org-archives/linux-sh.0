From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Aug 2015 12:54:41 +0000
Subject: Re: [PATCH/RFC v2 00/29] serial: sh-sci: Miscellaneous and DMA Improvements
Message-Id: <CAMuHMdXnCOP2gTrwBBoU4prppfF0AqCdNboQr7wvin6yDZwsZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437070920-28069-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1437070920-28069-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Thu, Jul 30, 2015 at 12:42 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> I investigated this driver more. And then, I found some issues about RX DMA.
> So, I wrote some patches below. Would you check them?

Thanks a lot for these patches! I will include them with v3.

> (Or, should I send these patches to the ML using "git send-email"?)

No, I can extract them fine.

> Subject: [PATCH 1/3] serial: sh-sci: Avoid disable_irq_nosync() twice after sci_er_interrupt()
>
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> This patch fixes an issue that this driver calls disable_irq_nosync()
> twice wrongly in a specific condition. After that, this driver cannot
> work correctly:
>  - CONFIG_SERIAL_SH_SCI_DMA=y
>  - SCIFA or SCIFB
>  - After overrun happened
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index e1ac4c3b..ab1e15a 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -958,7 +958,14 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
>
>                 /* Disable future Rx interrupts */
>                 if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
> -                       disable_irq_nosync(irq);
> +                       /*
> +                        * Since this function is called by sci_mpxed_interrupt
> +                        * and sci_er_interrupt, this function may call
> +                        * disale_irq_nosync() twice wrongly. And then, this
> +                        * driver doesn't enable the interrupt anymore.
> +                        */
> +                       if (!(scr & SCSCR_RDRQE))
> +                               disable_irq_nosync(irq);
>                         scr |= SCSCR_RDRQE;
>                 } else {
>                         scr &= ~SCSCR_RIE;

Right.

As I started submitting the RX DMA requests from sci_rx_interrupt() on (H)SCIF
(to avoid the 1-byte DMA transfer), that's also screwed up by the double call.

I think sci_er_interrupt() should call sci_rx_interrupt() for the PIO case
only. Which boils down to just calling sci_receive_chars():

        } else {
                sci_handle_fifo_overrun(port);
-               sci_rx_interrupt(irq, ptr);
+               if (!s->chan_rx)
+                       sci_receive_chars(ptr);
        }

> Subject: [PATCH 2/3] serial: sh-sci: Don't kick tx in sci_er_interrupt()
>
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> If CONFIG_SERIAL_SH_SCI_DMA is enabled, the driver doesn't enable TIE
> on SCIF or HSCIF. However, this driver may call sci_tx_interrupt()
> in sci_er_interrupt(). After that, the driver cannot care of the
> interrupt, and then "irq 109: nobody cared" happens on r8a7791/koelsch
> board. This patch fixes the issue.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index ab1e15a..87ebce7 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1021,9 +1021,6 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
>
>         sci_clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
>
> -       /* Kick the transmission */
> -       sci_tx_interrupt(irq, ptr);
> -

I think this is still needed for the PIO case.
Hence:

        /* Kick the transmission */
-       sci_tx_interrupt(irq, ptr);
+       if (!s->chan_tx)
+               sci_tx_interrupt(irq, ptr);

>         return IRQ_HANDLED;
>  }

> Subject: [PATCH 3/3] serial: sh-sci: return IRQ_HANDLED if detects overrun
>
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> This patch fix an issue that the driver may cause "nobody cared" IRQ
> when this driver detects the overrun flag only.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 87ebce7..b896a1c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1090,8 +1090,10 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
>                 ret = sci_br_interrupt(irq, ptr);
>
>         /* Overrun Interrupt */
> -       if (orer_status & s->overrun_mask)
> +       if (orer_status & s->overrun_mask) {
>                 sci_handle_fifo_overrun(port);
> +               ret = IRQ_HANDLED;
> +       }
>
>         return ret;
>  }

Thanks, obviously correct.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
