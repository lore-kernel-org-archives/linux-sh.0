From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Jan 2008 05:25:38 +0000
Subject: Re: [PATCH] sh: add spi header and r2d platform data V2
Message-Id: <20080123052538.GA13344@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 23, 2008 at 01:53:56PM +0900, Magnus Damm wrote:
> +static void r2d_chip_select(struct sh_spi_info *spi, int cs, int state)
> +{
> +	BUG_ON(cs != 0);  /* Single Epson RTC-9701JE attached on CS0 */
> +	ctrl_outw(state = BITBANG_CS_ACTIVE ? 1 : 0, PA_RTCCE);
> +}
> +
The ? 1 : 0 thing is pointless here. = will already evaluate to this.
? 1 : 0 is almost always crap anyways. Either the result you want already
exists in terms of evaluation, or you want a !! for the far off bits. If
there's nothing in CodingStyle about this, there ought to be.

> @@ -176,6 +216,7 @@ static struct platform_device *rts7751r2
>  #endif
>  	&cf_ide_device,
>  	&heartbeat_device,
> +	&spi_sh_sci_device,
>  };
>  
>  static int __init rts7751r2d_devices_setup(void)

You've just added the device to the platform device registration.

> @@ -260,6 +301,12 @@ static void __init rts7751r2d_setup(char
>  	writel(readl(sm501_reg) | (1 << SM501_GATE_UART0), sm501_reg);
>  }
>  
> +static int __init r2d_register_spi(void)
> +{
> +	return spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
> +}
> +__initcall(r2d_register_spi);
> +

And then added your own magical initcall for registering the bus. We
already have rts7751r2d_devices_setup(), which as the name implies, is
intended specifically for this sort of thing. Please use that instead of
spreading around more initcall damage.
