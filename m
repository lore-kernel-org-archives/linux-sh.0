From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2014 07:56:10 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: Call sh_pm_runtime_init() from platform code on all SoCs
Message-Id: <CAMuHMdUKQnJDi3+6FKWDmWgEmb9nd1_NKOpSmFZytkbu3VKYLw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-5-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-5-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Thu, Mar 27, 2014 at 11:59 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 27/03/14 20:05, Geert Uytterhoeven wrote:
>> On Wed, Mar 19, 2014 at 8:06 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> Explicitly call sh_pm_runtime_init() from shmobile platform code on all
>>> shmobile SoCs, to make sure the bus clocks are enabled for all devices.
>>>
>>> On ARCH_SHMOBILE_LEGACY, this duplicates the work done in the existing
>>> core_initcall() in drivers/sh/pm_runtime.c, which will be removed later.
>>> On ARCH_SHMOBILE_MULTI, this was missing, leading to disabled clocks,
>>> depending on implicit reset state or on the bootloader.
>>>
>>> The call to sh_pm_runtime_init() is made from .machine_init(), which is
>>> called from an arch_initcall(), i.e. after the old core_initcall().
>>
>>> diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c
>>> b/arch/arm/mach-shmobile/setup-r8a7791.c
>>> index a7e4966f5e18..03145c804f50 100644
>>> --- a/arch/arm/mach-shmobile/setup-r8a7791.c
>>> +++ b/arch/arm/mach-shmobile/setup-r8a7791.c
>>> @@ -185,6 +185,7 @@ static const struct resource thermal_resources[]
>>> __initconst = {
>>>
>>>   void __init r8a7791_add_dt_devices(void)
>>>   {
>>> +       sh_pm_runtime_init();
>>
>> For koelsch-legacy, this is actually too late: some platform devices
>> (pfc, gpio_rcar) have been registered already.
>
> IIRC the clock code looks for driver bind/unbind?

No, pm_clk_notify() looks for BUS_NOTIFY_ADD_DEVICE, not
BUS_NOTIFY_BIND_DRIVER.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
