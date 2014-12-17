From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 14:24:52 +0000
Subject: Re: [PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
Message-Id: <CAMuHMdVkwS9DhUjKxrLBQsYZbo+yX1btPqWHiQ-MTECf-rDZiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094234.7039.79623.sendpatchset@w520>
In-Reply-To: <20141217094234.7039.79623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Dec 17, 2014 at 3:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> --- 0001/arch/arm/mach-shmobile/Makefile
>>> +++ work/arch/arm/mach-shmobile/Makefile        2014-12-16 19:12:19.000000000 +0900
>>> @@ -7,7 +7,7 @@ obj-y                           := timer.o console.o
>>>  # CPU objects
>>>  obj-$(CONFIG_ARCH_SH7372)      += setup-sh7372.o intc-sh7372.o pm-sh7372.o
>>> -obj-$(CONFIG_ARCH_SH73A0)      += setup-sh73a0.o intc-sh73a0.o pm-sh73a0.o
>>> +obj-$(CONFIG_ARCH_SH73A0)      += setup-sh73a0.o pm-sh73a0.o
>>>  obj-$(CONFIG_ARCH_R8A73A4)     += setup-r8a73a4.o
>>>  obj-$(CONFIG_ARCH_R8A7740)     += setup-r8a7740.o pm-r8a7740.o
>>>  obj-$(CONFIG_ARCH_R8A7778)     += setup-r8a7778.o
>>> @@ -65,7 +65,7 @@ obj-$(CONFIG_MACH_BOCKW)      += board-bockw.
>>>  obj-$(CONFIG_MACH_BOCKW_REFERENCE)     += board-bockw-reference.o
>>>  obj-$(CONFIG_MACH_MARZEN)      += board-marzen.o
>>>  obj-$(CONFIG_MACH_ARMADILLO800EVA)     += board-armadillo800eva.o
>>> -obj-$(CONFIG_MACH_KZM9G)       += board-kzm9g.o
>>> +obj-$(CONFIG_MACH_KZM9G)       += board-kzm9g.o intc-sh73a0.o
>>>  obj-$(CONFIG_MACH_KZM9G_REFERENCE)     += board-kzm9g-reference.o
>>
>> Building intc-sh73a0.o for kzm9g-legacy only, means we will no longer
>> instantiate
>> the GIC from C board code on kzm9g-reference. So the issue I mentioned in
>> the sh_tmu thread:
>>
>> | On kzm9g-reference, the TWD is not instantiated, causing the same hang.
>> | If I instantiate the TWD from C board code there, it fails with
>> |
>> |    twd: can't register interrupt 29 (-22)
>> |
>> | which looks like a symptom of https://lkml.org/lkml/2014/12/2/339
>>
>> is indeed caused by the GIC.
>
> Oh, thanks for bringing this to my attention. So sh73a0 legacy DT
> reference needs some care too?

I think it needs a call to gic_init() somewhere else.

>>> --- 0011/arch/arm/mach-shmobile/setup-sh73a0.c
>>> +++ work/arch/arm/mach-shmobile/setup-sh73a0.c  2014-12-16 19:13:33.000000000 +0900
>>> @@ -764,7 +764,9 @@ void __init __weak sh73a0_register_twd(v
>>>  void __init sh73a0_earlytimer_init(void)
>>>  {
>>>         shmobile_init_delay();
>>> +#ifndef CONFIG_COMMON_CLK
>>>         sh73a0_clock_init();
>>> +#endif
>>>         shmobile_earlytimer_init();
>>>         sh73a0_register_twd();
>>>  }
>>> @@ -780,9 +782,10 @@ void __init sh73a0_add_early_devices(voi
>>>
>>>  void __init sh73a0_add_standard_devices_dt(void)
>>>  {
>>> +#ifndef CONFIG_COMMON_CLK
>>>         /* clocks are setup late during boot in the case of DT */
>>>         sh73a0_clock_init();
>>> -
>>> +#endif
>>>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>>  }
>>
>> These changes conflict with "[PATCH v7 6/6] ARM: shmobile: sh73a0: disable
>> legacy clock initialization", on which this series claims to depend on?
>
> That's right. I have a different version of this patch that is
> compatible with the one above.
>
> I was hoping on getting this series merged somewhat soonish -
> independently of the CCF patches - and without those #ifdef hunks the
> code will not compile. But the drawback is that the patch above needs
> to be dropped.
>
> I'm happy to adjust, but I do think in general that merging stuff
> early must be better than postponing and increasing the burden...

I 100% agree.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
