From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 23 May 2015 19:09:29 +0000
Subject: Re: [PATCH 4/8] serial: sh-sci: Use SCIF_DR instead of hardcoded 1
Message-Id: <1894468.fs1e2s7WTP@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432145174-11534-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432145174-11534-5-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 20 May 2015 20:06:10 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/tty/serial/sh-sci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 21c07c6cb0cd2220..73f4115159a7fbbc 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -960,7 +960,8 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
>  		}
>  		serial_port_out(port, SCSCR, scr);
>  		/* Clear current interrupt */
> -		serial_port_out(port, SCxSR, ssr & ~(1 | SCxSR_RDxF(port)));
> +		serial_port_out(port, SCxSR,
> +				ssr & ~(SCIF_DR | SCxSR_RDxF(port)));
>  		dev_dbg(port->dev, "Rx IRQ %lu: setup t-out in %u jiffies\n",
>  			jiffies, s->rx_timeout);
>  		mod_timer(&s->rx_timer, jiffies + s->rx_timeout);

-- 
Regards,

Laurent Pinchart

