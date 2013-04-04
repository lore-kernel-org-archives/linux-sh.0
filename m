From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 04 Apr 2013 16:06:22 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a7740: Add OF support to initialze the GIC
Message-Id: <CABYn4sz1GquCWXT9UZ1kz5tivOEpQhJmZVevuhvUNQXzBVpZDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365083144-16085-5-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365083144-16085-5-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

2013/4/4 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> Thanks for the patch.
>
> On Thursday 04 April 2013 15:45:43 Bastian Hecht wrote:
>> We add a variant to initalize the interrupt controller in case we describe
>> the GIC using the Device Tree and not platform data.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
>>  arch/arm/mach-shmobile/intc-r8a7740.c         |   24 ++++++++++++++++------
>>  2 files changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h
>> b/arch/arm/mach-shmobile/include/mach/r8a7740.h index 61df082..1cf6869
>> 100644
>> --- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
>> +++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
>> @@ -535,6 +535,7 @@ enum {
>>  extern void r8a7740_meram_workaround(void);
>>  extern void r8a7740_init_delay(void);
>>  extern void r8a7740_init_irq(void);
>> +extern void r8a7740_init_irq_of(void);
>>  extern void r8a7740_map_io(void);
>>  extern void r8a7740_add_early_devices(void);
>>  extern void r8a7740_add_standard_devices(void);
>> diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c
>> b/arch/arm/mach-shmobile/intc-r8a7740.c index b741c84..58115e8 100644
>> --- a/arch/arm/mach-shmobile/intc-r8a7740.c
>> +++ b/arch/arm/mach-shmobile/intc-r8a7740.c
>> @@ -20,19 +20,15 @@
>>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> +#include <linux/irqchip.h>
>>  #include <linux/irqchip/arm-gic.h>
>>
>> -void __init r8a7740_init_irq(void)
>> +void __init r8a7740_init_irq_common(void)
>
> static void ?

Yes true, will add it in v2.

Thanks for all the reviews!

 Bastian

>>  {
>> -     void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
>> -     void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
>>       void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
>>       void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
>>       void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
>>
>> -     /* initialize the Generic Interrupt Controller PL390 r0p0 */
>> -     gic_init(0, 29, gic_dist_base, gic_cpu_base);
>> -
>>       /* route signals to GIC */
>>       iowrite32(0x0, pfc_inta_ctrl);
>>
>> @@ -54,3 +50,19 @@ void __init r8a7740_init_irq(void)
>>       iounmap(intc_msk_base);
>>       iounmap(pfc_inta_ctrl);
>>  }
>> +
>> +void __init r8a7740_init_irq_of(void)
>> +{
>> +     irqchip_init();
>> +     r8a7740_init_irq_common();
>> +}
>> +
>> +void __init r8a7740_init_irq(void)
>> +{
>> +     void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
>> +     void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
>> +
>> +     /* initialize the Generic Interrupt Controller PL390 r0p0 */
>> +     gic_init(0, 29, gic_dist_base, gic_cpu_base);
>> +     r8a7740_init_irq_common();
>> +}
> --
> Regards,
>
> Laurent Pinchart
>
