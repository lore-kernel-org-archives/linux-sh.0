From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Nov 2015 04:46:41 +0000
Subject: [PATCH 0/4] VSP1: Add support for lookup tables
Message-Id: <1447649205-1560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello,

The VSP1 includes two lookup table modules, a 1D LUT and a 3D cubic lookup
table (CLU). This patch series fixes the LUT implementation and adds support
for the CLU.

The patches are based on top of

	git://linuxtv.org/media_tree.git master

and have been tested on a Koelsch board.

Laurent Pinchart (4):
  v4l: vsp1: Fix LUT format setting
  v4l: vsp1: Add Cubic Look Up Table (CLU) support
  ARM: Renesas: r8a7790: Enable CLU support in VSPS
  ARM: Renesas: r8a7791: Enable CLU support in VSPS

 .../devicetree/bindings/media/renesas,vsp1.txt     |   3 +
 arch/arm/boot/dts/r8a7790.dtsi                     |   1 +
 arch/arm/boot/dts/r8a7791.dtsi                     |   1 +
 drivers/media/platform/vsp1/Makefile               |   3 +-
 drivers/media/platform/vsp1/vsp1.h                 |   3 +
 drivers/media/platform/vsp1/vsp1_clu.c             | 288 +++++++++++++++++++++
 drivers/media/platform/vsp1/vsp1_clu.h             |  38 +++
 drivers/media/platform/vsp1/vsp1_drv.c             |  13 +
 drivers/media/platform/vsp1/vsp1_entity.c          |   1 +
 drivers/media/platform/vsp1/vsp1_entity.h          |   1 +
 drivers/media/platform/vsp1/vsp1_lut.c             |   1 +
 drivers/media/platform/vsp1/vsp1_regs.h            |   9 +
 include/uapi/linux/vsp1.h                          |  25 ++
 13 files changed, 386 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/vsp1/vsp1_clu.c
 create mode 100644 drivers/media/platform/vsp1/vsp1_clu.h

-- 
Regards,

Laurent Pinchart

