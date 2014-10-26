From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 14:11:05 +0000
Subject: [PATCH v5 00/14] DU DT support for Marzen, Lager and Koelsch
Message-Id: <1414332679-15497-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series enable the DU device in DT for the Marzen, Lager and Koelsch
boards (in their multiplatform implementation only).

Compared to v4,

- the shmobile_clk_workaround() function has been removed

- the Koelsch board files have been removed

- the Marzen LVDS encoder DT node has been renamed to lvds-encoder and its
  port subnodes now have reg properties.

Compared to v3,

- the series has been rebased on top of v3.18-rc1

Compared to v2,

- the Marzen and Lager adv7123 DT nodes have been renamed to vga-encoder

- the Marzen and Lager adv7123 DT nodes now correctly set the "reg" property
in their port subnodes.

Compared to v1,

- support for the external LVDS panel commonly used with the three boards has
been moved to a separate file (r8a77xx-aa104xd12-panel.dtsi) that can be
included at the end of the Marzen, Lager or Koelsch DTS

- the DU DT nodes have been renamed to "display"

- the s/remote/remove/ typo has been fixed in commit messages.

The first three patches add the DU nodes to the SoC .dtsi files. Patch 04 adds
the panel .dtsi. Patches 05 enables the DU device in DT for the Marzen board,
and patches 06 to 09 perform the same operation for the Lager and Koelsch
boards, removing the C code DU platform device in the process. The following
patches are removals, with 10 and 11 removing shmobile_clk_workaround() and 12
to 14 removing the Koelsch board files.

Simon, I expect Dave to need a stable branch with patches 06 and 08 in order
to merge the RCar DU HDMI support in v3.19. Is that something you can provide
without too much trouble ? You can include the whole series in the branch if
easier but that's not strictly mandatory.

The alternative would be to merge the RCar DU patches through your tree, but
the risk of conflicts might be a bit too high.

The patches are based on top of v3.18-rc1. I've pushed a test branch that
includes all patches to

	git://linuxtv.org/pinchartl/fbdev.git drm/du/dt

Cc: Simon Horman <horms+renesas@verge.net.au>

Laurent Pinchart (14):
  ARM: shmobile: r8a7779: Add DU node to device tree
  ARM: shmobile: r8a7790: Add DU node to device tree
  ARM: shmobile: r8a7791: Add DU node to device tree
  ARM: shmobile: dts: Add common file for AA104XD12 panel
  ARM: shmobile: marzen: Enable DU device in DT
  ARM: shmobile: lager-reference: Remove DU platform device
  ARM: shmobile: lager: Enable DU device in DT
  ARM: shmobile: koelsch-reference: Remove DU platform device
  ARM: shmobile: koelsch: Enable DU device in DT
  ARM: shmobile: marzen-reference: Don't include legacy clock.h
  ARM: shmobile: Remove shmobile_clk_workaround() implementation
  ARM: shmobile: koelsch: Remove legacy C board code
  ARM: shmobile: r8a7791: Remove legacy code
  ARM: shmobile: koelsch: Remove reference board code

 arch/arm/boot/dts/r8a7779-marzen.dts             |  83 ++++
 arch/arm/boot/dts/r8a7779.dtsi                   |  24 ++
 arch/arm/boot/dts/r8a7790-lager.dts              |  53 ++-
 arch/arm/boot/dts/r8a7790.dtsi                   |  39 ++
 arch/arm/boot/dts/r8a7791-koelsch.dts            |  16 +-
 arch/arm/boot/dts/r8a7791.dtsi                   |  30 ++
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi   |  41 ++
 arch/arm/configs/koelsch_defconfig               | 113 -----
 arch/arm/configs/shmobile_defconfig              |   1 -
 arch/arm/mach-shmobile/Kconfig                   |  19 -
 arch/arm/mach-shmobile/Makefile                  |   5 +-
 arch/arm/mach-shmobile/Makefile.boot             |   1 -
 arch/arm/mach-shmobile/board-koelsch-reference.c | 117 -----
 arch/arm/mach-shmobile/board-koelsch.c           | 527 -----------------------
 arch/arm/mach-shmobile/board-lager-reference.c   |  80 ----
 arch/arm/mach-shmobile/board-marzen-reference.c  |   1 -
 arch/arm/mach-shmobile/clock-r8a7791.c           | 342 ---------------
 arch/arm/mach-shmobile/clock.c                   |  32 +-
 arch/arm/mach-shmobile/clock.h                   |  14 -
 arch/arm/mach-shmobile/r8a7791.h                 |   3 -
 arch/arm/mach-shmobile/setup-r8a7791.c           | 181 +-------
 21 files changed, 285 insertions(+), 1437 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi
 delete mode 100644 arch/arm/configs/koelsch_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-koelsch-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-koelsch.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7791.c

-- 
Regards,

Laurent Pinchart

