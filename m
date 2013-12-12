From: Olof Johansson <olof@lixom.net>
Date: Thu, 12 Dec 2013 01:05:03 +0000
Subject: Re: [PATCH v4 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <20131212010503.GI21531@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20131211235616.12661.19702.sendpatchset@w520>
 <20131211235626.12661.8865.sendpatchset@w520>
In-Reply-To: <20131211235626.12661.8865.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, john.stultz@linaro.org, tglx@linutronix.de

Hi,

A couple of small comments below.

On Thu, Dec 12, 2013 at 08:56:26AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add Kconfig entries for CMT, MTU2, TMU and STI to
> drivers/clocksource/Kconfig. This will allow us to
> get rid of duplicated entires in architecture code
> such as arch/sh and arch/arm/mach-shmobile.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/clocksource/Kconfig |   44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> --- 0001/drivers/clocksource/Kconfig
> +++ work/drivers/clocksource/Kconfig	2013-12-12 08:41:55.000000000 +0900
> @@ -134,3 +134,47 @@ config VF_PIT_TIMER
>  	bool
>  	help
>  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
> +
> +config SYS_SUPPORTS_CMT
> +        bool
> +
> +config SYS_SUPPORTS_TMU
> +        bool
> +
> +config SYS_SUPPORTS_MTU2
> +        bool
> +
> +config SYS_SUPPORTS_STI
> +        bool

Maybe a prefix to avoid namespace collissions here?

> +
> +config SH_TIMER_CMT
> +	bool "Renesas CMT timer driver" if COMPILE_TEST
> +	default SYS_SUPPORTS_CMT

It might be useful to have an explicit depends on ARCH_SH || ARCH_SHMOBILE
|| COMPILE_TEST on these, just to make it easier for someone reading
the code later on.


-Olof
