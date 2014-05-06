From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 May 2014 21:17:48 +0000
Subject: Re: [PATCH] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <CAMuHMdXeC154pM5BjPzSnMRegqJbzaGWt-dKwOKxNfNp18oBpQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Tue, May 6, 2014 at 12:45 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>    2. Can we already reduce the list of SoCs to check for?
>>       E.g. is this needed for emev2, which doesn't have MSTP clocks?
>
> From what I remember the EMEV2 does have hardware clock gates for
> IP, just not the same way as the newer SoCs have. I have not tried
> any newer kernels with this as the project I was on which used this
> device is no-longer going.

OK, will keep.

>> v3:
>>    - Add of_machine_is_compatible() checks for multi-platform
>>    - Remove Reviewed-by, Tested-by, as too much has changed,
>>    - Assumed authorship, as not much is left from the original patch from
>>      Ben (Ben: is that OK?),
>
> Yes, that would fine. It looks like there is enough changes to
> drop that. Thanks for sorting this out.

Thanks!

>> -static int __init sh_pm_runtime_init(void)
>> +static bool default_pm_on;
>> +
>> +int __init sh_pm_runtime_init(void)
>>   {
>> +#ifdef CONFIG_ARCH_SHMOBILE_MULTI
>> +       if (!of_machine_is_compatible("renesas,emev2") &&
>> +           !of_machine_is_compatible("renesas,r7s72100") &&
>> +           !of_machine_is_compatible("renesas,r8a73a4") &&
>> +           !of_machine_is_compatible("renesas,r8a7740") &&
>> +           !of_machine_is_compatible("renesas,r8a7778") &&
>> +           !of_machine_is_compatible("renesas,r8a7779") &&
>> +           !of_machine_is_compatible("renesas,r8a7790") &&
>> +           !of_machine_is_compatible("renesas,r8a7791") &&
>> +           !of_machine_is_compatible("renesas,sh7372") &&
>> +           !of_machine_is_compatible("renesas,sh73a0"))
>> +               return 0;
>> +#endif
>
> Is there a more generic compatible that could be matched on?

As I already replied to Magnus, I don't think so.

> Could we do an if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) instead
> of an #ifdef block?

Good idea, that will increase compile coverage, while, the compiler will
still remove it when appropriate.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
