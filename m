From: Rich Felker <dalias@libc.org>
Date: Thu, 28 Apr 2016 21:47:41 +0000
Subject: [PATCH 0/7] J-core J2 cpu and SoC peripherals support
Message-Id: <cover.1461880061.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The following patchset adds support for the J-core J2, an open-source
VHDL reimplementation of the SH-2 ISA, and drivers for the associated
SoC devices (interrupt controller, clocksource, and SPI).

This version is posted for review, discussion, and testing. Before
merge it needs at least official assignment (and documentation) of
device tree bindings. Feedback on other improvements that could be
made is welcome too, especially if there are places where the
motivation is not clear and better commit messages or comments could
clarify.

Rich Felker (7):
  sh: add support for J-Core J2 processor
  sh: add AT_HWCAP flag for J-Core cas.l instruction
  irqchip: add J-Core AIC driver
  clocksource: add J-Core PIT/RTC driver
  spi: add driver for J-Core SPI controller
  sh: add defconfig for J-Core J2
  sh: add device tree source for J2 FPGA on Mimas v2 board

 arch/sh/Kconfig                         |   8 +
 arch/sh/Makefile                        |   1 +
 arch/sh/boot/dts/j2_mimas_v2.dts        |  98 ++++++++++++
 arch/sh/configs/j2_defconfig            |  38 +++++
 arch/sh/include/asm/processor.h         |   2 +-
 arch/sh/include/uapi/asm/cpu-features.h |   1 +
 arch/sh/kernel/cpu/init.c               |  40 ++++-
 arch/sh/kernel/cpu/proc.c               |   1 +
 arch/sh/kernel/cpu/sh2/entry.S          |   5 +
 arch/sh/kernel/cpu/sh2/probe.c          |  13 ++
 arch/sh/mm/Makefile                     |   3 +-
 arch/sh/mm/cache-j2.c                   |  58 +++++++
 arch/sh/mm/cache.c                      |   6 +-
 drivers/clocksource/Kconfig             |   4 +
 drivers/clocksource/Makefile            |   2 +
 drivers/clocksource/jcore-pit.c         | 176 +++++++++++++++++++++
 drivers/irqchip/Kconfig                 |   6 +
 drivers/irqchip/Makefile                |   1 +
 drivers/irqchip/irq-jcore-aic.c         |  95 ++++++++++++
 drivers/spi/Kconfig                     |   4 +
 drivers/spi/Makefile                    |   1 +
 drivers/spi/spi-jcore.c                 | 266 ++++++++++++++++++++++++++++++++
 22 files changed, 825 insertions(+), 4 deletions(-)
 create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts
 create mode 100644 arch/sh/configs/j2_defconfig
 create mode 100644 arch/sh/mm/cache-j2.c
 create mode 100644 drivers/clocksource/jcore-pit.c
 create mode 100644 drivers/irqchip/irq-jcore-aic.c
 create mode 100644 drivers/spi/spi-jcore.c

-- 
2.8.1

