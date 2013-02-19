From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 19 Feb 2013 15:05:16 +0000
Subject: Re: [PATCH] ARM: shmobile: Armadillo800EVA-reference: Remove usage of shmobile_timer
Message-Id: <CABYn4sxCL+Gf2kixbSeeE8f5Y2R5jFEeic4BTMwvuvKhpfZVeA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1361223490-20106-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361223490-20106-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

2013/2/18 Simon Horman <horms@verge.net.au>:
> On Mon, Feb 18, 2013 at 03:38:10PM -0600, Bastian Hecht wrote:
>> The struct sys_timer is gone since the patch "ARM: delete struct
>> sys_timer". Since then we can't use shmobile_timer any longer. Setting
>> .init_time directly to eva_earlytimer_init fixes the resulting compile
>> error and makes the code shorter as well.
>
> Hi Bastian,
>
> Magnus seems to be very keen on the idea that -reference code
> shouldn't use early timer or early devices if possible.
>
> Is it possible to re-work this patch so that armadillo800eva-reference
> doesn't use early timer?

Hmm I wonder if this is just a naming convention here. If I rename
eva_earlytimer_init() to eva_timer_init() the only thing that might
disturb us is that we call shmobile_EARLYtimer_init() inside it. But
this function only sets a callback named LATE_time_init. So we don't
break any timings.

So are you ok if I rename eva_earlytimer_init() to eva_timer_init()?

Thanks,

 Bastian


>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>>  .../board-armadillo800eva-reference.c              |   12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
>> index 623754d..ae20979 100644
>> --- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
>> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
>> @@ -219,14 +219,6 @@ static void __init eva_earlytimer_init(void)
>>       eva_clock_init();
>>  }
>>
>> -static void __init eva_add_early_devices(void)
>> -{
>> -     r8a7740_add_early_devices_dt();
>> -
>> -     /* override timer setup with board-specific code */
>> -     shmobile_timer.init = eva_earlytimer_init;
>> -}
>> -
>>  #define RESCNT2 IOMEM(0xe6188020)
>>  static void eva_restart(char mode, const char *cmd)
>>  {
>> @@ -241,13 +233,13 @@ static const char *eva_boards_compat_dt[] __initdata = {
>>
>>  DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
>>       .map_io         = r8a7740_map_io,
>> -     .init_early     = eva_add_early_devices,
>> +     .init_early     = r8a7740_add_early_devices_dt,
>>       .init_irq       = r8a7740_init_irq_of,
>>       .nr_irqs        = NR_IRQS_LEGACY,
>>       .handle_irq     = shmobile_handle_irq_intc,
>>       .init_machine   = eva_init,
>>       .init_late      = shmobile_init_late,
>> -     .init_time      = shmobile_timer_init,
>> +     .init_time      = eva_earlytimer_init,
>>       .dt_compat      = eva_boards_compat_dt,
>>       .restart        = eva_restart,
>>  MACHINE_END
>> --
>> 1.7.9.5
>>
