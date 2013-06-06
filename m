From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:46:24 +0000
Subject: [PATCH 0/4] mmc: MMCIF & SDHI: DT DMA support
Message-Id: <1370533588-23642-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Also a re-send of four earlier submitted patches. This patch-series alone 
is not enough to support DMA in DT on these MMC host controllers, support 
in appropriate DMAC driver is added in a separate series. This, however, 
doesn't introduce a dependency, series can be applied in arbitrary order.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (4):
  mmc: sh_mmcif: add support for Device Tree DMA bindings
  mmc: sdhi/tmio: make DMA filter implementation specific
  mmc: sdhi/tmio: switch to using dmaengine_slave_config()
  mmc: sdhi/tmio: add DT DMA support

 drivers/mmc/host/sh_mmcif.c       |   29 ++++++++++++++--------
 drivers/mmc/host/sh_mobile_sdhi.c |   24 ++++++++++++------
 drivers/mmc/host/tmio_mmc_dma.c   |   48 +++++++++++++++++++++++++++----------
 include/linux/mfd/tmio.h          |    5 ++++
 4 files changed, 74 insertions(+), 32 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
