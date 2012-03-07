From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 07 Mar 2012 21:58:39 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Move sh7372 Mackerel external clk setup
Message-Id: <201203072302.00154.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120306073018.27853.20666.sendpatchset@w520>
In-Reply-To: <20120306073018.27853.20666.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday, March 06, 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Move the board specific external clock setting for sh7372 Mackerel
> from machine_desc->sys_timer->init() to machine_desc->init_machine().
> 
> This is ground work for shmobile timer code consolidation.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied.

Thanks,
Rafael


> ---
> 
>  arch/arm/mach-shmobile/board-mackerel.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- 0004/arch/arm/mach-shmobile/board-mackerel.c
> +++ work/arch/arm/mach-shmobile/board-mackerel.c	2012-03-06 12:43:35.000000000 +0900
> @@ -1348,6 +1348,9 @@ static void __init mackerel_init(void)
>  	struct clk *clk;
>  	int ret;
>  
> +	/* External clock source */
> +	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
> +
>  	sh7372_pinmux_init();
>  
>  	/* enable SCIFA0 */
> @@ -1555,9 +1558,6 @@ static void __init mackerel_timer_init(v
>  {
>  	sh7372_clock_init();
>  	shmobile_timer.init();
> -
> -	/* External clock source */
> -	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
>  }
>  
>  static struct sys_timer mackerel_timer = {
> 
> 

