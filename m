From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 May 2010 06:51:33 +0000
Subject: [GIT PULL] genesis updates for 2.6.35-rc1
Message-Id: <20100520065132.GA13004@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Kuninori Morimoto (10):
      ARM: mach-shmobile: sh7372: Add I2C0, I2C1 support
      ARM: mach-shmobile: ap4evb: Add TouchScreen support
      ARM: mach-shmobile: ap4evb: Add SW43, SW3 tiny document
      ARM: mach-shmobile: ap4evb: Add R2025S RTC support
      ARM: mach-shmobile: intc-sh7377: Add INTCS support
      ARM: mach-shmobile: Add missing __initdata on intcs sh7367/sh7377
      ARM: mach-shmobile: Add SDHI support
      ARM: mach-shmobile: intc-sh7372: modify wrong address
      ARM: mach-shmobile: ap4evb: Add USB host support
      ARM: mach-shmobile: g3evm: Add IrDA support

Magnus Damm (13):
      dmaengine: shdma: Enable on SH-Mobile ARM
      i2c: i2c-sh_mobile register access code break out
      i2c: i2c-sh_mobile support for new ICIC bits
      i2c: i2c-sh_mobile kconfig update for SH-Mobile ARM
      ARM: mach-shmobile: add INTCS macros
      ARM: mach-shmobile: sh7367 INTCS support
      ARM: mach-shmobile: Use 0x2200 as INTCS_VECT_BASE
      ARM: mach-shmobile: sh7372 INTCS support
      ARM: mach-shmobile: Enable TMU driver build
      ARM: mach-shmobile: Use shared clock framework
      ARM: mach-shmobile: sh7372 clock framework support V2
      ARM: mach-shmobile: Set CONSISTENT_DMA_SIZE to 158 MB
      ARM: mach-shmobile: Update VMALLOC_END

Paul Mundt (2):
      MAINTAINERS: Add a patchwork entry for ARM/SH-Mobile.
      ARM: mach-shmobile: update defconfigs.

 MAINTAINERS                                   |    3 +-
 arch/arm/configs/ap4evb_defconfig             |   71 ++++-
 arch/arm/configs/g3evm_defconfig              |   73 ++++-
 arch/arm/configs/g4evm_defconfig              |   72 ++++-
 arch/arm/mach-shmobile/Kconfig                |   10 +
 arch/arm/mach-shmobile/Makefile               |    4 +-
 arch/arm/mach-shmobile/board-ap4evb.c         |  122 ++++++++-
 arch/arm/mach-shmobile/board-g3evm.c          |   33 ++
 arch/arm/mach-shmobile/board-g4evm.c          |  127 ++++++++
 arch/arm/mach-shmobile/clock-sh7367.c         |   36 +---
 arch/arm/mach-shmobile/clock-sh7372.c         |  387 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock.c                |   44 +++
 arch/arm/mach-shmobile/include/mach/common.h  |    3 +
 arch/arm/mach-shmobile/include/mach/irqs.h    |    6 +
 arch/arm/mach-shmobile/include/mach/memory.h  |    3 +
 arch/arm/mach-shmobile/include/mach/vmalloc.h |    3 +-
 arch/arm/mach-shmobile/intc-sh7367.c          |  178 +++++++++++-
 arch/arm/mach-shmobile/intc-sh7372.c          |  232 ++++++++++++++-
 arch/arm/mach-shmobile/intc-sh7377.c          |  300 +++++++++++++++++++-
 arch/arm/mach-shmobile/setup-sh7372.c         |   55 +++-
 drivers/dma/Kconfig                           |    2 +-
 drivers/dma/shdma.c                           |    8 +-
 drivers/i2c/busses/Kconfig                    |    2 +-
 drivers/i2c/busses/i2c-sh_mobile.c            |  121 ++++++---
 drivers/sh/Makefile                           |    5 +-
 include/linux/serial_sci.h                    |    2 +-
 26 files changed, 1754 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/clock-sh7372.c
 create mode 100644 arch/arm/mach-shmobile/clock.c
