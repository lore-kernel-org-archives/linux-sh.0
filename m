From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 29 Aug 2013 10:26:21 +0000
Subject: Re: [PATCH 3/3 v4] ARM: shmobile: bockw: add USB Function support
Message-Id: <2667369.4VpvVD7gSx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 29 August 2013 18:13:09 Magnus Damm wrote:
> On Wed, Aug 21, 2013 at 5:44 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Sun, Aug 04, 2013 at 05:43:37PM -0700, Kuninori Morimoto wrote:
> >> Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
> >> USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
> >> was selected on this patch
> >> 
> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> ---
> >> v3 -> v4
> >> 
> >>  - no change
> >>  
> >>  arch/arm/mach-shmobile/board-bockw.c |   81
> >>  ++++++++++++++++++++++++++++++++--> 
> > Magnus, could you review this?
> 
> Sure, I can try. Just to be clear though - I think I know this board
> and SoC as little as you do. =)
> 
> >>  1 file changed, 78 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-shmobile/board-bockw.c
> >> b/arch/arm/mach-shmobile/board-bockw.c index 07009f5..8094803 100644
> >> --- a/arch/arm/mach-shmobile/board-bockw.c
> >> +++ b/arch/arm/mach-shmobile/board-bockw.c
> >> @@ -31,6 +31,7 @@
> >> 
> >>  #include <linux/smsc911x.h>
> >>  #include <linux/spi/spi.h>
> >>  #include <linux/spi/flash.h>
> >> 
> >> +#include <linux/usb/renesas_usbhs.h>
> >> 
> >>  #include <mach/common.h>
> >>  #include <mach/irqs.h>
> >>  #include <mach/r8a7778.h>
> >> 
> >> @@ -61,6 +62,16 @@
> >> 
> >>   * SW19      (MMC)   1 pin
> >>   */
> >> 
> >> +/*
> >> + * USB
> >> + *
> >> + * USB1 (CN29) can be Host/Function
> >> + *
> >> + *           Host    Func
> >> + * SW98              1       2
> >> + * SW99              1       3
> >> + */
> >> +
> >> 
> >>  /* Dummy supplies, where voltage doesn't matter */
> >>  static struct regulator_consumer_supply dummy_supplies[] = {
> >>  
> >>       REGULATOR_SUPPLY("vddvario", "smsc911x"),
> >> 
> >> @@ -79,13 +90,71 @@ static struct resource smsc911x_resources[] = {
> >> 
> >>       DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
> >>  
> >>  };
> >> 
> >> +#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
> >> +/*
> >> + * When USB1 is Func
> >> + */
> >> +static int usbhsf_get_id(struct platform_device *pdev)
> >> +{
> >> +     return USBHS_GADGET;
> >> +}
> >> +
> >> +#define SUSPMODE     0x102
> >> +static int usbhsf_power_ctrl(struct platform_device *pdev,
> >> +                          void __iomem *base, int enable)
> >> +{
> >> +     enable = !!enable;
> >> +
> >> +     r8a7778_usb_phy_power(enable);
> >> +
> >> +     iowrite16(enable << 14, base + SUSPMODE);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static struct resource usbhsf_resources[] __initdata = {
> >> +     DEFINE_RES_MEM(0xffe60000, 0x110),
> >> +     DEFINE_RES_IRQ(gic_iid(0x4f)),
> >> +};
> >> +
> >> +static struct renesas_usbhs_platform_info usbhs_info __initdata = {
> >> +     .platform_callback = {
> >> +             .get_id         = usbhsf_get_id,
> >> +             .power_ctrl     = usbhsf_power_ctrl,
> >> +     },
> >> +     .driver_param = {
> >> +             .buswait_bwait  = 4,
> >> +     },
> >> +};
> >> +
> >> +#define USB_PHY_SETTING {.port1_func = 1, .ovc_pin[1].active_high = 1,}
> >> +#define USB1_DEVICE  "renesas_usbhs"
> >> +#define ADD_USB_FUNC_DEVICE_IF_POSSIBLE()                    \
> >> +     platform_device_register_resndata(                      \
> >> +             &platform_bus, "renesas_usbhs", -1,             \
> >> +             usbhsf_resources,                               \
> >> +             ARRAY_SIZE(usbhsf_resources),                   \
> >> +             &usbhs_info, sizeof(struct renesas_usbhs_platform_info))
> >> +
> >> +#else
> >> +/*
> >> + * When USB1 is Host
> >> + */
> >> +#define USB_PHY_SETTING { }
> >> +#define USB1_DEVICE  "ehci-platform"
> >> +#define ADD_USB_FUNC_DEVICE_IF_POSSIBLE()
> >> +
> >> +#endif
> >> +
> >> 
> >>  /* USB */
> >>  static struct resource usb_phy_resources[] __initdata = {
> >>  
> >>       DEFINE_RES_MEM(0xffe70800, 0x100),
> >>       DEFINE_RES_MEM(0xffe76000, 0x100),
> >>  
> >>  };
> >> 
> >> -static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
> >> +static struct rcar_phy_platform_data usb_phy_platform_data __initdata > >> +     USB_PHY_SETTING;
> >> +
> >> 
> >>  /* SDHI */
> >>  static struct sh_mobile_sdhi_info sdhi0_info = {
> >> 
> >> @@ -181,7 +250,7 @@ static const struct pinctrl_map bockw_pinctrl_map[] > >> {
> >> 
> >>       /* USB */
> >>       PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
> >>       
> >>                                 "usb0", "usb0"),
> >> 
> >> -     PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
> >> +     PIN_MAP_MUX_GROUP_DEFAULT(USB1_DEVICE, "pfc-r8a7778",
> >> 
> >>                                 "usb1", "usb1"),
> >>       
> >>       /* SDHI0 */
> >>       PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
> >> 
> >> @@ -270,6 +339,12 @@ static void __init bockw_init(void)
> >> 
> >>       }
> >>  
> >>  }
> >> 
> >> +static void __init bockw_init_late(void)
> >> +{
> >> +     r8a7778_init_late();
> >> +     ADD_USB_FUNC_DEVICE_IF_POSSIBLE();
> >> +}
> >> +
> >> 
> >>  static const char *bockw_boards_compat_dt[] __initdata = {
> >>  
> >>       "renesas,bockw",
> >>       NULL,
> >> 
> >> @@ -281,5 +356,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
> >> 
> >>       .init_machine   = bockw_init,
> >>       .init_time      = shmobile_timer_init,
> >>       .dt_compat      = bockw_boards_compat_dt,
> >> 
> >> -     .init_late      = r8a7778_init_late,
> >> +     .init_late      = bockw_init_late,
> >> 
> >>  MACHINE_END
> 
> Morimoto-san,
> 
> Thanks for your work on this. In this patch I understand that you
> based on Kconfig select if ehci-platform or renesas-usbhs should be
> used. I wonder how well that will work together with multiplatform
> kernels in the future. Probably not so well. So we need to figure out
> how to handle this in the future.
> 
> I propose that we accept this patch as-is today to enable the
> hardware, but we should also investigate if we for instance could let
> the PFC handle mutual exclusion of the hardware and use bind/unbind to
> start/stop devices during run time. Paul Mundt and I talked about this
> ages ago but I'm not sure if it is actually possible with pinctrl or
> not. If possible would install both ehci-platform and renesas-usbhs
> devices in parallel and instead dynamically select one of them through
> sysfs.
> 
> Laurent, do you think it is possible to use pinctrl for mutual
> exclusion control in the drivers somehow? Basically, if the requested
> pins are already in use then the conflicting driver instance should
> error out.

That's a good question. The current driver core requests pins when devices are 
probed, which then results in a probe failure. One option would be to manually 
unbind the successfully probed device through sysfs, and then bind the other 
one (I believe that should work but I haven't tested it). There will be a 
little complexity involved with the fact that we can't know which device will 
be probed successfully, but that shouldn't be a huge issue.

> We also want to have DT bindings for USB drivers. Morimoto-san, can
> you please work on adding USB support to Bock-W DT reference?

-- 
Regards,

Laurent Pinchart

