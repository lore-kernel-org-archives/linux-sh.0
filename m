From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 07:45:42 +0000
Subject: Re: [PATCH 3/4 v2] RM: shmobile: r8a7778: add r8a7778_add_usb_func_device()
Message-Id: <20130710074541.GC7313@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87siznuozu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87siznuozu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 09, 2013 at 10:20:50PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> This Subject is using "RM", but it should be "ARM"
> Can I send v3 ?

Yes, please do.

> > This patch adds USB Function (= renesas_usbhs) driver support.
> > r8a7778_add_usb_phy_device()  should be called from .init_machine,
> > r8a7778_add_usb_func_device() should be called from .init_late
> > when platform use it.
> > 
> > This r8a7778_add_usb_func_device() will fill
> > renesas_usbhs_platform_info::platform_callback.get_id and
> > renesas_usbhs_platform_info::platform_callback.power_ctrl
> > if these callbacks were NULL, since these don't depend
> > on platform basically.
> > 
> > Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v1 -> v2
> > 
> >  - no change
> > 
> >  arch/arm/mach-shmobile/clock-r8a7778.c        |    1 +
> >  arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
> >  arch/arm/mach-shmobile/setup-r8a7778.c        |   39 +++++++++++++++++++++++++
> >  3 files changed, 42 insertions(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
> > index 53798e5..0d34282 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7778.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7778.c
> > @@ -148,6 +148,7 @@ static struct clk_lookup lookups[] = {
> >  	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
> >  	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
> >  	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
> > +	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP100]), /* USB FUNC */
> >  	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
> >  	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
> >  	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
> > diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> > index 54e0132..5d894fd 100644
> > --- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
> > +++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> > @@ -22,6 +22,7 @@
> >  #include <linux/mmc/sh_mobile_sdhi.h>
> >  #include <linux/sh_eth.h>
> >  #include <linux/platform_data/usb-rcar-phy.h>
> > +#include <linux/usb/renesas_usbhs.h>
> >  
> >  extern void r8a7778_add_standard_devices(void);
> >  extern void r8a7778_add_standard_devices_dt(void);
> > @@ -32,6 +33,7 @@ extern void r8a7778_add_hspi_device(int id);
> >  extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
> >  extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
> >  extern void r8a7778_add_usb_host_device(void);
> > +extern void r8a7778_add_usb_func_device(struct renesas_usbhs_platform_info *info);
> >  
> >  extern void r8a7778_init_late(void);
> >  extern void r8a7778_init_delay(void);
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> > index 9ea1e25..b059ccd 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> > @@ -153,6 +153,7 @@ static void usb_power_off(struct platform_device *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  }
> >  
> > +/* USB HOST */
> >  static int ehci_init_internal_buffer(struct usb_hcd *hcd)
> >  {
> >  	/*
> > @@ -211,6 +212,44 @@ void __init r8a7778_add_usb_host_device(void)
> >  	platform_device_register_full(&ohci_info);
> >  }
> >  
> > +/* USB Func */
> > +static int usbhsf_get_id(struct platform_device *pdev)
> > +{
> > +	return USBHS_GADGET;
> > +}
> > +
> > +#define SUSPMODE	0x102
> > +static int usbhsf_power_ctrl(struct platform_device *pdev,
> > +			     void __iomem *base, int enable)
> > +{
> > +	enable = !!enable;
> > +
> > +	r8a7778_usb_phy_power(enable);
> > +
> > +	iowrite16(enable << 14, base + SUSPMODE);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct resource usbhsf_resources[] __initdata = {
> > +	DEFINE_RES_MEM(0xffe60000, 0x110),
> > +	DEFINE_RES_IRQ(gic_iid(0x4f)),
> > +};
> > +
> > +void __init
> > +r8a7778_add_usb_func_device(struct renesas_usbhs_platform_info *info)
> > +{
> > +	if (!info->platform_callback.get_id)
> > +		info->platform_callback.get_id = usbhsf_get_id;
> > +	if (!info->platform_callback.power_ctrl)
> > +		info->platform_callback.power_ctrl = usbhsf_power_ctrl;
> > +
> > +	platform_device_register_resndata(&platform_bus, "renesas_usbhs", -1,
> > +					  usbhsf_resources,
> > +					  ARRAY_SIZE(usbhsf_resources),
> > +					  info, sizeof(*info));
> > +}
> > +
> >  /* Ether */
> >  static struct resource ether_resources[] __initdata = {
> >  	DEFINE_RES_MEM(0xfde00000, 0x400),
> > -- 
> > 1.7.9.5
> > 
> 
> 
> Best regards
> ---
> Kuninori Morimoto
> 
