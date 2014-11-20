From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 20 Nov 2014 16:21:30 +0000
Subject: [PATCH v2 0/6] r8a73a4 common clock framework implementation
Message-Id: <1416500496-21024-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

The CCF implementation for r8a73a4 again; this includes multi-parent DIV6
clocks and thus depends on the "clk: shmobile: DIV6 clock variable parent
support" patch set that should be in the clk-next tree by now.

This revision replaces renesas,clock-indices with clock-indices, dumps the
superfluous extal2 fractions, and includes a little DT reformat as requested
by Geert.

Mike, could you please ack this CPG driver, too? It is very similar to the
one for sh73a0.

CU
Uli


Changes since v1:
- use clock-indices instead of renesas,clock-indices
- dump unused extal2_div2_clk and extal2_div4_clk
- move mstp2 clocks property below interrupt-names


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
 drivers/clk/shmobile/clk-r8a73a4.c                 | 242 +++++++++++++++
 include/dt-bindings/clock/r8a73a4-clock.h          |  62 ++++
 7 files changed, 665 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a73a4.c
 create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h

-- 
1.8.4.5

