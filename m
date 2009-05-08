From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 08 May 2009 02:48:36 +0000
Subject: Re: [PATCH] sh: sh7785lcr clock fixes
Message-Id: <20090508024836.GC26125@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090507104813.31966.8510.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090507104813.31966.8510.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 07, 2009 at 07:48:13PM +0900, Magnus Damm wrote:
> --- 0001/arch/sh/boards/board-sh7785lcr.c
> +++ work/arch/sh/boards/board-sh7785lcr.c	2009-05-07 18:34:15.000000000 +0900
> @@ -289,6 +289,9 @@ static void sh7785lcr_power_off(void)
>  		cpu_relax();
>  }
>  
> +#define PNCR 0xffe70018
> +#define PNDR 0xffe70038
> +
>  /* Initialize the board */
>  static void __init sh7785lcr_setup(char **cmdline_p)
>  {
> @@ -301,6 +304,13 @@ static void __init sh7785lcr_setup(char 
>  	/* sm501 DRAM configuration */
>  	sm501_reg = (void __iomem *)0xb3e00000 + SM501_DRAM_CONTROL;
>  	writel(0x000307c2, sm501_reg);
> +
> +	/* read PN5 pin to get MODE4/PLL configuration for clock code */
> +	ctrl_outw(ctrl_inw(PNCR) | 0x0c00, PNCR);
> +	if (ctrl_inb(PNDR) & 0x20)
> +		parse_early_options("mode4_pin=high");
> +	else
> +		parse_early_options("mode4_pin=low");
>  }
>  
>  /*

This seems like a pretty lame way to avoid making a function call. Beyond
that, all you really want to do is:

	mode4_pin = !!(__raw_readb(PNDR) & 0x20);

Just have something like a __setup_mode4_pin() that does the real work,
and expose that as an accessor. The string parsing especially is utterly
superfluous.

On Thu, May 07, 2009 at 07:50:56PM +0900, Magnus Damm wrote:
> --- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
> +++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-05-07 16:28:24.000000000 +0900
> @@ -15,6 +15,22 @@
>  #include <asm/freq.h>
>  #include <asm/io.h>
>  
> +static int mode4_pin;
> +
> +static int __init setup_mode4_pin(char *buf)
> +{
> +	if (buf) {
> +		if (strstr(buf, "high"))
> +			mode4_pin = 1;
> +
> +		if (strstr(buf, "low"))
> +			mode4_pin = 0;
> +	}
> +
> +	return 0;
> +}
> +early_param("mode4_pin", setup_mode4_pin);
> +
I wonder how you really want to handle this, this will permit the kernel
param to clobber whatever the PNDR state returns, is that really what you
want? Anyways, the string parsing here too should be taken out and shot.
1 and 0 are quite acceptable values for a pin state, if folks can't work
that out, they shouldn't be toggling the pin in the first place.
