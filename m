From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 13 Mar 2009 16:31:17 +0000
Subject: Re: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <20090313163117.GD31657@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1505.7000500@st.com>
In-Reply-To: <49BA1505.7000500@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09:34 Fri 13 Mar     , Francesco VIRLINZI wrote:
> Sorry I forgot the timers..
> Here the right patch
> Regards
> Francesco
> Francesco VIRLINZI ha scritto:
>> Hi all
>>
>> This patch changes the init field in the clk_ops structure.
>> Moreover it changes how the init function is used.
>> Now it's called during registration and if something was wrong the  
>> clock isn't registered.
>>
>> Regards
>> Francesco
>

> >From 942219bb95734329c858587806e49895bae29208 Mon Sep 17 00:00:00 2001
> From: Francesco Virlinzi <francesco.virlinzi@st.com>
> Date: Fri, 13 Mar 2009 09:32:45 +0100
> Subject: [PATCH] sh: clkfwk: Changed the init field to return a value
> 
> This patch changes the clk_ops.init function pointer
> to return a value.
> Moreover it change the clk_register function to call
> always the clk_ops.init function to initilize the clock
> if there is an error the clock _isn't_ registered.
> 
> Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
> ---
>  arch/sh/include/asm/clock.h            |    2 +-
>  arch/sh/kernel/cpu/clock.c             |   18 +++++-------------
>  arch/sh/kernel/cpu/sh2/clock-sh7619.c  |    3 ++-
>  arch/sh/kernel/cpu/sh2a/clock-sh7201.c |    3 ++-
>  arch/sh/kernel/cpu/sh2a/clock-sh7203.c |    3 ++-
>  arch/sh/kernel/cpu/sh2a/clock-sh7206.c |    3 ++-
>  arch/sh/kernel/cpu/sh3/clock-sh3.c     |    3 ++-
>  arch/sh/kernel/cpu/sh3/clock-sh7705.c  |    3 ++-
>  arch/sh/kernel/cpu/sh3/clock-sh7706.c  |    3 ++-
>  arch/sh/kernel/cpu/sh3/clock-sh7709.c  |    3 ++-
>  arch/sh/kernel/cpu/sh3/clock-sh7712.c  |    3 ++-
>  arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    3 ++-
>  arch/sh/kernel/cpu/sh4/clock-sh4.c     |    3 ++-
>  arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/clock-sh7763.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/clock-sh7770.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/clock-sh7780.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    3 ++-
>  arch/sh/kernel/cpu/sh5/clock-sh5.c     |    3 ++-
>  arch/sh/kernel/timers/timer-cmt.c      |    3 ++-
>  arch/sh/kernel/timers/timer-mtu2.c     |    3 ++-
>  arch/sh/kernel/timers/timer-tmu.c      |    3 ++-
>  24 files changed, 50 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
> index 2f6c962..f7a5899 100644
> --- a/arch/sh/include/asm/clock.h
> +++ b/arch/sh/include/asm/clock.h
> @@ -10,7 +10,7 @@
>  struct clk;
>  
>  struct clk_ops {
> -	void (*init)(struct clk *clk);
> +	int (*init)(struct clk *clk);
>  	void (*enable)(struct clk *clk);
>  	void (*disable)(struct clk *clk);
>  	void (*recalc)(struct clk *clk);
> diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
> index e2d2451..87a54b5 100644
> --- a/arch/sh/kernel/cpu/clock.c
> +++ b/arch/sh/kernel/cpu/clock.c
> @@ -92,17 +92,6 @@ static void propagate_rate(struct clk *clk)
>  
>  static int __clk_enable(struct clk *clk)
>  {
> -	/*
> -	 * See if this is the first time we're enabling the clock, some
> -	 * clocks that are always enabled still require "special"
> -	 * initialization. This is especially true if the clock mode
> -	 * changes and the clock needs to hunt for the proper set of
> -	 * divisors to use before it can effectively recalc.
> -	 */
> -	if (unlikely(atomic_read(&clk->kref.refcount) = 1))
> -		if (clk->ops && clk->ops->init)
> -			clk->ops->init(clk);
> -
>  	kref_get(&clk->kref);
>  
>  	if (clk->flags & CLK_ALWAYS_ENABLED)
> @@ -167,6 +156,11 @@ EXPORT_SYMBOL_GPL(clk_disable);
>  
>  int clk_register(struct clk *clk)
>  {
> +
> +	if (clk->ops && clk->ops->init)
> +		if (clk->ops->init(clk))
> +			return -EINVAL;
> +
why do you check the return if all clk_init will always return 0; ?

IMHO if clk-ops is NULL return directly instead of recheck it later

Best Regards,
J.
