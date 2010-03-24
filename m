From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Mar 2010 02:38:35 +0000
Subject: [GIT PULL] sh updates for 2.6.34-rc3
Message-Id: <20100324023834.GA10729@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.34

Which contains:

Andreas Bombe (1):
      sh64: Remove long unused mid_sched macro

Guennadi Liakhovetski (2):
      SH: fix SCIFA SCASCR register bit definitions
      SH: remove superfluous warning from the serial driver

Kuninori Morimoto (3):
      sh: mach-ecovec24: Add i2c_put_adapter on sh_eth_init
      sh: ms7724: Add tiny-document for sound
      sh: Add watch-dog register address for SH7722/SH7723/SH7724

Magnus Damm (1):
      serial: sh-sci: fix SH-Mobile SH breakage

Matt Fleming (3):
      sh: Flush ITLB too in PTEAEX's flush_tlb_page()
      sh: Replace unsafe manipulation of MMUCR
      sh: Fix build after dynamic PMB rework

Paul Mundt (2):
      sh: Tidy up a couple of section mismatches.
      sh: Silence unintialized variable warnings in dwarf unwinder.

 arch/sh/boards/mach-ecovec24/setup.c      |    2 +
 arch/sh/boards/mach-se/7724/setup.c       |    8 ++++++
 arch/sh/include/cpu-sh4/cpu/mmu_context.h |    2 +
 arch/sh/include/cpu-sh4/cpu/watchdog.h    |    6 +++++
 arch/sh/kernel/dwarf.c                    |    4 +-
 arch/sh/kernel/idle.c                     |    2 +-
 arch/sh/kernel/perf_event.c               |    2 +-
 arch/sh/kernel/process_64.c               |    7 -----
 arch/sh/mm/pmb.c                          |    4 ++-
 arch/sh/mm/tlb-pteaex.c                   |    2 +
 arch/sh/mm/tlbflush_32.c                  |   21 ++++++++++++-----
 drivers/serial/sh-sci.c                   |    4 ---
 drivers/serial/sh-sci.h                   |   35 ++++++++++++++++++++++------
 13 files changed, 69 insertions(+), 30 deletions(-)
