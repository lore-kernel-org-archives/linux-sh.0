From: John Stultz <john.stultz@linaro.org>
Date: Thu, 05 Dec 2013 18:32:53 +0000
Subject: Re: [PATCH v3 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <52A0C6D5.5010603@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20131204203818.19090.92396.sendpatchset@w520> <20131204203827.19090.98268.sendpatchset@w520>
In-Reply-To: <20131204203827.19090.98268.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, olof@lixom.net, tglx@linutronix.de

On 12/04/2013 12:38 PM, Magnus Damm wrote:
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
>  drivers/clocksource/Kconfig |   36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> --- 0001/drivers/clocksource/Kconfig
> +++ work/drivers/clocksource/Kconfig	2013-12-04 22:14:29.000000000 +0900
> @@ -134,3 +134,39 @@ config VF_PIT_TIMER
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
> +
> +config SH_TIMER_CMT
> +	bool "Renesas CMT timer driver" if COMPILE_TEST
> +	default SYS_SUPPORTS_CMT
> +	help
> +	  This enables build of the CMT timer driver.
> +

So again, I'd say if this is a non-conflicting COMPILE_TEST option (ie,
enabling it doesn't for anything else to be disabled), you might as well
enable it without a prompt on COMPILE_TEST. But that's just me. :)

If folks really disagree, and there is to be a user prompt, can we get
just a little more detail in the help text?
So what is the CMT hardware? Maybe what does CMT stand for? What
hardware is it frequently found on?

thanks
-john

