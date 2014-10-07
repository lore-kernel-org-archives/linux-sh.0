From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 07 Oct 2014 05:52:48 +0000
Subject: Re: [PATCH] ARM: shmobile: Handle CA7 arch timer delay
Message-Id: <CANqRtoS-=cAS_ZST13CLc6wSzYK9=pm6X+j7=LdjyR0hLJyeUg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141005235920.3532.40364.sendpatchset@w520>
In-Reply-To: <20141005235920.3532.40364.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san,

On Tue, Oct 7, 2014 at 1:17 PM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> Hi Magnus-san,
>
> On 10/7/2014 12:32 PM, Magnus Damm wrote:
>> Hi Khiem-san,
>>
>> On Tue, Oct 7, 2014 at 9:50 AM, Khiem Nguyen
>> <khiem.nguyen.xt@renesas.com> wrote:
>>> Hi Magnus-san,
>>>
>>>
>>>
>>> Thanks for your patch.
>>
>> Thanks for your email.
>>
>>> I have 2 points to confirm.
>>>
>>> Please kindly share your opinions.
>>
>> Sure.
>>
>>> On 10/6/2014 8:59 AM, Magnus Damm wrote:
>>>> From: Magnus Damm <damm+renesas@opensource.se>
>>>>
>>>> Update the delay code to include arch timer checks
>>>> for CA7. From a arch timer availability perspective
>>>> CA7 should be treated same as CA15.
>>>
>>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>>>> ---
>>>>
>>>>  Written against renesas-devel-20141002-v3.17-rc7
>>>>
>>>>  arch/arm/mach-shmobile/timer.c |   23 +++++++++++++++--------
>>>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>>>
>>>> --- 0001/arch/arm/mach-shmobile/timer.c
>>>> +++ work/arch/arm/mach-shmobile/timer.c       2014-10-06 08:44:21.000000000 +0900
>>>> @@ -45,6 +45,7 @@ void __init shmobile_init_delay(void)
>>>>       struct device_node *np, *cpus;
>>>>       bool is_a7_a8_a9 = false;
>>>>       bool is_a15 = false;
>>>> +     bool has_arch_timer = false;
>>>>       u32 max_freq = 0;
>>>>
>>>>       cpus = of_find_node_by_path("/cpus");
>>>> @@ -57,12 +58,16 @@ void __init shmobile_init_delay(void)
>>>>               if (!of_property_read_u32(np, "clock-frequency", &freq))
>>>>                       max_freq = max(max_freq, freq);
>>>>
>>>> -             if (of_device_is_compatible(np, "arm,cortex-a7") ||
>>>> -                 of_device_is_compatible(np, "arm,cortex-a8") ||
>>>> -                 of_device_is_compatible(np, "arm,cortex-a9"))
>>>> +             if (of_device_is_compatible(np, "arm,cortex-a8") ||
>>>> +                 of_device_is_compatible(np, "arm,cortex-a9")) {
>>>>                       is_a7_a8_a9 = true;
>>>> -             else if (of_device_is_compatible(np, "arm,cortex-a15"))
>>>> +             } else if (of_device_is_compatible(np, "arm,cortex-a7")) {
>>>> +                     is_a7_a8_a9 = true;
>>>> +                     has_arch_timer = true;
>>>> +             } else if (of_device_is_compatible(np, "arm,cortex-a15")) {
>>>>                       is_a15 = true;
>>>> +                     has_arch_timer = true;
>>>
>>> Because has_arch_timer set true here, below delay setting for a15 will never be entered.
>>> However, before this patch, it will be executed in case CONFIG_ARM_ARCH_TIMER is disable.
>>> Is it your intention ?
>>
>> No, it is not my intention. "has_arch_timer" here is used to tell if
>> the arch timer hardware may be available. This only happens on CA7 and
>> CA15.
>>
>>>> +             }
>>>>       }
>>>>
>>>>       of_node_put(cpus);
>>>> @@ -70,10 +75,12 @@ void __init shmobile_init_delay(void)
>>>>       if (!max_freq)
>>>>               return;
>>>>
>>>> -     if (is_a7_a8_a9)
>>>> -             shmobile_setup_delay_hz(max_freq, 1, 3);
>>>> -     else if (is_a15 && !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
>>>> -             shmobile_setup_delay_hz(max_freq, 2, 4);
>>>> +     if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
>>>
>>> Above condition checking will apply to all cortex cores, including a8 and a9.
>>> However, before this patch, delay setting will be set for a8 and a9,
>>> regardless of CONFIG_ARM_ARCH_TIMER.
>>> Is it your intention ?
>>
>> My intention is to only call shmobile_setup_delay_hz() in the following cases:
>>
>> A) arch timer hardware is unavailable (has_arch_timer is false)
>> or
>> B) arch timer is available (has_arch_timer is true) and
>> CONFIG_ARM_ARCH_TIMER is disabled.
>>
>> Case A) above covers CPU cores without arch timer, like CA8 and CA9.
>>
>> Is there any problem?
>
> Your implementation is OK.
> At the beginning, I confused the meaning of using 'has_arch_timer'
> and CONFIG_ARM_ARCH_TIMER.
> Now, I understood the implementation via your explanation.

Ok, good! Thanks for checking!

Cheers,

/ magnus
