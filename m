From: Simon Horman <horms@verge.net.au>
Date: Thu, 31 Jan 2013 06:38:38 +0000
Subject: Re: [PATCH 0/3] R-Car Display Unit DRM driver
Message-Id: <20130131063838.GC24518@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com

On Thu, Jan 31, 2013 at 02:45:00AM +0100, Laurent Pinchart wrote:
> Hello,
> 
> Here's a new DRM driver for the Renesas R-Car Display Unit (DU).
> 
> The DU features two superposition processors (modeled as CRTCs) and eight
> planes that can be shared between the superposition processors.
> 
> The driver supports the superposition processors (currently in pure overlay
> mode without alpha blending), all eight planes and all hardware supported
> formats except 8-bit indexed color more and 32-bit RGB666 mode (that would be
> [31:0] x:R:x:G:x:B:x 8:6:2:6:2:6:2 little endian, not supported by DRM at the
> moment).
> 
> On the output side only sync master non-interlaced modes are currently
> supported. Only the VGA output has been tested, as I lack an LVDS panel for
> the development board. The second CRTC hasn't been tested for the same reason.
> 
> Platform data are subject to change with the common display framework. This is
> why I haven't implemented DT bindings yet.
> 
> Laurent Pinchart (2):
>   drm: Renesas R-Car Display Unit DRM driver
>   ARM: shmobile: marzen: Add Display Unit support

I assume that the above patch is dependent on the other two patches in the
series. If so please let me know how you would like to handle the merge.

> Phil Edworthy (1):
>   r8a7779: Add Display Unit clock support

As per my email response to the above patch I have queued this up,
but it can be de-queued if appropriate.

> 
>  arch/arm/mach-shmobile/board-marzen.c   |  65 +++++
>  arch/arm/mach-shmobile/clock-r8a7779.c  |   4 +-
>  drivers/gpu/drm/Kconfig                 |   2 +
>  drivers/gpu/drm/Makefile                |   1 +
>  drivers/gpu/drm/rcar-du/Kconfig         |  11 +
>  drivers/gpu/drm/rcar-du/Makefile        |   8 +
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 471 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h  |  47 ++++
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 265 ++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h   |  56 ++++
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 163 +++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_kms.h   |  34 +++
>  drivers/gpu/drm/rcar-du/rcar_du_lvds.c  | 247 +++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_lvds.h  |  25 ++
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 299 ++++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_plane.h |  58 ++++
>  drivers/gpu/drm/rcar-du/rcar_du_regs.h  | 439 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_vga.c   | 193 +++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_vga.h   |  24 ++
>  include/linux/platform_data/rcar-du.h   |  51 ++++
>  20 files changed, 2462 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/rcar-du/Kconfig
>  create mode 100644 drivers/gpu/drm/rcar-du/Makefile
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_crtc.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_crtc.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_drv.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_drv.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvds.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvds.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_plane.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_plane.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_regs.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vga.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vga.h
>  create mode 100644 include/linux/platform_data/rcar-du.h
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
