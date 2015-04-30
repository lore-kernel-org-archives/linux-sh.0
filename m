From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:49 +0000
Subject: [PATCH v2 00/15] r8a7793 SoC, Gose board support
Message-Id: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here is a revised set of patches adding R8A7793 (M2-N) support.
The major changes are that I dropped power management for now,
and that the PFC monster patch has been broken down for ease
of review.  Also a lot of small errors, most spotted by Geert,
have been fixed.

CU
Uli


Changes since v1:
- pfc: split patch in six
- pfc: fixed typos
- dts: named clock bits correctly
- dts: made more consistent with the very similar r8a7791 dts
- dts: removed adv7511, don't know the address
- pm: dropped for now, needs to be fixed up first
- everywhere: renamed M2N -> M2-N (and M2 to M2-W, while at it)
- everywhere: added Acks


Ulrich Hecht (15):
  pinctrl: sh-pfc: Add r8a7793 PFC support part 1: pinmux data
  pinctrl: sh-pfc: Add r8a7793 PFC support part 2: pin groups
  pinctrl: sh-pfc: Add r8a7793 PFC support part 3: pinmux config
    registers
  pinctrl: sh-pfc: Add r8a7793 pinmux info
  pinctrl: sh-pfc: Enable building of r8a7793 PFC support
  pinctrl: sh-pfc: Add renesas,pfc-r8a7793 to binding documentation
  ARM: shmobile: Basic r8a7793 SoC support
  ARM: shmobile: add r8a7793 SoC device tree
  ARM: shmobile: r8a7793: add Gose board device tree
  ARM: shmobile: r8a7793: add SMP support
  clk: shmobile: r8a7793: document DIV6 clock bindings
  mmc: sh_mmcif: Document r8a7793 DT bindings
  serial: sh-sci: Add device tree bindings for r8a7793
  clk: shmobile: Add r8a7793 SoC to MSTP bindings
  PCI: rcar: document r8a7793 DT bindings

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |    3 +-
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |    3 +-
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |    1 +
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |    1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    3 +-
 .../bindings/serial/renesas,sci-serial.txt         |   12 +-
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/r8a7793-gose.dts                 |  534 ++
 arch/arm/boot/dts/r8a7793.dtsi                     | 1376 +++++
 arch/arm/mach-shmobile/Kconfig                     |    4 +
 arch/arm/mach-shmobile/Makefile                    |    2 +
 arch/arm/mach-shmobile/r8a7793.h                   |    6 +
 arch/arm/mach-shmobile/setup-r8a7793.c             |   35 +
 arch/arm/mach-shmobile/smp-r8a7793.c               |   67 +
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/core.h                      |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7793.c               | 6033 ++++++++++++++++++++
 include/dt-bindings/clock/r8a7793-clock.h          |  158 +
 20 files changed, 8245 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts
 create mode 100644 arch/arm/boot/dts/r8a7793.dtsi
 create mode 100644 arch/arm/mach-shmobile/r8a7793.h
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 create mode 100644 arch/arm/mach-shmobile/smp-r8a7793.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7793.c
 create mode 100644 include/dt-bindings/clock/r8a7793-clock.h

-- 
2.3.5

