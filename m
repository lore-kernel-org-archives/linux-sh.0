From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 11:46:38 +0000
Subject: [WIP 0/7] Koelsch HDMI output support
Message-Id: <1396439205-26199-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This work in progress patch series adds support for the HDMI output on the
Koelsch board. I'm not happy with the result yet, but as several people are
eager to test HDMI output on Koelsch, I've decided to already provide the
patches, with a 'WIP' status.

Points that still need to be fixed before submitting patches for inclusion in
mainline are:

- Document (and probably rework) the ADV7511 DT bindings
- Use a proper abstraction API instead of drm_slave_encoder
- Use the component framework for asynchronous probing
- Go full DT on the DU side

The patches are based on top of the latest devel branch from Simon's tree,
plus a mix of patches that I've have previously submitted to the mailing list.
For convenience I've pushed the result to

	git://linuxtv.org/pinchartl/fbdev.git drm/du/adv7511

Please note that the branch will be rebased during development.

Lars-Peter Clausen (2):
  drm: Decouple EDID parsing from I2C adapter
  DRM: Add adv7511 encoder driver

Laurent Pinchart (5):
  drm/rcar-du: Replace direct DRM encoder access with cast macro
  drm/rcar-du: Replace drm_encoder with drm_slave_encoder
  drm/rcar-du: Add HDMI encoder and connector support
  ARM: shmobile: koelsch: Add DISP pin group to the DU pins
  ARM: shmobile: koelsch-reference: Add DU HDMI output support

 arch/arm/boot/dts/r8a7791-koelsch.dts            |  18 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c |   4 +
 drivers/gpu/drm/drm_edid.c                       |  24 +-
 drivers/gpu/drm/i2c/Kconfig                      |   6 +
 drivers/gpu/drm/i2c/Makefile                     |   3 +
 drivers/gpu/drm/i2c/adv7511_drv.c                | 995 +++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/Kconfig                  |  11 +-
 drivers/gpu/drm/rcar-du/Makefile                 |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c        |  34 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h        |   9 +-
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c        | 118 +++
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h        |  31 +
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c        | 157 ++++
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h        |  34 +
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c        |   5 +-
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c         |   5 +-
 include/drm/drm_edid.h                           |   4 +
 include/drm/i2c/adv7511.h                        | 456 +++++++++++
 include/linux/platform_data/rcar-du.h            |   5 +
 19 files changed, 1894 insertions(+), 27 deletions(-)
 create mode 100644 drivers/gpu/drm/i2c/adv7511_drv.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h
 create mode 100644 include/drm/i2c/adv7511.h

-- 
Regards,

Laurent Pinchart

