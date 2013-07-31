From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 31 Jul 2013 13:21:44 +0000
Subject: [PATCH v2 00/23] R-Car DU DRM support for R8A7790
Message-Id: <1375276927-20181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hello,

Here's the second version of a patch set that adds support for the DU found in
the R8A7790 SoC.

Compared to the R8A7779 DU, the R8A7790 has a third CRTC, internal LVDS
encoders and different output routing options.

These patches are based on the drm-next branch are are targetted at v3.12.

Laurent Pinchart (23):
  drm/rcar-du: Add missing alpha plane register definitions
  drm/rcar-du: Use devm_ioremap_resource()
  drm/rcar-du: Add platform module device table
  drm/rcar-du: Support per-CRTC clock and IRQ
  drm/rcar-du: Clarify comment regarding plane Y source coordinate
  drm/rcar-du: Split LVDS encoder and connector
  drm/rcar-du: Split VGA encoder and connector
  drm/rcar-du: Merge LVDS and VGA encoder code
  drm/rcar-du: Rename platform data fields to match what they describe
  drm/rcar-du: Create rcar_du_planes structure
  drm/rcar-du: Rename rcar_du_plane_(init|register) to rcar_du_planes_*
  drm/rcar-du: Introduce CRTCs groups
  drm/rcar-du: Use dynamic number of CRTCs instead of CRTCs array size
  drm/rcar-du: Remove register definitions for the second channel
  drm/rcar-du: Move output routing configuration to group
  drm/rcar-du: Add support for the R8A7790 DU
  drm/rcar-du: Fix buffer pitch alignment for R8A7790 DU
  drm/rcar-du: Add support for multiple groups
  drm/rcar-du: Add support for DEFR8 register
  drm/rcar-du: Rework output routing support
  drm/rcar-du: Configure RGB output routing to DPAD0
  drm/rcar-du: Add internal LVDS encoder support
  drm/rcar-du: Add FBDEV emulation support

 drivers/gpu/drm/rcar-du/Kconfig           |   7 +
 drivers/gpu/drm/rcar-du/Makefile          |  10 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    | 255 ++++++++++++++++--------------
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h    |  13 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     | 173 +++++++++-----------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h     |  63 ++++++--
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 202 +++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h |  49 ++++++
 drivers/gpu/drm/rcar-du/rcar_du_group.c   | 187 ++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_group.h   |  50 ++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 165 +++++++++++--------
 drivers/gpu/drm/rcar-du/rcar_du_kms.h     |  29 +---
 drivers/gpu/drm/rcar-du/rcar_du_lvds.c    | 216 -------------------------
 drivers/gpu/drm/rcar-du/rcar_du_lvds.h    |  24 ---
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c | 131 +++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h |  25 +++
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c | 196 +++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h |  46 ++++++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c   | 170 ++++++++++----------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h   |  26 ++-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h    |  94 +++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_vga.c     | 149 -----------------
 drivers/gpu/drm/rcar-du/rcar_du_vga.h     |  24 ---
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  |  96 +++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.h  |  23 +++
 drivers/gpu/drm/rcar-du/rcar_lvds_regs.h  |  69 ++++++++
 include/linux/platform_data/rcar-du.h     |  34 +++-
 27 files changed, 1665 insertions(+), 861 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_encoder.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_encoder.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_group.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_group.h
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvds.c
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvds.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vga.c
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vga.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vgacon.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_lvds_regs.h

-- 
Regards,

Laurent Pinchart

