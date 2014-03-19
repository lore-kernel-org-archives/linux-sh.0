From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 16:16:18 +0000
Subject: Re: [RFC 4/6] ARM: shmobile: r8a7790: call sh_pm_runtime_init()
Message-Id: <CAMuHMdXzMdSu_17LvTT+qHfmssiDxa9uh=V68SC49YCV_+tRMg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395054917-27390-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1395054917-27390-5-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 19, 2014 at 5:15 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
>>> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
>>> @@ -305,6 +305,7 @@ void __init r8a7790_add_dt_devices(void)
>>>
>>>   void __init r8a7790_add_standard_devices(void)
>>>   {
>>> +       sh_pm_runtime_init();
>>>          r8a7790_add_dt_devices();
>>>          r8a7790_register_irqc(0);
>>>          r8a7790_register_thermal();
>>
>>
>> Are you sure this is the right function?
>> r8a7790_add_standard_devices() is only called from board-lager.c,
>> not from board-lager-reference.c.
>>
>> I'd expect it to be added to r8a7790_add_dt_devices().
>
> Thanks, I only put this out as an RFC, not had time to do a full
> test yet.

IC.

I'm reworking the series to apply to all shmobile SoCs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
