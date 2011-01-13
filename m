From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 09:42:44 +0000
Subject: [GIT PULL] sh updates for 2.6.38-rc1, part 2.
Message-Id: <20110113094244.GA20783@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-latest

Which contains:

Arnd Hannemann (4):
      sh: sh7724 Enable SDIO IRQs
      sh: sh7722 Enable SDIO IRQs
      sh: sh7723 / ap325rxa enable SDIO IRQs
      sh: mach-ecovec24: enable runtime PM for SDHI

Magnus Damm (3):
      sh: sh7343 Enable SDIO IRQs
      sh: sh7366 Enable SDIO IRQs
      sh: sh7372 SH4AL-DSP probe support

Nobuhiro Iwamatsu (5):
      sh: pci: Add pci_fixup_pcic to pci of landisk
      sh: Fix IRQ macro in header of landisk
      sh: Move init_landisk_IRQ to header file
      sh: intc - convert board specific landisk code
      sh: Use device_initcall() instead of __initcall()

Paul Mundt (15):
      serial: sh-sci: Move SCSCR_INIT in to platform data.
      serial: sh-sci: Move SCBRR calculation algo in to platform data.
      serial: sh-sci: Kill off unused register accessors.
      serial: sh-sci: Convert from old SCSR control flags to common defines.
      serial: sh-sci: Kill off more unused defines.
      sh: mach-sdk7786: Fix up fallout from clkdev consolidation.
      sh: Kill off deprecated ctrl_in/out I/O routines.
      sh: Add a machvec callback for early memblock reservations.
      sh: constify prefetch pointers.
      sh: Stub out legacy PCC pgprot encoding for X2 TLBs.
      sh: Fix up legacy PTEA space attribute mapping.
      serial: sh-sci: build fixes.
      sh: Add a new mach type for alpha project boards.
      sh: Add support for AP-SH4A-3A board.
      sh: Add support for AP-SH4AD-0A board.

Simon Horman (2):
      mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
      mmc, sh: Remove sh_mmcif_boot_slurp()

Yoshihiro Shimoda (2):
      sh: add PVR probing for SH7757 3rd cut
      sh: update sh7757lcr_defconfig

 arch/arm/mach-shmobile/setup-sh7367.c              |   14 ++
 arch/arm/mach-shmobile/setup-sh7372.c              |   14 ++
 arch/arm/mach-shmobile/setup-sh7377.c              |   16 ++
 arch/arm/mach-shmobile/setup-sh73a0.c              |   18 ++
 arch/sh/boards/Kconfig                             |   18 ++
 arch/sh/boards/Makefile                            |    2 +
 arch/sh/boards/board-apsh4a3a.c                    |  175 ++++++++++++++++++++
 arch/sh/boards/board-apsh4ad0a.c                   |  125 ++++++++++++++
 arch/sh/boards/board-edosk7705.c                   |    2 +-
 arch/sh/boards/board-edosk7760.c                   |    2 +-
 arch/sh/boards/board-sh7785lcr.c                   |    2 +-
 arch/sh/boards/mach-ap325rxa/setup.c               |   16 ++
 arch/sh/boards/mach-cayman/setup.c                 |    2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |    2 +
 arch/sh/boards/mach-kfr2r09/setup.c                |    2 +
 arch/sh/boards/mach-landisk/irq.c                  |   59 ++++---
 arch/sh/boards/mach-landisk/setup.c                |    4 +-
 arch/sh/boards/mach-migor/setup.c                  |    2 +
 arch/sh/boards/mach-r2d/setup.c                    |    2 +-
 arch/sh/boards/mach-sdk7786/setup.c                |    4 +-
 arch/sh/boards/mach-se/7206/setup.c                |    2 +-
 arch/sh/boards/mach-se/7724/setup.c                |    3 +
 arch/sh/boards/mach-se/7751/setup.c                |    2 +-
 arch/sh/boards/mach-sh03/setup.c                   |    2 +-
 arch/sh/boot/romimage/mmcif-sh7724.c               |    7 +-
 arch/sh/configs/apsh4a3a_defconfig                 |  102 ++++++++++++
 arch/sh/configs/apsh4ad0a_defconfig                |  133 +++++++++++++++
 arch/sh/configs/sh7757lcr_defconfig                |   11 +-
 arch/sh/drivers/pci/fixups-landisk.c               |   28 +++-
 arch/sh/include/asm/io.h                           |   61 +------
 arch/sh/include/asm/machvec.h                      |    1 +
 arch/sh/include/asm/pgtable_32.h                   |   15 +-
 arch/sh/include/asm/processor.h                    |    2 +-
 arch/sh/include/asm/processor_32.h                 |    6 +-
 arch/sh/include/mach-landisk/mach/iodata_landisk.h |    6 +-
 arch/sh/kernel/cpu/proc.c                          |    2 +-
 arch/sh/kernel/cpu/sh2/setup-sh7619.c              |    6 +
 arch/sh/kernel/cpu/sh2a/setup-mxg.c                |    2 +
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c             |   16 ++
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |    8 +
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c             |    8 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c              |    5 +
 arch/sh/kernel/cpu/sh3/setup-sh770x.c              |    6 +
 arch/sh/kernel/cpu/sh3/setup-sh7710.c              |    6 +
 arch/sh/kernel/cpu/sh3/setup-sh7720.c              |    6 +-
 arch/sh/kernel/cpu/sh4/probe.c                     |    6 +
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c             |    2 +
 arch/sh/kernel/cpu/sh4/setup-sh7750.c              |   36 +++-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c              |    8 +
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c             |   33 +++--
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c             |   26 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c             |    8 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c             |   16 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c             |   16 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c             |    6 +
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c             |    6 +
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c             |   20 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c             |   12 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c             |   12 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c             |   12 ++
 arch/sh/kernel/cpu/sh4a/setup-shx3.c               |    6 +
 arch/sh/kernel/cpu/sh5/setup-sh5.c                 |    2 +
 arch/sh/mm/init.c                                  |   10 +-
 arch/sh/tools/mach-types                           |    3 +
 drivers/serial/sh-sci.c                            |  102 +++++++++---
 drivers/serial/sh-sci.h                            |  153 -----------------
 include/linux/mmc/sh_mmcif.h                       |   37 ++---
 include/linux/serial_sci.h                         |   22 +++
 68 files changed, 1122 insertions(+), 359 deletions(-)
 create mode 100644 arch/sh/boards/board-apsh4a3a.c
 create mode 100644 arch/sh/boards/board-apsh4ad0a.c
 create mode 100644 arch/sh/configs/apsh4a3a_defconfig
 create mode 100644 arch/sh/configs/apsh4ad0a_defconfig
