From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 May 2015 15:01:53 +0000
Subject: [PATCH 0/3] R-Car DU fixes
Message-Id: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Cao Minh Hiep <cm-hiep@jinso.co.jp>, linux-sh@vger.kernel.org

Hello,

This patch set fixes a crash in the R-Car DU driver (1/3) and adds two other
small cleanups (2/3 and 3/3). Please see individual patches for details.

Laurent Pinchart (3):
  drm: rcar-du: Fix crash with groups that have less than 9 planes
  drm: rcar-du: Clarify error message when encoder initialization fails
  drm: rcar-du: Convert rcar_du_encoders_init_one() return value to 0/<0

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_group.h |  2 ++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 22 ++++++++++++++--------
 drivers/gpu/drm/rcar-du/rcar_du_plane.c |  5 ++---
 4 files changed, 20 insertions(+), 13 deletions(-)

-- 
Regards,

Laurent Pinchart

