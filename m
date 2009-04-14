From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Apr 2009 00:00:48 +0000
Subject: Re: [Review request] sh-sci clock
Message-Id: <20090414000048.GA17618@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 13, 2009 at 01:17:59PM +0900, Kuninori Morimoto wrote:
> diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
> index d0aa82d..5215b9d 100644
> --- a/drivers/serial/sh-sci.h
> +++ b/drivers/serial/sh-sci.h
> @@ -761,9 +761,9 @@ static inline int sci_rxd_in(struct uart_port *port)
>  static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
>  {
>  	if (port->type = PORT_SCIF)
> -		return (clk+16*bps)/(32*bps)-1;
> +		return (clk/(32*bps))-1;
>  	else
> -		return ((clk*2)+16*bps)/(16*bps)-1;
> +		return (clk/(16*bps))-1;
>  }
>  #define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
>  #elif defined(__H8300H__) || defined(__H8300S__)

This looks like an unrelated change, can you explain what this is about?
