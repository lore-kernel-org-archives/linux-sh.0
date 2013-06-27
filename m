From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Jun 2013 09:47:55 +0000
Subject: [PATCH v2 0/3] ARM: shmobile: r8a73a4: add I2C devices and CPUFreq support
Message-Id: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

CPUFreq voltage scaling support for APE6EVM uses an I2C PMIC. This patch 
series adds support for I2C on r8a73a4 and adds required hooks to APE6EVM. 
This patch series is identical to v1 with the only difference, that a 
patch from it has been split into two upon maintainer's request.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  ARM: shmobile: r8a73a4: add clocks for I2C controllers
  ARM: shmobile: r8a73a4: add I2C controller DT nodes
  ARM: shmobile: ape6evm: add CPUFreq support

 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   22 +++++++++
 arch/arm/boot/dts/r8a73a4.dtsi         |   81 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c |   25 +++++++++-
 3 files changed, 126 insertions(+), 2 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
