From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 03 Sep 2015 16:00:31 +0000
Subject: [PATCH 0/5] [media] Create pads links after entities registration
Message-Id: <1441296036-20727-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>, Javier Martinez Canillas <javier@osg.samsung.com>, devel@driverdev.osuosl.org, Sakari Ailus <sakari.ailus@iki.fi>, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org

Hello,

This series changes all the MC media drivers that are currently creating
pads links before registering the media entities with the media device.

The patches are similar to the ones posted for the OMAP3 ISP driver [0]
and depends on Mauro's "[PATCH v8 00/55] MC next generation patches" [1].

The patches just moves the entities registration logic before pads links
creation and in the case of the vsp1, split the pads links creationg from
the entities initialization logic as it was made for the OMAP3 ISP driver.

Unfortunately I don't have hardware to test these patches and they were
only build tested. So testing that I didn't introduce any regression will
be highly appreciated.

[0]: https://lkml.org/lkml/2015/8/26/453
[1]: http://www.spinics.net/lists/linux-samsung-soc/msg47089.html

Best regards,
Javier


Javier Martinez Canillas (5):
  [media] staging: omap4iss: separate links creation from entities init
  [media] v4l: vsp1: create pad links after subdev registration
  [media] v4l: vsp1: separate links creation from entities init
  [media] uvcvideo: create pad links after subdev registration
  [media] smiapp: create pad links after subdev registration

 drivers/media/i2c/smiapp/smiapp-core.c       |  20 +++---
 drivers/media/platform/vsp1/vsp1_drv.c       |  30 +++++---
 drivers/media/platform/vsp1/vsp1_rpf.c       |  29 +++++---
 drivers/media/platform/vsp1/vsp1_rwpf.h      |   5 ++
 drivers/media/platform/vsp1/vsp1_wpf.c       |  40 +++++++----
 drivers/media/usb/uvc/uvc_entity.c           |  16 +++--
 drivers/staging/media/omap4iss/iss.c         | 101 ++++++++++++++++++---------
 drivers/staging/media/omap4iss/iss_csi2.c    |  35 +++++++---
 drivers/staging/media/omap4iss/iss_csi2.h    |   1 +
 drivers/staging/media/omap4iss/iss_ipipeif.c |  29 ++++----
 drivers/staging/media/omap4iss/iss_ipipeif.h |   1 +
 drivers/staging/media/omap4iss/iss_resizer.c |  29 ++++----
 drivers/staging/media/omap4iss/iss_resizer.h |   1 +
 13 files changed, 224 insertions(+), 113 deletions(-)

-- 
2.4.3

