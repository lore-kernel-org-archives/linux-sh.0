From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 04 Mar 2010 17:11:35 +0000
Subject: [GIT PULL] sh updates for 2.6.34-rc1, part 2.
Message-Id: <20100304171134.GB26618@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Andrea Gelmini (2):
      arch/sh/lib/libgcc.h: Checkpatch cleanup
      arch/sh/boot/compressed/cache.c: Checkpatch cleanup

Guennadi Liakhovetski (10):
      sh: add DMA slave definitions and SIU platform data to sh7722 setup
      sh: audio support for the sh7722 Migo-R board
      dmaengine: shdma: fix DMA error handling.
      dmaengine: shdma: convert to platform device resources
      dmaengine: shdma: separate DMA headers.
      dmaengine: shdma: add runtime PM support.
      sh: activate runtime PM for dmaengine on sh7722 and sh7724
      sh: merge sh7722 and sh7724 DMA register definitions
      dmaengine: shdma: extend .device_terminate_all() to record partial transfer
      serial: sh-sci: Add DMA support.

John Stultz (1):
      sh: Convert sh to use read/update_persistent_clock

Paul Mundt (11):
      sh: hw-breakpoints: Accept breakpoints on NULL addresses.
      sh: Fix up ctrl_read/write stragglers in migor setup.
      serial: sh-sci: Tidy up build warnings.
      sh: Fix up cpumask_of_pcibus() for the NUMA build.
      sh: reworked dynamic PMB mapping.
      sh: make pmb iomapping configurable.
      sh: fixed virt/phys mapping helpers for PMB.
      sh: check for existing mappings for bolted PMB entries.
      sh: establish PMB mappings for NUMA nodes.
      sh: fix up MMU reset with variable PMB mapping sizes.
      sh: Fix up flush_cache_vmap() on SMP.

Pawel Moll (1):
      sh: Move PMB debugfs entry initialization to later stage

Robert P. J. Day (1):
      sh: No need to explicitly include <linux/rwlock.h>.

 arch/sh/boards/mach-migor/setup.c          |   16 +
 arch/sh/boot/compressed/cache.c            |    2 +-
 arch/sh/include/asm/cacheflush.h           |    4 +-
 arch/sh/include/asm/dma-register.h         |   51 +++
 arch/sh/include/asm/dma-sh.h               |   88 +----
 arch/sh/include/asm/dmaengine.h            |   93 +++++
 arch/sh/include/asm/io.h                   |   23 +-
 arch/sh/include/asm/mmu.h                  |   31 ++-
 arch/sh/include/asm/siu.h                  |    2 +-
 arch/sh/include/asm/topology.h             |    2 +-
 arch/sh/include/cpu-sh3/cpu/dma-register.h |   41 ++
 arch/sh/include/cpu-sh3/cpu/dma.h          |   27 --
 arch/sh/include/cpu-sh4/cpu/dma-register.h |  112 +++++
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h     |   62 ---
 arch/sh/include/cpu-sh4/cpu/dma.h          |   36 +--
 arch/sh/include/mach-migor/mach/migor.h    |    1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c     |  190 ++++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c     |  186 ++++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c     |  134 ++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c     |  134 ++++++-
 arch/sh/kernel/hw_breakpoint.c             |   30 +--
 arch/sh/kernel/setup.c                     |    3 +-
 arch/sh/kernel/time.c                      |    6 +-
 arch/sh/lib/libgcc.h                       |    3 +-
 arch/sh/mm/ioremap.c                       |   70 +---
 arch/sh/mm/ioremap_fixed.c                 |   11 +-
 arch/sh/mm/numa.c                          |    3 +
 arch/sh/mm/pmb.c                           |  412 +++++++++++++------
 drivers/dma/shdma.c                        |  500 ++++++++++++++---------
 drivers/dma/shdma.h                        |   26 +-
 drivers/serial/Kconfig                     |    4 +
 drivers/serial/sh-sci.c                    |  616 +++++++++++++++++++++++++--
 include/linux/serial_sci.h                 |    6 +
 sound/soc/sh/siu.h                         |    2 +-
 sound/soc/sh/siu_pcm.c                     |    2 +-
 35 files changed, 2201 insertions(+), 728 deletions(-)
 create mode 100644 arch/sh/include/asm/dma-register.h
 create mode 100644 arch/sh/include/asm/dmaengine.h
 create mode 100644 arch/sh/include/cpu-sh3/cpu/dma-register.h
 create mode 100644 arch/sh/include/cpu-sh4/cpu/dma-register.h
