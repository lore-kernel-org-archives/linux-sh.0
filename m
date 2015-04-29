From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 00:37:54 +0000
Subject: [PATCH 00/10] R-Car DU: Fix flicker due to hardware plane reassociations
Message-Id: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hello,

This patch set attempts to get rid of flicker caused by hardware plane
reassociations.

The 8 DU hardware planes are shared by two CRTCs and can be associated with
any of them. However, when association needs to change, for instance because
a currently unused planes that was associated with the first CRTC is getting
used by the second CRTC, the hardware architecture requires both CRTCs to be
restarted, causing flicker on both CRTCs.

To mitigate the problem this patch set avoids changing associations when a
plane is being disabled (07/10), teach the plane allocator to allocate
preferably from free planes already associated with the right CRTC (08/10) and
creates a split 4/4 pre-associations of planes to CRTCs (10/10). The other
patches include a bit of refactoring to make this possible (01/10 to 05/10 and
09/10) and handy debugging (06/10).

Flicker still occurs on the other CRTC when a CRTC in the group is enabled,
but this seems unrelated to plane associations. I'll investigate it
separately.

Laurent Pinchart (10):
  drm: rcar-du: Document the rcar_du_crtc structure
  drm: rcar-du: Document the rcar_du_plane_state structure
  drm: rcar-du: Move properties from rcar_du_planes to rcar_du_device
  drm: rcar-du: Embed rcar_du_planes structure into rcar_du_group
  drm: rcar-du: Rename to_rcar_du_plane_state to to_rcar_plane_state
  drm: rcar-du: Add plane allocation debugging
  drm: rcar-du: Keep plane to CRTC associations when disabling a plane
  drm: rcar-du: Consider plane to CRTC associations in the plane
    allocator
  drm: rcar-du: Store the number of CRTCs per group in the group
    structure
  drm: rcar-du: Split planes pre-association 4/4 between CRTCs

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  61 ++++++++++---------
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h  |  14 +++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   |   6 ++
 drivers/gpu/drm/rcar-du/rcar_du_group.c |   6 ++
 drivers/gpu/drm/rcar-du/rcar_du_group.h |   8 ++-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 105 +++++++++++++++++++++++++++++---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c |  71 +++++++--------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  21 ++++---
 8 files changed, 195 insertions(+), 97 deletions(-)

-- 
Regards,

Laurent Pinchart

