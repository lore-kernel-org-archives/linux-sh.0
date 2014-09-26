From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 26 Sep 2014 10:23:08 +0000
Subject: Re: [PATCH RFC 7/7] ARM: shmobile: Use separate CPUCMCR addresses for CA15/CA7
Message-Id: <54253E8C.2010002@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5424D226.7020502@renesas.com>
In-Reply-To: <5424D226.7020502@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 9/26/2014 11:40 AM, Khiem Nguyen wrote:
> It turned out that the CPUCMCR common address was not worked for CA7.
> Change to use separate CPUCMCR addresses for CA15 and CA7.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> ---
>  arch/arm/mach-shmobile/platsmp-apmu.c |   21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
> index 0dedb13..7d030fc 100644
> --- a/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
> @@ -36,9 +36,11 @@ static struct {
>  #define WUPCR_OFFS 0x10
>  #define PSTR_OFFS 0x40
>  #define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
> -#define CPUCMCR 0xe6154184
> +#define CPUCMCR_CA7  0xe6151184
> +#define CPUCMCR_CA15 0xe6152184
>  
> -void __iomem *cpucmcr;
> +void __iomem *cpucmcr_ca7;
> +void __iomem *cpucmcr_ca15;
>  
>  static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
>  {
> @@ -254,20 +256,25 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
>  	 */
>  	gic_cpu_if_down();
>  
> -	writel_relaxed(0x2, cpucmcr);
>  	if (read_cpuid_part() = ARM_CPU_PART_CORTEX_A15) {
This lacked of one line of code. i.e 
        +	writel_relaxed(0x2, cpucmcr_ca15);

Will fix in v2.

>  		is_a15_l2shutdown = 1;
>  		asm volatile("mrc p15, 1, %0, c9 , c0, 2"
>  			     : "=r" (l2ctlr_value));
>  		pr_debug("%s: l2ctlr: 0x%08x\n", __func__, l2ctlr_value);
> -	} else
> +	} else {
> +		writel_relaxed(0x2, cpucmcr_ca7);
>  		is_a15_l2shutdown = 0;
> +	}
>  
>  	shmobile_smp_hook(smp_processor_id(), virt_to_phys(rcar_cpu_resume), 0);
>  	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
>  	cpu_leave_lowpower();
>  
> -	writel_relaxed(0x0, cpucmcr);
> +	if (read_cpuid_part() = ARM_CPU_PART_CORTEX_A15)
> +		writel_relaxed(0x0, cpucmcr_ca15);
> +	else
> +		writel_relaxed(0x0, cpucmcr_ca7);
> +
>  	rcar_sysc_clear_event_status();
>  	is_a15_l2shutdown = 0;
>  
> @@ -276,7 +283,9 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
>  
>  void __init shmobile_smp_apmu_suspend_init(void)
>  {
> -	cpucmcr = ioremap_nocache(CPUCMCR, 0x4);
> +	cpucmcr_ca7  = ioremap_nocache(CPUCMCR_CA7, 0x4);
> +	cpucmcr_ca15 = ioremap_nocache(CPUCMCR_CA15, 0x4);
> +
>  	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
>  }
>  #endif
> 

-- 
Best regards,
KHIEM Nguyen
