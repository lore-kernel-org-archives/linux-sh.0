From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 07 Dec 2011 11:12:39 +0000
Subject: Re: [PATCH] sh: fix cpuidle on sh7724, possibly others
Message-Id: <Pine.LNX.4.64.1112071211100.3173@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1112061704300.10715@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1112061704300.10715@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 7 Dec 2011, Guennadi Liakhovetski wrote:

> cpuidle has been broken on sh7724 and, possibly, other SuperH SoCs since 
> 
> commit f533c3d340536198a4889a42a68d6c0d79a504e7
> Author: Paul Mundt <lethal@linux-sh.org>
> Date:   Fri Oct 16 17:20:58 2009 +0900
> 
>     sh: Idle loop chainsawing for SMP-based light sleep.
> 
> i.e., since 2.6.33-rc1. The reason is a missing local_irq_enable() on the 
> path, actually entering a sleep mode. This patch adds the missing call.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> This fixes one of the problem with cpuidle on sh. When applied (suitably 
> adjusted) directly after f533c3d340536198a4889a42a68d6c0d79a504e7, it does 
> fix the problem. However, since that commit cpuidle has been broken (at 
> least for my configuration) at least once more. This time bisection points 
> out at

Apparently, a hick up during bisect: this

> commit 03625e7107cde46e2851557ec06426799e6ae7f2
> Author: Magnus Damm <damm@opensource.se>
> Date:   Fri Oct 30 04:24:32 2009 +0000
> 
>     sh: Use RSMEM for sleep code on sh7724
> 
> Still investigating.

is not the offending commit, this is the one:

commit 323ef8dba67fb7b9c709457bd0374d88cfb8f25f
Author: Magnus Damm <damm@opensource.se>
Date:   Fri Oct 30 04:24:07 2009 +0000

    sh: Rework SuperH Mobile sleep mode code

Thanks
Guennadi

> 
> diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> index 1cc257c..e58640a 100644
> --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -48,6 +48,7 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
>  	 */
>  	k = min_t(int, allowed_state, requested_state);
>  
> +	local_irq_enable();
>  	before = ktime_get();
>  	sh_mobile_call_standby(cpuidle_mode[k]);
>  	after = ktime_get();
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
