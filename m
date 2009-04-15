From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Apr 2009 11:42:57 +0000
Subject: Re: [PATCH 02/05] sh: arch earlytimer support
Message-Id: <20090415114257.GB16961@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090415105012.29940.70431.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090415105012.29940.70431.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 07:50:12PM +0900, Magnus Damm wrote:
> --- 0001/arch/sh/kernel/time_32.c
> +++ work/arch/sh/kernel/time_32.c	2009-04-15 16:59:31.000000000 +0900
> @@ -233,6 +234,14 @@ void __init time_init(void)
>  	 * initialized for us.
>  	 */
>  	sys_timer = get_sys_timer();
> +
> +	/* Make sure all compiled-in early timers register themselves.
> +	 * Run probe() for one "earlytimer" device.
> +	 */
> +	early_platform_driver_register_all("earlytimer");
> +	if (early_platform_driver_probe("earlytimer", 1, 0))
> +		return;
> +
>  	if (unlikely(!sys_timer))
>  		panic("System timer missing.\n");
>  
What exactly is the plan for progression from here? If the CMT
clocksource and clockevent drivers are filling the role of the old CMT
driver, then the sys_timer stuff needs to be isolated. As it is now,
platforms that only contain the CMT will still need to use the sys_timer
version, especially if they don't have multiple channels.
