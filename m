From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:48:18 +0000
Subject: [PATCH v2 0/6] ARM: shmobile: add DMA DT bindings for MMCIF and SDHI
Message-Id: <1370533704-23734-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Update of earlier patches, adding DMA DT nodes for sh73a0 and r8a7740 
platforms. This time r8a7740 is done in one step as a DMA multiplexer 
node with 3 DMAC instances in it.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (6):
  ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
  ARM: shmobile: kzm9g-reference: add DMA channels to the MMCIF DT
  ARM: shmobile: add SDHI and MMCIF interfaces to
    armadillo800eva-reference
  ARM: shmobile: r8a7740: add MMCIF DMA definitions
  ARM: shmobile: r8a7740: add DT nodes for three DMAC instance
  ARM: shmobile: armadillo800eva-reference: add DMA support for MMCIF
    and SDHI

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   30 ++++++-
 arch/arm/boot/dts/r8a7740.dtsi                     |  100 ++++++++++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |    3 +
 arch/arm/boot/dts/sh73a0.dtsi                      |   36 +++++++
 .../board-armadillo800eva-reference.c              |   36 +++++++-
 arch/arm/mach-shmobile/include/mach/r8a7740.h      |    2 +
 arch/arm/mach-shmobile/setup-r8a7740.c             |   16 +++
 arch/arm/mach-shmobile/setup-sh73a0.c              |    4 +
 8 files changed, 225 insertions(+), 2 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
