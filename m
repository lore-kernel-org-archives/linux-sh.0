From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 31 Jan 2013 01:45:00 +0000
Subject: [PATCH 0/3] R-Car Display Unit DRM driver
Message-Id: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: magnus.damm@gmail.com

Hello,

Here's a new DRM driver for the Renesas R-Car Display Unit (DU).

The DU features two superposition processors (modeled as CRTCs) and eight
planes that can be shared between the superposition processors.

The driver supports the superposition processors (currently in pure overlay
mode without alpha blending), all eight planes and all hardware supported
formats except 8-bit indexed color more and 32-bit RGB666 mode (that would be
[31:0] x:R:x:G:x:B:x 8:6:2:6:2:6:2 little endian, not supported by DRM at the
moment).

On the output side only sync master non-interlaced modes are currently
supported. Only the VGA output has been tested, as I lack an LVDS panel for
the development board. The second CRTC hasn't been tested for the same reason.

Platform data are subject to change with the common display framework. This is
why I haven't implemented DT bindings yet.

Laurent Pinchart (2):
  drm: Renesas R-Car Display Unit DRM driver
  ARM: shmobile: marzen: Add Display Unit support

Phil Edworthy (1):
  r8a7779: Add Display Unit clock support

 arch/arm/mach-shmobile/board-marzen.c   |  65 +++++
 arch/arm/mach-shmobile/clock-r8a7779.c  |   4 +-
 drivers/gpu/drm/Kconfig                 |   2 +
 drivers/gpu/drm/Makefile                |   1 +
 drivers/gpu/drm/rcar-du/Kconfig         |  11 +
 drivers/gpu/drm/rcar-du/Makefile        |   8 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 471 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h  |  47 ++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 265 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   |  56 ++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 163 +++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.h   |  34 +++
 drivers/gpu/drm/rcar-du/rcar_du_lvds.c  | 247 +++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_lvds.h  |  25 ++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 299 ++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  58 ++++
 drivers/gpu/drm/rcar-du/rcar_du_regs.h  | 439 +++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vga.c   | 193 +++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vga.h   |  24 ++
 include/linux/platform_data/rcar-du.h   |  51 ++++
 20 files changed, 2462 insertions(+), 1 deletion(-)
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

