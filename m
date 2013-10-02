From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 02 Oct 2013 12:36:24 +0000
Subject: Re: [PATCH 5/6] arm: shmobile: lager: Add internal PCI support
Message-Id: <524C1348.5050108@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-6-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-6-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/02/2013 04:24 AM, Magnus Damm wrote:
> Hi again Valentine,

Hi,

>
> Thanks for your efforts.

Thanks!

>
> On Wed, Oct 2, 2013 at 3:30 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
>> This adds internal PCI/USB host support to Lager board.
>> There are 3 internal PCI bus controllers with only a EHCI/OHCI
>> device present on each one. This gives us 3 USB host channels.
>> Channel 0 is shared with the USBHS function module.
>> Channel 2 is shared with the USBSS (XHCI) device.
>>
>> Currently no channel configuration is supported,
>> and the default settings are assumed:
>> Channel 0 - USBHS
>> Channel 1 - PCI/USB host
>> Channel 2 - PCI/USB host
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   arch/arm/mach-shmobile/board-lager.c | 41 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
>> index e408fc7..08236fb 100644
>> --- a/arch/arm/mach-shmobile/board-lager.c
>> +++ b/arch/arm/mach-shmobile/board-lager.c
>> @@ -303,6 +303,38 @@ static struct usbhs_private usbhs_priv __initdata = {
>>   #define lager_register_usbhs()
>>   #endif /* CONFIG_USB_RENESAS_USBHS_UDC */
>>
>> +/*
>> + * Internal PCI
>> + * There are 3 internal PCI bus controllers with only a EHCI/OHCI
>> + * device present on each one. This gives us 3 USB host channels.
>> + * Channel 0 is shared with the USBHS function module.
>> + * Channel 2 is shared with the USBSS (XHCI) device.
>> + */
>> +#if IS_ENABLED(CONFIG_PCI)
>
> Usually we don't wrap any platform devices in #Ifdefs, what's the
> reason for that in this case?

No particular reason, other than probably just to save some bits
and make it look the same as the USBHS stuff.

>
>> +static const struct resource pci_resources[] __initconst = {
>> +       /* Internal PCI0 */
>> +       DEFINE_RES_MEM_NAMED(0xee080000, 0x10000, "PCI0 MEM"),
>> +       DEFINE_RES_MEM_NAMED(0xee090000, 0x10000, "PCI0 CFG"),
>> +       DEFINE_RES_IRQ(gic_spi(108)),
>> +       /* Internal PCI1 */
>> +       DEFINE_RES_MEM_NAMED(0xee0a0000, 0x10000, "PCI1 MEM"),
>> +       DEFINE_RES_MEM_NAMED(0xee0b0000, 0x10000, "PCI1 CFG"),
>> +       DEFINE_RES_IRQ(gic_spi(112)),
>> +       /* Internal PCI2 */
>> +       DEFINE_RES_MEM_NAMED(0xee0c0000, 0x10000, "PCI2 MEM"),
>> +       DEFINE_RES_MEM_NAMED(0xee0d0000, 0x10000, "PCI2 CFG"),
>> +       DEFINE_RES_IRQ(gic_spi(113)),
>> +};
>> +
>> +#define lager_register_pci()                                           \
>> +       platform_device_register_simple("pci-rcar-gen2",                \
>> +                                       -1, pci_resources,              \
>> +                                       ARRAY_SIZE(pci_resources))
>> +}
>> +#else  /* CONFIG_PCI */
>> +#define lager_register_pci()
>> +#endif /* CONFIG_PCI */
>
> Also, I doubt that these PCI bits have anything to do with Lager. They
> must be more of a r8a7790 SoC specific property. So they should most
> likely go into setup-r8a7790.c instead of board-lager.c.

OK, I'll move it to setup-r8a7790.c

BTW, the PCI resources on r8a7791 look almost the same (according to 
RCAR M2 manual), apart that IRQ 112 is marked "reserved" and there seems 
to be no interrupt for PCI1 for some reason.

>
> I would also like to hear if you have any plans for DT bindings for
> the USB and/or PCI drivers, please let me know.

Probably later when non-DT version is pulled in.
USBHS DT bindings would involve some driver changes as well.

>
> Thanks,
>
> / magnus
>

Thanks,
Val.
