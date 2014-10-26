From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 15:24:19 +0000
Subject: [PATCH v3 0/9] Renesas R-Car DU HDMI support
Message-Id: <1414337068-28664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org

Hello,

This patch set adds support for the HDMI output port present on the Renesas
Koelsch board. Doing so requires two components, a driver for the external
ADV7511W HDMI encoder, and support for HDMI encoders in the DU driver.

The HDMI encoder drivers uses the DRM slave encoder framework and the
component framework to communicate with the DU driver. The DT bindings are
based on the OF graph bindings to link the display controller and encoder.

The R-Car DU patches start with a bit of refactoring, to finally add HDMI
support in patch 5/9

The new adv7511 driver (patch 8/9) depends on decoupling EDID parsing from the
DDC I2C adapter (patch 6/9). It supports DT instantiation only (bindings are
documented in patch 7/9) for now. Platform data support could be added later
if needed. The code is based on Lars-Peter Clausen's adv7511 driver, with
heavy modifications.

The last patch instantiates the HDMI encoder in the Koelsch board DT file and
connects it to the DU output.

The patch series depends on Koelsch DU DT enablement (scheduled for merge in
v3.19-rc1). Dave, I'd like to get this merged in v3.19-rc1, how would you like
to proceed ? Could it go through Simon's Renesas tree ? There's a small risk
of conflict in drivers/gpu/drm/drm_edid.c, include/drm/drm_edid.h,
drivers/gpu/drm/i2c/Kconfig and drivers/gpu/drm/i2c/Makefile. Simon, could you
alternatively provide a stable branch with the required dependencies ?

Changes since v2:

- Name arguments to get_edid_block()

Changes since v1:

- Dropped Philipp Zabel's OF graph patches (the rcar-du-drm driver will be
  udpated to use for_each_endpoint_of_node when the implementation hits
  upstream)
- adv7511: Clarify the adi,input-format DT property documentation
- adv7511: Use map array to convert input style to hardware value
- adv7511: Fixed typos

For ease of testing and review I've pushed this series and its dependencies to
a git branch on

	git://linuxtv.org/pinchartl/fbdev.git drm/du/adv7511

Cc: devicetree@vger.kernel.org
Cc: Dave Airlie <airlied@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Simon <horms@verge.net.au>

Lars-Peter Clausen (2):
  drm: Decouple EDID parsing from I2C adapter
  drm: Add adv7511 encoder driver

Laurent Pinchart (7):
  drm: rcar-du: Remove platform data support
  drm: rcar-du: Pass the encoder DT node to rcar_du_encoder_init()
  drm: rcar-du: Replace direct DRM encoder access with cast macro
  drm: rcar-du: Replace drm_encoder with drm_slave_encoder
  drm: rcar-du: Add HDMI encoder and connector support
  video: Add ADV751[13] DT bindings documentation
  ARM: shmobile: koelsch: Add DU HDMI output support

 .../devicetree/bindings/video/adi,adv7511.txt      |   88 ++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   50 +-
 drivers/gpu/drm/drm_edid.c                         |   27 +-
 drivers/gpu/drm/i2c/Kconfig                        |    6 +
 drivers/gpu/drm/i2c/Makefile                       |    2 +
 drivers/gpu/drm/i2c/adv7511.c                      | 1010 ++++++++++++++++++++
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
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   53 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |   31 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h          |    2 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h          |    1 -
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c           |    5 +-
 include/drm/drm_edid.h                             |    5 +
 include/linux/platform_data/rcar-du.h              |   74 --
 25 files changed, 1894 insertions(+), 181 deletions(-)
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

