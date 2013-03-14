From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 14 Mar 2013 14:35:43 +0000
Subject: [PATCH v2 0/3] R-Car Display Unit DRM driver
Message-Id: <1363271746-9806-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>

Hello,

Here's the second version of the Renesas R-Car Display Unit (DU) DRM driver.

The DU features two superposition processors (modeled as CRTCs) and eight
planes that can be shared between the superposition processors.

The driver supports the superposition processors, all eight planes and all
hardware supported formats except 8-bit indexed color mode and 32-bit RGB666
mode (that would be [31:0] x:R:x:G:x:B:x 8:6:2:6:2:6:2 little endian, not
supported by DRM at the moment).

On the output side only sync master non-interlaced modes are currently
supported. Both the VGA and the LVDS outputs have been tested.

Platform data are subject to change with the common display framework. This is
why I haven't implemented DT bindings yet.

Changes since v1:

 - Use drm_encoder_cleanup() directly as .destroy handlers
 - Enable alpha blending support
 - Don't re-reserve hardware plane at each update
 - Fix planes allocation for multiplanar formats
 - Add DRM PRIME support
 - Fix race condition between page flip request and handler
 - Add configurable z-order support for planes
 - Support configurable color keying for planes
 - Update plane format after releasing hardware planes
 - Fix register access for global registers
 - Fix plane index wrap-around for multi-planar overlays

Please note that this version depends on the GEM CMA DRM PRIME patches I have
previously sent to the dri-devel mailing list.

I've included necessary arch/ modifications to allow easy testing. The r8a7779
clock patch should already be on its way to mainline, the Marzen board code
will be resubmitted separately through the ARM tree after the DU driver gets
pulled in the DRM tree.

Laurent Pinchart (2):
  drm: Renesas R-Car Display Unit DRM driver
  ARM: shmobile: marzen: Add Display Unit support

Phil Edworthy (1):
  r8a7779: Add Display Unit clock support

 arch/arm/configs/marzen_defconfig       |   2 +
 arch/arm/mach-shmobile/board-marzen.c   |  65 +++++
 arch/arm/mach-shmobile/clock-r8a7779.c  |   4 +-
 drivers/gpu/drm/Kconfig                 |   2 +
 drivers/gpu/drm/Makefile                |   1 +
 drivers/gpu/drm/rcar-du/Kconfig         |   9 +
 drivers/gpu/drm/rcar-du/Makefile        |   8 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 499 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h  |  48 +++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 270 +++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   |  59 ++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 163 +++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.h   |  33 +++
 drivers/gpu/drm/rcar-du/rcar_du_lvds.c  | 242 ++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_lvds.h  |  25 ++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 444 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  61 ++++
 drivers/gpu/drm/rcar-du/rcar_du_regs.h  | 443 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vga.c   | 188 ++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vga.h   |  24 ++
 include/linux/platform_data/rcar-du.h   |  51 ++++
 21 files changed, 2640 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/rcar-du/Kconfig
 create mode 100644 drivers/gpu/drm/rcar-du/Makefile
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_crtc.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_crtc.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_drv.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_drv.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvds.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvds.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_plane.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_plane.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_regs.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vga.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vga.h
 create mode 100644 include/linux/platform_data/rcar-du.h

-- 
Regards,

Laurent Pinchart

