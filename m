From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 29 Jan 2014 10:04:05 +0000
Subject: Re: [PATCH RFC 1/2] ARM: shmobile: lager: Use DMA bounce for PCI devices
Message-Id: <52E8D215.9060007@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390935213-12896-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390935213-12896-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/29/2014 10:47 AM, Simon Horman wrote:
> On Tue, Jan 28, 2014 at 10:53:32PM +0400, Valentine Barshak wrote:
>> Since R-Car Gen2 PCI controller does not support
>> more than 2GB memory window limit DMA mask for
>> PCI devices to 31 bits and enable DMA bounce.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   arch/arm/mach-shmobile/Kconfig       |  2 ++
>>   arch/arm/mach-shmobile/board-lager.c | 38 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
>> index 8011329..bfd8757 100644
>> --- a/arch/arm/mach-shmobile/Kconfig
>> +++ b/arch/arm/mach-shmobile/Kconfig
>> @@ -126,6 +126,7 @@ config ARCH_R8A7790
>>   	select MIGHT_HAVE_PCI
>>   	select SH_CLK_CPG
>>   	select RENESAS_IRQC
>> +	select DMABOUNCE if PCI_RCAR_GEN2
>>
>>   config ARCH_R8A7791
>>   	bool "R-Car M2 (R8A77910)"
>> @@ -135,6 +136,7 @@ config ARCH_R8A7791
>>   	select MIGHT_HAVE_PCI
>>   	select SH_CLK_CPG
>>   	select RENESAS_IRQC
>> +	select DMABOUNCE if PCI_RCAR_GEN2
>>
>>   config ARCH_EMEV2
>>   	bool "Emma Mobile EV2"
>> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
>> index 972633e..2044a23 100644
>> --- a/arch/arm/mach-shmobile/board-lager.c
>> +++ b/arch/arm/mach-shmobile/board-lager.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/leds.h>
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/sh_mmcif.h>
>> +#include <linux/pci.h>
>>   #include <linux/pinctrl/machine.h>
>>   #include <linux/platform_data/camera-rcar.h>
>>   #include <linux/platform_data/gpio-rcar.h>
>> @@ -546,9 +547,43 @@ static const struct resource usbhs_phy_resources[] __initconst = {
>>   	DEFINE_RES_MEM(0xe6590100, 0x100),
>>   };
>
> Is all the #if...#endif below completely necessary?
>

Yes they are. Otherwise the kernel doesn't build.

>>
>> +#if IS_ENABLED(CONFIG_DMABOUNCE)
>> +static int lager_needs_bounce(struct device *dev,
>> +			      dma_addr_t dma_addr, size_t size)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int lager_platform_notify(struct device *dev)
>> +{
>> +	if (dev_is_pci(dev)) {
>> +		*dev->dma_mask =  DMA_BIT_MASK(31);
>> +		dev->coherent_dma_mask = DMA_BIT_MASK(31);
>> +		dmabounce_register_dev(dev, SZ_2K, SZ_4K,
>> +				       lager_needs_bounce);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int lager_platform_notify_remove(struct device *dev)
>> +{
>> +	if (dev_is_pci(dev))
>> +		dmabounce_unregister_dev(dev);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>>   /* Add all available USB devices */
>>   static void __init lager_add_usb_devices(void)
>>   {
>> +
>> +#if IS_ENABLED(CONFIG_DMABOUNCE)
>> +	platform_notify = lager_platform_notify;
>> +	platform_notify_remove = lager_platform_notify_remove;
>> +#endif
>> +
>>   	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
>>   					  -1, usbhs_phy_resources,
>>   					  ARRAY_SIZE(usbhs_phy_resources),
>> @@ -707,4 +742,7 @@ DT_MACHINE_START(LAGER_DT, "lager")
>>   	.init_machine	= lager_init,
>>   	.init_late	= shmobile_init_late,
>>   	.dt_compat	= lager_boards_compat_dt,
>> +#if IS_ENABLED(CONFIG_ZONE_DMA)
>> +	.dma_zone_size	= SZ_1G
>> +#endif
>>   MACHINE_END
>> --
>> 1.8.3.1
>>

Thanks,
Val.
