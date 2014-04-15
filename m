From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 15 Apr 2014 14:59:32 +0000
Subject: Re: [PATCH v3 00/52] Renesas CMT and TMU cleanups
Message-Id: <534D4954.9080102@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1397228675-11684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1397228675-11684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 04/11/2014 05:13 PM, Laurent Pinchart wrote:
> On Friday 11 April 2014 17:03:43 Laurent Pinchart wrote:
>> Hello,
>>
>> This patch set cleans up the Renesas CMT and TMU drivers in preparation =
for
>> DT support. All patches except 31/52 to 35/52, 43/52 to 48/52 and 51/52 =
to
>> 52/52 have already been posted as part of the "[PATCH v2 00/40] Renesas
>> CMT, MTU2 and TMU cleanups" series.
>>
>> I've decided to drop the MTU2 patch for now, I'll resend it as part of a
>> larger MTU2 cleanup series.
>
> Which I've forgotten I had already posted as "[PATCH 00/22] SH MTU2 DT
> support" and received a Tested-by for.
>
> I can send a single combined pull request for the driver patches from both
> series (01/22 to 17/22 for MTU2 and 01/52 to 35/52 for CMT/TMU) rebased
> directly on top of v3.15-rc1 when it will be released. Daniel, Thomas, wo=
uld
> that help, or would you prefer to pick the patches up yourself ?

Please send me the patches rebased on top of v3.15-rc1. I will apply=20
them on a branch where Simon can pull from.

Thanks
   -- Daniel


>> The first 35 patches are a bunch of necessary cleanups that reorganize t=
he
>> CMT and TMU drivers, their platform data, and the memory, interrupt and
>> clock resources they expect. As a result the drivers accept a new platfo=
rm
>> data model close to the hardware with supports for all the timer channels
>> using a single device.
>>
>> The next 13 patches (36/52 to 48/52) move all CMT and TMU platforms from=
 the
>> old to the new platform data model. Patches 49/52 to 52/52 then drop
>> support for the old model and perform one more cleanup.
>>
>> The patches are based directly on top of Simon's latest devel branch. Th=
ey
>> have been tested on the Marzen (R8A7779, using TMU), Lager (R8A7790, usi=
ng
>> CMT) and Koelsch (R8A7791, using CMT) boards.
>>
>> I'd like to get this merged into v3.16. Simon, how would you like to pro=
ceed
>> with the arch/ patches ? Daniel, Thomas, would you be able to provide a
>> stable branch directly on top of v3.15-rc1 (when it will be released) wi=
th
>> patches 01/52 to 35/52 ? Simon could then merge it in his tree and apply
>> arch/ patches on top of it.
>>
>> Laurent Pinchart (52):
>>    clocksource: sh_cmt: Use request_irq() instead of setup_irq()
>>    clocksource: sh_cmt: Split channel fields from sh_cmt_priv
>>    clocksource: sh_cmt: Rename struct sh_cmt_priv to sh_cmt_device
>>    clocksource: sh_cmt: Split channel setup to separate function
>>    clocksource: sh_cmt: Constify name argument to sh_cmt_register()
>>    clocksource: sh_cmt: Rename mapbase/mapbase_str to mapbase_ch/mapbase
>>    clocksource: sh_cmt: Add memory base to sh_cmt_channel structure
>>    clocksource: sh_cmt: Add index to struct sh_cmt_channel
>>    clocksource: sh_cmt: Replace kmalloc + memset with kzalloc
>>    clocksource: sh_cmt: Allocate channels dynamically
>>    clocksource: sh_cmt: Split static information from sh_cmt_device
>>    clocksource: sh_cmt: Replace hardcoded register values with macros
>>    clocksource: sh_cmt: Set cpumask to cpu_possible_mask
>>    clocksource: sh_cmt: Hardcode CMT clock event rating to 125
>>    clocksource: sh_cmt: Hardcode CMT clock source rating to 125
>>    clocksource: sh_cmt: Add support for multiple channels per device
>>    clocksource: sh_cmt: Rename clock to "fck" in the non-legacy case
>>    clocksource: sh_cmt: Remove FSF mail address from GPL notice
>>    clocksource: sh_cmt: Sort headers alphabetically
>>    clocksource: sh_cmt: Request IRQ for clock event device only
>>    clocksource: sh_tmu: Use request_irq() instead of setup_irq()
>>    clocksource: sh_tmu: Split channel fields from sh_tmu_priv
>>    clocksource: sh_tmu: Rename struct sh_tmu_priv to sh_tmu_device
>>    clocksource: sh_tmu: Split channel setup to separate function
>>    clocksource: sh_tmu: Constify name argument to sh_tmu_register()
>>    clocksource: sh_tmu: Add memory base to sh_tmu_channel structure
>>    clocksource: sh_tmu: Add index to struct sh_tmu_channel
>>    clocksource: sh_tmu: Replace kmalloc + memset with kzalloc
>>    clocksource: sh_tmu: Allocate channels dynamically
>>    clocksource: sh_tmu: Replace hardcoded register values with macros
>>    clocksource: sh_tmu: Hardcode TMU clock event and source ratings to 2=
00
>>    clocksource: sh_tmu: Add support for multiple channels per device
>>    clocksource: sh_tmu: Rename clock to "fck" in the non-legacy case
>>    clocksource: sh_tmu: Remove FSF mail address from GPL notice
>>    clocksource: sh_tmu: Sort headers alphabetically
>>    sh: Switch to new style CMT device
>>    ARM: shmobile: sh7372: Switch to new style CMT device
>>    ARM: shmobile: sh73a0: Switch to new style CMT device
>>    ARM: shmobile: r8a73a4: Switch to new style CMT device
>>    ARM: shmobile: r8a7740: Switch to new style CMT device
>>    ARM: shmobile: r8a7790: Switch to new style CMT device
>>    ARM: shmobile: r8a7791: Switch to new style CMT device
>>    sh: Switch to new style TMU device
>>    ARM: shmobile: sh7372: Switch to new style TMU device
>>    ARM: shmobile: sh73a0: Switch to new style TMU device
>>    ARM: shmobile: r8a7740: Switch to new style TMU device
>>    ARM: shmobile: r8a7778: Switch to new style TMU device
>>    ARM: shmobile: r8a7779: Switch to new style TMU device
>>    clocksource: sh_cmt: Drop support for legacy platform data
>>    clocksource: sh_cmt: Replace global spinlock with a per-device spinlo=
ck
>>    clocksource: sh_tmu: Drop support for legacy platform data
>>    clocksource: sh_tmu: Replace global spinlock with a per-device spinlo=
ck
>>
>>   arch/arm/mach-shmobile/board-koelsch-reference.c |   2 +-
>>   arch/arm/mach-shmobile/board-lager-reference.c   |   2 +-
>>   arch/arm/mach-shmobile/clock-r8a73a4.c           |   2 +-
>>   arch/arm/mach-shmobile/clock-r8a7740.c           |  10 +-
>>   arch/arm/mach-shmobile/clock-r8a7778.c           |   4 +-
>>   arch/arm/mach-shmobile/clock-r8a7779.c           |   4 +-
>>   arch/arm/mach-shmobile/clock-r8a7790.c           |   2 +-
>>   arch/arm/mach-shmobile/clock-r8a7791.c           |   2 +-
>>   arch/arm/mach-shmobile/clock-sh7372.c            |   9 +-
>>   arch/arm/mach-shmobile/clock-sh73a0.c            |   5 +-
>>   arch/arm/mach-shmobile/setup-r8a73a4.c           |  17 +-
>>   arch/arm/mach-shmobile/setup-r8a7740.c           | 133 +---
>>   arch/arm/mach-shmobile/setup-r8a7778.c           |  30 +-
>>   arch/arm/mach-shmobile/setup-r8a7779.c           |  66 +-
>>   arch/arm/mach-shmobile/setup-r8a7790.c           |  17 +-
>>   arch/arm/mach-shmobile/setup-r8a7791.c           |  17 +-
>>   arch/arm/mach-shmobile/setup-sh7372.c            |  89 +--
>>   arch/arm/mach-shmobile/setup-sh73a0.c            |  92 +--
>>   arch/sh/kernel/cpu/clock-cpg.c                   |   8 +-
>>   arch/sh/kernel/cpu/sh2/setup-sh7619.c            |  66 +-
>>   arch/sh/kernel/cpu/sh2a/clock-sh7264.c           |   2 +-
>>   arch/sh/kernel/cpu/sh2a/clock-sh7269.c           |   2 +-
>>   arch/sh/kernel/cpu/sh2a/setup-sh7203.c           |  66 +-
>>   arch/sh/kernel/cpu/sh2a/setup-sh7206.c           |  66 +-
>>   arch/sh/kernel/cpu/sh2a/setup-sh7264.c           |  69 +-
>>   arch/sh/kernel/cpu/sh2a/setup-sh7269.c           |  66 +-
>>   arch/sh/kernel/cpu/sh3/setup-sh7705.c            |  78 +-
>>   arch/sh/kernel/cpu/sh3/setup-sh770x.c            |  78 +-
>>   arch/sh/kernel/cpu/sh3/setup-sh7710.c            |  78 +-
>>   arch/sh/kernel/cpu/sh3/setup-sh7720.c            | 228 +-----
>>   arch/sh/kernel/cpu/sh4/setup-sh4-202.c           |  78 +-
>>   arch/sh/kernel/cpu/sh4/setup-sh7750.c            | 138 +---
>>   arch/sh/kernel/cpu/sh4/setup-sh7760.c            |  78 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7343.c           |   2 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7366.c           |   2 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7722.c           |   6 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7723.c           |  10 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7724.c           |  10 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7734.c           |  12 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7757.c           |   4 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7785.c           |   8 +-
>>   arch/sh/kernel/cpu/sh4a/clock-sh7786.c           |  16 +-
>>   arch/sh/kernel/cpu/sh4a/clock-shx3.c             |   8 +-
>>   arch/sh/kernel/cpu/sh4a/setup-sh7343.c           |  96 +--
>>   arch/sh/kernel/cpu/sh4a/setup-sh7366.c           |  96 +--
>>   arch/sh/kernel/cpu/sh4a/setup-sh7722.c           |  96 +--
>>   arch/sh/kernel/cpu/sh4a/setup-sh7723.c           | 172 +----
>>   arch/sh/kernel/cpu/sh4a/setup-sh7724.c           | 173 +----
>>   arch/sh/kernel/cpu/sh4a/setup-sh7734.c           | 235 +-----
>>   arch/sh/kernel/cpu/sh4a/setup-sh7757.c           |  48 +-
>>   arch/sh/kernel/cpu/sh4a/setup-sh7763.c           | 154 +---
>>   arch/sh/kernel/cpu/sh4a/setup-sh7770.c           | 230 +-----
>>   arch/sh/kernel/cpu/sh4a/setup-sh7780.c           | 154 +---
>>   arch/sh/kernel/cpu/sh4a/setup-sh7785.c           | 154 +---
>>   arch/sh/kernel/cpu/sh4a/setup-sh7786.c           | 299 +-------
>>   arch/sh/kernel/cpu/sh4a/setup-shx3.c             | 150 +---
>>   arch/sh/kernel/cpu/sh5/setup-sh5.c               |  79 +-
>>   drivers/clocksource/sh_cmt.c                     | 879 ++++++++++++---=
-----
>>   drivers/clocksource/sh_tmu.c                     | 499 +++++++------
>>   include/linux/sh_timer.h                         |   1 +
>>   60 files changed, 1308 insertions(+), 3889 deletions(-)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

