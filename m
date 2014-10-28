From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 28 Oct 2014 17:02:09 +0000
Subject: [PATCH v3 0/7] sh73a0 common clock framework implementation
Message-Id: <1414515736-24905-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This revision drops the stuff that has since been merged.  It also drops the
selectable-parent DIV6 clock support, I'll resend those separately RSN.

The only functional change is the removal of the redundant
shmobile_clk_workaround() call, the rest are cosmetic, see below for
details.

CU
Uli


Changes since v2:
- split CCF DT description in three
- reformatted CPG bits header file
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


Ulrich Hecht (7):
  clk: shmobile: sh73a0 common clock framework implementation
  ARM: shmobile: sh73a0: Add CPG register bits header
  ARM: shmobile: sh73a0: Common clock framework DT description
  ARM: shmobile: kzm9g-reference: Common clock framework DT description
  ARM: shmobile: sh73a0: add MSTP clock assignments to DT
  ARM: shmobile: sh73a0: disable legacy clock initialization
  ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet
    controller

 .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  31 ++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   5 +
 arch/arm/boot/dts/sh73a0.dtsi                      | 375 +++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c              |   5 +-
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-sh73a0.c                  | 202 +++++++++++
 include/dt-bindings/clock/sh73a0-clock.h           |  79 +++++
 7 files changed, 697 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-sh73a0.c
 create mode 100644 include/dt-bindings/clock/sh73a0-clock.h

-- 
1.8.4.5

