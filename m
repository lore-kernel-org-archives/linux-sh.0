From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Wed, 04 Mar 2015 04:46:49 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: r8a7794 SYSC setup code
Message-Id: <54F68E39.502@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <54F50C56.5030605@bp.renesas.com>
In-Reply-To: <54F50C56.5030605@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon-san,

Thank you for your feedback.

On 2015/03/04 10:40, Simon Horman wrote:

> Hi Inami-san,
>
> On Tue, Mar 03, 2015 at 10:20:22AM +0900, Gaku Inami wrote:
>> Add r8a7794 SYSC power management support.
>>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> ---
>>  arch/arm/mach-shmobile/Makefile     |    2 +-
>>  arch/arm/mach-shmobile/pm-r8a7794.c |   44 +++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-shmobile/r8a7794.h    |    6 +++++
>>  3 files changed, 51 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/mach-shmobile/pm-r8a7794.c
>>  create mode 100644 arch/arm/mach-shmobile/r8a7794.h
>>
>> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
>> index d3aca07..cde95f8 100644
>> --- a/arch/arm/mach-shmobile/Makefile
>> +++ b/arch/arm/mach-shmobile/Makefile
>> @@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
>>  obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
>>  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
>>  obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o pm-r8a7791.o
>> -obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
>> +obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o pm-r8a7794.o
>>  obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
>>  obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
>>  
>> diff --git a/arch/arm/mach-shmobile/pm-r8a7794.c b/arch/arm/mach-shmobile/pm-r8a7794.c
>> new file mode 100644
>> index 0000000..a8a94cf
>> --- /dev/null
>> +++ b/arch/arm/mach-shmobile/pm-r8a7794.c
>> @@ -0,0 +1,44 @@
>> +/*
>> + * r8a7794 Power management support
>> + *
>> + * Copyright (C) 2015  Renesas Electronics Corporation
>> + *
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + */
>> +
>> +#include <asm/io.h>
>> +#include "pm-rcar.h"
>> +#include "r8a7794.h"
>> +
>> +/* SYSC */
>> +#define SYSCIER 0x0c
>> +#define SYSCIMR 0x10
>> +
>> +#if defined(CONFIG_SMP)
>> +
>> +static void __init r8a7794_sysc_init(void)
>> +{
>> +	void __iomem *base = rcar_sysc_init(0xe6180000);
>> +
>> +	/* enable all interrupt sources, but do not use interrupt handler */
>> +	iowrite32(0x00310060, base + SYSCIER);
> Is it intentional that 0x00310060 differs from
> the value of 0x0131000e used on the r8a7790 and r8a7791?

Yes. According to R-CAR Gen2 HW manual, interrupt bits are 
different in each SoC. Therefore, I think the setting value 
of SYSCIER should be set to a different value in each SoC.

*Setting value of SYSCIER
 r8a7790 : 0x013111EF
 r8a7791 : 0x00111003
 r8a7794 : 0x00310060

I don't know why the value of 0x0131000e is used on the r8a7790
and the r8a7791. (maybe wrong value)

> Could we consolidate this function across the R-Car Gen2 SoCs that
> use them?

I will consider to consolidate these functions into one.

Regards,
Inami

