From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Sep 2013 07:50:31 +0000
Subject: Re: [PATCH 3/3 v4] ARM: shmobile: bockw: add USB Function support
Message-Id: <CANqRtoSWYwewKwsnwHr3xGJXioCoDT3hyCFa=Su9ZVr5jWB8Cw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Thu, Aug 29, 2013 at 9:49 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 29-08-2013 13:13, Magnus Damm wrote:
>
>> [CC Laurent]
>
>
>>>> Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
>>>> USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
>>>> was selected on this patch
>
>
>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>> ---
>>>> v3 -> v4
>
>
>>>>   - no change
>
>
>>>>   arch/arm/mach-shmobile/board-bockw.c |   81
>>>> ++++++++++++++++++++++++++++++++--
>
>
>>> Magnus, could you review this?
>
>
>> Sure, I can try. Just to be clear though - I think I know this board
>> and SoC as little as you do. =)
>
>
>>>>   1 file changed, 78 insertions(+), 3 deletions(-)
>
>
>>>> diff --git a/arch/arm/mach-shmobile/board-bockw.c
>>>> b/arch/arm/mach-shmobile/board-bockw.c
>>>> index 07009f5..8094803 100644
>>>> --- a/arch/arm/mach-shmobile/board-bockw.c
>>>> +++ b/arch/arm/mach-shmobile/board-bockw.c
>
> [...]
>
>>>> @@ -79,13 +90,71 @@ static struct resource smsc911x_resources[] = {
>>>>        DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
>>>>   };
>>>>
>>>> +#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
>>>> +/*
>>>> + * When USB1 is Func
>>>> + */
>>>> +static int usbhsf_get_id(struct platform_device *pdev)
>>>> +{
>>>> +     return USBHS_GADGET;
>>>> +}
>>>> +
>>>> +#define SUSPMODE     0x102
>>>> +static int usbhsf_power_ctrl(struct platform_device *pdev,
>>>> +                          void __iomem *base, int enable)
>>>> +{
>>>> +     enable = !!enable;
>>>> +
>>>> +     r8a7778_usb_phy_power(enable);
>>>> +
>>>> +     iowrite16(enable << 14, base + SUSPMODE);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static struct resource usbhsf_resources[] __initdata = {
>>>> +     DEFINE_RES_MEM(0xffe60000, 0x110),
>>>> +     DEFINE_RES_IRQ(gic_iid(0x4f)),
>>>> +};
>>>> +
>>>> +static struct renesas_usbhs_platform_info usbhs_info __initdata = {
>>>> +     .platform_callback = {
>>>> +             .get_id         = usbhsf_get_id,
>>>> +             .power_ctrl     = usbhsf_power_ctrl,
>>>> +     },
>>>> +     .driver_param = {
>>>> +             .buswait_bwait  = 4,
>>>> +     },
>>>> +};
>>>> +
>>>> +#define USB_PHY_SETTING {.port1_func = 1, .ovc_pin[1].active_high = 1,}
>>>> +#define USB1_DEVICE  "renesas_usbhs"
>>>> +#define ADD_USB_FUNC_DEVICE_IF_POSSIBLE()                    \
>>>> +     platform_device_register_resndata(                      \
>>>> +             &platform_bus, "renesas_usbhs", -1,             \
>>>> +             usbhsf_resources,                               \
>>>> +             ARRAY_SIZE(usbhsf_resources),                   \
>>>> +             &usbhs_info, sizeof(struct renesas_usbhs_platform_info))
>>>> +
>>>> +#else
>>>> +/*
>>>> + * When USB1 is Host
>>>> + */
>>>> +#define USB_PHY_SETTING { }
>>>> +#define USB1_DEVICE  "ehci-platform"
>>>> +#define ADD_USB_FUNC_DEVICE_IF_POSSIBLE()
>>>> +
>>>> +#endif
>>>> +
>>>>   /* USB */
>>>>   static struct resource usb_phy_resources[] __initdata = {
>>>>        DEFINE_RES_MEM(0xffe70800, 0x100),
>>>>        DEFINE_RES_MEM(0xffe76000, 0x100),
>>>>   };
>>>>
>>>> -static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
>>>> +static struct rcar_phy_platform_data usb_phy_platform_data __initdata >>>> +     USB_PHY_SETTING;
>>>> +
>>>>
>>>>   /* SDHI */
>>>>   static struct sh_mobile_sdhi_info sdhi0_info = {
>>>> @@ -181,7 +250,7 @@ static const struct pinctrl_map bockw_pinctrl_map[]
>>>> = {
>>>>        /* USB */
>>>>        PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
>>>>                                  "usb0", "usb0"),
>>>> -     PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
>>>> +     PIN_MAP_MUX_GROUP_DEFAULT(USB1_DEVICE, "pfc-r8a7778",
>>>>                                  "usb1", "usb1"),
>>>>        /* SDHI0 */
>>>>        PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
>>>> @@ -270,6 +339,12 @@ static void __init bockw_init(void)
>>>>        }
>>>>   }
>>>>
>>>> +static void __init bockw_init_late(void)
>>>> +{
>>>> +     r8a7778_init_late();
>>>> +     ADD_USB_FUNC_DEVICE_IF_POSSIBLE();
>>>> +}
>>>> +
>>>>   static const char *bockw_boards_compat_dt[] __initdata = {
>>>>        "renesas,bockw",
>>>>        NULL,
>>>> @@ -281,5 +356,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
>>>>        .init_machine   = bockw_init,
>>>>        .init_time      = shmobile_timer_init,
>>>>        .dt_compat      = bockw_boards_compat_dt,
>>>> -     .init_late      = r8a7778_init_late,
>>>> +     .init_late      = bockw_init_late,
>>>>   MACHINE_END
>
>
>> Morimoto-san,
>
>
>> Thanks for your work on this. In this patch I understand that you
>> based on Kconfig select if ehci-platform or renesas-usbhs should be
>> used.  I wonder how well that will work together with multiplatform
>> kernels in the future. Probably not so well. So we need to figure out
>> how to handle this in the future.
>
>
>> I propose that we accept this patch as-is today to enable the
>> hardware, but we should also investigate if we for instance could let
>> the PFC handle mutual exclusion of the hardware
>
>
>    There is no mutual exclusion in this case -- host and device controllers
> only compete for USB port 1, with host owning port 0 exclusively. So both
> host and device drivers can be loaded and work concurrently.

So there is one host-only port and another host/gadget port. The
former seems easy enough, but I believe the latter one may be
problematic if the host is EHCI/OHCI and gadget is renesas_usbhs.
Regardless, unless I'm mistaken then using bind should allow us to
assign these during run-time.

>> and use bind/unbind to
>> start/stop devices during run time. Paul Mundt and I talked about this
>> ages ago but I'm not sure if it is actually possible with pinctrl or
>> not. If possible would install both ehci-platform and renesas-usbhs
>> devices in parallel and instead dynamically select one of them through
>> sysfs.
>
>
>> Laurent, do you think it is possible to use pinctrl for mutual
>> exclusion control in the drivers somehow? Basically, if the requested
>> pins are already in use then the conflicting driver instance should
>> error out.
>
>
>    I would think it's the natural thing to do, yet currently device core
> just ignores the pin conflict IIRC.

Oh, well if that's the case then someone needs to fix that. =)

>> We also want to have DT bindings for USB drivers. Morimoto-san, can
>> you please work on adding USB support to Bock-W DT reference?
>
>
>    DT bindings for EHCI/OHCI hosts are simply not possible due to using
> procedural platform data. The same seems true for USB device controller.
> Thus the only thing convertible to DT is USB common PHY and it's still on my
> agenda.

But this must be a driver design issue, no? So if the driver could be
reworked then I suspect it could be treated as any other DT device. Of
course, this may be quite difficult in practice..

Cheers,

/ magnus
