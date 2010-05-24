From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 24 May 2010 00:02:22 +0000
Subject: [GIT PULL] [UPDATED] genesis updates for 2.6.35-rc1
Message-Id: <20100524000222.GC19552@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This is a resend of the genesis updates with a few more changes rolled
in. I still have a few more changes on top of this, but they depend on
the second batch of sh updates and can wait until -rc2.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Guennadi Liakhovetski (8):
      fbdev: add a MIPI DSI header
      ARM: mach-shmobile: add LCDC and MIPI DSI-Tx clock definitions to sh7372
      sh: add a YUV422 output data format, that is also supported by LCDC
      sh-mobile: add support for displays, connected over the MIPI bus
      ARM: mach-shmobile: add framebuffer support for ap4evb
      serial: add a new port type, found on some sh-mobile SoCs
      serial: sh-sci: fix handling of SCIFB sh-mobile ports
      ARM: mach-shmobile: SH7372 has 6 SCIFA and 1 SCIFB ports

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

Magnus Damm (19):
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
      ARM: mach-shmobile: sh7367/G3EVM evt2irq() update
      ARM: mach-shmobile: sh7377/G4EVM evt2irq() update
      ARM: mach-shmobile: sh7372/AP4EVB evt2irq() update
      ARM: mach-shmobile: sh7372 clock fixes
      ARM: mach-shmobile: sh7367 clock framework V2
      ARM: mach-shmobile: sh7377 clock framework V2

Paul Mundt (2):
      MAINTAINERS: Add a patchwork entry for ARM/SH-Mobile.
      ARM: mach-shmobile: update defconfigs.

 MAINTAINERS                                   |    3 +-
 arch/arm/configs/ap4evb_defconfig             |   71 +++-
 arch/arm/configs/g3evm_defconfig              |   73 +++-
 arch/arm/configs/g4evm_defconfig              |   72 +++-
 arch/arm/mach-shmobile/Kconfig                |   13 +
 arch/arm/mach-shmobile/Makefile               |    6 +-
 arch/arm/mach-shmobile/board-ap4evb.c         |  248 ++++++++++++-
 arch/arm/mach-shmobile/board-g3evm.c          |   56 +++-
 arch/arm/mach-shmobile/board-g4evm.c          |  151 +++++++-
 arch/arm/mach-shmobile/clock-sh7367.c         |  357 +++++++++++++++---
 arch/arm/mach-shmobile/clock-sh7372.c         |  395 +++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7377.c         |  369 ++++++++++++++++++
 arch/arm/mach-shmobile/clock.c                |   44 +++
 arch/arm/mach-shmobile/include/mach/common.h  |   10 +
 arch/arm/mach-shmobile/include/mach/irqs.h    |    6 +
 arch/arm/mach-shmobile/include/mach/memory.h  |    3 +
 arch/arm/mach-shmobile/include/mach/vmalloc.h |    3 +-
 arch/arm/mach-shmobile/intc-sh7367.c          |  178 +++++++++-
 arch/arm/mach-shmobile/intc-sh7372.c          |  232 +++++++++++-
 arch/arm/mach-shmobile/intc-sh7377.c          |  300 +++++++++++++++-
 arch/arm/mach-shmobile/setup-sh7367.c         |   30 ++-
 arch/arm/mach-shmobile/setup-sh7372.c         |   98 ++++--
 arch/arm/mach-shmobile/setup-sh7377.c         |   34 ++-
 drivers/dma/Kconfig                           |    2 +-
 drivers/dma/shdma.c                           |    8 +-
 drivers/i2c/busses/Kconfig                    |    2 +-
 drivers/i2c/busses/i2c-sh_mobile.c            |  121 ++++--
 drivers/serial/sh-sci.c                       |   42 ++-
 drivers/serial/sh-sci.h                       |   29 ++-
 drivers/sh/Makefile                           |    5 +-
 drivers/video/Kconfig                         |    8 +
 drivers/video/Makefile                        |    1 +
 drivers/video/sh_mipi_dsi.c                   |  505 +++++++++++++++++++++++++
 include/linux/serial_core.h                   |    3 +
 include/linux/serial_sci.h                    |    2 +-
 include/video/mipi_display.h                  |  130 +++++++
 include/video/sh_mipi_dsi.h                   |   35 ++
 include/video/sh_mobile_lcdc.h                |   39 +-
 38 files changed, 3435 insertions(+), 249 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/clock-sh7372.c
 create mode 100644 arch/arm/mach-shmobile/clock-sh7377.c
 create mode 100644 arch/arm/mach-shmobile/clock.c
 create mode 100644 drivers/video/sh_mipi_dsi.c
 create mode 100644 include/video/mipi_display.h
 create mode 100644 include/video/sh_mipi_dsi.h
