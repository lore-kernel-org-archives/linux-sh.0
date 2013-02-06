From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 06 Feb 2013 19:46:47 +0000
Subject: [PATCH v3 00/13] mmc: core and driver DT and related development
Message-Id: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This is v3 of my mmc DT patchset with several patches updated and two
patches, previously sent separately, now integrated into the series.

Guennadi Liakhovetski (13):
  mmc: sdhi, tmio: only check flags in tmio-mmc driver proper
  mmc: detailed definition of CD and WP MMC line polarities in DT
  mmc: provide a standard MMC device-tree binding parser centrally
  mmc: (cosmetic) remove "extern" from function declarations
  mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
  mmc: tmio-mmc: define device-tree bindings
  mmc: tmio-mmc: parse device-tree bindings
  mmc: sh_mobile_sdhi: remove unused .pdata field
  mmc: sh_mobile_sdhi: use managed resource allocations
  mmc: tmio: remove unused and deprecated symbols
  mmc: tmio: add support for the VccQ regulator
  mmc: add DT bindings for more MMC capability flags
  mmc: tmio: add barriers to IO operations

 Documentation/devicetree/bindings/mmc/mmc.txt      |   47 +++++++++-
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   15 +++
 drivers/mmc/core/host.c                            |  103 ++++++++++++++++++++
 drivers/mmc/host/sh_mmcif.c                        |    3 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |   64 +++---------
 drivers/mmc/host/tmio_mmc.h                        |   18 ++--
 drivers/mmc/host/tmio_mmc_pio.c                    |   83 ++++++++++++++---
 include/linux/mfd/tmio.h                           |   18 ----
 include/linux/mmc/host.h                           |   23 +++--
 include/linux/mmc/sh_mobile_sdhi.h                 |    2 -
 10 files changed, 273 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
