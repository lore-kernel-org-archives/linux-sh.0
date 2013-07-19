From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Jul 2013 16:29:25 +0000
Subject: [PATCH v2 00/15] ARM: shmobile: move DMAC configuration data in the driver
Message-Id: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

An extended and slightly updated to address comments from Sergei Shtylyov 
version of my patch set of 12.07. As with v1, ARM patches should be 
applied after DMA. Since the DMA part only affects the shdma driver, maybe 
it would be possible to have them acked and pulled via the ARM tree too. 
Otherwise the ARM patches will have to wait for 1 cycle.

Guennadi Liakhovetski (15):
  DMA: shdma: add support for DMAC configuration data, supplied via
    device ID
  DMA: shdma: add r8a7740 DMAC data to the device ID table
  DMA: shdma: add r8a73a4 DMAC data to the device ID table
  DMA: shdma: make a pointer const
  DMA: shdma: pass SoC-specific configuration to the driver via OF
    matching
  DMA: shdma: make multiplexer platform data optional
  DMA: shdma: add sh73a0 DMAC data to the device ID table
  DMA: shdma: move two macros to a header
  DMA: shdma: support referencing specific DMACs within a multiplexer
    in DT
  ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
  ARM: shmobile: r8a7740: switch DMAC controllers to using device ID
    data
  ARM: shmobile: r8a7740: add DT nodes and clock aliases for three DMAC
    instances
  ARM: shmobile: r8a73a4: add a DT node and a clock alias for the DMAC
  ARM: shmobile: sh73a0: switch DMAC controllers to using device ID
    data
  ARM: shmobile: r8a7740: add support for 2 RTDMACs

 Documentation/devicetree/bindings/dma/shdma.txt |   23 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |   43 +
 arch/arm/boot/dts/r8a7740.dtsi                  |   95 +++
 arch/arm/mach-shmobile/clock-r8a73a4.c          |    5 +-
 arch/arm/mach-shmobile/clock-r8a7740.c          |   17 +-
 arch/arm/mach-shmobile/clock-sh73a0.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h   |    9 +
 arch/arm/mach-shmobile/setup-r8a73a4.c          |   17 +
 arch/arm/mach-shmobile/setup-r8a7740.c          |  178 ++---
 arch/arm/mach-shmobile/setup-sh73a0.c           |  182 +----
 drivers/dma/sh/Kconfig                          |   12 +
 drivers/dma/sh/Makefile                         |    5 +
 drivers/dma/sh/shdma-base.c                     |    3 -
 drivers/dma/sh/shdma-of.c                       |    5 -
 drivers/dma/sh/shdma-r8a73a4.c                  |   75 ++
 drivers/dma/sh/shdma-r8a7740.c                  |   95 +++
 drivers/dma/sh/shdma-sh73a0.c                   |  181 ++++
 drivers/dma/sh/shdma.c                          |  939 ---------------------
 drivers/dma/sh/shdma.h                          |   30 +-
 drivers/dma/sh/shdmac.c                         | 1025 +++++++++++++++++++++++
 include/linux/shdma-base.h                      |    3 +
 21 files changed, 1705 insertions(+), 1239 deletions(-)
 create mode 100644 drivers/dma/sh/shdma-r8a73a4.c
 create mode 100644 drivers/dma/sh/shdma-r8a7740.c
 create mode 100644 drivers/dma/sh/shdma-sh73a0.c
 delete mode 100644 drivers/dma/sh/shdma.c
 create mode 100644 drivers/dma/sh/shdmac.c

-- 
1.7.2.5

