From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 09 Dec 2011 09:27:54 +0000
Subject: Re: [PATCH] sh: fix cpuidle on sh7724, possibly others
Message-Id: <Pine.LNX.4.64.1112091002330.24110@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1112061704300.10715@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1112061704300.10715@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul

On Fri, 9 Dec 2011, Paul Mundt wrote:

> On Wed, Dec 07, 2011 at 09:38:13AM +0100, Guennadi Liakhovetski wrote:
> > cpuidle has been broken on sh7724 and, possibly, other SuperH SoCs since 
> > 
> > commit f533c3d340536198a4889a42a68d6c0d79a504e7
> > Author: Paul Mundt <lethal@linux-sh.org>
> > Date:   Fri Oct 16 17:20:58 2009 +0900
> > 
> >     sh: Idle loop chainsawing for SMP-based light sleep.
> > 
> > i.e., since 2.6.33-rc1. The reason is a missing local_irq_enable() on the 
> > path, actually entering a sleep mode. This patch adds the missing call.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > This fixes one of the problem with cpuidle on sh. When applied (suitably 
> > adjusted) directly after f533c3d340536198a4889a42a68d6c0d79a504e7, it does 
> > fix the problem. However, since that commit cpuidle has been broken (at 
> > least for my configuration) at least once more. This time bisection points 
> > out at
> > 
> > commit 03625e7107cde46e2851557ec06426799e6ae7f2
> > Author: Magnus Damm <damm@opensource.se>
> > Date:   Fri Oct 30 04:24:32 2009 +0000
> > 
> >     sh: Use RSMEM for sleep code on sh7724
> > 
> > Still investigating.
> > 
> > diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > index 1cc257c..e58640a 100644
> > --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > @@ -48,6 +48,7 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
> >  	 */
> >  	k = min_t(int, allowed_state, requested_state);
> >  
> > +	local_irq_enable();
> >  	before = ktime_get();
> >  	sh_mobile_call_standby(cpuidle_mode[k]);
> >  	after = ktime_get();
> 
> Thanks for debugging this. This looks like a simple imbalance to me, but
> the changeset you cite doesn't do any SR toggling that would account for
> it, so that makes me suspect something else.

The commit, that I quoted, does add a local_irq_disable() in cpu_idle() 
and a WARN_ON(irqs_disabled()) after the call to pm_idle(), so, it 
expects, that inside pm_idle() interrupts are re-enabled. This is also 
done in the two local implementations poll_idle() and default_idle(), but 
not on the path, activated, once the cpuidle driver had been brought up. 
After it has, it is only the cpuidle_idle_call() that gets executed, not 
pm_idle(). And cpuidle_idle_call() ends up calling target_state->enter(), 
which points at cpuidle_sleep_enter(), which locks up, if ktime_get() is 
called with interrupts disabled. And it anyway has to return with 
interrupts enebled. As for

> Looking at the code in question, perhaps this is the culprit?
> 
> ---
> 
> diff --git a/arch/sh/kernel/cpu/shmobile/pm.c b/arch/sh/kernel/cpu/shmobile/pm.c
> index a6f95ae..55b9024 100644
> --- a/arch/sh/kernel/cpu/shmobile/pm.c
> +++ b/arch/sh/kernel/cpu/shmobile/pm.c
> @@ -136,7 +136,7 @@ static int sh_pm_enter(suspend_state_t state)
>  	local_irq_disable();
>  	set_bl_bit();
>  	sh_mobile_call_standby(SUSP_MODE_STANDBY_SF);
> -	local_irq_disable();
> +	local_irq_enable();
>  	clear_bl_bit();
>  	return 0;
>  }

I also was starring at this, failing to understand, but, I think, this is 
a different bug altogether. I think, this .enter() method is for 
suspending, not for cpuidle, or am I missing something?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
