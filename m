From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 06 May 2014 14:23:47 +0000
Subject: [PATCH 0/6] sh73a0 common clock framework implementation
Message-Id: <1399386233-11928-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's the CCF implementation for sh73a0. This is quite similar to the
r8a7740 variety, but with more clocks.  Two of them ("dsi0pck" and "vclk3")
are currently listed as DIV6 clocks, but have custom bits and will thus be
moved into the CPG clocks driver in the next iteration.

Contained herein is an updated version of the DIV6 driver that preserves the
input clock settings properly.  This merely happened to work on the r8a7740
(where all important clock sources are set to zero, I suppose), but breaks
on the sh73a0.

This iteration does not yet reflect the change from "renesas,clock-indices"
to "clock-indices".

CU
Uli

Ulrich Hecht (6):
  ARM: shmobile: sh73a0: Common clock framework DT description
  clk: shmobile: sh73a0 common clock framework implementation
  clk: shmobile: div6: support selectable-input clocks
  ARM: shmobile: kzm9g: require ZB1 clock for Ethernet controller
  ARM: shmobile: sh73a0: common clock framework board support
  clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  11 +-
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   2 +
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   5 +
 arch/arm/boot/dts/sh73a0.dtsi                      | 407 +++++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  25 ++
 arch/arm/mach-shmobile/setup-sh73a0.c              |   5 +-
 drivers/clk/shmobile/clk-div6.c                    |  32 +-
 drivers/clk/shmobile/clk-sh73a0.c                  | 202 ++++++++++
 include/dt-bindings/clock/sh73a0-clock.h           |  79 ++++
 9 files changed, 760 insertions(+), 8 deletions(-)
 create mode 100644 drivers/clk/shmobile/clk-sh73a0.c
 create mode 100644 include/dt-bindings/clock/sh73a0-clock.h

-- 
1.8.4.5

