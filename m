From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 19 Jan 2012 03:44:10 +0000
Subject: Re: [RFC PATCH 05/10] sh: intc: remove dependency on NR_IRQS
Message-Id: <CABMQnVJ5WTxMq_pi2D94DxaHe9TaYx8ZRRFTCqNrOE7vUZOPeQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-6-git-send-email-robherring2@gmail.com>
 <CABMQnVKfitZu01_sKeVoC94y3GjbfTHqFEZ8ANWF4PCqA6F-Ug@mail.gmail.com>
 <4F14DEF3.5020907@gmail.com>
 <CABMQnV+e90OdoK+bMQ16H1PLtBRt9n=QxdCCOT=SZN060Ys+cw@mail.gmail.com>
 <4F15A0C6.9000901@gmail.com>
In-Reply-To: <4F15A0C6.9000901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2012/1/18 Rob Herring <robherring2@gmail.com>:
> On 01/16/2012 11:09 PM, Nobuhiro Iwamatsu wrote:
>> 2012/1/17 Rob Herring <robherring2@gmail.com>:
>>> On 01/16/2012 07:54 PM, Nobuhiro Iwamatsu wrote:
>>>> Hi,
>>>>
>>>> 2012/1/14 Rob Herring <robherring2@gmail.com>:
>>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>>
>>>>> SH intc has a compile time dependency on NR_IRQS. Make this dependenc=
y a
>>>>> local define so that shmobile (and ARM in general) can have run-time
>>>>> NR_IRQS setting. SH has NR_IRQS set to 512 and shmobile has NR_IRQS s=
et to
>>>>> 1024, so we are using the maximum.
>>>>>
>>>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>>>> ---
>>>>> =A0drivers/sh/intc/balancing.c | =A0 =A02 +-
>>>>> =A0drivers/sh/intc/core.c =A0 =A0 =A0| =A0 =A02 +-
>>>>> =A0drivers/sh/intc/handle.c =A0 =A0| =A0 =A02 +-
>>>>> =A0drivers/sh/intc/internals.h | =A0 =A09 +++++++++
>>>>> =A0drivers/sh/intc/virq.c =A0 =A0 =A0| =A0 =A02 +-
>>>>> =A05 files changed, 13 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/sh/intc/balancing.c b/drivers/sh/intc/balancing.c
>>>>> index cec7a96..bc78080 100644
>>>>> --- a/drivers/sh/intc/balancing.c
>>>>> +++ b/drivers/sh/intc/balancing.c
>>>>> @@ -9,7 +9,7 @@
>>>>> =A0*/
>>>>> =A0#include "internals.h"
>>>>>
>>>>> -static unsigned long dist_handle[NR_IRQS];
>>>>> +static unsigned long dist_handle[INTC_NR_IRQS];
>>>>>
>>>>> =A0void intc_balancing_enable(unsigned int irq)
>>>>> =A0{
>>>>> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
>>>>> index e53e449..2fde897 100644
>>>>> --- a/drivers/sh/intc/core.c
>>>>> +++ b/drivers/sh/intc/core.c
>>>>> @@ -42,7 +42,7 @@ unsigned int nr_intc_controllers;
>>>>> =A0* - this needs to be at least 2 for 5-bit priorities on 7780
>>>>> =A0*/
>>>>> =A0static unsigned int default_prio_level =3D 2; =A0 =A0/* 2 - 16 */
>>>>> -static unsigned int intc_prio_level[NR_IRQS]; =A0/* for now */
>>>>> +static unsigned int intc_prio_level[INTC_NR_IRQS]; =A0 =A0 /* for no=
w */
>>>>>
>>>>> =A0unsigned int intc_get_dfl_prio_level(void)
>>>>> =A0{
>>>>> diff --git a/drivers/sh/intc/handle.c b/drivers/sh/intc/handle.c
>>>>> index 057ce56..f461d53 100644
>>>>> --- a/drivers/sh/intc/handle.c
>>>>> +++ b/drivers/sh/intc/handle.c
>>>>> @@ -13,7 +13,7 @@
>>>>> =A0#include <linux/spinlock.h>
>>>>> =A0#include "internals.h"
>>>>>
>>>>> -static unsigned long ack_handle[NR_IRQS];
>>>>> +static unsigned long ack_handle[INTC_NR_IRQS];
>>>>>
>>>>> =A0static intc_enum __init intc_grp_id(struct intc_desc *desc,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0intc_enum enum_id)
>>>>> diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
>>>>> index b0e9155..469f092 100644
>>>>> --- a/drivers/sh/intc/internals.h
>>>>> +++ b/drivers/sh/intc/internals.h
>>>>> @@ -6,6 +6,15 @@
>>>>> =A0#include <linux/radix-tree.h>
>>>>> =A0#include <linux/device.h>
>>>>>
>>>>> +#define INTC_NR_IRQS =A0 1024
>>>>
>>>> On SH, INTC_NR_IRQS ( NR_IRQS ) =A0is using to by arch/sh/kernel/machv=
ec.c.
>>>> And, this is defined by arch/sh/include/asm/irq.h.
>>>> You need to remove or rename from these.
>>>>
>>>
>>> machvec.c will still pickup NR_IRQS from arch/sh/include/asm/irq.h, so
>>> there is no change there. The value here is increased from 512 for SH to
>>> 1024, but that should not have any functional impact only array storage
>>> space. Where it is used is a bit of a hack as the comment indicates. The
>>> only other easy way to fix it I see is with an #ifdef CONFIG_SH or
>>> CONFIG_ARM here. I welcome patches if you've got better ideas.
>>>
>>
>> I also cared about the problem from which array increases in SH.
>> Since drivers/sh/intc/internals.h is referred to only from intc function,
>> it needs to define INTC_NR_IRQS as other places.
>>
>> How is it that defines by Kconfig?
>> I created a patch on your patch. Could you give comment?
>>
>> Best regards,
>> =A0 Nobuhiro
>>
>> ------
>> diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
>> index 45d08b6..9278bb0 100644
>> --- a/arch/sh/include/asm/irq.h
>> +++ b/arch/sh/include/asm/irq.h
>> @@ -9,7 +9,6 @@
>> =A0 * advised to cap this at the hard limit that they're interested in
>> =A0 * through the machvec.
>> =A0 */
>> -#define NR_IRQS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0512
>> =A0#define NR_IRQS_LEGACY =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 =A0 =A0 =A0 /* L=
egacy external IRQ0-7 */
>>
>> =A0/*
>> diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
>> index 3d722e4..e6b12b4 100644
>> --- a/arch/sh/kernel/machvec.c
>> +++ b/arch/sh/kernel/machvec.c
>> @@ -123,5 +123,5 @@ void __init sh_mv_setup(void)
>> =A0 =A0 =A0 mv_set(mem_init);
>>
>> =A0 =A0 =A0 if (!sh_mv.mv_nr_irqs)
>> - =A0 =A0 =A0 =A0 =A0 =A0 sh_mv.mv_nr_irqs =3D NR_IRQS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sh_mv.mv_nr_irqs =3D CONFIG_SH_NR_IRQS;
>> =A0}
>> diff --git a/drivers/sh/intc/Kconfig b/drivers/sh/intc/Kconfig
>> index c88cbcc..38d51f1 100644
>> --- a/drivers/sh/intc/Kconfig
>> +++ b/drivers/sh/intc/Kconfig
>> @@ -33,3 +33,9 @@ config INTC_MAPPING_DEBUG
>> =A0 =A0 =A0 =A0 between system IRQs and the per-controller id tables.
>>
>> =A0 =A0 =A0 =A0 If in doubt, say N.
>> +
>> +config SH_NR_IRQS
>> + =A0 =A0 int
>> + =A0 =A0 depends on ARCH_SHMOBILE || SUPERH
>> + =A0 =A0 default 1024 if ARCH_SHMOBILE
>> + =A0 =A0 default 512 if SUPERH
>> diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
>> index 469f092..076c286 100644
>> --- a/drivers/sh/intc/internals.h
>> +++ b/drivers/sh/intc/internals.h
>> @@ -6,7 +6,7 @@
>> =A0#include <linux/radix-tree.h>
>> =A0#include <linux/device.h>
>>
>> -#define INTC_NR_IRQS 1024
>> +#define INTC_NR_IRQS CONFIG_SH_NR_IRQS
>>
>> =A0#ifndef evt2irq
>> =A0#define evt2irq(evt) =A0 =A0 =A0 =A0 =A0 =A0(((evt) >> 5) - 16)
>>
>
> If we went this route I wonder if it would be better for this to be more
> generic and have CONFIG_NR_IRQS like powerpc. However, I don't see
> having CONFIG_NR_IRQS as being that useful in the SPARSE_IRQ case. Plus
> it would be a much more invasive. I think I'll just add this to
> linux/sh_intc.h:
>
> #ifdef CONFIG_SUPERH
> #define INTC_NR_IRQS =A0 512
> #else
> #define INTC_NR_IRQS =A0 1024
> #endif
>

I think that this is good.

Best regards,
  Nobuhiro



--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
