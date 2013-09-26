From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 17:20:55 +0000
Subject: [PATCH v2 0/5] ARM: shmobile: CPUFreq support on Lager
Message-Id: <1380216060-14506-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Lager a da9210 regulator is used to supply DVFS power to the SoC. This
patch series adds I2C and Z-clock support on r8a7790 and CPUFreq support
for the Lager board. Please note, that patch 4/4 is an RFC as explained
inline.

Developed on top of today's

    git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git    devel

plus i2c-rcar patches from my earlier patch series

[PATCH v2 0/5] i2c: rcar: Device Tree support and clock improvements

and the "sh-pfc: r8a7790: Add I2C pin groups and functions" patch from
Ulrich Hecht.

All changes since v1 are noted in respective patches. They all are trivial,
still as soon as test hardware is available, it would be good to run-time
test this version too.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (5):
  pinctrl: sh-pfc: r8a7790: add pin definitions for the I2C3 interface
  ARM: shmobile: r8a7790: add I2C clocks and aliases for the DT mode
  ARM: shmobile: r8a7790: add I2C DT nodes
  ARM: shmobile: r8a7790: add CPUFreq clock support
  ARM: shmobile: lager: (DEVEL) add CPUFreq support

 arch/arm/boot/dts/r8a7790-lager-reference.dts  |   33 +++++
 arch/arm/boot/dts/r8a7790.dtsi                 |   40 ++++++
 arch/arm/mach-shmobile/Kconfig                 |    2 +
 arch/arm/mach-shmobile/board-lager-reference.c |    4 +-
 arch/arm/mach-shmobile/clock-r8a7790.c         |  160 ++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c           |   28 ++++
 6 files changed, 266 insertions(+), 1 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
