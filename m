From: Simon Horman <horms@verge.net.au>
Date: Mon, 24 Mar 2014 01:54:41 +0000
Subject: Re: [PATCH -next] clocksource: CMT, MTU2, TMU and STI should depend on GENERIC_CLOCKEVENTS
Message-Id: <20140324015440.GA8777@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1395324352-9146-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395324352-9146-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <damm@opensource.se>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On Thu, Mar 20, 2014 at 03:05:50PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> If GENERIC_CLOCKEVENTS=n:
> 
> drivers/clocksource/sh_cmt.c:54:28: error: field 'ced' has incomplete type
> drivers/clocksource/sh_cmt.c: In function 'sh_cmt_interrupt':
> drivers/clocksource/sh_cmt.c:407:23: error: 'CLOCK_EVT_MODE_ONESHOT' undeclared (first use in this function)
> 
> drivers/clocksource/sh_mtu2.c:44:28: error: field 'ced' has incomplete type
> drivers/clocksource/sh_mtu2.c: In function 'ced_to_sh_mtu2':
> drivers/clocksource/sh_mtu2.c:184:70: warning: initialization from incompatible pointer type [enabled by default]
> drivers/clocksource/sh_mtu2.c: At top level:
> drivers/clocksource/sh_mtu2.c:188:16: warning: 'enum clock_event_mode' declared inside parameter list [enabled by default]
> 
> drivers/clocksource/sh_tmu.c:45:28: error: field 'ced' has incomplete type
> drivers/clocksource/sh_tmu.c: In function 'sh_tmu_interrupt':
> drivers/clocksource/sh_tmu.c:207:21: error: 'CLOCK_EVT_MODE_ONESHOT' undeclared (first use in this function)
> 
> drivers/clocksource/em_sti.c:44:28: error: field 'ced' has incomplete type
> drivers/clocksource/em_sti.c: In function 'ced_to_em_sti':
> drivers/clocksource/em_sti.c:251:69: warning: initialization from incompatible pointer type [enabled by default]
> drivers/clocksource/em_sti.c: At top level:
> drivers/clocksource/em_sti.c:255:16: warning: 'enum clock_event_mode' declared inside parameter list [enabled by default]
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> http://kisskb.ellerman.id.au/kisskb/buildresult/10807476/
> 
>  drivers/clocksource/Kconfig |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 143f1aff486b..837b7804775e 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -158,6 +158,7 @@ config SYS_SUPPORTS_EM_STI
>  
>  config SH_TIMER_CMT
>  	bool "Renesas CMT timer driver" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS
>  	default SYS_SUPPORTS_SH_CMT
>  	help
>  	  This enables build of a clocksource and clockevent driver for
> @@ -166,6 +167,7 @@ config SH_TIMER_CMT
>  
>  config SH_TIMER_MTU2
>  	bool "Renesas MTU2 timer driver" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS
>  	default SYS_SUPPORTS_SH_MTU2
>  	help
>  	  This enables build of a clockevent driver for the Multi-Function
> @@ -174,6 +176,7 @@ config SH_TIMER_MTU2
>  
>  config SH_TIMER_TMU
>  	bool "Renesas TMU timer driver" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS
>  	default SYS_SUPPORTS_SH_TMU
>  	help
>  	  This enables build of a clocksource and clockevent driver for
> @@ -182,6 +185,7 @@ config SH_TIMER_TMU
>  
>  config EM_TIMER_STI
>  	bool "Renesas STI timer driver" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS
>  	default SYS_SUPPORTS_EM_STI
>  	help
>  	  This enables build of a clocksource and clockevent driver for
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
