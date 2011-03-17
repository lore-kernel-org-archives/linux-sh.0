From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Mar 2011 08:43:40 +0000
Subject: [GIT PULL] sh updates for 2.6.39-rc1
Message-Id: <20110317084340.GA14122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-latest

Which contains:

Alexandre Courbot (1):
      serial: sh-sci: fix deadlock when resuming from S3 sleep

Chris Smith (1):
      sh: Enable CONFIG_GCOV_PROFILE_ALL for sh

Paul Mundt (22):
      watchdog: shwdt: Kill off mmap stub and superfluous comments.
      watchdog: shwdt: driver model conversion.
      sh: pci: Support asynchronous initialization of SH-X3 PCIe channels.
      serial: sh-sci: Kill off unused clock string.
      serial: sh-sci: Kill off unused membase kludge.
      serial: sh-sci: Provide a helper for muxed IRQs.
      serial: sh-sci: Consolidate port definition structures.
      serial: sh-sci: Kill off some DMA ifdeffery.
      serial: sh-sci: Require a device per port mapping.
      serial: sh-sci: Handle request_irq() failures.
      serial: sh-sci: Kill off unused SCSCR definitions.
      serial: sh-sci: Fix up ioremap handling.
      serial: sh-sci: Handle port memory region reservations.
      serial: sh-sci: Bring oversized error handlers out of line.
      serial: sh-sci: Fix up break timer scheduling race.
      serial: sh-sci: Limit early console to one device.
      serial: sh-sci: Fix up earlyprintk port mapping.
      serial: sh-sci: Use dev_name() for region reservations.
      serial: sh-sci: Kill off the special earlyprintk device.
      sh: Fix up async PCIe probing on SMP.
      sh: Wire up new fhandle and clock_adjtime syscalls.
      sh: Convert to generic show_interrupts.

Thomas Renninger (1):
      sh: Rename cpuidle states to fit general conventions

Yoshihiro Shimoda (9):
      sh: add USB_ARCH_HAS_EHCI and OHCI for SH7757
      sh: add platform_device for SPI
      sh: add spi_board_info in sh7757lcr
      sh: add mmc clock in clock-sh7757
      sh: dmaengine support for SH7757
      sh: add platform_device of tmio_mmc and sh_mmcif to sh7757lcr
      sh: update sh7757lcr_defconfig
      sh: add GETHER's platform_device in board-sh7757lcr
      sh: modify platform_device for sh_eth driver

 arch/sh/Kconfig                            |    3 +
 arch/sh/boards/board-espt.c                |    7 +
 arch/sh/boards/board-sh7757lcr.c           |  185 ++++++++++
 arch/sh/boards/mach-ecovec24/setup.c       |    2 +
 arch/sh/boards/mach-sh7763rdp/setup.c      |    6 +
 arch/sh/boot/compressed/Makefile           |    2 +
 arch/sh/configs/sh7757lcr_defconfig        |   19 +-
 arch/sh/drivers/pci/pcie-sh7786.c          |   46 ++-
 arch/sh/include/asm/unistd_32.h            |    5 +-
 arch/sh/include/asm/unistd_64.h            |    5 +-
 arch/sh/include/cpu-sh4/cpu/dma-register.h |    5 +
 arch/sh/include/cpu-sh4/cpu/sh7757.h       |   32 ++
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c     |    7 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c     |  542 +++++++++++++++++++++++++++-
 arch/sh/kernel/cpu/shmobile/cpuidle.c      |    6 +-
 arch/sh/kernel/irq.c                       |   61 +---
 arch/sh/kernel/syscalls_32.S               |    3 +
 arch/sh/kernel/syscalls_64.S               |    3 +
 arch/sh/mm/Makefile                        |    2 +
 drivers/tty/serial/sh-sci.c                |  431 +++++++++++-----------
 drivers/tty/serial/sh-sci.h                |   39 --
 drivers/watchdog/Kconfig                   |    8 -
 drivers/watchdog/shwdt.c                   |  365 +++++++++----------
 include/linux/serial_sci.h                 |   16 +-
 kernel/gcov/Kconfig                        |    2 +-
 25 files changed, 1250 insertions(+), 552 deletions(-)
