From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 04:15:08 +0000
Subject: Re: [PATCH 01/03] ARM: shmobile: sh73a0: Introduce generic setup callback
Message-Id: <CANqRtoQ-OD0p44Bjaeu4siaQdyNWk7z4ydsCnZrkxXgFpStG_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904022845.26216.45573.sendpatchset@w520>
In-Reply-To: <20140904022845.26216.45573.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 4, 2014 at 1:05 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Sep 04, 2014 at 11:28:45AM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Add a generic sh73a0 machine setup callback for the upcoming
>> sh73a0 multiplatform case. Cache needs to be configured, and
>> legacy clocks must be omitted.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  arch/arm/mach-shmobile/setup-sh73a0.c |   16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> --- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
>> +++ work/arch/arm/mach-shmobile/setup-sh73a0.c        2014-09-04 10:46:41.000000000 +0900
>> @@ -33,6 +33,7 @@
>>  #include <linux/platform_data/sh_ipmmu.h>
>>  #include <linux/platform_data/irq-renesas-intc-irqpin.h>
>>
>> +#include <asm/hardware/cache-l2x0.h>
>>  #include <asm/mach-types.h>
>>  #include <asm/mach/map.h>
>>  #include <asm/mach/arch.h>
>> @@ -772,8 +773,6 @@ void __init sh73a0_add_early_devices(voi
>>       shmobile_setup_console();
>>  }
>>
>> -#ifdef CONFIG_USE_OF
>> -
>
> Is moving CONFIG_USE_OF from here to a bit further down intentional?
> I'm not sure how it fits with the rest of the patch.

True, I overlooked that, will fix and resend.

Cheers,

/ magnus
