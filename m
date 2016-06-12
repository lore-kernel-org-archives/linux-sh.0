From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:18 +0000
Subject: [PATCH v2 00/17] sh: LANDISK convert to device tree
Message-Id: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

SH get devicetree support. But it not working on existing H/W.

IO-DATA HDL-U (aka landisk) currentry supported.
This H/W like SH7751 evalution board. It's a best to use this as a
change base H/W.

Changes V2
- split DeviceTree suppoty update.
- PCI driver update.
- Some cleanup.

Yoshinori Sato (17):
  sh: Add sh-specific early_init_dt_reserve_memory_arch
  sh: More early unflatten device tree
  sh: set preset_lpj
  sh: Use P1SEGADDR
  sh: command line passing chosen/bootargs in devicetree
  sh: FDT address save before bank change
  sh: Passing FDT address on zImage
  sh: Disable board specific code on device tree mode
  sh: Use GENERIC_IOMAP on device tree mode
  sh: convert generic drivers framework
  sh: SH7750/51 clock driver
  sh: Add PCI host bridge driver for SH7751
  sh: Add PCI definetion
  sh: SH3/4 Generic IRQCHIP driever
  sh: SH-INTC helper files
  sh: I/O DATA HDL-U (a.k.a. landisk) Device Tree
  sh: landisk CPLD interrupt controller driver

 .../bindings/clock/renesas,sh7750-div-clock.txt    |  27 ++
 .../bindings/clock/renesas,sh7750-pll-clock.txt    |  26 ++
 .../interrupt-controller/iodata-landisk.txt        |  28 ++
 .../interrupt-controller/renesas,sh7751-intc.txt   |  25 ++
 .../devicetree/bindings/pci/sh7751-pci.txt         |  51 +++
 arch/sh/Kconfig                                    |   6 +-
 arch/sh/Makefile                                   |   2 +
 arch/sh/boards/Kconfig                             |   4 +
 arch/sh/boards/of-generic.c                        |  24 +-
 arch/sh/boot/compressed/head_32.S                  |   5 +-
 arch/sh/boot/dts/include/dt-bindings               |   1 +
 arch/sh/boot/dts/landisk.dts                       | 150 +++++++
 arch/sh/drivers/Makefile                           |   2 +
 arch/sh/include/asm/io.h                           |   6 +
 arch/sh/kernel/cpu/Makefile                        |   8 +-
 arch/sh/kernel/cpu/clock.c                         |   6 +-
 arch/sh/kernel/cpu/sh4/Makefile                    |   2 +
 arch/sh/kernel/head_32.S                           |   7 +-
 arch/sh/kernel/setup.c                             |  16 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   3 +-
 drivers/clk/sh/Kconfig                             |   2 +
 drivers/clk/sh/Makefile                            |   2 +
 drivers/clk/sh/clk-sh7750.c                        | 240 +++++++++++
 drivers/clk/sh/clk-shdiv.c                         | 344 ++++++++++++++++
 drivers/clk/sh/clk-shdiv.h                         |  16 +
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-io-landisk.c                   |  72 ++++
 drivers/irqchip/irq-renesas-sh7751.c               | 141 +++++++
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-sh7751.c                      | 443 +++++++++++++++++++++
 include/dt-bindings/interrupt-controller/sh_intc.h |   2 +
 34 files changed, 1656 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
 create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 drivers/clk/sh/Kconfig
 create mode 100644 drivers/clk/sh/Makefile
 create mode 100644 drivers/clk/sh/clk-sh7750.c
 create mode 100644 drivers/clk/sh/clk-shdiv.c
 create mode 100644 drivers/clk/sh/clk-shdiv.h
 create mode 100644 drivers/irqchip/irq-io-landisk.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c
 create mode 100644 drivers/pci/host/pci-sh7751.c
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

-- 
2.7.0

