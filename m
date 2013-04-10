From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 10 Apr 2013 22:19:43 +0000
Subject: [PATCH/RFC 0/6] DMA: shdma: add Device Tree support
Message-Id: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This patch series adds Device Tree support to the shdma dmaengine driver 
and illustraits its use with the kzm9g-reference board's MMCIF interface.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (6):
  DMA: shdma: (cosmetic) don't re-calculate a pointer
  DMA: shdma: shdma_chan_filter() has to be in shdma-base.h
  DMA: shdma: add DT support
  ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
  mmc: sh_mmcif: add support for Device Tree DMA bindings
  ARM: shmobile: kzm9g-reference: add DMA channels to the MMCIF DT

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    3 ++
 arch/arm/boot/dts/sh73a0.dtsi                |   36 ++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c        |    4 ++
 drivers/dma/sh/shdma-base.c                  |   51 +++++++++++++++++++++++---
 drivers/dma/sh/shdma.c                       |   46 ++++++++++++++++++++----
 drivers/mmc/host/sh_mmcif.c                  |   29 +++++++++------
 include/linux/sh_dma.h                       |    2 -
 include/linux/shdma-base.h                   |    6 +++
 8 files changed, 151 insertions(+), 26 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
