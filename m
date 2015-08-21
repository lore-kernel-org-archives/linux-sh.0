From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 21 Aug 2015 23:17:50 +0000
Subject: Re: [PATCH/RFC v3 1/4] serial: sh-sci: Stop TX and RX on shutdown
Message-Id: <1780221.Xost2UeeDz@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1440181546-7334-1-git-send-email-geert+renesas@glider.be> <1440181546-7334-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440181546-7334-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 21 August 2015 20:25:43 Geert Uytterhoeven wrote:
> Make sure the transmitter and receiver are stopped when shutting down
> the port, to avoid new RX DMA requests to arrive.
> 
> Inspired by a patch in the BSP by Koji Matsuoka
> <koji.matsuoka.xm@renesas.com>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - No changes,
> 
> v2:
>   - New.
> ---
>  drivers/tty/serial/sh-sci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index d8b73e791a554823..0622cafaf1c71cab 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1820,12 +1820,16 @@ static void sci_shutdown(struct uart_port *port)
>  {
>  	struct sci_port *s = to_sci_port(port);
>  	unsigned long flags;
> +	u16 scscr;
> 
>  	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
> 
>  	spin_lock_irqsave(&port->lock, flags);
>  	sci_stop_rx(port);
>  	sci_stop_tx(port);
> +	scscr = serial_port_in(port, SCSCR);
> +	scscr &= ~(SCSCR_TE | SCSCR_RE);
> +	serial_port_out(port, SCSCR, scscr);

Given that the register contains lots of interrupt enable bits, would it make 
sense to just write it to 0 to disable everything ? I don't think we need to 
keep any of the SCSCR bits across shutdown/startup.

>  	spin_unlock_irqrestore(&port->lock, flags);
> 
>  	sci_free_dma(port);

-- 
Regards,

Laurent Pinchart

