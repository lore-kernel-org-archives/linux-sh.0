From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 15:32:35 +0000
Subject: [RFC/PATCH 0/7] Renesas R-Car DU OF support
Message-Id: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Magnus Damm <magnus.damm@gmail.com>

Hello,

This patch set adds OF support to the DU driver (1/7) and enables the DU on
the Lager (2/7 to 4/7) and Koelsch (5/7 to 7/7) platforms.

Due to the lack of standard bindings for video devices, the approach taken
here is minimalistic and aims at enabling the DU on multiplatform kernels until
more complete DT bindings get developed. The DU DT node contains core resources
only (memory, IRQ and clocks), and output configuration is passed in platform
data using OF_DEV_AUXDATA.

Laurent Pinchart (7):
  drm/rcar-du: Add OF support
  ARM: shmobile: r8a7790: Add DU node to device tree
  ARM: shmobile: lager-reference: Add DU platform data
  ARM: shmobile: lager: Enable DU device in DT
  ARM: shmobile: r8a7791: Add DU node to device tree
  ARM: shmobile: koelsch-reference: Add DU platform data
  ARM: shmobile: koelsch: Enable DU device in DT

 .../devicetree/bindings/video/renesas,du.txt       |  49 +++++++
 arch/arm/boot/dts/r8a7790-lager.dts                |  11 ++
 arch/arm/boot/dts/r8a7790.dtsi                     |  19 +++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  11 ++
 arch/arm/boot/dts/r8a7791.dtsi                     |  15 ++
 arch/arm/mach-shmobile/board-koelsch-reference.c   |  38 ++++-
 arch/arm/mach-shmobile/board-lager-reference.c     |  41 +++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 161 ++++++++++++---------
 8 files changed, 271 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/renesas,du.txt

-- 
Regards,

Laurent Pinchart

