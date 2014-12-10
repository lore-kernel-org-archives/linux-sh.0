From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:00 +0000
Subject: [PATCH 00/15] R-Car DU fixes and enhancements (including interlaced support)
Message-Id: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hello,

This patch series fixes several bugs in the R-Car DU driver and adds support
for new features, namely LVDS-HDMI encoders chaining, external pixel clock and
interlaced modes.

The last 5 patches enable HDMI output in the Lager and Koelsch DT files and
add external pixel clocks to the three currently supported boards (Marzen,
Lager and Koelsch).

All DT changes except "ARM: shmobile: lager: Add DU HDMI output support" can
be merged independently of the code as there is no runtime dependency. The DT
bindings extensions to support external pixel clocks should be acked first
though.

Patch 11/15 ("ARM: shmobile: lager: Add DU HDMI output support") depends on at
least patch 02/15 ("drm: rcar-du: Don't fail probe in case of partial encoder
init error").

I plan to send a pull request for patches 01/15 to 10/15 to get them merged
through the DRM tree. At the same time I plan to send a pull request for
patches 12/15 to 15/15 to get them merged through the linux-sh tree. Unless
someone wants to get it merged first, patch 11/15 can wait for v3.21.

Laurent Pinchart (15):
  drm: adv7511: Remove interlaced mode check
  drm: rcar-du: Don't fail probe in case of partial encoder init error
  drm: rcar-du: Configure pitch for chroma plane of multiplanar formats
  drm: rcar-du: Remove LVDS and HDMI encoders chaining restriction
  drm: rcar-du: Refactor DEFR8 feature
  drm: rcar-du: Add support for external pixel clock
  drm: rcar-du: Output HSYNC instead of CSYNC
  drm: rcar-du: Enable hotplug detection on HDMI connector
  drm: rcar-du: Clamp DPMS states to on and off
  drm: rcar-du: Implement support for interlaced modes
  ARM: shmobile: lager: Add DU HDMI output support
  ARM: shmobile: koelsch: Add DU HDMI output support
  ARM: shmobile: marzen: Add DU external pixel clock to DT
  ARM: shmobile: lager: Add DU external pixel clocks to DT
  ARM: shmobile: koelsch: Add DU external pixel clocks to DT

 .../devicetree/bindings/video/renesas,du.txt       |  4 +
 arch/arm/boot/dts/r8a7779-marzen.dts               |  9 ++
 arch/arm/boot/dts/r8a7790-lager.dts                | 69 ++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 69 +++++++++++++++-
 drivers/gpu/drm/i2c/adv7511.c                      |  3 -
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             | 95 ++++++++++++++++++----
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  6 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          | 34 +++++---
 drivers/gpu/drm/rcar-du/rcar_du_group.c            | 21 ++++-
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c          |  2 +
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c          | 18 ++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              | 15 +++-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            | 20 ++++-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h             |  5 +-
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c           |  1 +
 17 files changed, 326 insertions(+), 48 deletions(-)

-- 
Regards,

Laurent Pinchart

