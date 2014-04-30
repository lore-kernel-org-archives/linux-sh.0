From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Apr 2014 06:43:04 +0000
Subject: Re: [RFC/PATCH 2/6] serial: sh-sci: Drop the interface clock
Message-Id: <20140430064304.GC5153@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Apr 30, 2014 at 02:31:42AM +0200, Laurent Pinchart wrote:
> As no platform defines an interface clock the SCI driver always fall
> back to a clock named "peripheral_clk". On SH platform that clock is the
> base clock for the SCI functional clock and has the same frequency. On
> ARM platforms that clock doesn't exist, and clk_get() will return the
> default clock for the device. We can thus make the functional clock
> mandatory and drop the interface clock.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../bindings/serial/renesas,sci-serial.txt         |  4 +-
>  drivers/tty/serial/sh-sci.c                        | 52 ++++++++++++----------
>  2 files changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index 53e6c17..efc9eda 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -26,7 +26,7 @@ Required properties:
>  
>    - clocks: Must contain a phandle and clock-specifier pair for each entry
>      in clock-names.
> -  - clock-names: Must contain "sci_ick" for the SCIx UART interface clock.
> +  - clock-names: Must contain "fck" for the SCIx UART functional clock.

I have tested that this patch works on the Koelsch and Lager boards
with the remainder of the series applied and a fixup for the Lager patch,
as noted in a response to that patch.

I have also tested that this patch works on the Marzen board with a
modified version of my series to enable SCI via DT on that board.


It was my understanding that this patch would not break existing bindings.
However, if my reading and testing of this patch correct this patch
modifies an existing binding, included in v3.14, in an incompatible way.
Requiring all users of "sci_ick" to be updated to "fck".

This includes the DT nodes provided for the r8a7790 and r8a7791 which are
present in v3.15-rc1 and will also be included in v3.15 unless this patch,
its dependencies and the patches in this series that update the dtsi for
those SoCs are submitted as fixes for v3.15. (I am aware the nodes in
question are "disabled" :)

I would prefer if this change it was done in a way that maintains
compatibility with the published binding.

Apart from addressing my concern above such an approach would also allow
patches that enable SCI via DT (using "sci_ick") to be merged independently
of this driver change. Although I am happy to wait on those if you have a
strong preference for them to use the updated binding.

>  Note: Each enabled SCIx UART should have an alias correctly numbered in the
>  "aliases" node.
> @@ -42,5 +42,5 @@ Example:
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
> -		clock-names = "sci_ick";
> +		clock-names = "fck";
>  	};
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 88236da..ea4255c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -90,8 +90,6 @@ struct sci_port {
>  	struct timer_list	break_timer;
>  	int			break_flag;
>  
> -	/* Interface clock */
> -	struct clk		*iclk;
>  	/* Function clock */
>  	struct clk		*fclk;
>  
> @@ -442,9 +440,8 @@ static void sci_port_enable(struct sci_port *sci_port)
>  
>  	pm_runtime_get_sync(sci_port->port.dev);
>  
> -	clk_prepare_enable(sci_port->iclk);
> -	sci_port->port.uartclk = clk_get_rate(sci_port->iclk);
>  	clk_prepare_enable(sci_port->fclk);
> +	sci_port->port.uartclk = clk_get_rate(sci_port->fclk);
>  }
>  
>  static void sci_port_disable(struct sci_port *sci_port)
> @@ -461,7 +458,6 @@ static void sci_port_disable(struct sci_port *sci_port)
>  	sci_port->break_flag = 0;
>  
>  	clk_disable_unprepare(sci_port->fclk);
> -	clk_disable_unprepare(sci_port->iclk);
>  
>  	pm_runtime_put_sync(sci_port->port.dev);
>  }
> @@ -1045,7 +1041,7 @@ static int sci_notifier(struct notifier_block *self,
>  		struct uart_port *port = &sci_port->port;
>  
>  		spin_lock_irqsave(&port->lock, flags);
> -		port->uartclk = clk_get_rate(sci_port->iclk);
> +		port->uartclk = clk_get_rate(sci_port->fclk);
>  		spin_unlock_irqrestore(&port->lock, flags);
>  	}
>  
> @@ -2097,6 +2093,30 @@ static struct uart_ops sci_uart_ops = {
>  #endif
>  };
>  
> +static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
> +{
> +	/* Get the SCI functional clock. It's called "fck" on ARM. */
> +	sci_port->fclk = clk_get(dev, "fck");
> +	if (!IS_ERR(sci_port->fclk))
> +		return 0;
> +
> +	/* SH has historically named the clock "sci_fck". */
> +	sci_port->fclk = clk_get(dev, "sci_fck");
> +	if (!IS_ERR(sci_port->fclk))
> +		return 0;
> +
> +	/*
> +	 * Not all SH platforms declare a clock lookup entry for SCI devices, in
> +	 * which case we need to get the global "peripheral_clk" clock.
> +	 */
> +	sci_port->fclk = clk_get(dev, "peripheral_clk");
> +	if (!IS_ERR(sci_port->fclk))
> +		return 0;
> +
> +	dev_err(dev, "failed to can't get fclk\n");
> +	return PTR_ERR(sci_port->fclk);
> +}
> +
>  static int sci_init_single(struct platform_device *dev,
>  			   struct sci_port *sci_port, unsigned int index,
>  			   struct plat_sci_port *p, bool early)
> @@ -2183,22 +2203,9 @@ static int sci_init_single(struct platform_device *dev,
>  				: sampling_rate;
>  
>  	if (!early) {
> -		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
> -		if (IS_ERR(sci_port->iclk)) {
> -			sci_port->iclk = clk_get(&dev->dev, "peripheral_clk");
> -			if (IS_ERR(sci_port->iclk)) {
> -				dev_err(&dev->dev, "can't get iclk\n");
> -				return PTR_ERR(sci_port->iclk);
> -			}
> -		}
> -
> -		/*
> -		 * The function clock is optional, ignore it if we can't
> -		 * find it.
> -		 */
> -		sci_port->fclk = clk_get(&dev->dev, "sci_fck");
> -		if (IS_ERR(sci_port->fclk))
> -			sci_port->fclk = NULL;
> +		ret = sci_init_clocks(sci_port, &dev->dev);
> +		if (ret < 0)
> +			return ret;
>  
>  		port->dev = &dev->dev;
>  
> @@ -2252,7 +2259,6 @@ static int sci_init_single(struct platform_device *dev,
>  
>  static void sci_cleanup_single(struct sci_port *port)
>  {
> -	clk_put(port->iclk);
>  	clk_put(port->fclk);
>  
>  	pm_runtime_disable(port->port.dev);
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
