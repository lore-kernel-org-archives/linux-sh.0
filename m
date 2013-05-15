From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 May 2013 00:59:38 +0000
Subject: Re: [PATCH 08/20] ARM: shmobile: emev2: Remove init_irq declaration in machine description
Message-Id: <20130515005938.GG12246@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-9-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1368545933-7430-9-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 14, 2013 at 05:38:41PM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for shmobile as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-shmobile/setup-emev2.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
> index 899a86c..66694e0 100644
> --- a/arch/arm/mach-shmobile/setup-emev2.c
> +++ b/arch/arm/mach-shmobile/setup-emev2.c
> @@ -20,7 +20,6 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/irqchip.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/gpio-em.h>
>  #include <linux/of_platform.h>
> @@ -454,7 +453,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
>  	.smp		= smp_ops(emev2_smp_ops),
>  	.init_early	= emev2_init_delay,
>  	.nr_irqs	= NR_IRQS_LEGACY,
> -	.init_irq	= irqchip_init,
>  	.init_machine	= emev2_add_standard_devices_dt,
>  	.dt_compat	= emev2_boards_compat_dt,
>  MACHINE_END

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
