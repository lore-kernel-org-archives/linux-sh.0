From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 22 Apr 2014 13:19:08 +0000
Subject: [PATCH 0/4] ARM: shmobile: r8a7740 CCF implementation
Message-Id: <1398172752-30567-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's an updated version of the r8a7740 CCF RFC. Changes include:

- added switchable input clocks to DIV6 driver
- added all clocks supported by the legacy clock framework
- moved board-specific stuff out of the dtsi
- added DT bindings documentation
- dumped r8a7740_clocks_init() in favor of a DT property
- worked in various other suggestions by Laurent

CU
Uli

Ulrich Hecht (4):
  clk: shmobile: div6: support selectable-input clocks
  ARM: shmobile: r8a7740: Add clocks to DTS
  ARM: shmobile: r8a7740: common clock framework board support
  clk: shmobile: Add R8A7740-specific clock support

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |   8 +
 .../bindings/clock/renesas,r8a7740-cpg-clocks.txt  |  39 ++++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  13 ++
 arch/arm/boot/dts/r8a7740.dtsi                     | 229 +++++++++++++++++++++
 .../board-armadillo800eva-reference.c              |  25 +++
 arch/arm/mach-shmobile/setup-r8a7740.c             |   2 +
 drivers/clk/shmobile/clk-div6.c                    |  19 +-
 drivers/clk/shmobile/clk-r8a7740.c                 | 196 ++++++++++++++++++
 include/dt-bindings/clock/r8a7740-clock.h          |  77 +++++++
 9 files changed, 607 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a7740.c
 create mode 100644 include/dt-bindings/clock/r8a7740-clock.h

-- 
1.8.4.5

