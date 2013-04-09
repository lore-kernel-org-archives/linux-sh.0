From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 12:17:50 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: bockw: add dummy regulators for SMSC
Message-Id: <20130409121748.GB15412@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87txng9ha0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txng9ha0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 02:37:15AM -0700, Kuninori Morimoto wrote:
> SMSC driver will try to get regulator if .config had CONFIG_REGULATOR,
> and, shmobile_defconfig has it.
> SMSC driver on Bock-W board will be failed if it doens't have
> dummy regulator settings.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued up in the boards-bockw branch.

> ---
>  arch/arm/mach-shmobile/board-bockw.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 0275d14..88fcdb3 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
> @@ -20,6 +20,8 @@
>  
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>
>  #include <linux/smsc911x.h>
>  #include <mach/common.h>
>  #include <mach/irqs.h>
> @@ -34,6 +36,12 @@
>   * SW41		SCIF	RCAN
>   */
>  
> +/* Dummy supplies, where voltage doesn't matter */
> +static struct regulator_consumer_supply dummy_supplies[] = {
> +	REGULATOR_SUPPLY("vddvario", "smsc911x"),
> +	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
> +};
> +
>  static struct smsc911x_platform_config smsc911x_data = {
>  	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
>  	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
> @@ -81,6 +89,9 @@ static void __init bockw_init(void)
>  		iowrite16(val, fpga + IRQ0MR);
>  		iounmap(fpga);
>  
> +		regulator_register_fixed(0, dummy_supplies,
> +					 ARRAY_SIZE(dummy_supplies));
> +
>  		platform_device_register_resndata(
>  			&platform_bus, "smsc911x", -1,
>  			smsc911x_resources, ARRAY_SIZE(smsc911x_resources),
> -- 
> 1.7.9.5
> 
