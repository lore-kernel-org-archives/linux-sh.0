From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:50:47 +0000
Subject: [PATCH 00/22] R-Car DU: Add Gen3 support
Message-Id: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hello,

This patch series adds support for the Display Unit found in the R-Car Gen3
SoC series.

The third generation differs significantly from the previous ones in that the
DU has lost its ability to source data from memory. It must instead use an
external hardware composer named VSP to read planes from memory and blend
them.

The VSP has a V4L2 driver in mainline that can be used in conjunction with the
DU through the live sources API (submitted previously as an RFC). However, as
VSP usage is mandatory in Gen3 and as no native DU planes are available, we
have decided that forcing userspace to use both KMS and V4L2 to display any
content wouldn't be very friendly. Instead the VSP driver has been extended to
make the device directly controllable by the DU driver ([1]) and this patch
series builds on top of it.

[1] http://www.spinics.net/lists/linux-media/msg93575.html

Koji Matsuoka (4):
  drm: rcar-du: Fix compile warning on 64-bit platforms
  drm: rcar-du: Enable compilation on ARM64
  drm: rcar-du: Support up to 4 CRTCs
  drm: rcar-du: lvds: Add R-Car Gen3 support

Laurent Pinchart (18):
  drm: rcar-du: Don't update planes on disabled CRTCs
  drm: rcar-du: Add support for the R8A7793 DU
  drm: rcar-du: Add support for the R8A7794 DU
  drm: rcar-du: Compute plane DDCR4 register value directly
  drm: rcar-du: Refactor plane setup
  drm: rcar-du: Add VSP1 support to the planes allocator
  drm: rcar-du: Add VSP1 compositor support
  drm: rcar-du: Restart the DU group when a plane source changes
  drm: rcar-du: Move plane allocator to rcar_du_plane.c
  drm: rcar-du: Expose the VSP1 compositor through KMS planes
  drm: rcar-du: Use the VSP atomic update API
  drm: rcar-du: Drop LVDS double dependency on OF
  drm: rcar-du: Output the DISP signal on the DISP pin
  drm: rcar-du: Output the DISP signal on the ODDF pin
  drm: rcar-du: Add R8A7795 device support
  drm: rcar-du: lvds: Avoid duplication of clock clamp code
  drm: rcar-du: lvds: Fix PLL frequency-related configuration
  drm: rcar-du: lvds: Rename PLLEN bit to PLLON

 .../devicetree/bindings/video/renesas,du.txt       |  22 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |  15 +-
 drivers/gpu/drm/rcar-du/Makefile                   |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |  63 ++-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  58 ++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |  12 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   6 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |  73 +++-
 drivers/gpu/drm/rcar-du/rcar_du_group.h            |   4 +
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c          |   7 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              | 273 ++----------
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c          | 142 +++++--
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h          |   6 +
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            | 465 ++++++++++++++++++---
 drivers/gpu/drm/rcar-du/rcar_du_plane.h            |  21 +-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h             |  21 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              | 373 +++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h              |  76 ++++
 drivers/gpu/drm/rcar-du/rcar_lvds_regs.h           |  26 +-
 20 files changed, 1263 insertions(+), 404 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vsp.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vsp.h

-- 
Regards,

Laurent Pinchart

