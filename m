From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 Jul 2015 02:50:36 +0000
Subject: Re: Traceback in -next due to commit 'clockevents/drivers/sh_tmu: Migrate to new 'set-state' interfa
Message-Id: <55ADB37C.5020306@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <55AD6314.2050000@roeck-us.net> <20150721023114.GD4994@linux>
In-Reply-To: <20150721023114.GD4994@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 07/20/2015 07:31 PM, Viresh Kumar wrote:
> On 20-07-15, 14:07, Guenter Roeck wrote:
>> Hi,
>>
>> Commit 991a7f4970ed1 ("clockevents/drivers/sh_tmu: Migrate to new 'set-state' interface")
>> in -next causes the following traceback. This is seen with qemu runs for the sh target.
>>
>> ------------[ cut here ]------------
>> WARNING: at drivers/clocksource/sh_tmu.c:202
>> Modules linked in:
>
> Can you please try this:
>
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 43c98143f79a..469e776ec17a 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -362,7 +362,8 @@ static int sh_tmu_clock_event_shutdown(struct clock_event_device *ced)
>   {
>   	struct sh_tmu_channel *ch = ced_to_sh_tmu(ced);
>
> -	sh_tmu_disable(ch);
> +	if (clockevent_state_oneshot(ced) || clockevent_state_periodic(ced))
> +		sh_tmu_disable(ch);
>   	return 0;
>   }
>
>
This patch fixes the problem.

Thanks,
Guenter

