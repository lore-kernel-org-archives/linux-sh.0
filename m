From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:20 +0000
Subject: [PATCH 00/38] Renesas R-Car DU atomic updates support
Message-Id: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hello,

This patch series implements atomic updates support for the rcar-du driver.

The series starts with four core atomic helpers fixes/cleanups (two from
Daniel that I have included here for completeness). It then follows with two
fixes for the adv7511 driver and height fixes for the rcar-du driver. It
finally gets to work by slowly reworking rcar-du until atomic updates are
fully implemented and the transitional helpers gone.

The patches are based on Dave's 'next' branch and available at

	git://linuxtv.org/pinchartl/fbdev.git drm/next/atomic

The last patch contains a hardware plane allocator based solely on state
objects, which could be useful as a base implementation should other drivers
experience similar needs.

Daniel Vetter (2):
  drm/atomic-helper: Rename commmit_post/pre_planes
  drm/atomic-helpers: make mode_set hooks optional

Laurent Pinchart (36):
  drm/atomic: Rename drm_atomic_helper_commit_pre_planes() state
    argument
  drm/atomic-helpers: Fix documentation typos and wrong copy&paste
  drm: adv7511: Fix DDC error interrupt handling
  drm: adv7511: Fix nested sleep when reading EDID
  drm: rcar-du: Don't disable unused functions at init time
  drm: rcar-du: Remove drm_fbdev_cma_restore_mode() call at init time
  drm: rcar-du: Don't set connector->encoder at init time
  drm: rcar-du: Reorder CRTC functions
  drm: rcar-du: Wait for page flip completion when turning the CRTC off
  drm: rcar-du: Turn vblank on/off when enabling/disabling CRTC
  drm: rcar-du: Disable fbdev emulation when no connector is present
  drm: rcar-du: Define macros for the max number of groups, CRTCs and
    LVDS
  drm: rcar-du: Implement universal plane support
  drm: rcar-du: Fix hardware plane allocation
  drm: rcar-du: Implement planes atomic operations
  drm: rcar-du: Handle primary plane config through atomic plane ops
  drm: rcar-du: Wire up atomic state object scaffolding
  drm: rcar-du: Remove private copy of plane size and position
  drm: rcar-du: Replace LVDS encoder DPMS by enable/disable
  drm: rcar-du: Rework encoder enable/disable for atomic updates
  drm: rcar-du: Rework HDMI encoder enable/disable for atomic updates
  drm: rcar-du: Rework CRTC enable/disable for atomic updates
  drm: rcar-du: Switch plane update to atomic helpers
  drm: rcar-du: Switch mode config to atomic helpers
  drm: rcar-du: Switch connector DPMS to atomic helpers
  drm: rcar-du: Replace encoder mode_fixup with atomic_check
  drm: rcar-du: Implement asynchronous commit support
  drm: rcar-du: Switch page flip to atomic helpers
  drm: rcar-du: Switch plane set_property to atomic helpers
  drm: rcar-du: Rework plane setup code
  drm: rcar-du: Replace plane crtc and enabled fields by plane state
  drm: rcar-du: Remove unneeded rcar_du_crtc plane field
  drm: rcar-du: Move plane format to plane state
  drm: rcar-du: Move plane commit code from CRTC start to CRTC resume
  drm: rcar-du: Move group locking inside rcar_du_crtc_update_planes()
  drm: rcar-du: Fix race condition in hardware plane allocator

 drivers/gpu/drm/drm_atomic_helper.c       |  68 +++--
 drivers/gpu/drm/i2c/adv7511.c             | 102 ++++----
 drivers/gpu/drm/i915/intel_atomic.c       |   4 +-
 drivers/gpu/drm/msm/msm_atomic.c          |   4 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    | 400 +++++++++++++---------------
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h    |   8 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     |  17 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h     |  16 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  71 ++---
 drivers/gpu/drm/rcar-du/rcar_du_group.h   |   5 +
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c |   9 +-
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c |  65 +++--
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 333 ++++++++++++++++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c |   9 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c |  18 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h |   8 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c   | 419 ++++++++++++------------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h   |  69 +++--
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  |   9 +-
 include/drm/drm_atomic_helper.h           |   6 +-
 include/drm/drm_crtc_helper.h             |   3 +-
 21 files changed, 924 insertions(+), 719 deletions(-)

-- 
Regards,

Laurent Pinchart

