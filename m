From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 13:16:15 +0000
Subject: [PATCH 0/6] DMA for MMCIF and SDHI devices in DT mode
Message-Id: <1374498981-5263-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds DMA support for MMCIF and SDHI on APE6EVM,
armadillo800eva and KZM9G in DT mode.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (6):
  ARM: shmobile: ape6evm: add DMA support to MMCIF
  ARM: shmobile: ape6evm-reference: enable DMA for the MMC interface
  ARM: shmobile: armadillo800eva-reference: add MMCIF and SDHI DT nodes
  ARM: shmobile: armadillo800eva-reference: add DMA to SDHI and MMCIF
  ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
  ARM: shmobile: kzm9g-reference: add DMA channels to MMCIF and SDHI DT

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |    3 +
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   92 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |   33 +++++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |    9 ++
 arch/arm/boot/dts/sh73a0.dtsi                      |   43 +++++++++
 arch/arm/mach-shmobile/board-ape6evm.c             |    2 +
 arch/arm/mach-shmobile/clock-sh73a0.c              |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c              |    3 +
 8 files changed, 186 insertions(+), 0 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
