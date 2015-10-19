From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 19 Oct 2015 14:07:33 +0000
Subject: [PATCH/RFT 0/7] HDMI capture on Lager
Message-Id: <1445263660-6945-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This series is supposed to serve as a basis for testing the HDMI input on
the Lager board.  It is based on the series by William Towle, dropping the
patches that have since been merged, and adding the interrupt to the adv7612
DT description.

The base of this series, Laurent's "pad config allocator" patch, had been
deferred pending a retooling of the media controller framework.  I could
not, however, find significant activity in that area (read: the patch still
applies)...

With this series applied I was able to capture the top left quarter of the
output of my Raspberry Pi.  Whether this meager result is caused by the
input device, the output device, the userland software, or me, I have yet to
find out.  I suspect the latter, as I have last used VIN on Linux with an
Iomega Buz...

CU
Uli


Ian Molton (1):
  ARM: shmobile: lager dts: specify default-input for ADV7612

Laurent Pinchart (1):
  v4l: subdev: Add pad config allocator and init

Rob Taylor (1):
  media: soc_camera: soc_scale_crop: Use correct pad number in try_fmt

William Towle (4):
  media: soc_camera pad-aware driver initialisation
  media: rcar_vin: Use correct pad number in try_fmt
  ARM: shmobile: lager dts: Add entries for VIN HDMI input support
  media: adv7604: automatic "default-input" selection

 arch/arm/boot/dts/r8a7790-lager.dts                | 41 +++++++++++++++++++++-
 drivers/media/i2c/adv7604.c                        | 25 +++++++++----
 drivers/media/platform/soc_camera/Kconfig          |  1 +
 drivers/media/platform/soc_camera/rcar_vin.c       | 18 +++++++---
 drivers/media/platform/soc_camera/soc_camera.c     | 20 ++++++++++-
 drivers/media/platform/soc_camera/soc_scale_crop.c |  1 +
 drivers/media/v4l2-core/v4l2-subdev.c              | 19 +++++++++-
 include/media/soc_camera.h                         |  1 +
 include/media/v4l2-subdev.h                        | 10 ++++++
 9 files changed, 121 insertions(+), 15 deletions(-)

-- 
2.6.1

