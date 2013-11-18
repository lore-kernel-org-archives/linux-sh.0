From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Nov 2013 08:23:11 +0000
Subject: Re: [PATCH 0/5] R-Car DU fixes and support for R8A7791
Message-Id: <20131118082309.GB1506@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Laurent,

I am wondering if you have any patches to wire up this driver
for the Koelsch board so that I might test it.

On Wed, Nov 13, 2013 at 02:52:10PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> This patch series adds support for the DU found in the R8A7791 SoC. It starts
> by a cleanup patch (1/5), a bug fix (2/5), two preparation patches (3/5 and
> 4/5) and finally adds support for the R8A7791 DU (5/5).
> 
> Patch 2/5 is a candidate for stable kernels. There's no rush to get this
> upstreamed in v3.13, v3.14 is fine.
> 
> The series is based on top of the latest drm-next branch.
> 
> Laurent Pinchart (5):
>   drm/rcar-du: Don't cast crtc to rcrtc twice in the same function
>   drm/rcar-du: Update plane pitch in .mode_set_base() operation
>   drm/rcar-du: Split features and quirks
>   drm/rcar-du: Add LVDS_LANES quirk
>   drm/rcar-du: Add support for the r8a7791 DU
> 
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c    |  3 +--
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c     | 24 ++++++++++++++++++++++--
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h     | 14 ++++++++++++--
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c     |  4 ++--
>  drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c | 15 ++++++++++-----
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c   | 21 +++++++++++----------
>  6 files changed, 58 insertions(+), 23 deletions(-)
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
