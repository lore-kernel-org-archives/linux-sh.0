From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 16 Jan 2015 15:37:04 +0000
Subject: Re: [GIT PULL FOR v3.20] R-Car DU fixes and enhancements
Message-Id: <4486086.1ppABuDUDI@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2195818.kbPWsnQAkp@avalon>
In-Reply-To: <2195818.kbPWsnQAkp@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Dave,

Ping ?

On Tuesday 23 December 2014 12:03:34 Laurent Pinchart wrote:
> Hi Dave,
> 
> The following changes since commit 4e0cd68115620bc3236ff4e58e4c073948629b41:
> 
>   drm: sti: fix module compilation issue (2014-12-15 17:07:57 +1000)
> 
> are available in the git repository at:
> 
>   git://linuxtv.org/pinchartl/fbdev.git drm/next/du
> 
> for you to fetch changes up to 906eff7fcada4186cde54eb89572fb774ab294a0:
> 
>   drm: rcar-du: Implement support for interlaced modes (2014-12-23 12:01:52
> +0200)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (10):
>       drm: adv7511: Remove interlaced mode check
>       drm: rcar-du: Don't fail probe in case of partial encoder init error
>       drm: rcar-du: Configure pitch for chroma plane of multiplanar formats
>       drm: rcar-du: Remove LVDS and HDMI encoders chaining restriction
>       drm: rcar-du: Refactor DEFR8 feature
>       drm: rcar-du: Add support for external pixel clock
>       drm: rcar-du: Output HSYNC instead of CSYNC
>       drm: rcar-du: Enable hotplug detection on HDMI connector
>       drm: rcar-du: Clamp DPMS states to on and off
>       drm: rcar-du: Implement support for interlaced modes
> 
>  Documentation/devicetree/bindings/video/renesas,du.txt |  4 ++
>  drivers/gpu/drm/i2c/adv7511.c                          |  3 -
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c                 | 95 +++++++++++----
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h                 |  1 +
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c                  |  6 +-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h                  |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c              | 34 +++++----
>  drivers/gpu/drm/rcar-du/rcar_du_group.c                | 21 ++++--
>  drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c              |  2 +
>  drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c              | 18 +++++
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c                  | 15 +++-
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c                | 20 +++++-
>  drivers/gpu/drm/rcar-du/rcar_du_regs.h                 |  5 +-
>  drivers/gpu/drm/rcar-du/rcar_du_vgacon.c               |  1 +
>  14 files changed, 180 insertions(+), 47 deletions(-)

-- 
Regards,

Laurent Pinchart

