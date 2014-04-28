From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Apr 2014 05:45:38 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: Enable shmobile Runtime PM from MSTP clock driver
Message-Id: <CAMuHMdVE8eEhUa2DPRpavmhgDEpbnPxXcr8pErOUDf1XKTJmVA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398445124-16828-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398445124-16828-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Mon, Apr 28, 2014 at 2:10 AM, Simon Horman <horms@verge.net.au> wrote:
>> --- a/drivers/sh/pm_runtime.c
>> +++ b/drivers/sh/pm_runtime.c
>> @@ -75,20 +75,24 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
>>       .con_ids = { NULL, },
>>  };
>>
>> -static bool default_pm_on;
>> +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE_LEGACY)
>> +bool default_pm_on = true;
>> +#else
>> +bool default_pm_on;
>> +#endif
>
> I wonder if there is some way we can get the compiler
> to optimise out code in the case of default_pm_on = false,
> perhaps by using IS_ENABLED() in conjunction with a Kconfig variable.

What's the use case of that?

This code is compiled only if SUPERH || ARCH_SHMOBILE_LEGACY ||
ARCH_SHMOBILE_MULTIPLATORM.
If should always be used when running on shmobile.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
