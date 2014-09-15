From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Sep 2014 09:09:55 +0000
Subject: [GIT PULL FOR v3.18] Renesas DRM changes
Message-Id: <4992932.9rhSoL2QsX@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>, Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org

Hi Dave,

Could you please pull the following changes for v3.18 ?

Commit "drm/rcar-du: Use struct videomode in platform data" touches board code 
in arch/arm/mach-shmobile. There is, to the best of my knowledge, no risk of 
conflict for v3.18. Simon, are you fine with getting those changes merged 
through Dave's tree (and could you confirm that no conflict should occur) ?

The following changes since commit 98faa78ce7f1f986e11e7805d31b409782a6d2d4:

  Merge tag 'topic/drm-header-rework-2014-09-12' of 
git://anongit.freedesktop.org/drm-intel into drm-next (2014-09-13 07:01:49 
+1000)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git drm/next/du

for you to fetch changes up to 96c026911890ceacee238da00a0b140ad634cc43:

  drm/rcar-du: Add OF support (2014-09-15 11:55:47 +0300)

----------------------------------------------------------------
Laurent Pinchart (10):
      drm/rcar-du: Update copyright notice
      drm/shmob: Update copyright notice
      devicetree: Add vendor prefix "mitsubishi" to vendor-prefixes.txt
      devicetree: Add vendor prefix "thine" to vendor-prefixes.txt
      video: Add DT binding documentation for VGA connector
      video: Add ADV7123 DT bindings documentation
      video: Add THC63LVDM83D DT bindings documentation
      video: Add DT bindings for the R-Car Display Unit
      drm/rcar-du: Use struct videomode in platform data
      drm/rcar-du: Add OF support

 Documentation/devicetree/bindings/vendor-prefixes.txt   |   2 +
 Documentation/devicetree/bindings/video/adi,adv7123.txt |  50 +++++
 Documentation/devicetree/bindings/video/renesas,du.txt  |  84 +++++++++
 .../devicetree/bindings/video/thine,thc63lvdm83d        |  50 +++++
 .../devicetree/bindings/video/vga-connector.txt         |  36 ++++
 arch/arm/mach-shmobile/board-koelsch-reference.c        |  19 +-
 arch/arm/mach-shmobile/board-koelsch.c                  |  19 +-
 arch/arm/mach-shmobile/board-lager-reference.c          |  19 +-
 arch/arm/mach-shmobile/board-lager.c                    |  19 +-
 arch/arm/mach-shmobile/board-marzen.c                   |  19 +-
 drivers/gpu/drm/rcar-du/Kconfig                         |   1 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c                  |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h                  |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c                   | 172 ++++++++-------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h                   |   4 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c               |  13 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h               |   5 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c                 |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.h                 |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c                   | 233 +++++++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_kms.h                   |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c               |  45 +++--
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h               |   5 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c               |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h               |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c                 |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.h                 |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c                |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.h                |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_backlight.c          |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_backlight.h          |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c               |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h               |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c                |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.h                |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.c                |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.h                |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_plane.c              |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_plane.h              |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_regs.h               |   2 +-
 include/linux/platform_data/rcar-du.h                   |   4 +-
 41 files changed, 645 insertions(+), 198 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/adi,adv7123.txt
 create mode 100644 Documentation/devicetree/bindings/video/renesas,du.txt
 create mode 100644 Documentation/devicetree/bindings/video/thine,thc63lvdm83d
 create mode 100644 Documentation/devicetree/bindings/video/vga-connector.txt

-- 
Regards,

Laurent Pinchart

