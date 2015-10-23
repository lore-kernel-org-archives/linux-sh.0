From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 23 Oct 2015 12:24:34 +0000
Subject: Re: [RFC v2 4/5] ARM: shmobile: r8a7790: let rst module allow watchdog resets if desired
Message-Id: <1650574.GugTO9so7a@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1444632876-2672-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444632876-2672-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Monday 12 October 2015 07:54:35 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> b/arch/arm/mach-shmobile/setup-rcar-gen2.c index
> aa3339258d9c02..39976ae23a3df2 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -28,7 +28,18 @@
>  #include "common.h"
>  #include "rcar-gen2.h"
> 
> -#define MODEMR 0xe6160060
> +#define WDTRSTCR	0xe6160054
> +#define MODEMR		0xe6160060
> +
> +void __init rcar_gen2_wdt_rst_init(void)
> +{
> +#if defined(CONFIG_WATCHDOG)
> +	void __iomem *p = ioremap_nocache(WDTRSTCR, 4);
> +	BUG_ON(!p);
> +	iowrite32(0xa55a0000, p);
> +	iounmap(p);
> +#endif

That's a bit of a hack. We should aim at removing code from mach-shmobile, not 
adding new code :-) Furthermore it will cause issues with virtualization as 
hypervisors commonly map memory based on DT, the above code will thus generate 
a write access to an unmapped piece of memory as there's no corresponding DT 
node.

Time for a reset driver it seems ;-)

> +}
> 
>  u32 rcar_gen2_read_mode_pins(void)
>  {
> @@ -128,6 +139,10 @@ void __init rcar_gen2_timer_init(void)
>  #endif /* CONFIG_ARM_ARCH_TIMER */
> 
>  	rcar_gen2_clocks_init(mode);
> +
> +	/* allow watchdog timers to trigger reset */
> +	rcar_gen2_wdt_rst_init();
> +
>  	clocksource_of_init();
>  }

-- 
Regards,

Laurent Pinchart

