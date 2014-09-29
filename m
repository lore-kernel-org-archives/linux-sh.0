From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Mon, 29 Sep 2014 00:09:47 +0000
Subject: Re: [PATCH RFC 4/7] ARM: shmobile: Backup and restore L2CTLR in Suspend-to-RAM
Message-Id: <5428A34B.8040402@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5424D20C.1090406@renesas.com>
In-Reply-To: <5424D20C.1090406@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 9/26/2014 7:06 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 9/26/2014 6:40 AM, Khiem Nguyen wrote:
> 
>> This is needed for CA15 only, to maintain L2CTLR register value
>> set in bootloader.
> 
>> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> 
> [...]
> 
>> diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
>> index fb6d3e5..f883697 100644
>> --- a/arch/arm/mach-shmobile/platsmp-apmu.c
>> +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
> [...]
>> @@ -229,6 +230,13 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
>>       gic_cpu_if_down();
>>
>>       writel_relaxed(0x2, cpucmcr);
>> +    if (read_cpuid_part() = ARM_CPU_PART_CORTEX_A15) {
>> +        is_a15_l2shutdown = 1;
>> +        asm volatile("mrc p15, 1, %0, c9 , c0, 2"
>> +                 : "=r" (l2ctlr_value));
>> +        pr_debug("%s: l2ctlr: 0x%08x\n", __func__, l2ctlr_value);
>> +    } else
>> +        is_a15_l2shutdown = 0;
> 
>    Both arms of *if* should have {} if at least one arm has it.

Will fix in V2. Thanks.
 
> WBR, Sergei
> 

-- 
Best regards,
KHIEM Nguyen
