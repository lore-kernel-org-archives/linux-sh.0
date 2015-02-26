From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 26 Feb 2015 16:42:05 +0000
Subject: [PATCH v4 0/9] r8a7778 CCF and multiplatform
Message-Id: <1424968934-30577-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

As requested by Simon here are the remaining parts of CCF/MP support for
r8a7778 and Bock-W, with the DT bindings broken out, and the missing
sound bindings.

The last patch in this series is a fix-up for the already-merged "ARM:
shmobile: bockw dts: Move Ethernet node to BSC", where the removal of
the old entry somehow got left out.

CU
Uli


Changes since v3:
- dropped everything that has already been merged
- split off DT bindings
- added rcar_sound bindings
- added Acks

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


Ulrich Hecht (9):
  clk: shmobile: Add r8a7778 SoC to MSTP bindings
  ARM: shmobile: r8a7778: common clock framework CPG driver
  DT: i2c: add trivial binding for OKI ML86V7667 video decoder
  ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
  ASoC: rsnd: Document r8a7778-specific bindings
  ARM: shmobile: r8a7778: add sound to DT
  ARM: shmobile: bockw: add sound to DT
  ARM: shmobile: r8a7778: enable multiplatform target
  ARM: shmobile: bockw dts: Remove leftover Ethernet node

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  25 ++++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a7778-bockw.dts                |  49 +++++--
 arch/arm/boot/dts/r8a7778.dtsi                     |  55 ++++++++
 arch/arm/mach-shmobile/Kconfig                     |   4 +
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7778.c                 | 143 +++++++++++++++++++++
 include/linux/clk/shmobile.h                       |   1 +
 11 files changed, 273 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a7778.c

-- 
2.2.2

