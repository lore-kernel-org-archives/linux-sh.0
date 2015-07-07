From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Jul 2015 15:21:54 +0000
Subject: Re: [PATCH] ARM: shmobile: rcar-gen2: CONFIG_ARM_ARCH_TIMER is always set
Message-Id: <CAMuHMdWNyJAitU17N1=tNReeHJqCENCS7JxLJocj5zanouavew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tue, Jul 7, 2015 at 5:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Tue, Jul 7, 2015 at 11:05 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> Since commit 731bde02f622d694 ("ARM: shmobile: Select
>> HAVE_ARM_ARCH_TIMER from Kconfig"), CONFIG_ARM_ARCH_TIMER is always set
>> when building for R-Car Gen2 SoCs, as it is selected by
>> CONFIG_HAVE_ARM_ARCH_TIMER.  Remove the obsolete #ifdef testing for it.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> index aa3339258d9c0232..570d6bd3784f7464 100644
>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> @@ -52,7 +52,6 @@ u32 rcar_gen2_read_mode_pins(void)
>>  void __init rcar_gen2_timer_init(void)
>>  {
>>         u32 mode = rcar_gen2_read_mode_pins();
>> -#ifdef CONFIG_ARM_ARCH_TIMER
>>         void __iomem *base;
>>         int extal_mhz = 0;
>>         u32 freq;
>> @@ -125,7 +124,6 @@ void __init rcar_gen2_timer_init(void)
>>         }
>>
>>         iounmap(base);
>> -#endif /* CONFIG_ARM_ARCH_TIMER */
>
> Uhm, these two variables at least used to work differently:
> CONFIG_HAVE_ARM_ARCH_TIMER - hardware may include arch timer
> CONFIG_ARM_ARCH_TIMER - user enabled arch timer device driver
>
> In arch/arm/Kconfig, isn't CONFIG_ARM_ARCH_TIMER user selectable?
>
> I like that users can select and deselect support for various timers,
> but if the user can't select then I think your patch is correct. =)

HAVE_ARM_ARCH_TIMER used to be user-selectable, but your patch
"ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig" made that
unconditional for R-Car Gen2 and APE6 ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
