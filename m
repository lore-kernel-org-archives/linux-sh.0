From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 05 Jul 2012 21:25:37 +0000
Subject: Re: [PATCH] ARM: shmobile: sh7372 A3SM CPUIdle support
Message-Id: <201207052325.37463.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120705054647.29736.21566.sendpatchset@w520>
In-Reply-To: <20120705054647.29736.21566.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, July 05, 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add CPUIdle support for the A3SM power domain on sh7372.
> 
> With this in place we can turn off more of the SoC during
> run time and save power. Makes use of the recently introduced
> sh7372 INTCA A3SM power domain wakeup support.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied to the sh7372 branch of the renesas.git tree.

Thanks,
Rafael


> ---
> 
>  Depends on "[PATCH] ARM: shmobile: Use INTCA with sh7372 A3SM power domain"
> 
>  arch/arm/mach-shmobile/pm-sh7372.c |   50 +++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 14 deletions(-)
> 
> --- 0002/arch/arm/mach-shmobile/pm-sh7372.c
> +++ work/arch/arm/mach-shmobile/pm-sh7372.c	2012-07-05 14:34:30.000000000 +0900
> @@ -300,9 +300,6 @@ static void sh7372_set_reset_vector(unsi
>  	__raw_writel(0, APARMBAREA);
>  }
>  
> -#endif
> -
> -#ifdef CONFIG_SUSPEND
>  static void sh7372_enter_sysc(int pllc0_on, unsigned long sleep_mode)
>  {
>  	if (pllc0_on)
> @@ -448,17 +445,6 @@ static void sh7372_enter_a3sm_common(int
>  	sh7372_enter_sysc(pllc0_on, 1 << 12);
>  }
>  
> -static void sh7372_enter_a4s_common(int pllc0_on)
> -{
> -	sh7372_intca_suspend();
> -	memcpy((void *)SMFRAM, sh7372_resume_core_standby_sysc, 0x100);
> -	sh7372_set_reset_vector(SMFRAM);
> -	sh7372_enter_sysc(pllc0_on, 1 << 10);
> -	sh7372_intca_resume();
> -}
> -
> -#endif
> -
>  #ifdef CONFIG_CPU_IDLE
>  static int sh7372_do_idle_core_standby(unsigned long unused)
>  {
> @@ -479,6 +465,16 @@ static void sh7372_enter_core_standby(vo
>  	__raw_writel(0, SBAR);
>  }
>  
> +static void sh7372_enter_a3sm_pll_on(void)
> +{
> +	sh7372_enter_a3sm_common(1);
> +}
> +
> +static void sh7372_enter_a3sm_pll_off(void)
> +{
> +	sh7372_enter_a3sm_common(0);
> +}
> +
>  static void sh7372_cpuidle_setup(struct cpuidle_driver *drv)
>  {
>  	struct cpuidle_state *state = &drv->states[drv->state_count];
> @@ -489,7 +485,24 @@ static void sh7372_cpuidle_setup(struct
>  	state->target_residency = 20 + 10;
>  	state->flags = CPUIDLE_FLAG_TIME_VALID;
>  	shmobile_cpuidle_modes[drv->state_count] = sh7372_enter_core_standby;
> +	drv->state_count++;
>  
> +	state = &drv->states[drv->state_count];
> +	snprintf(state->name, CPUIDLE_NAME_LEN, "C3");
> +	strncpy(state->desc, "A3SM PLL ON", CPUIDLE_DESC_LEN);
> +	state->exit_latency = 20;
> +	state->target_residency = 30 + 20;
> +	state->flags = CPUIDLE_FLAG_TIME_VALID;
> +	shmobile_cpuidle_modes[drv->state_count] = sh7372_enter_a3sm_pll_on;
> +	drv->state_count++;
> +
> +	state = &drv->states[drv->state_count];
> +	snprintf(state->name, CPUIDLE_NAME_LEN, "C4");
> +	strncpy(state->desc, "A3SM PLL OFF", CPUIDLE_DESC_LEN);
> +	state->exit_latency = 120;
> +	state->target_residency = 30 + 120;
> +	state->flags = CPUIDLE_FLAG_TIME_VALID;
> +	shmobile_cpuidle_modes[drv->state_count] = sh7372_enter_a3sm_pll_off;
>  	drv->state_count++;
>  }
>  
> @@ -502,6 +515,14 @@ static void sh7372_cpuidle_init(void) {}
>  #endif
>  
>  #ifdef CONFIG_SUSPEND
> +static void sh7372_enter_a4s_common(int pllc0_on)
> +{
> +	sh7372_intca_suspend();
> +	memcpy((void *)SMFRAM, sh7372_resume_core_standby_sysc, 0x100);
> +	sh7372_set_reset_vector(SMFRAM);
> +	sh7372_enter_sysc(pllc0_on, 1 << 10);
> +	sh7372_intca_resume();
> +}
>  
>  static int sh7372_enter_suspend(suspend_state_t suspend_state)
>  {
> @@ -562,6 +583,7 @@ static void sh7372_suspend_init(void)
>  #else
>  static void sh7372_suspend_init(void) {}
>  #endif
> +#endif /* CONFIG_SUSPEND || CONFIG_CPU_IDLE */
>  
>  void __init sh7372_pm_init(void)
>  {
> 
> 

