From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Sep 2009 02:00:28 +0000
Subject: Re: [PATCH] sh: remove .init from sh7709_cpu_clk_ops
Message-Id: <20090914020027.GC15078@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090914004851.GA14697@rafazurita.homelinux.net>
In-Reply-To: <20090914004851.GA14697@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 13, 2009 at 09:48:51PM -0300, Rafael Ignacio Zurita wrote:
> It avoids to change the parent of sh7709_cpu_clk. With this change
> master_clk is the parent of cpu_clk (from clk_cpg_legacy), and it
> prevents the second mutex_lock(&clock_list_sem) while the first
> one is still locked.
> 
> Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>
> ---
>  arch/sh/kernel/cpu/sh3/clock-sh7709.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7709.c b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
> index fa30b60..f3064f9 100644
> --- a/arch/sh/kernel/cpu/sh3/clock-sh7709.c
> +++ b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
> @@ -78,7 +78,6 @@ static unsigned long cpu_clk_recalc(struct clk *clk)
>  }
>  
>  static struct clk_ops sh7709_cpu_clk_ops = {
> -	.init		= set_bus_parent,
>  	.recalc		= cpu_clk_recalc,
>  };
>  
There is basically no way for this set_bus_parent() code to work at all
in the current scheme, so you are better off killing it off entirely. The
other case (which is currently protected by an unused ifdef) isn't going
to work either.

I'll check this in with the rest of it killed off, though ideally the
sh7709 clock framework wants to be rewritten given that it obviously does
not adhere to the legacy CPG layout very well in the first place.
