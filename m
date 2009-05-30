From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sat, 30 May 2009 13:27:16 +0000
Subject: Re: [PATCH] clocksource: SuperH TMU Timer driver
Message-Id: <4A213434.4030800@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090501065100.8800.99808.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090501065100.8800.99808.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus, could you provide an answer to my question on SH-TMU?

Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds a TMU driver for the SuperH architecture.
> 
> The TMU driver is a platform driver with early platform
> support to allow using a TMU channel as clockevent or
> clocksource during system bootup or later.
> 
> Clocksource or clockevent can be selected.
> Both periodic and oneshot clockevents are supported.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Tested on a Migo-R board with sh7722.
>  Applies on top of the MTU2 patches.
>  Clocksource operation requires the following patch:
>  "clocksource: setup mult_orig in clocksource_enable()"
> 
>  arch/sh/Kconfig              |   12 +
>  drivers/clocksource/Makefile |    1 
>  drivers/clocksource/sh_tmu.c |  461 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sh_tmu.h       |   13 +
>  4 files changed, 487 insertions(+)
> 
> --- 0006/arch/sh/Kconfig
> +++ work/arch/sh/Kconfig	2009-05-01 13:18:03.000000000 +0900
> @@ -116,6 +116,9 @@ config SYS_SUPPORTS_CMT
>  config SYS_SUPPORTS_MTU2
>  	bool
>  
> +config SYS_SUPPORTS_TMU
> +	bool
> +
>  config STACKTRACE_SUPPORT
>  	def_bool y
>  
> @@ -470,6 +473,15 @@ config SH_TMU
>  	help
>  	  This enables the use of the TMU as the system timer.
>  
> +config SH_TIMER_TMU
> +	bool "TMU timer driver"
> +	depends on !SH_TMU && SYS_SUPPORTS_TMU
> +	default y
> +	select GENERIC_TIME
> +	select GENERIC_CLOCKEVENTS
> +	help
> +	  This enables the build of the TMU timer driver.
> +
>  config SH_TIMER_CMT
>  	bool "CMT timer driver"
>  	depends on SYS_SUPPORTS_CMT
> --- 0004/drivers/clocksource/Makefile
> +++ work/drivers/clocksource/Makefile	2009-05-01 13:17:38.000000000 +0900
> @@ -4,3 +4,4 @@ obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
>  obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
>  obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
>  obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
> +obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
> --- /dev/null
> +++ work/drivers/clocksource/sh_tmu.c	2009-05-01 13:20:00.000000000 +0900
> @@ -0,0 +1,461 @@
(snip...)

> +static void sh_tmu_set_next(struct sh_tmu_priv *p, unsigned long delta,
> +			    int periodic)
> +{
> +	/* stop timer */
> +	sh_tmu_start_stop_ch(p, 0);
> +
> +	/* acknowledge interrupt */
> +	sh_tmu_read(p, TCR);
> +
> +	/* enable interrupt */
> +	sh_tmu_write(p, TCR, 0x0020);
> +
> +	/* reload delta value in case of periodic timer */
> +	if (periodic)
> +		sh_tmu_write(p, TCOR, delta);
> +	else
> +		sh_tmu_write(p, TCOR, 0);
> +
> +	sh_tmu_write(p, TCNT, delta);
> +
> +	/* start timer */
> +	sh_tmu_start_stop_ch(p, 1);
> +}

In some occasions, qemu-sh prints out a lot of warnings on timer
with this message : 'Timer with period zero. disabling.'

I made some investigation, and found that the warnings are printed
after zero value is set to TCOR.  I checked SH7785 hardware manual,
but could not find any description what happens when zero value set
to TCOR.

According to the code above, I guess that TMU works as a non-periodic
one-shot timer when the TCOR value is zero. Is it right?


Regards,
Shin-ichiro KAWASAKI
