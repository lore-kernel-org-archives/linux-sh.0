From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Aug 2015 15:03:37 +0000
Subject: Re: Traceback in -next due to commit 'clockevents/drivers/sh_tmu: Migrate to new 'set-state' interfa
Message-Id: <CAMuHMdXpxcu_Rmi6p6JvAwB8Tr19Fr7oEBVbWXN1G0QyYPVr2g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <55AD6314.2050000@roeck-us.net>
	<20150721023114.GD4994@linux>
	<55ADB37C.5020306@roeck-us.net>
In-Reply-To: <55ADB37C.5020306@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

Hi Viresh,

On Tue, Jul 21, 2015 at 4:50 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/20/2015 07:31 PM, Viresh Kumar wrote:
>> On 20-07-15, 14:07, Guenter Roeck wrote:
>>> Commit 991a7f4970ed1 ("clockevents/drivers/sh_tmu: Migrate to new
>>> 'set-state' interface")
>>> in -next causes the following traceback. This is seen with qemu runs for
>>> the sh target.
>>>
>>> ------------[ cut here ]------------
>>> WARNING: at drivers/clocksource/sh_tmu.c:202
>>> Modules linked in:
>>
>> Can you please try this:
>>
>> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
>> index 43c98143f79a..469e776ec17a 100644
>> --- a/drivers/clocksource/sh_tmu.c
>> +++ b/drivers/clocksource/sh_tmu.c
>> @@ -362,7 +362,8 @@ static int sh_tmu_clock_event_shutdown(struct
>> clock_event_device *ced)
>>   {
>>         struct sh_tmu_channel *ch = ced_to_sh_tmu(ced);
>>
>> -       sh_tmu_disable(ch);
>> +       if (clockevent_state_oneshot(ced) ||
>> clockevent_state_periodic(ced))
>> +               sh_tmu_disable(ch);
>>         return 0;
>>   }
>>
>>
> This patch fixes the problem.

I'm seeing the same WARNING on ARM (r8a7740/armadillo), and it's fixed by
your patch.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
