From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 12 Jul 2013 13:43:50 +0000
Subject: [PATCH 0/8] ARM: shmobile: move DMAC configuration data in the driver
Message-Id: <1373636638-18496-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Currently DMACs on sh-, r-mobile and r-car SoCs use platform data for 
their configuration. This doesn't work well with DT. Adding the complete 
DMAC configuration to DT wouldn't make sense either, because it would 
produce duplication, it would be difficult to define future-safe bindings, 
that wouldn't have to change with any future DMAC versions, and it is 
unneeded, because all that configuration is SoC-specific, not board- 
specific.

The best option is to move that configuration data to the driver, to be 
used, depending on the device ID. Then this data can be re-used in DT- 
and non-DT configurations.

This patch set extends the driver, adds example configuration data sets 
for 2 SoCs. One of those SoCs already had DMAC support, so, it is switched 
over. The other SoC didn't include support for DMAC yet, it is added in 
this series too. Patches 1-3 are common for DT- and non-DT cases, patches 
4 and 5 handle the "traditional" non-DT case, and patches 6-8 deal with DT.

The DMA part applies on top of my earlier shdma patch "DMA: shdma: support 
the new CHCLR register layout" and other patches, already in -next. The 
ARM part applies on top of today's renesas.git devel branch.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (8):
  DMA: shdma: add support for DMAC configuration data, supplied via
    device ID
  DMA: shdma: add r8a7740 DMAC data to the device ID table
  DMA: shdma: add r8a73a4 DMAC data to the device ID table
  ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
  ARM: shmobile: r8a7740: switch DMAC controllers to using device ID
    data
  DMA: shdma: pass SoC-specific configuration to the driver via OF
    matching
  DMA: shdma: make multiplexer platform data optional
  ARM: shmobile: r8a7740: add DT nodes and clock aliases for three DMAC
    instances

 Documentation/devicetree/bindings/dma/shdma.txt |    7 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |   61 +++++++++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c          |    4 +-
 arch/arm/mach-shmobile/clock-r8a7740.c          |    9 ++-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h   |    9 ++
 arch/arm/mach-shmobile/setup-r8a73a4.c          |   16 ++++
 arch/arm/mach-shmobile/setup-r8a7740.c          |  106 +----------------------
 drivers/dma/sh/Kconfig                          |    8 ++
 drivers/dma/sh/Makefile                         |    4 +
 drivers/dma/sh/shdma-of.c                       |    3 -
 drivers/dma/sh/shdma-r8a73a4.c                  |   75 ++++++++++++++++
 drivers/dma/sh/shdma-r8a7740.c                  |   95 ++++++++++++++++++++
 drivers/dma/sh/shdma.h                          |   14 +++
 drivers/dma/sh/{shdma.c => shdmac.c}            |   28 +++++-
 14 files changed, 322 insertions(+), 117 deletions(-)
 create mode 100644 drivers/dma/sh/shdma-r8a73a4.c
 create mode 100644 drivers/dma/sh/shdma-r8a7740.c
 rename drivers/dma/sh/{shdma.c => shdmac.c} (97%)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
