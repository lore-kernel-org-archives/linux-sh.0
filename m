From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 08 Sep 2018 17:20:42 +0000
Subject: Re: [PATCH v2] clocksource: sh_cmt: fixup for 64-bit machines
Message-Id: <8ffc1f31-607a-2550-59bb-bba1da4e1f78@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <e7324659-7697-7d8a-dcc4-edd8968bcfad@cogentembedded.com>
 <CAMuHMdW0KkVYyMeo3wwnyGzn1tAA5Tkrq_cKVjHCFnYc9tALjw@mail.gmail.com>
In-Reply-To: <CAMuHMdW0KkVYyMeo3wwnyGzn1tAA5Tkrq_cKVjHCFnYc9tALjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, andrey.gusakov@cogentembedded.com, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello!

On 09/06/2018 03:18 PM, Geert Uytterhoeven wrote:

>> When trying to use CMT for clockevents on R-Car gen3 SoCs, I noticed
>> that 'max_delta_ns' for the broadcast timer (CMT) was shown as 1000 in
>> /proc/timer_list. It turned out that when calculating it, the driver did
>> 1 << 32 (causing what I think was undefined behavior) resulting in a zero
>> delta, later clamped to 1000 by cev_delta2ns(). The root cause turned out
>> to be that the driver abused *unsigned long* for the CMT register values
>> (which are 16/32-bit), so that the calculation of 'ch->max_match_value'
>> in sh_cmt_setup_channel() used the worng branch. Using more proper 'u32'
>> instead fixed 'max_delta_ns' and even fixed the switching an active
>> clocksource to CMT (which caused the system to turn non-interactive
>> before).
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'tip.git' repo's 'timers/core' branch.
>> The CMT driver wasn't ever used on SH64; on R-Car gen3 (ARM64) I'm only
>> enabling building of this driver now, so not sure how urgent is this...
>>
>> Changes in version 2:
>> - completely redid the patch, fixing abuse of *unsigned long* for the CMT
>>   register values.
> 
> Thanks for the update!
> 
>> --- tip.orig/drivers/clocksource/sh_cmt.c
>> +++ tip/drivers/clocksource/sh_cmt.c
>> @@ -82,14 +82,13 @@ struct sh_cmt_info {
>>         unsigned long clear_bits;
> 
> "clear_bits" should be u32, as it corresponds to a register value.

   OK.
 
>> @@ -103,9 +102,9 @@ struct sh_cmt_channel {
>>
>>         unsigned int timer_bit;
>>         unsigned long flags;
> 
> While no register value, "flags" can be unsigned int, too.

   OK to leave that for another patch?

>> -       unsigned long match_value;
>> -       unsigned long next_match_value;
>> -       unsigned long max_match_value;
>> +       u32 match_value;
>> +       u32 next_match_value;
>> +       u32 max_match_value;
>>         raw_spinlock_t lock;
>>         struct clock_event_device ced;
>>         struct clocksource cs;
> 
>> @@ -290,7 +284,7 @@ static inline void sh_cmt_write_cmcor(st
>>  static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
> 
> Return type should be "u32".

   Thanks, missed it...

>>                                         int *has_wrapped)
> 
> While not "unsigned long", "has_wrapped" is used to store a register value,
> so I think it should be changed to "u32 *".

   Hm, indeed...

>>  {
>> -       unsigned long v1, v2, v3;
>> +       u32 v1, v2, v3;
>>         int o1, o2;
> 
> While not "unsigned long", "o1" and "o2" contain register values, so I think
> they should be "u32".

   OK, lemme try that...

>>         o1 = sh_cmt_read_cmcsr(ch) & ch->cmt->info->overflow_bit;
> 
> "overflow_bit" should become "u32", too.

   I've figured. :-)

> 
>> @@ -619,9 +614,10 @@ static struct sh_cmt_channel *cs_to_sh_c
>>  static u64 sh_cmt_clocksource_read(struct clocksource *cs)
>>  {
>>         struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
>> -       unsigned long flags, raw;
>> +       unsigned long flags;
>>         unsigned long value;
>>         int has_wrapped;
>> +       u32 raw;
>>
>>         raw_spin_lock_irqsave(&ch->lock, flags);
>>         value = ch->total_cycles;
> 
> "value" and "total_cycles" should be "u64". But that's a separate bug fix.

   And for 32-bit CPUs, I guess? Will look into it...

> Not in the context, so I cannot comment to it, but "sh_cmt_info.width" should
> be "unsigned int", too.

   Separate patch?

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergei
