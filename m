From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Sep 2014 09:12:56 +0000
Subject: [PATCH v2 00/10] sh73a0 common clock framework implementation
Message-Id: <1409649186-1046-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's an updated sh73a0 CCF implementation.  It adds the missing clock
assignments, CMT1, and various minor fixes.  It also splits off the parent
selection for the DIV6 clocks so it can be merged without requiring the DIV6
driver patch.

CU
Uli


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


Ulrich Hecht (10):
  clk: shmobile: sh73a0 common clock framework implementation
  ARM: shmobile: sh73a0: Common clock framework DT description
  ARM: shmobile: sh73a0: common clock framework board support
  ARM: shmobile: sh73a0: add MSTP clock assignments to DT
  ARM: shmobile: sh73a0: Add CMT1 device to DT
  ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree
  ARM: shmobile: kzm9g: require ZB1 clock for Ethernet controller
  clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings
  clk: shmobile: div6: support selectable-input clocks
  ARM: shmobile: sh73a0: add selectable sources to DIV6 clocks

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  12 +-
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   2 +
 .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  31 ++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   9 +
 arch/arm/boot/dts/sh73a0.dtsi                      | 440 +++++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  25 ++
 arch/arm/mach-shmobile/setup-sh73a0.c              |  16 +-
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-div6.c                    |  32 +-
 drivers/clk/shmobile/clk-sh73a0.c                  | 202 ++++++++++
 include/dt-bindings/clock/sh73a0-clock.h           |  79 ++++
 11 files changed, 832 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-sh73a0.c
 create mode 100644 include/dt-bindings/clock/sh73a0-clock.h

-- 
1.8.4.5

