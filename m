From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:34 +0000
Subject: [RFC 00/10] Lager HDMI support
Message-Id: <1377866264-21110-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is an attempt to enable the HDMI output on the Lager board. It is not
likely to work as is because I do not have physical access to such a board
yet, but it builds and runs, and the devices involved (i2c controller, DU,
HDMI encoder) respond as expected.

This work depends on two unmerged drivers (r8a7790 i2c controller and
ADV7511 HDMI encoder) that I have included in this patch set.

It appears that the DRM i2c slave code assumes that video encoders are
always connected to a local dedicated i2c controller that is instantiated by
the GPU driver.  This is not so on the Lager board which has the HDMI
encoder on a general-purpose i2c bus together with other devices.  This
makes it difficult for the DU driver to get an i2c_client handle to the
encoder.  I have solved this by forwarding the handle from the adv7511
driver to the DU driver via their platform_data structures.  I'd like to
hear if there is a more elegant/correct way to deal with this.  (There is
for DT, but this is the best C version I could come up with.)

The other question I have is what would be a viable strategy to get this
whole mess upstream, particularly the adv7511 driver which requires changes
to common DRM code...

CU
Uli

Lars-Peter Clausen (1):
  ASoC: Add SPDIF DAI format

Nguyen Viet Dung (3):
  i2c: rcar: modify I2C driver
  ARM: shmobile: r8a7790: add I2C setup
  ARM: shmobile: r8a7790: add I2C clock

Ulrich Hecht (6):
  drm: ADV7511 i2c HDMI encoder driver
  drm: Decouple edid parsing from i2c adapter
  ARM: shmobile: r8a7790: i2c pinmux
  ARM: shmobile: r8a7790: lager: i2c support
  drm: rcar-du: support for i2c HDMI encoders
  ARM: shmobile: r8a7790: lager: HDMI output via DU and ADV7511

 arch/arm/mach-shmobile/board-lager.c          |  56 ++
 arch/arm/mach-shmobile/clock-r8a7790.c        |  11 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h |   3 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |  28 +
 drivers/gpu/drm/Kconfig                       |   6 +
 drivers/gpu/drm/drm_edid.c                    |  18 +-
 drivers/gpu/drm/i2c/Makefile                  |   3 +
 drivers/gpu/drm/i2c/adv7511.h                 | 455 ++++++++++++
 drivers/gpu/drm/i2c/adv7511_audio.c           | 304 ++++++++
 drivers/gpu/drm/i2c/adv7511_core.c            | 981 ++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/Makefile              |   1 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |   7 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.h         |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c     |  56 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h     |   6 +-
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c     | 165 +++++
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h     |  28 +
 drivers/i2c/busses/i2c-rcar.c                 |  17 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c          |  90 +++
 include/drm/drm_edid.h                        |   3 +
 include/linux/i2c/i2c-rcar.h                  |   4 +
 include/linux/platform_data/rcar-du.h         |   4 +
 include/sound/soc-dai.h                       |   1 +
 23 files changed, 2236 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/i2c/adv7511.h
 create mode 100644 drivers/gpu/drm/i2c/adv7511_audio.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511_core.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h

-- 
1.8.1.4

