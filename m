From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Sep 2014 20:04:20 +0000
Subject: [PATCH 00/12] Renesas R-Car DU HDMI support
Message-Id: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org

Hello,

This patch set adds support for the HDMI output port present on the Renesas
Koelsch board. Doing so requires two components, a driver for the external
ADV7511W HDMI encoder, and support for HDMI encoders in the DU driver.

The HDMI encoder drivers uses the DRM slave encoder framework and the
component framework to communicate with the DU driver. The DT bindings are
based on the OF graph bindings to link the display controller and encoder.

The first two patches have been taken from Philipp Zabel's "[PATCH v3 0/8]
Add of-graph helpers to loop over endpoints and find ports by id" series.
Philipp, I don't see that series in linux-next, what's the merge status ?

The R-Car DU patches start with a bit of refactoring, to finally add HDMI
support in patch 08/12.

The new adv7511 driver (patch 11/12) depends on decoupling EDID parsing from
the DDC I2C adapter (patch 09/12). It supports DT instantiation only (bindings
are documented in patch 10/12) for now. Platform data support could be added
later if needed. The code is based on Lars-Peter Clausen's adv7511 driver,
with heavy modifications.

The last patch instantiates the HDMI encoder in the Koelsch board DT file and
connects it to the DU output.

The patch series depends on R-Car DU DT support (scheduled for merge in
v3.18-rc1) and on Koelsch DU DT enablement (hopefully scheduled for merge in
v3.19-rc1). For ease of testing and review I've pushed this series and its
dependencies to a git branch on

	git://linuxtv.org/pinchartl/fbdev.git drm/du/adv7511

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org

Lars-Peter Clausen (2):
  drm: Decouple EDID parsing from I2C adapter
  drm: Add adv7511 encoder driver

Laurent Pinchart (8):
  drm: rcar-du: Remove platform data support
  drm: rcar-du: Use for_each_endpoint_of_node()
  drm: rcar-du: Pass the encoder DT node to rcar_du_encoder_init()
  drm: rcar-du: Replace direct DRM encoder access with cast macro
  drm: rcar-du: Replace drm_encoder with drm_slave_encoder
  drm: rcar-du: Add HDMI encoder and connector support
  video: Add ADV751[13] DT bindings documentation
  ARM: shmobile: koelsch: Add DU HDMI output support

Philipp Zabel (2):
  of: Decrement refcount of previous endpoint in
    of_graph_get_next_endpoint
  of: Add for_each_endpoint_of_node helper macro

 .../devicetree/bindings/video/adi,adv7511.txt      |   87 ++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   50 +-
 drivers/gpu/drm/drm_edid.c                         |   26 +-
 drivers/gpu/drm/i2c/Kconfig                        |    6 +
 drivers/gpu/drm/i2c/Makefile                       |    2 +
 drivers/gpu/drm/i2c/adv7511.c                      | 1007 ++++++++++++++++++++
 drivers/gpu/drm/i2c/adv7511.h                      |  289 ++++++
 drivers/gpu/drm/rcar-du/Kconfig                    |   11 +-
 drivers/gpu/drm/rcar-du/Makefile                   |    2 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   10 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    4 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |    2 -
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   45 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |   23 +-
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c          |  118 +++
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h          |   31 +
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c          |  151 +++
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h          |   35 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   65 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |   31 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h          |    2 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h          |    1 -
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c           |    5 +-
 drivers/of/base.c                                  |    9 +-
 include/drm/drm_edid.h                             |    4 +
 include/linux/of_graph.h                           |   11 +
 include/linux/platform_data/rcar-du.h              |   74 --
 27 files changed, 1902 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/adi,adv7511.txt
 create mode 100644 drivers/gpu/drm/i2c/adv7511.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h
 delete mode 100644 include/linux/platform_data/rcar-du.h

-- 
Regards,

Laurent Pinchart

