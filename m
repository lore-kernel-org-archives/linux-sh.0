From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:19 +0000
Subject: [PATCH 00/14] V4L2 DT support
Message-Id: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

The last version of the V4L2 DT binding RFC only raised some cosmetic
improvement suggestions, which are addressed in the respective patch in this
series.

The rest of patches add a simple V4L2 DT parser for common properties, and an
implementation for soc-camera, the sh_mobile_ceu_camera host driver and the
mt9t112 camera sensor driver. This has been tested on an sh7372 SoC based
mackerel board, using a dummy I2C driver to simulate a proper one (the onboard
sensor has no driver and simply continuously produces video frames in a fixed
format). Only patches 4 and 5 are actually core V4L2 changes.

Some comments:

1. generic clock framework support is needed for a proper V4L2 DT
implementation. For now patch 6/14 exports an soc-camera specific function to
attach and detach a client to / from a host. Yes, I know this is bad from
several PoVs, and has to be fixed. If we don't want to depend on the clock
framework progress, we could implement V4L2 generic functions to do the same
until clocks become available.

2. the two driver-specific DT properties in patch 13/14 are just an RFC and
can be modified / discussed.

Thanks
Guennadi

Guennadi Liakhovetski (14):
  i2c: add dummy inline functions for when CONFIG_OF_I2C(_MODULE) isn't
    defined
  of: add a dummy inline function for when CONFIG_OF is not defined
  OF: make a function pointer argument const
  media: add V4L2 DT binding documentation
  media: add a V4L2 OF parser
  media: soc-camera: prepare for asynchronous client probing
  media: soc-camera: support deferred probing of clients
  media: soc-camera: use managed devm_regulator_bulk_get()
  media: mt9t112: support deferred probing
  media: soc-camera: support OF cameras
  media: sh-mobile-ceu-camera: runtime PM suspending doesn't have to be
    synchronous
  media: sh-mobile-ceu-camera: add primitive OF support
  media: sh-mobile-ceu-driver: support max width and height in DT
  media: sh_mobile_ceu_camera: support all standard V4L2 DT properties

 Documentation/devicetree/bindings/media/v4l2.txt   |  162 +++++
 drivers/media/i2c/soc_camera/mt9t112.c             |   18 +-
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |  177 ++++--
 drivers/media/platform/soc_camera/soc_camera.c     |  650 +++++++++++++++++---
 drivers/media/v4l2-core/Makefile                   |    3 +
 drivers/media/v4l2-core/v4l2-of.c                  |  190 ++++++
 drivers/of/base.c                                  |    4 +-
 include/linux/of.h                                 |   11 +-
 include/linux/of_i2c.h                             |   12 +
 include/media/soc_camera.h                         |   10 +
 include/media/v4l2-of.h                            |   62 ++
 11 files changed, 1153 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/v4l2.txt
 create mode 100644 drivers/media/v4l2-core/v4l2-of.c
 create mode 100644 include/media/v4l2-of.h

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
