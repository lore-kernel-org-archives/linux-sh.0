From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 16 Feb 2015 16:58:44 +0000
Subject: [PATCH v3 00/15] r8a7778 CCF and multiplatform
Message-Id: <1424105939-4910-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's the CCF/MP support for r8a7778 and Bock-W again.  This revision again
attempts to incorporate all suggestions made and should be more successful
in that than the last one.  Thank you for the reviews and acks, the changes
made are detailed below.

CU
Uli


Changes since v2:
- minor reformatting and code styling
- renamed *SCU_SRC* -> *SRU_SRC*
- updated DT bindings to match implementation
- removed unused Ethernet pins from bockw DT
- renamed sound node to conform to standards
- retooled external Ethernet compatible list
- added more Acks

Changes since v1:
- added oki,ml86v7667 to trivial-devices.txt
- added internal ethernet controller
- moved pins from external to internal ethernet controller
- added bsc bus, moved external ethernet controller there
- removed extal from CPG driver and made it a fixed clock
- renamed "scu*" clocks to "scu-src*"
- split SoC/board CCF enablement from CPG driver
- added "smsc,lan89218" compat string to external net controller
- added missing clock-names to tmu nodes
- named Kconfig entry properly
- added Acks


Ulrich Hecht (15):
  ARM: shmobile: r8a7778: synchronize dts with reference platform
  ARM: shmobile: r8a7778: add CPG register bits header
  ARM: shmobile: r8a7778: Common clock framework DT description
  ARM: shmobile: r8a7778: common clock framework CPG driver
  ARM: shmobile: r8a7778: implement SoC and board CCF support
  ARM: shmobile: r8a7778: add MSTP clock assignments to DT
  ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
  ARM: shmobile: r8a7778: add internal ethernet controller to DT
  ARM: shmobile: bockw: add USB, VIN pin descriptions to DT
  ARM: shmobile: r8a7778: add sound to DT
  ARM: shmobile: bockw: add sound to DT
  ARM: shmobile: r8a7778: enable multiplatform target
  ARM: shmobile: r8a7778 dtsi: Add Bus State Controller node
  ARM: shmobile: bockw dts: Move Ethernet node to BSC
  ARM: shmobile: bockw dts: set extal clock frequency

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  25 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a7778-bockw.dts                | 175 ++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                     | 293 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   4 +
 arch/arm/mach-shmobile/board-bockw-reference.c     |   2 +
 arch/arm/mach-shmobile/setup-r8a7778.c             |  19 ++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7778.c                 | 143 ++++++++++
 include/dt-bindings/clock/r8a7778-clock.h          |  71 +++++
 include/linux/clk/shmobile.h                       |   1 +
 13 files changed, 737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a7778.c
 create mode 100644 include/dt-bindings/clock/r8a7778-clock.h

-- 
2.2.2

