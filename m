From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:30 +0000
Subject: [PATCH v2 00/40] Renesas CMT, MTU2 and TMU cleanups
Message-Id: <1393603090-23144-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set cleans up the Renesas CMT, MTU2 and TMU drivers in preparation
for DT support. The CMT patches have already been sent as a "Renesas CMT
(Compare Match Timer) DT bindings" patch series. I've decided to drop the DT
bindings from this set and send patches separately in order to speed up
acceptance of the cleanups.

The first patch is a lone cleanup for the MTU2 driver. More patches are
planned, I've focussed on the CMT and TMU drivers first.

The next 20 patches are a bunch of necessary cleanups that reorganize the
CMT driver, its platform data, and the memory, interrupt and clock resources
it expects. As a result the driver accepts a new platform data model close to
the hardware with supports for all the timer channels using a single device.

The next 10 patches are similar cleanups for the TMU driver, up to the point
where cpumask and ratings need to be touched. I ran into issues with that, I
will fix them and then submit more TMU cleanup patches.

The next 7 patches (32 to 38) move all CMT platforms from the old to the new
platform data model. Patch 39 then drops support for the old model, and patch
40 performs one more cleanup.

The patches are based directly on top of Simon's latest devel branch.

I'd like to get this merged into v3.15. Simon, how would you like to proceed
with the arch/ patches ?

Laurent Pinchart (40):
  clocksource: sh_mtu2: Use request_irq() instead of setup_irq()
  clocksource: sh_cmt: Use request_irq() instead of setup_irq()
  clocksource: sh_cmt: Split channel fields from sh_cmt_priv
  clocksource: sh_cmt: Rename struct sh_cmt_priv to sh_cmt_device
  clocksource: sh_cmt: Split channel setup to separate function
  clocksource: sh_cmt: Constify name argument to sh_cmt_register()
  clocksource: sh_cmt: Rename mapbase/mapbase_str to mapbase_ch/mapbase
  clocksource: sh_cmt: Add memory base to sh_cmt_channel structure
  clocksource: sh_cmt: Add index to struct sh_cmt_channel
  clocksource: sh_cmt: Replace kmalloc + memset with kzalloc
  clocksource: sh_cmt: Allocate channels dynamically
  clocksource: sh_cmt: Split static information from sh_cmt_device
  clocksource: sh_cmt: Replace hardcoded register values with macros
  clocksource: sh_cmt: Set cpumask to cpu_possible_mask
  clocksource: sh_cmt: Hardcode CMT clock event rating to 125
  clocksource: sh_cmt: Hardcode CMT clock source rating to 125
  clocksource: sh_cmt: Add support for multiple channels per device
  clocksource: sh_cmt: Rename clock to "fck" in the non-legacy case
  clocksource: sh_cmt: Remove FSF mail address from GPL notice
  clocksource: sh_cmt: Sort headers alphabetically
  clocksource: sh_cmt: Request IRQ for clock event device only
  clocksource: sh_tmu: Use request_irq() instead of setup_irq()
  clocksource: sh_tmu: Split channel fields from sh_tmu_priv
  clocksource: sh_tmu: Rename struct sh_tmu_priv to sh_tmu_device
  clocksource: sh_tmu: Split channel setup to separate function
  clocksource: sh_tmu: Constify name argument to sh_tmu_register()
  clocksource: sh_tmu: Add memory base to sh_tmu_channel structure
  clocksource: sh_tmu: Add index to struct sh_tmu_channel
  clocksource: sh_tmu: Replace kmalloc + memset with kzalloc
  clocksource: sh_tmu: Allocate channels dynamically
  clocksource: sh_tmu: Replace hardcoded register values with macros
  sh: Switch to new style CMT device
  ARM: shmobile: sh7372: Switch to new style CMT device
  ARM: shmobile: sh73a0: Switch to new style CMT device
  ARM: shmobile: r8a73a4: Switch to new style CMT device
  ARM: shmobile: r8a7740: Switch to new style CMT device
  ARM: shmobile: r8a7790: Switch to new style CMT device
  ARM: shmobile: r8a7791: Switch to new style CMT device
  clocksource: sh_cmt: Drop support for legacy platform data
  clocksource: sh_cmt: Replace global spinlock with a per-device
    spinlock

 arch/arm/mach-shmobile/board-koelsch-reference.c |   2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |   2 +-
 arch/arm/mach-shmobile/clock-r8a73a4.c           |   2 +-
 arch/arm/mach-shmobile/clock-r8a7740.c           |   2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c           |   2 +-
 arch/arm/mach-shmobile/clock-r8a7791.c           |   2 +-
 arch/arm/mach-shmobile/clock-sh7372.c            |   6 +-
 arch/arm/mach-shmobile/clock-sh73a0.c            |   2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  17 +-
 arch/arm/mach-shmobile/setup-r8a7740.c           |  36 +-
 arch/arm/mach-shmobile/setup-r8a7790.c           |  17 +-
 arch/arm/mach-shmobile/setup-r8a7791.c           |  17 +-
 arch/arm/mach-shmobile/setup-sh7372.c            |  20 +-
 arch/arm/mach-shmobile/setup-sh73a0.c            |  36 +-
 arch/sh/kernel/cpu/clock-cpg.c                   |   3 +-
 arch/sh/kernel/cpu/sh2/setup-sh7619.c            |  66 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c           |   2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c           |   2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c           |  66 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c           |  66 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c           |  69 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c           |  66 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c            | 150 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c           |   2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c           |   2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c           |   2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c           |   2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c           |   2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c           |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c           |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c           |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c           |  18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c           |  18 +-
 drivers/clocksource/sh_cmt.c                     | 873 ++++++++++++++---------
 drivers/clocksource/sh_mtu2.c                    |  22 +-
 drivers/clocksource/sh_tmu.c                     | 373 +++++-----
 include/linux/sh_timer.h                         |   1 +
 37 files changed, 920 insertions(+), 1102 deletions(-)

-- 
Regards,

Laurent Pinchart

