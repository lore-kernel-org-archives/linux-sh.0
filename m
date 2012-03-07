From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 07 Mar 2012 13:41:10 +0000
Subject: Re: [PATCH 02/03] ARM: mach-shmobile: sh7372 generic board support via DT
Message-Id: <201203071341.10782.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094710.10442.59532.sendpatchset@t400s>
In-Reply-To: <20110630094710.10442.59532.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 07 March 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add generic DT board support for the sh7372 SoC.
> 
> SCIF serial ports and timers are kept as regular
> platform devices. Other on-chip and on-board devices
> should be configured via the device tree.
> 
> Tested on the mackerel board via kexec using a zImage
> kernel with an appended dtb.

This looks good as a start, very nice!
> 
>  arch/arm/mach-shmobile/setup-sh7372.c |   39 +++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

I think so far everyone has added the device tree source files to the kernel
when they did the conversion. I'd suggest you do that, too.

> --- 0034/arch/arm/mach-shmobile/setup-sh7372.c
> +++ work/arch/arm/mach-shmobile/setup-sh7372.c	2012-03-06 14:04:36.000000000 +0900
> @@ -1082,3 +1082,42 @@ void __init sh7372_add_early_devices(voi
>  	/* override timer setup with soc-specific code */
>  	shmobile_timer.init = sh7372_earlytimer_init;
>  }
> +
> +#ifdef CONFIG_USE_OF
> +
> +void __init sh7372_add_early_devices_dt(void)
> +{
> +	shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
> +
> +	early_platform_add_devices(sh7372_early_devices,
> +				   ARRAY_SIZE(sh7372_early_devices));
> +
> +	/* setup early console here as well */
> +	shmobile_setup_console();
> +}

Are these always 800MHz? Maybe it would be better to read the "clock-frequency"
property from the root node and use the value that is given for a particular
board.

	Arnd
