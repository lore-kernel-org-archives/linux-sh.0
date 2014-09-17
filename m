From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 17 Sep 2014 14:11:05 +0000
Subject: [PATCH 0/8] DU DT support for Marzen, Lager and Koelsch
Message-Id: <1410963073-3176-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series enable the DU device in DT for the Marzen, Lager and Koelsch
boards (in their multiplatform implementation only).

Nothing special here, the first three patches add the DU nodes to the SoC
.dtsi files, the next two patches remove the DU platform devices from the
lager and koelsch reference board files, and the last three patches finally
enable the DU devices in the board DT files.

Please note that HDMI output isn't supported yet, another patch set will come
in the next few days.

The patches are based on top of the DU changes from the "[PATCH 00/16] R-Car
Display Unit DT bindings" series that will be merged in v3.18. This series is
thus targeted at v3.19. Fast-tracking it to v3.18 is still possible if
desired, in which case I would need to ask Dave Airlie to provide a stable
branch with the driver changes. The clock is ticking, if anyone would like DU
DT in v3.18, speak now or forever hold your peace.

I've pushed a test branch that includes all patches to

	git://linuxtv.org/pinchartl/fbdev.git drm/du/dt

Laurent Pinchart (8):
  ARM: shmobile: r8a7779: Add DU node to device tree
  ARM: shmobile: r8a7790: Add DU node to device tree
  ARM: shmobile: r8a7791: Add DU node to device tree
  ARM: shmobile: lager-reference: Remove DU platform device
  ARM: shmobile: koelsch-reference: Remove DU platform device
  ARM: shmobile: marzen: Enable DU device in DT
  ARM: shmobile: lager: Enable DU device in DT
  ARM: shmobile: koelsch: Enable DU device in DT

 arch/arm/boot/dts/r8a7779-marzen.dts             | 106 +++++++++++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                   |  24 +++++
 arch/arm/boot/dts/r8a7790-lager.dts              |  78 ++++++++++++++++-
 arch/arm/boot/dts/r8a7790.dtsi                   |  39 +++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts            |  43 ++++++++-
 arch/arm/boot/dts/r8a7791.dtsi                   |  30 +++++++
 arch/arm/mach-shmobile/board-koelsch-reference.c |  73 ----------------
 arch/arm/mach-shmobile/board-lager-reference.c   |  80 -----------------
 8 files changed, 314 insertions(+), 159 deletions(-)

-- 
Regards,

Laurent Pinchart

