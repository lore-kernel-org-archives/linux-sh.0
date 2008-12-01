From: john stultz <johnstul@us.ibm.com>
Date: Mon, 01 Dec 2008 20:57:44 +0000
Subject: Re: [PATCH 08/10] clocksource: add read2() callback
Message-Id: <1228165064.7176.31.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103337.26620.38744.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103337.26620.38744.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 2008-12-01 at 19:33 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Add a read2() callback for clocksources. This callback is passing
> a pointer to struct clocksource which makes it easy to share the
> same callback for multiple clocksource instances.
> 
> The function clocksource_read() is modified to prefer read2() over
> read() if initialized.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

I'm still not yet totally sold on the reasons we need this change, but I
don't have any issue with this implementation. Hopefully the discussion
around the timer_inc code will help resolve my concerns.

Also, if we're going to go this way, you might want to add read() to the
feature-removal list and add a warning in clocksource_register() for any
clocksource that doesn't implement read2, just so we don't have to keep
both around forever

thanks
-john


> ---
> 
>  include/linux/clocksource.h |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- 0001/include/linux/clocksource.h
> +++ work/include/linux/clocksource.h	2008-11-27 13:58:25.000000000 +0900
> @@ -43,6 +43,7 @@ struct clocksource;
>   *				The ideal clocksource. A must-use where
>   *				available.
>   * @read:		returns a cycle value
> + * @read2:		returns a cycle value, passes clocksource as argument
>   * @mask:		bitmask for two's complement
>   *			subtraction of non 64 bit counters
>   * @mult:		cycle to nanosecond multiplier (adjusted by NTP)
> @@ -62,6 +63,7 @@ struct clocksource {
>  	struct list_head list;
>  	int rating;
>  	cycle_t (*read)(void);
> +	cycle_t (*read2)(struct clocksource *cs);
>  	cycle_t mask;
>  	u32 mult;
>  	u32 mult_orig;
> @@ -170,7 +172,7 @@ static inline u32 clocksource_hz2mult(u3
>   */
>  static inline cycle_t clocksource_read(struct clocksource *cs)
>  {
> -	return cs->read();
> +	return cs->read2 ? cs->read2(cs) : cs->read();
>  }
> 
>  /**

