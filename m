From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 13 Mar 2009 16:33:21 +0000
Subject: Re: [PATCH] sh-clkfwk  Safer resume from hibenration
Message-Id: <20090313163321.GE31657@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1461.7070207@st.com>
In-Reply-To: <49BA1461.7070207@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09:08 Fri 13 Mar     , Francesco VIRLINZI wrote:
>

> >From 444e5623bfb9ceae22b6190dfcc003cb19efcf71 Mon Sep 17 00:00:00 2001
> From: Francesco Virlinzi <francesco.virlinzi@st.com>
> Date: Fri, 13 Mar 2009 08:39:26 +0100
> Subject: [PATCH] sh: clkfwk: Safer resume from hibenration
> 
> This patch fixes a possible problem in the resume from
> hibenration. It temporaneally saves the clk->rate on the
> stack to avoid any possible change during the clk->set_parent(..)
> call
> 
> Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
> ---
>  arch/sh/kernel/cpu/clock.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
> index 3209a87..e2d2451 100644
> --- a/arch/sh/kernel/cpu/clock.c
> +++ b/arch/sh/kernel/cpu/clock.c
> @@ -372,12 +372,13 @@ static int clks_sysdev_suspend(struct sys_device *dev, pm_message_t state)
>  		if (prev_state.event = PM_EVENT_FREEZE) {
>  			list_for_each_entry(clkp, &clock_list, node)
>  				if (likely(clkp->ops)) {
> +					unsigned long rate = clkp->rate;
please add an empty line
>  					if (likely(clkp->ops->set_parent))
>  						clkp->ops->set_parent(clkp,
>  							clkp->parent);
>  					if (likely(clkp->ops->set_rate))
>  						clkp->ops->set_rate(clkp,
> -							clkp->rate, NO_CHANGE);
> +							rate, NO_CHANGE);
>  					else if (likely(clkp->ops->recalc))
>  						clkp->ops->recalc(clkp);
>  					}
> -- 
> 1.5.6.6
> 
Best Regards,
J.
