From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 29 Jun 2016 13:40:45 +0000
Subject: [PATCH v4 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
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
RTS7751R2Dplus is QEMU-SH4 target. So easy trying.

Changes V4
- split board depend patch.
- dts cleanup.

Changes V3
- PCI driver update for v4.7.
- New Clock driver. Unified PLL/Divider.
- R2Dplus support.
- Split DTS.
- Some cleanup.

Changes V2
- split DeviceTree suppoty update.
- PCI driver update.
- Some cleanup.

Yoshinori Sato (22):
  sh: Add sh-specific early_init_dt_reserve_memory_arch
  sh: More early unflatten device tree
  sh: set preset_lpj
  sh: Use P1SEGADDR
  sh: command line passing chosen/bootargs in devicetree
  sh: FDT address save before bank change
  sh: Passing FDT address on zImage
  sh: Disable board specific code on device tree mode
  sh: Use GENERIC_IOMAP on device tree mode
  sh: Add board specific initialize of of-generic
  sh: SH7750/51 CPG Driver
  sh: Add PCI host bridge driver for SH7751
  sh: irqchip: SH7751 IRQCHIP Driver
  sh: SH7751 core dtsi
  sh: Move common PCI stuff to arch/sh/kernel
  pci: pci_config_window move to linux/pci.h
  pci: PCI_HOST_GENERIC enable for SH
  sh: Add separate DTB build rule
  sh: IO-DATA HDL-U (a,k.a landisk) IRQCHIP driver
  sh: IO-DATA HDL-U (a,k.a landisk) DeviceTree
  sh: Renesas RTS7751R2Dplus (a,k.a R2Dplus) IRQCHIP Driver
  sh: Renesas RTS7751R2Dplus (a,k.a R2Dplus) DeviceTree

 .../bindings/clock/renesas,sh7750-cpg.txt          |  25 ++
 .../interrupt-controller/iodata-landisk.txt        |  31 ++
 .../interrupt-controller/renesas,sh7751-intc.txt   |  25 ++
 .../interrupt-controller/renesas-r2dplus.txt       |  38 +++
 .../devicetree/bindings/pci/sh7751-pci.txt         |  37 +++
 arch/sh/Kconfig                                    |   6 +-
 arch/sh/Makefile                                   |   9 +
 arch/sh/boards/Kconfig                             |   4 +
 arch/sh/boards/of-generic.c                        |  88 +++++-
 arch/sh/boot/compressed/head_32.S                  |   5 +-
 arch/sh/boot/dts/Makefile                          |   5 +
 arch/sh/boot/dts/include/dt-bindings               |   1 +
 arch/sh/boot/dts/landisk.dts                       |  61 ++++
 arch/sh/boot/dts/r2dplus.dts                       |  83 +++++
 arch/sh/boot/dts/sh7751.dtsi                       |  83 +++++
 arch/sh/drivers/Makefile                           |   2 +
 arch/sh/drivers/pci/Makefile                       |   2 -
 arch/sh/drivers/pci/common.c                       | 162 ----------
 arch/sh/drivers/pci/pci.c                          | 320 -------------------
 arch/sh/include/asm/io.h                           |   6 +
 arch/sh/kernel/Makefile                            |   2 +
 arch/sh/kernel/cpu/Makefile                        |   8 +-
 arch/sh/kernel/cpu/clock.c                         |   6 +-
 arch/sh/kernel/cpu/sh4/Makefile                    |   2 +
 arch/sh/kernel/head_32.S                           |   7 +-
 arch/sh/kernel/pci-common.c                        | 162 ++++++++++
 arch/sh/kernel/pci.c                               | 342 ++++++++++++++++++++
 arch/sh/kernel/setup.c                             |  15 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   3 +-
 drivers/clk/sh/Kconfig                             |   2 +
 drivers/clk/sh/Makefile                            |   1 +
 drivers/clk/sh/clk-sh7750cpg.c                     | 344 +++++++++++++++++++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-io-landisk.c                   |  72 +++++
 drivers/irqchip/irq-renesas-r2dplus.c              |  88 ++++++
 drivers/irqchip/irq-renesas-sh7751.c               | 141 +++++++++
 drivers/pci/ecam.h                                 |  17 +-
 drivers/pci/host/Kconfig                           |   9 +-
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-sh7751.c                      | 326 +++++++++++++++++++
 include/dt-bindings/clock/renesas-sh7750.h         |  26 ++
 include/dt-bindings/interrupt-controller/sh_intc.h |   2 +
 include/linux/pci.h                                |  18 ++
 45 files changed, 2073 insertions(+), 521 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas-r2dplus.txt
 create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 arch/sh/boot/dts/r2dplus.dts
 create mode 100644 arch/sh/boot/dts/sh7751.dtsi
 delete mode 100644 arch/sh/drivers/pci/common.c
 delete mode 100644 arch/sh/drivers/pci/pci.c
 create mode 100644 arch/sh/kernel/pci-common.c
 create mode 100644 arch/sh/kernel/pci.c
 create mode 100644 drivers/clk/sh/Kconfig
 create mode 100644 drivers/clk/sh/Makefile
 create mode 100644 drivers/clk/sh/clk-sh7750cpg.c
 create mode 100644 drivers/irqchip/irq-io-landisk.c
 create mode 100644 drivers/irqchip/irq-renesas-r2dplus.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c
 create mode 100644 drivers/pci/host/pci-sh7751.c
 create mode 100644 include/dt-bindings/clock/renesas-sh7750.h
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

-- 
2.7.0

