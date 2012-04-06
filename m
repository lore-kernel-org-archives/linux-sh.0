From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 06 Apr 2012 05:19:34 +0000
Subject: Re: [PATCH 6/6] ARM: mach-shmobile: armadillo800eva: add support sh_eth
Message-Id: <87zkapjv31.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hawy4lww.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hawy4lww.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for checking patch.

> are some changes in drivers/net/ethernet/renesas/ also required
> or am I missing something else?

Yes. it needs 2 patches.
I explained it on [0/6] mail :)

---------------------------
#6 patch adds sh_eth support to armadillo800eva board,
no compile error, but doesn't work on rafael/master at this point.
it needs shimoda-san's sh_eth patches.

git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
10b9194f959608368ed89df1937f17cfe6bd6d84
(net: sh_eth: fix endian check for architecture independent)

git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
73a0d907301ece200d32b4e8ba2da2ca296b507f
(net: sh_eth: add support R8A7740)
----------------------------

> 
> On Thu, Apr 05, 2012 at 01:34:27AM -0700, Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/mach-shmobile/board-armadillo800eva.c |   58 ++++++++++++++++++++++++
> >  1 files changed, 58 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> > index 987265a..b1a192a 100644
> > --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> > +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/gpio.h>
> >  #include <linux/gpio_keys.h>
> > +#include <linux/sh_eth.h>
> >  #include <linux/videodev2.h>
> >  #include <mach/common.h>
> >  #include <asm/page.h>
> > @@ -96,6 +97,38 @@
> >   *-----------+---------------+----------------------------
> >   */
> >  
> > +/* Ether */
> > +static struct sh_eth_plat_data sh_eth_platdata = {
> > +	.phy			= 0x00, /* LAN8710A */
> > +	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
> > +	.register_type		= SH_ETH_REG_GIGABIT,
> > +	.phy_interface		= PHY_INTERFACE_MODE_MII,
> > +};
> > +
> > +static struct resource sh_eth_resources[] = {
> > +	{
> > +		.start	= 0xe9a00000,
> > +		.end	= 0xe9a00800 - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= 0xe9a01800,
> > +		.end	= 0xe9a02000 - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= evt2irq(0x0500),
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static struct platform_device sh_eth_device = {
> > +	.name = "sh-eth",
> > +	.dev = {
> > +		.platform_data = &sh_eth_platdata,
> > +	},
> > +	.resource = sh_eth_resources,
> > +	.num_resources = ARRAY_SIZE(sh_eth_resources),
> > +};
> > +
> >  /* LCDC */
> >  static struct fb_videomode lcdc0_mode = {
> >  	.name		= "AMPIER/AM-800480",
> > @@ -188,6 +221,7 @@ static struct platform_device gpio_keys_device = {
> >  static struct platform_device *eva_devices[] __initdata = {
> >  	&lcdc0_device,
> >  	&gpio_keys_device,
> > +	&sh_eth_device,
> >  };
> >  
> >  /*
> > @@ -244,6 +278,30 @@ static void __init eva_init(void)
> >  	gpio_request(GPIO_PORT166,	NULL); /* TP_RST_B */
> >  	gpio_direction_output(GPIO_PORT166, 1);
> >  
> > +	/* GETHER */
> > +	gpio_request(GPIO_FN_ET_CRS,		NULL);
> > +	gpio_request(GPIO_FN_ET_MDC,		NULL);
> > +	gpio_request(GPIO_FN_ET_MDIO,		NULL);
> > +	gpio_request(GPIO_FN_ET_TX_ER,		NULL);
> > +	gpio_request(GPIO_FN_ET_RX_ER,		NULL);
> > +	gpio_request(GPIO_FN_ET_ERXD0,		NULL);
> > +	gpio_request(GPIO_FN_ET_ERXD1,		NULL);
> > +	gpio_request(GPIO_FN_ET_ERXD2,		NULL);
> > +	gpio_request(GPIO_FN_ET_ERXD3,		NULL);
> > +	gpio_request(GPIO_FN_ET_TX_CLK,		NULL);
> > +	gpio_request(GPIO_FN_ET_TX_EN,		NULL);
> > +	gpio_request(GPIO_FN_ET_ETXD0,		NULL);
> > +	gpio_request(GPIO_FN_ET_ETXD1,		NULL);
> > +	gpio_request(GPIO_FN_ET_ETXD2,		NULL);
> > +	gpio_request(GPIO_FN_ET_ETXD3,		NULL);
> > +	gpio_request(GPIO_FN_ET_PHY_INT,	NULL);
> > +	gpio_request(GPIO_FN_ET_COL,		NULL);
> > +	gpio_request(GPIO_FN_ET_RX_DV,		NULL);
> > +	gpio_request(GPIO_FN_ET_RX_CLK,		NULL);
> > +
> > +	gpio_request(GPIO_PORT18, NULL); /* PHY_RST */
> > +	gpio_direction_output(GPIO_PORT18, 1);
> > +
> >  	/*
> >  	 * CAUTION
> >  	 *
> > -- 
> > 1.7.5.4
> > 


Best regards
---
Kuninori Morimoto
