From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Jul 2013 20:38:48 +0000
Subject: [PATCH 0/6] ARM: shmobile: DMAC, MMCIF and SDHI for H2 and APE6
Message-Id: <1372970334-21485-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add support for DMA, MMCIF and SDHI controllers to non-DT 
APE6EVM and Lager board implementations, and MMCIF and SDHI DT templates 
for APE6 and H2 SoCs.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (6):
  ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
  ARM: shmobile: APE6EVM: add MMCIF support
  ARM: shmobile: APE6EVM: add SDHI interfaces
  ARM: shmobile: Lager: add MMCIF support
  ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
  ARM: shmobile: r8a7790: add MMCIF and SDHI DT templates

 arch/arm/boot/dts/r8a73a4.dtsi                |   45 ++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                |   56 ++++++++++++
 arch/arm/mach-shmobile/board-ape6evm.c        |   75 ++++++++++++++++
 arch/arm/mach-shmobile/board-lager.c          |   31 +++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c        |    4 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |   15 +++
 arch/arm/mach-shmobile/setup-r8a73a4.c        |  117 +++++++++++++++++++++++++
 7 files changed, 342 insertions(+), 1 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
