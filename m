From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 12 May 2012 21:07:20 +0000
Subject: [GIT PULL] Renesas ARM-based platforms: core SoC updates for v3.5
Message-Id: <201205122307.20590.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit c8241085e8606a14ef48e6d99556133c48aaddaf

    ARM: mach-shmobile: clock-r8a7740: use followparent_recalc on usb24s

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc-core

to receive updates of the Renesas ARM-based platforms core code for v3.5.
Included are:

 * Shared delay calibration code update from Magnus Damm.

 * The addition of FSI DMAEngine support for the sh7372 SoC from Kuninori Morimoto.

 * Muliple updates of the r8a7740 SoC support code from Kuninori Morimoto.

This is based on the Renesas DT updates that have been merged into arm-soc already
and on the urgent fixes I've sent a separate pull request for.

Thanks!


 arch/arm/boot/dts/sh7372.dtsi                |   21 +++++
 arch/arm/mach-shmobile/board-ag5evm.c        |   22 +----
 arch/arm/mach-shmobile/board-mackerel.c      |   22 +----
 arch/arm/mach-shmobile/clock-r8a7740.c       |  125 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/headsmp.S             |   56 +++++++++++-
 arch/arm/mach-shmobile/include/mach/common.h |    4 +-
 arch/arm/mach-shmobile/include/mach/intc.h   |   44 +++++++++
 arch/arm/mach-shmobile/include/mach/irqs.h   |    2 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 +
 arch/arm/mach-shmobile/intc-sh7372.c         |   34 +++++---
 arch/arm/mach-shmobile/pfc-r8a7740.c         |   39 ++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c       |   12 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c       |    4 +
 arch/arm/mach-shmobile/setup-sh7372.c        |   58 ++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c        |    4 +
 arch/arm/mach-shmobile/smp-r8a7779.c         |    8 ++-
 arch/arm/mach-shmobile/smp-sh73a0.c          |    7 ++-
 arch/arm/mach-shmobile/timer.c               |   27 ++++--
 18 files changed, 417 insertions(+), 74 deletions(-)

---------------

Guennadi Liakhovetski (2):
      ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
      ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper

Kuninori Morimoto (9):
      ARM / mach-shmobile: sh73a0 SMP TWD boot regression fix
      ARM: mach-shmobile: sh7372: Add FSI DMAEngine support
      ARM: mach-shmobile: r8a7740: add gpio_irq support
      ARM: mach-shmobile: r8a7740: cleanup I2C workaround method
      ARM: mach-shmobile: clock-r8a7740: add FSI clock
      ARM: mach-shmobile: clock-r8a7740: add USB clock
      ARM: mach-shmobile: clock-r8a7740: add SDHI clock
      ARM: mach-shmobile: clock-r8a7740: add MMCIF clock
      ARM: mach-shmobile: clock-r8a7740: use followparent_recalc on usb24s

Magnus Damm (9):
      ARM: mach-shmobile: Introduce shmobile_setup_delay()
      ARM: mach-shmobile: Introduce INTC_IRQ_PINS_16H
      ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
      ARM: mach-shmobile: Use INTC_IRQ_PINS_16H on sh7372
      ARM: mach-shmobile: Rework sh7372 INTCS demuxer V2
      ARM: mach-shmobile: sh7372 generic board support via DT V2
      ARM / mach-shmobile: r8a7779 SMP TWD boot regression fix
      ARM / mach-shmobile: Invalidate caches when booting secondary cores
      ARM / mach-shmobile: Use preset_lpj with calibrate_delay()

