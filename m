From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 07 Nov 2014 15:51:58 +0000
Subject: [PATCH 0/6] r8a73a4 common clock framework implementation
Message-Id: <1415375524-15468-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's the CCF implementation for r8a73a4; unlike the sh73a0 series, this
includes multi-parent DIV6 clocks and thus depends on the "clk: shmobile:
DIV6 clock variable parent support" patch set.

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
 .../bindings/clock/renesas,r8a73a4-cpg-clocks.txt  |  33 ++
 arch/arm/boot/dts/r8a73a4.dtsi                     | 340 +++++++++++++++++++++
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |   3 +-
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a73a4.c                 | 242 +++++++++++++++
 include/dt-bindings/clock/r8a73a4-clock.h          |  62 ++++
 7 files changed, 681 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a73a4.c
 create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h

-- 
1.8.4.5

