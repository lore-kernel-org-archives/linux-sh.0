From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 01 May 2016 05:08:24 +0000
Subject: [PATCH RESEND 00/12] SH: landisk convert to devicetree
Message-Id: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

SH get devicetree support. But it not working on existing H/W.

IO-DATA HDL-U (aka landisk) currentry supported.
This H/W like SH7751 evalution board. It's a best to use this as a
change base H/W.

Yoshinori Sato (12):
  sh: Fix typo
  sh: Config update for OF mode
  sh: Disable board specific code in OF mode
  sh: Drop CPU specific setup on OF mode
  sh: DeviceTree support update
  clk: sh: SH7750/51 PLL and divider clock driver
  pci: sh: SH7751 PCI host bridge driver
  intc: sh: Renesas Super H INTC driver
  sh: Add I/O DATA HDL-U support drivers.
  sh: I/O DATA HDL-U (aka landisk) support dts
  sh: I/O DATA HDL-U defconfig (DT mode)
  of: Add sh support

 .../bindings/clock/renesas,sh-div-clock.txt        |  24 ++
 .../bindings/clock/renesas,sh7750-div-clock.txt    |  27 ++
 .../bindings/clock/renesas,sh7750-pll-clock.txt    |  26 ++
 .../interrupt-controller/iodata-landisk.txt        |  28 ++
 .../interrupt-controller/renesas,sh7751-intc.txt   |  25 ++
 .../devicetree/bindings/pci/sh7751-pci.txt         |  51 +++
 arch/sh/Kconfig                                    |  26 +-
 arch/sh/Makefile                                   |  11 +
 arch/sh/boards/Kconfig                             |   4 +
 arch/sh/boards/of-generic.c                        |  23 +-
 arch/sh/boot/compressed/head_32.S                  |   5 +-
 arch/sh/boot/dts/include/dt-bindings               |   1 +
 arch/sh/boot/dts/landisk.dts                       | 150 +++++++++
 arch/sh/configs/landisk-dt_defconfig               | 100 ++++++
 arch/sh/drivers/Makefile                           |   2 +
 arch/sh/include/asm/io.h                           |   6 +
 arch/sh/kernel/cpu/Makefile                        |   8 +-
 arch/sh/kernel/cpu/clock.c                         |   9 +-
 arch/sh/kernel/cpu/sh4/Makefile                    |   2 +
 arch/sh/kernel/head_32.S                           |   2 +-
 arch/sh/kernel/setup.c                             |  19 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   3 +-
 drivers/clk/sh/Kconfig                             |   5 +
 drivers/clk/sh/Makefile                            |   2 +
 drivers/clk/sh/clk-sh7750.c                        | 223 +++++++++++++
 drivers/clk/sh/clk-shdiv.c                         | 338 ++++++++++++++++++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-io-landisk.c                   |  71 +++++
 drivers/irqchip/irq-renesas-shipr.c                | 138 ++++++++
 drivers/of/fdt.c                                   |   3 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-sh7751.c                      | 346 +++++++++++++++++++++
 drivers/pci/host/pci-sh7751.h                      | 269 ++++++++++++++++
 drivers/sh/Makefile                                |   2 +
 include/dt-bindings/interrupt-controller/sh_intc.h |   2 +
 38 files changed, 1942 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
 create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 arch/sh/configs/landisk-dt_defconfig
 create mode 100644 drivers/clk/sh/Kconfig
 create mode 100644 drivers/clk/sh/Makefile
 create mode 100644 drivers/clk/sh/clk-sh7750.c
 create mode 100644 drivers/clk/sh/clk-shdiv.c
 create mode 100644 drivers/irqchip/irq-io-landisk.c
 create mode 100644 drivers/irqchip/irq-renesas-shipr.c
 create mode 100644 drivers/pci/host/pci-sh7751.c
 create mode 100644 drivers/pci/host/pci-sh7751.h
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

-- 
2.7.0

