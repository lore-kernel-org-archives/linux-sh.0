From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat, 16 May 2015 15:01:29 +0000
Subject: Re: [PATCH] sh-sci: Get register size from platform data
Message-Id: <87lhgoo9bq.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1431786127-10316-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1431786127-10316-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sorry. I mistake this patch.
Please ignore.

On Sat, 16 May 2015 23:22:07 +0900,
Yoshinori Sato wrote:
> 
> There is much implement of SCI,
> So the register size should be acquired from platform data.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/tty/serial/sh-sci.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 1468ec5..0263486 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -84,7 +84,7 @@ struct sci_port {
>  	int			overrun_bit;
>  	unsigned int		error_mask;
>  	unsigned int		sampling_rate;
> -
> +	unsigned int		reg_size;
>  
>  	/* Break timer */
>  	struct timer_list	break_timer;
> @@ -2073,23 +2073,9 @@ static const char *sci_type(struct uart_port *port)
>  	return NULL;
>  }
>  
> -static inline unsigned long sci_port_size(struct uart_port *port)
> -{
> -	/*
> -	 * Pick an arbitrary size that encapsulates all of the base
> -	 * registers by default. This can be optimized later, or derived
> -	 * from platform resource data at such a time that ports begin to
> -	 * behave more erratically.
> -	 */
> -	if (port->type = PORT_HSCIF)
> -		return 96;
> -	else
> -		return 64;
> -}
> -
>  static int sci_remap_port(struct uart_port *port)
>  {
> -	unsigned long size = sci_port_size(port);
> +	struct sci_port *sport = to_sci_port(port);
>  
>  	/*
>  	 * Nothing to do if there's already an established membase.
> @@ -2098,7 +2084,7 @@ static int sci_remap_port(struct uart_port *port)
>  		return 0;
>  
>  	if (port->flags & UPF_IOREMAP) {
> -		port->membase = ioremap_nocache(port->mapbase, size);
> +		port->membase = ioremap_nocache(port->mapbase, sport->reg_size);
>  		if (unlikely(!port->membase)) {
>  			dev_err(port->dev, "can't remap port#%d\n", port->line);
>  			return -ENXIO;
> @@ -2117,23 +2103,28 @@ static int sci_remap_port(struct uart_port *port)
>  
>  static void sci_release_port(struct uart_port *port)
>  {
> +	struct sci_port *sport = to_sci_port(port);
> +
>  	if (port->flags & UPF_IOREMAP) {
>  		iounmap(port->membase);
>  		port->membase = NULL;
>  	}
>  
> -	release_mem_region(port->mapbase, sci_port_size(port));
> +	release_mem_region(port->mapbase, sport->reg_size);
>  }
>  
>  static int sci_request_port(struct uart_port *port)
>  {
> -	unsigned long size = sci_port_size(port);
>  	struct resource *res;
> +	struct sci_port *sport = to_sci_port(port);
>  	int ret;
>  
> -	res = request_mem_region(port->mapbase, size, dev_name(port->dev));
> -	if (unlikely(res = NULL))
> +	res = request_mem_region(port->mapbase, sport->reg_size,
> +				 dev_name(port->dev));
> +	if (unlikely(res = NULL)) {
> +		dev_err(port->dev, "request_mem_region failed.");
>  		return -EBUSY;
> +	}
>  
>  	ret = sci_remap_port(port);
>  	if (unlikely(ret != 0)) {
> @@ -2151,7 +2142,6 @@ static void sci_config_port(struct uart_port *port, int flags)
>  
>  		port->type = sport->cfg->type;
>  		sci_request_port(port);
> -	}
>  }
>  
>  static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
> @@ -2207,6 +2197,7 @@ static int sci_init_single(struct platform_device *dev,
>  		return -ENOMEM;
>  
>  	port->mapbase = res->start;
> +	sci_port->reg_size = res->end - res->start + 1;
>  
>  	for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i)
>  		sci_port->irqs[i] = platform_get_irq(dev, i);
> -- 
> 2.1.4
> 
