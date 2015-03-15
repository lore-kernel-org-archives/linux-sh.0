From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 15 Mar 2015 12:55:26 +0000
Subject: [PATCH 0/3] R-Car DU fixes
Message-Id: <1426424129-20746-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hello,

Here are three patches that fix issues with the R-Car DU driver implementation
of the atomic updates API. There's not much else to be said, please see
individual patches for details.

Laurent Pinchart (3):
  drm: rcar-du: Fix framebuffer reference leak through plane state
  drm: rcar-du: Don't initialize event->pipe field
  drm: rcar-du: Enable the atomic updates API

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 2 --
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 3 ++-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart

