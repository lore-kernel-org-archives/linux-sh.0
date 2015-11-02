From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Nov 2015 14:27:59 +0000
Subject: Re: [PATCH 01/14] serial: sh-sci: Drop the interface clock
Message-Id: <CAMuHMdWx-uuuKXEKccuem+yf5ioGxTuA8Pr63==D5z0tJH=5+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1442232876-27629-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442232876-27629-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Laurent,

On Mon, Sep 14, 2015 at 2:14 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> As no platform defines an interface clock the SCI driver always fall
> back to a clock named "peripheral_clk". On SH platform that clock is the
> base clock for the SCI functional clock and has the same frequency. On
> ARM platforms that clock doesn't exist, and clk_get() will return the
> default clock for the device. We can thus make the functional clock
> mandatory and drop the interface clock.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../bindings/serial/renesas,sci-serial.txt         |  4 +-
>  drivers/tty/serial/sh-sci.c                        | 60 +++++++++++++---------
>  2 files changed, 39 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index e84b13a8eda3..c390860bc23f 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt

> @@ -2181,6 +2177,38 @@ static struct uart_ops sci_uart_ops = {
>  #endif
>  };
>
> +static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
> +{
> +       /* Get the SCI functional clock. It's called "fck" on ARM. */
> +       sci_port->fclk = clk_get(dev, "fck");
> +       if (!IS_ERR(sci_port->fclk))
> +               return 0;
> +
> +       /*
> +        * But it used to be called "sci_ick", and we need to maintain DT
> +        * backward compatibility.
> +        */
> +       sci_port->fclk = clk_get(dev, "sci_ick");
> +       if (!IS_ERR(sci_port->fclk))
> +               return 0;
> +
> +       /* SH has historically named the clock "sci_fck". */
> +       sci_port->fclk = clk_get(dev, "sci_fck");
> +       if (!IS_ERR(sci_port->fclk))
> +               return 0;
> +
> +       /*
> +        * Not all SH platforms declare a clock lookup entry for SCI devices, in
> +        * which case we need to get the global "peripheral_clk" clock.
> +        */
> +       sci_port->fclk = clk_get(dev, "peripheral_clk");
> +       if (!IS_ERR(sci_port->fclk))
> +               return 0;
> +
> +       dev_err(dev, "failed to get functional clock\n");
> +       return PTR_ERR(sci_port->fclk);

This doesn't handle probe deferral correctly.
-EPROBE_DEFER from an earlier clock will be overwritten by -ENOENT from a
later clock, and the driver will never be reprobed.

> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
