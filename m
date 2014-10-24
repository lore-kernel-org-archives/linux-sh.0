From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 24 Oct 2014 12:03:52 +0000
Subject: [PATCH v4 0/9] DU DT support for Marzen, Lager and Koelsch
Message-Id: <1414152241-5390-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series enable the DU device in DT for the Marzen, Lager and Koelsch
boards (in their multiplatform implementation only).

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
boards, removing the C code DU platform device in the process.

The patches are based on top of v3.18-rc1. I've pushed a test branch that
includes all patches (and more) to

	git://linuxtv.org/pinchartl/fbdev.git drm/du/dt

Laurent Pinchart (9):
  ARM: shmobile: r8a7779: Add DU node to device tree
  ARM: shmobile: r8a7790: Add DU node to device tree
  ARM: shmobile: r8a7791: Add DU node to device tree
  ARM: shmobile: dts: Add common file for AA104XD12 panel
  ARM: shmobile: marzen: Enable DU device in DT
  ARM: shmobile: lager-reference: Remove DU platform device
  ARM: shmobile: lager: Enable DU device in DT
  ARM: shmobile: koelsch-reference: Remove DU platform device
  ARM: shmobile: koelsch: Enable DU device in DT

 arch/arm/boot/dts/r8a7779-marzen.dts             | 81 ++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                   | 24 +++++++
 arch/arm/boot/dts/r8a7790-lager.dts              | 53 +++++++++++++++-
 arch/arm/boot/dts/r8a7790.dtsi                   | 39 ++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 16 ++++-
 arch/arm/boot/dts/r8a7791.dtsi                   | 30 +++++++++
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi   | 41 ++++++++++++
 arch/arm/mach-shmobile/board-koelsch-reference.c | 73 ---------------------
 arch/arm/mach-shmobile/board-lager-reference.c   | 80 -----------------------
 9 files changed, 278 insertions(+), 159 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi

-- 
Regards,

Laurent Pinchart

