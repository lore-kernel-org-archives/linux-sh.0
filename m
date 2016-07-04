From: Rich Felker <dalias@libc.org>
Date: Mon, 04 Jul 2016 01:35:57 +0000
Subject: Re: [PATCH v5 10/22] sh: Add board specific initialize of of-generic
Message-Id: <20160704013557.GN15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <1467564402-2649-11-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-11-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 04, 2016 at 01:46:30AM +0900, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/boards/of-generic.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> index 2d3cda3..4038682 100644
> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c
> @@ -16,9 +16,15 @@
>  #include <linux/irqchip.h>
>  #include <linux/clk-provider.h>
>  #include <linux/memblock.h>
> +#include <linux/sm501-regs.h>
>  #include <asm/machvec.h>
>  #include <asm/rtc.h>
>  
> +struct model_setup {
> +	char *name;
> +	void (*fn)(void);
> +};
> +
>  #ifdef CONFIG_SMP
>  
>  static void dummy_smp_setup(void)
> @@ -125,10 +131,61 @@ static void __init sh_of_time_init(void)
>  	clocksource_probe();
>  }
>  
> +#define PA_LED		0xb0000001	/* LED Control Register */
> +#define PA_SHUTDOWN	0xb0000003	/* Shutdown Control Register */
> +static void landisk_power_off(void)
> +{
> +	__raw_writeb(0x01, PA_SHUTDOWN);
> +}
> +
> +static void __init landisk_setup(void)
> +{
> +	/* LED ON */
> +	__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
> +	pm_power_off = landisk_power_off;
> +}
> +
> +#define PA_POWOFF	0xa4000030	/* Board Power OFF control */
> +#define PA_OUTPORT	0xa4000036	/* LED control */
> +static void rts7751r2d_power_off(void)
> +{
> +	__raw_writew(0x0001, PA_POWOFF);
> +}
> +
> +static void __init r2dplus_setup(void)
> +{
> +	void __iomem *sm501_reg;
> +
> +	__raw_writew(0x0000, PA_OUTPORT);
> +	pm_power_off = rts7751r2d_power_off;
> +
> +	/* sm501 dram configuration:
> +	 * ColSizeX = 11 - External Memory Column Size: 256 words.
> +	 * APX = 1 - External Memory Active to Pre-Charge Delay: 7 clocks.
> +	 * RstX = 1 - External Memory Reset: Normal.
> +	 * Rfsh = 1 - Local Memory Refresh to Command Delay: 12 clocks.
> +	 * BwC =  1 - Local Memory Block Write Cycle Time: 2 clocks.
> +	 * BwP =  1 - Local Memory Block Write to Pre-Charge Delay: 1 clock.
> +	 * AP = 1 - Internal Memory Active to Pre-Charge Delay: 7 clocks.
> +	 * Rst = 1 - Internal Memory Reset: Normal.
> +	 * RA = 1 - Internal Memory Remain in Active State: Do not remain.
> +	 */
> +
> +	sm501_reg = (void __iomem *)0xb3e00000 + SM501_DRAM_CONTROL;
> +	writel(readl(sm501_reg) | 0x00f107c0, sm501_reg);
> +}
> +
> +static const struct model_setup model_setup_table[] __initconst = {
> +	{ .name = "iodata,HDL-U", .fn = landisk_setup, },
> +	{ .name = "renesas,RTS7751R2D+", .fn = r2dplus_setup, },
> +	{},
> +};
> +
>  static void __init sh_of_setup(char **cmdline_p)
>  {
>  	struct device_node *root;
>  	struct device_node *cpu;
> +	const struct model_setup *setup;
>  	u32 freq;
>  
>  	board_time_init = sh_of_time_init;
> @@ -145,6 +202,13 @@ static void __init sh_of_setup(char **cmdline_p)
>  	cpu = of_find_node_by_name(NULL, "cpu");
>  	if (!of_property_read_u32(cpu, "clock-frequency", &freq))
>  		preset_lpj = freq / CONFIG_HZ / 2;
> +
> +	for (setup = model_setup_table; setup->name; setup++) {
> +		if (strcmp(setup->name, sh_mv.mv_name) = 0) {
> +			setup->fn();
> +			break;
> +		}
> +	}
>  }
>  
>  static int sh_of_irq_demux(int irq)
> -- 

I think all of this code should be in appropriate driver files, not
of-generic.c. Much of it looks like it should be pm (power management)
drivers for which I'd assume there's an existing framework. I'm not
sure about the DRAM control. For the LED I think there's an LED GPIO
framework already too that would be appropriate and that probably
only needs appropriate nodes in the DT, not even any code.

Rich
