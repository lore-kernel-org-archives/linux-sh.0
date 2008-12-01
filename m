From: john stultz <johnstul@us.ibm.com>
Date: Mon, 01 Dec 2008 20:43:55 +0000
Subject: Re: [PATCH 09/10] clocksource: add enable() and disable() callbacks
Message-Id: <1228164235.7176.26.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103347.26620.3670.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103347.26620.3670.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 2008-12-01 at 19:33 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Add enable() and disable() callbacks for clocksources. This allows
> us to put unused clocksources in power save mode. The functions
> clocksource_enable() and clocksource_disable() wrap the callbacks
> and are inserted in the timekeeping code to enable before use and
> disable after switching to a new clocksource.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

I like this! Its a nice addition to the clocksource structure to allow
for improved power management.

I've got some worries that if clocksource_enable() is allowed to fail it
might give us some grief in early boot (you don't check for errors
there, but understandably, as there isn't much we can do).

However, maybe if a clocksource fails to be enabled, we need to eject it
from the list of usable clocksources, as if clocksource with a high
rating value, were to fail to be enabled, every tick we'd try to swap
the bad clocksource in and fail, never to move to a good clocksource
with slightly lower rating.

But other then that nit, I think this is a good change.

thanks
-john



> ---
> 
>  include/linux/clocksource.h |   31 +++++++++++++++++++++++++++++++
>  kernel/time/timekeeping.c   |   12 +++++++++---
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> --- 0009/include/linux/clocksource.h
> +++ work/include/linux/clocksource.h	2008-12-01 14:19:43.000000000 +0900
> @@ -44,6 +44,8 @@ struct clocksource;
>   *				available.
>   * @read:		returns a cycle value
>   * @read2:		returns a cycle value, passes clocksource as argument
> + * @enable:		optional function to enable the clocksource
> + * @disable:		optional function to disable the clocksource
>   * @mask:		bitmask for two's complement
>   *			subtraction of non 64 bit counters
>   * @mult:		cycle to nanosecond multiplier (adjusted by NTP)
> @@ -64,6 +66,8 @@ struct clocksource {
>  	int rating;
>  	cycle_t (*read)(void);
>  	cycle_t (*read2)(struct clocksource *cs);
> +	int (*enable)(struct clocksource *cs);
> +	void (*disable)(struct clocksource *cs);
>  	cycle_t mask;
>  	u32 mult;
>  	u32 mult_orig;
> @@ -176,6 +180,33 @@ static inline cycle_t clocksource_read(s
>  }
> 
>  /**
> + * clocksource_enable: - enable clocksource
> + * @cs:		pointer to clocksource
> + *
> + * Enables the specified clocksource. The clocksource callback
> + * function should start up the hardware and setup mult and field
> + * members of struct clocksource to reflect hardware capabilities.
> + */
> +static inline int clocksource_enable(struct clocksource *cs)
> +{
> +	return cs->enable ? cs->enable(cs) : 0;
> +}
> +
> +/**
> + * clocksource_disable: - disable clocksource
> + * @cs:		pointer to clocksource
> + *
> + * Disables the specified clocksource. The clocksource callback
> + * function should power down the now unused hardware block to
> + * save power.
> + */
> +static inline void clocksource_disable(struct clocksource *cs)
> +{
> +	if (cs->disable)
> +		cs->disable(cs);
> +}
> +
> +/**
>   * cyc2ns - converts clocksource cycles to nanoseconds
>   * @cs:		Pointer to clocksource
>   * @cycles:	Cycles
> --- 0001/kernel/time/timekeeping.c
> +++ work/kernel/time/timekeeping.c	2008-12-01 14:20:32.000000000 +0900
> @@ -177,7 +177,7 @@ EXPORT_SYMBOL(do_settimeofday);
>   */
>  static void change_clocksource(void)
>  {
> -	struct clocksource *new;
> +	struct clocksource *new, *old;
> 
>  	new = clocksource_get_next();
> 
> @@ -186,11 +186,16 @@ static void change_clocksource(void)
> 
>  	clocksource_forward_now();
> 
> -	new->raw_time = clock->raw_time;
> +	if (clocksource_enable(new))
> +		return;
> 
> +	new->raw_time = clock->raw_time;
> +	old = clock;
>  	clock = new;
> +	clocksource_disable(old);
> +
>  	clock->cycle_last = 0;
> -	clock->cycle_last = clocksource_read(new);
> +	clock->cycle_last = clocksource_read(clock);
>  	clock->error = 0;
>  	clock->xtime_nsec = 0;
>  	clocksource_calculate_interval(clock, NTP_INTERVAL_LENGTH);
> @@ -287,6 +292,7 @@ void __init timekeeping_init(void)
>  	ntp_init();
> 
>  	clock = clocksource_get_next();
> +	clocksource_enable(clock);
>  	clocksource_calculate_interval(clock, NTP_INTERVAL_LENGTH);
>  	clock->cycle_last = clocksource_read(clock);
> 

