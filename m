From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:36:43 +0000
Subject: [PATCH v3 0/6] r8a73a4 common clock framework implementation
Message-Id: <1417509409-31638-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Version 3 of the CCF implementation for r8a73a4.  Again, this includes
multi-parent DIV6 clocks and thus depends on the "clk: shmobile: DIV6 clock
variable parent support" patch set from the clk-next tree.

This version fixes three real issues acutely spotted by Laurent and Geert,
adds a number of acks, and includes the usual reformatting routine.  See
below for details.

CU
Uli


Ulrich Hecht (6):
  clk: shmobile: r8a73a4 common clock framework implementation
  clk: shmobile: Add r8a73a4 SoC to MSTP bindings
  ARM: shmobile: r8a73a4: Add CPG register bits header
  ARM: shmobile: r8a73a4: Common clock framework DT description
  ARM: shmobile: ape6evm: disable legacy clock initialization
  ARM: shmobile: r8a73a4: add MSTP clock assignments to DT

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,r8a73a4-cpg-clocks.txt  |  33 +++
 arch/arm/boot/dts/r8a73a4.dtsi                     | 324 +++++++++++++++++++++
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |   3 +-
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a73a4.c                 | 244 ++++++++++++++++
 include/dt-bindings/clock/r8a73a4-clock.h          |  62 ++++
 7 files changed, 667 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a73a4.c
 create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h

-- 
1.8.4.5

