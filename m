From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 26 Jun 2013 14:40:49 +0000
Subject: [PATCH v3 0/7] ARM: shmobile: shdma DT on sh73a0 and r8a7740
Message-Id: <1372257656-9944-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Vinod Koul <vinod.koul@intel.com>

Recently shdma acquired DT support with a possibility to place multiple 
compatible DMAC instances under a common DMA multiplexer DT node. This is 
used to provide DMA support on r8a7740 / armadillo800eva. However there 
are also SoCs with a single DMAC instance. We could still put it under a 
(dummy) multiplexer DT node, or we can add support for such configurations 
to the shdma driver and simplify DTs on such SoCs. Patch 1 in this 
series adds support for such top-level DMAC DT nodes to shdma, which is 
then used on sh73a0. This is why patches 1-3 are marked "RFC," if it is 
preferred to not add this complexity to the driver and use a dummy DMA 
multiplexer instead, patch 1 shall be dropped and patches 2 and 3 would 
have to be reworked.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>

Guennadi Liakhovetski (7):
  DMA: shdma: also support single top-level DMAC DT nodes
  ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
  ARM: shmobile: kzm9g-reference: add DMA channels to the MMCIF DT
  ARM: shmobile: r8a7740: add MMCIF DMA definitions
  ARM: shmobile: r8a7740: add DT nodes for three DMAC instance
  ARM: shmobile: add SDHI and MMCIF interfaces to
    armadillo800eva-reference
  ARM: shmobile: armadillo800eva-reference: add DMA support for MMCIF
    and SDHI

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   30 ++++++-
 arch/arm/boot/dts/r8a7740.dtsi                     |   95 ++++++++++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |    3 +
 arch/arm/boot/dts/sh73a0.dtsi                      |   36 ++++++++
 .../board-armadillo800eva-reference.c              |   36 +++++++-
 arch/arm/mach-shmobile/include/mach/r8a7740.h      |    2 +
 arch/arm/mach-shmobile/setup-r8a7740.c             |   22 +++++
 arch/arm/mach-shmobile/setup-sh73a0.c              |    4 +
 drivers/dma/sh/shdma-of.c                          |    5 +-
 drivers/dma/sh/shdma.c                             |   16 ++++
 include/linux/sh_dma.h                             |    5 +
 11 files changed, 250 insertions(+), 4 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
