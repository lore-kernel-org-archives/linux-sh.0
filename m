From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 20 Mar 2009 05:50:00 +0000
Subject: Re: [PATCH 1/2] sh: add support for SMSC Polaris platform
Message-Id: <20090320145000.eb8c693a.iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1237459362-5204-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1237459362-5204-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Steve. 

On Thu, 19 Mar 2009 10:42:41 +0000
Steve Glendinning <steve.glendinning@smsc.com> wrote:

> Polaris is an SMSC reference platform with a SH7709S CPU and LAN9118
> ethernet controller.  This patch adds support for it.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
> ---
>  arch/sh/boards/Kconfig         |    7 ++
>  arch/sh/boards/Makefile        |    1 +
>  arch/sh/boards/board-polaris.c |  160 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+), 0 deletions(-)
>  create mode 100644 arch/sh/boards/board-polaris.c
You forget update of arch/sh/tools/mach-types.

> 
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index 48c043b..dcc1af8 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -261,6 +261,13 @@ config SH_CAYMAN
>  	depends on CPU_SUBTYPE_SH5_101 || CPU_SUBTYPE_SH5_103
>  	select SYS_SUPPORTS_PCI
>  
> +config SH_POLARIS
> +	bool "SMSC Polaris"
> +	select CPU_HAS_IPR_IRQ
> +	depends on CPU_SUBTYPE_SH7709
> +	help
> +	  Select if configuring for an SMSC Polaris development board
> +
>  endmenu
>  
>  source "arch/sh/boards/mach-r2d/Kconfig"
> diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
> index d0daebc..7baa210 100644
> --- a/arch/sh/boards/Makefile
> +++ b/arch/sh/boards/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_SH_URQUELL)	+= board-urquell.o
>  obj-$(CONFIG_SH_SHMIN)		+= board-shmin.o
>  obj-$(CONFIG_SH_EDOSK7760)	+= board-edosk7760.o
>  obj-$(CONFIG_SH_ESPT)		+= board-espt.o
> +obj-$(CONFIG_SH_POLARIS)	+= board-polaris.o
> diff --git a/arch/sh/boards/board-polaris.c b/arch/sh/boards/board-polaris.c
> new file mode 100644
> index 0000000..b944b8b
> --- /dev/null
> +++ b/arch/sh/boards/board-polaris.c
> @@ -0,0 +1,160 @@
> +/*
> + * linux/arch/sh/boards/se/770x/polaris.c
A file pass is wrong.

> + *
> + * June 2006 steve.glendinning@smsc.com
> + *
> + * Polaris-specific resource declaration
> + *
> + */

<snip>

> +static struct resource smsc911x_resources[] = {
> +	[0] = {
> +		.name		= "smsc911x-memory",
> +		.start		= PA_EXT5,
> +		.end		= PA_EXT5 + 0x1fff,
> +		.flags		= IORESOURCE_MEM,
> +	},	[1] = {
space prohibited before open square bracket '['

> +		.name		= "smsc911x-irq",
> +		.start		= IRQ0_IRQ,
> +		.end		= IRQ0_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct smsc911x_platform_config smsc911x_config = {
> +        .irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> +        .irq_type = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
Please fix white space.

> +	.flags = SMSC911X_USE_32BIT,
> +	.phy_interface = PHY_INTERFACE_MODE_MII,
> +};
> +

<snip>

> +
> +static int __init polaris_initialise(void)
> +{
> +	u16 wcr, bcr_mask;
> +
> +	printk(KERN_INFO "Configuring Polaris external bus\n");
> +
> +	/* Configure area 5 with 2 wait states */
> +	wcr = ctrl_inw(WCR2);
> +	wcr &= (~AREA5_WAIT_CTRL);
> +	wcr |= (WAIT_STATES_10 << 10);
> +	ctrl_outw(wcr, WCR2);
> +
> +	bcr_mask = ctrl_inw(BCR2);
> +
> +	/* The polaris platform has a DIP switch fitted, whose setting defines
> +	 * whether the LAN9118 is to be used in 32-bit mode.  We should detect
> +	 * its value here and set this accordingly, but for now assume 32-bit */
> +#if 0
> +	/* Configure area 5 for 16-bit access */
> +	bcr_mask &= ~(1 << 10);
> +#else
> +	/* Configure area 5 for 32-bit access */
> +	bcr_mask |= 1 << 10;
> +#endif
> +

I think yout should remove this '#if 0' code.
You should change it by the information if this board can acquire the information 
of the DIP switch. 
You had better change it if you cannot do it to be able to control it in Kconfig. 
In addition, you had better change the change of this line and the change of 
platform-data of smsc911x to change it.

Best regards,
 Nobuhiro
-- 
Nobuhiro Iwamatsu
	GPG ID : 3170EBE9
