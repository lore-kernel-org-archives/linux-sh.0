From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 19 Sep 2014 01:57:01 +0000
Subject: Re: [PATCH] ARM: shmobile: Fix wrong calculation in shmobile_init_delay()
Message-Id: <541B8D6D.5020901@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5412A889.2000209@renesas.com>
In-Reply-To: <5412A889.2000209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san,

Thanks for your reply.

On 9/19/2014 10:04 AM, Magnus Damm wrote:
> Hi Khiem-san,
> 
> Thanks for your patch.
> 
> On Fri, Sep 12, 2014 at 5:02 PM, Khiem Nguyen
> <khiem.nguyen.xt@renesas.com> wrote:
>> The processing to get CPU information loop on all available CPUs
>> and decide whether calculating preset_lpj for for CA15 or CA7/8/9.
>> The calculation will go for CA7/8/9 prior to CA15.
>>
>> The commit 0dc50fd ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
>> introduced wrong CPU selection in case CA15 and CA7/8/9 coexist, e.g R-CarH2.
>> At the end, it leads to the wrong calculation of preset_lpj for R-CarH2.
>>
>> Fix it by selecting the first CPU in DTS file.
>>
>> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
>> ---
>>  arch/arm/mach-shmobile/timer.c |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
>> index 87c6be1..9394cad 100644
>> --- a/arch/arm/mach-shmobile/timer.c
>> +++ b/arch/arm/mach-shmobile/timer.c
>> @@ -59,10 +59,14 @@ void __init shmobile_init_delay(void)
>>
>>                 if (of_device_is_compatible(np, "arm,cortex-a7") ||
>>                     of_device_is_compatible(np, "arm,cortex-a8") ||
>> -                   of_device_is_compatible(np, "arm,cortex-a9"))
>> +                   of_device_is_compatible(np, "arm,cortex-a9")) {
>>                         is_a7_a8_a9 = true;
>> -               else if (of_device_is_compatible(np, "arm,cortex-a15"))
>> +                       break;
>> +               }
>> +               else if (of_device_is_compatible(np, "arm,cortex-a15")) {
>>                         is_a15 = true;
>> +                       break;
>> +               }
>>         }
>>
>>         of_node_put(cpus);
> 
> I may misunderstand the problem here, but I don't think this patch is needed.

Base on your explanation,  I think it's not needed.
Sorry for the noise.

> 
> Basically, my view of things is that if we have a CA7 core on the
> system then a longer delay may be necessary. This to make sure that
> delays running on CA7 will work as expected as well. This patch
> introduces some ordering dependency and just considers the first CPU.

So, before 0dc50fd was merged, if all CPUs (CA15 and CA7) in R-CarH2 are enabled,
like big.LITTLE configuration, system may not run correctly (due to insufficient delay of CA7).

Is it correct ? :)
  
> 
> A different fix for CA7 may however be necessary to handle arch timer
> as expected. So you are right that commit "0dc50fd ARM: shmobile:
> support Cortex-A7 in shmobile_init_delay()" may need some more work.
> 
> Thanks,
> 
> / magnus
> 

-- 
Best regards,
KHIEM Nguyen
