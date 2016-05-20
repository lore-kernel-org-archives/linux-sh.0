From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 02:53:03 +0000
Subject: [PATCH v2 00/12] J-core J2 cpu and SoC peripherals support
Message-Id: <cover.1463708766.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

The following patchset adds support for the J-core J2, an open-source
VHDL reimplementation of the SH-2 ISA, and drivers for the associated
SoC devices (interrupt controller, clocksource, and SPI).

As arch/sh co-maintainer my intent is to have this merged for 4.7, but
I realized my previous post of the patch series omitted device tree
bindings and omitted Cc'ing of subsystem maintainers for the necessary
clocksource, irqchip, and spi drivers.

Rich Felker (12):
  of: add vendor prefix for J-Core
  of: add J-Core cpu bindings
  of: add J-Core interrupt controller bindings
  of: add J-Core timer bindings
  of: add J-Core SPI master bindings
  sh: add support for J-Core J2 processor
  sh: add AT_HWCAP flag for J-Core cas.l instruction
  irqchip: add J-Core AIC driver
  clocksource: add J-Core PIT/RTC driver
  spi: add driver for J-Core SPI controller
  sh: add defconfig for J-Core J2
  sh: add device tree source for J2 FPGA on Mimas v2 board

 .../bindings/interrupt-controller/jcore,aic.txt    |  28 +++
 Documentation/devicetree/bindings/jcore/cpus.txt   |  91 +++++++
 .../devicetree/bindings/spi/jcore,spi.txt          |  23 ++
 .../devicetree/bindings/timer/jcore,pit.txt        |  28 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/sh/Kconfig                                    |   8 +
 arch/sh/Makefile                                   |   1 +
 arch/sh/boot/dts/j2_mimas_v2.dts                   |  87 +++++++
 arch/sh/configs/j2_defconfig                       |  38 +++
 arch/sh/include/asm/processor.h                    |   2 +-
 arch/sh/include/uapi/asm/cpu-features.h            |   1 +
 arch/sh/kernel/cpu/init.c                          |   2 +-
 arch/sh/kernel/cpu/proc.c                          |   1 +
 arch/sh/kernel/cpu/sh2/entry.S                     |   5 +
 arch/sh/kernel/cpu/sh2/probe.c                     |  36 ++-
 arch/sh/mm/Makefile                                |   3 +-
 arch/sh/mm/cache-j2.c                              |  58 +++++
 arch/sh/mm/cache.c                                 |   6 +-
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/jcore-pit.c                    | 176 ++++++++++++++
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-jcore-aic.c                    |  95 ++++++++
 drivers/spi/Kconfig                                |   4 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-jcore.c                            | 266 +++++++++++++++++++++
 27 files changed, 973 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
 create mode 100644 Documentation/devicetree/bindings/jcore/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
 create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts
 create mode 100644 arch/sh/configs/j2_defconfig
 create mode 100644 arch/sh/mm/cache-j2.c
 create mode 100644 drivers/clocksource/jcore-pit.c
 create mode 100644 drivers/irqchip/irq-jcore-aic.c
 create mode 100644 drivers/spi/spi-jcore.c

-- 
2.8.1

