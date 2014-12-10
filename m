From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 10 Dec 2014 14:45:21 +0000
Subject: [PATCH v7 0/6] sh73a0 common clock framework implementation
Message-Id: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's the sh73a0 CCF driver with two fixes for issues in the frequency
calculation for the z and dsi?phy clocks found by Geert and Laurent.

CU
Uli


Changes since v6:
- removed unused divider masks and flags
- consider FRQCRB:ZSEL when calculating z clock
- fixed dsi?phy PLL frequency calculation
- added Acked-by

Changes since v5:
- use clock-indices instead of renesas,clock-indices
- added Tested-by

Changes since v4:
- reordered MSTP clock assignments to directly follow interrupts property

Changes since v3:
- fixed bindings to match the implementation
- handle extal division in CPG driver, dump extal?_div2_clk
- added acks
- dropped eth clock hack

Changes since v2:
- split CCF DT description
- tabbed constants in CPG bits header file
- reordered patches to avoid need for shmobile_clk_workaround()
- removed said workaround
- squashed unmerged remains of CMT1 DT description into MSTP clocks patch
- renamed clock zb1 to zb
- removed DIV6 stuff, will be a separate series

Changes since v1:
- div6 patch replaced with v4
- split off div6 extended clocks
- added cmt1 DT description
- added MSTP clock assignments
- reordered according to dependencies
- removed dummy frequencies in extal2, extcki
- removed enable_on_init on zb1 and flctlck
- added missing tpu4 in mstp3_clks
- use c->parent in cpg driver
- fix some style issues


Ulrich Hecht (6):
  clk: shmobile: sh73a0 common clock framework implementation
  ARM: shmobile: sh73a0: Add CPG register bits header
  ARM: shmobile: sh73a0: Common clock framework DT description
  ARM: shmobile: kzm9g-reference: Common clock framework DT description
  ARM: shmobile: sh73a0: add MSTP clock assignments to DT
  ARM: shmobile: sh73a0: disable legacy clock initialization

 .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  35 ++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   4 +
 arch/arm/boot/dts/sh73a0.dtsi                      | 358 +++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c              |   5 +-
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-sh73a0.c                  | 218 +++++++++++++
 include/dt-bindings/clock/sh73a0-clock.h           |  79 +++++
 7 files changed, 699 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-sh73a0.c
 create mode 100644 include/dt-bindings/clock/sh73a0-clock.h

-- 
1.8.4.5

