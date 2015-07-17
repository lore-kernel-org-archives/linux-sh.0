From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 17 Jul 2015 08:26:02 +0000
Subject: [PATCH 0/5] R-Car DU: Add support for R8A7793 and R8A7794
Message-Id: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Magnus Damm <magnus.damm@gmail.com>

Hello,

This patch series adds support for the DU found in the R8A7793 and R8A7794
SoCs. It mostly consists of DT bindings updates (1/5 and 2/5) with a small
driver change in 2/5 to support fixed RGB output routing. Patches 4/5 and 5/5
then add DU nodes to the r8a7793.dtsi and r8a7794.dtsi, with patch 3/5 adding
support for the DU0 clock to r8a7794.dtsi.

I will enable DU support for the Gose and Alt board in a later step when I'll
have access to the schematics. I won't be able to test that due to lack of
hardware though.

The R8A7794 datasheet documents as single DU clock named DU0, while the DU
section documents DU0 and DU1 channels. I don't know at this point whether this
is a datasheet mistake or if the DU0 clock drives both channels. I've opted for
the latter, but I'd appreciate a confirmation.

Laurent Pinchart (5):
  drm: rcar-du: Add support for the R8A7793 DU
  drm: rcar-du: Add support for the R8A7794 DU
  ARM: shmobile: r8a7794: Add DU0 clock
  ARM: shmobile: r8a7793: Add DU node to device tree
  ARM: shmobile: r8a7794: Add DU node to device tree

 .../devicetree/bindings/video/renesas,du.txt       | 14 +++++----
 arch/arm/boot/dts/r8a7793.dtsi                     | 30 +++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi                     | 35 ++++++++++++++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 27 ++++++++++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |  5 ++--
 include/dt-bindings/clock/r8a7794-clock.h          |  1 +
 6 files changed, 101 insertions(+), 11 deletions(-)

-- 
Regards,

Laurent Pinchart

