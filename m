From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 21 May 2015 10:48:02 +0000
Subject: [PATCH v3 00/11] r8a7793 SoC, Gose board support
Message-Id: <1432205293-9488-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This revision drops the merged PFC parts, uses CPU_METHOD_OF_DECLARE with
enable-method to define the SMP ops as suggested by Laurent, and fixes the
numerous tidbits found by Geert and Morimoto-san.  It also adds assorted
Cc's and acks to the various DT binding patches.

CU
Uli


Changes since v2:
- dts: remove unused pins
- dts: fix flash partition addresses
- dts: add pmic
- dtsi, dts: add CMTs
- dts: add interrupt parent to regulator
- smp, dtsi: use CPU_METHOD_OF_DECLARE, enable-method
- smp: re-add rcar_gen2_pm_init() call
- dtsi: add irqc0 clock
- dtsi: add DMA controllers
- dtsi: remove audmapp
- dtsi: fix sdhi0 resource length
- dtsi: add SDHI DMAs, remove unsupported properties
- dtsi: add rcan, adsp clocks
- dtsi: add missing MSTP4
- dtsi: fix audmac clocks
- dtsi: add MSIOF DMAs, remove unused register set
- dtsi: copy sound description from r8a7791
- enable rcar2 regulator quirk on Gose

Changes since v1:

- pfc: split patch in six
- pfc: fixed typos
- dts: named clock bits properly
- dts: made more consistent with the very similar r8a7791 dts
- dts: removed adv7511, don't know the address
- pm: dropped for now, needs to be fixed up first
- everywhere: renamed M2N -> M2-N (and M2 to M2-W, while at it)
- everywhere: added Acks


Ulrich Hecht (11):
  ARM: shmobile: Basic r8a7793 SoC support
  ARM: shmobile: add r8a7793 SoC device tree
  ARM: shmobile: r8a7793: add Gose board device tree
  ARM: shmobile: r8a7793: add SMP support
  clk: shmobile: r8a7793: document DIV6 clock bindings
  mmc: sh_mmcif: Document r8a7793 DT bindings
  serial: sh-sci: Add device tree bindings for r8a7793
  clk: shmobile: Add r8a7793 SoC to MSTP bindings
  PCI: rcar: document r8a7793 DT bindings
  clocksource: sh_cmt: Document r8a7793-specific bindings
  ARM: shmobile: gose: enable R-Car Gen2 regulator quirk

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |    3 +-
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |    3 +-
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |    1 +
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |    1 +
 .../bindings/serial/renesas,sci-serial.txt         |   12 +-
 .../devicetree/bindings/timer/renesas,cmt.txt      |    2 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/r8a7793-gose.dts                 |  535 ++++++++
 arch/arm/boot/dts/r8a7793.dtsi                     | 1429 ++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |    4 +
 arch/arm/mach-shmobile/Makefile                    |    2 +
 arch/arm/mach-shmobile/r8a7793.h                   |    6 +
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |    3 +-
 arch/arm/mach-shmobile/setup-r8a7793.c             |   34 +
 arch/arm/mach-shmobile/smp-r8a7793.c               |   70 +
 include/dt-bindings/clock/r8a7793-clock.h          |  164 +++
 16 files changed, 2263 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts
 create mode 100644 arch/arm/boot/dts/r8a7793.dtsi
 create mode 100644 arch/arm/mach-shmobile/r8a7793.h
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 create mode 100644 arch/arm/mach-shmobile/smp-r8a7793.c
 create mode 100644 include/dt-bindings/clock/r8a7793-clock.h

-- 
2.3.5

