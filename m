From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 09 Sep 2013 16:03:52 +0000
Subject: [PATCH 0/4] ARM: shmobile: CPUFreq support on Lager
Message-Id: <1378742636-11215-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Lager a da9210 regulator is used to supply DVFS power to the SoC. This
patch series adds I2C and Z-clock support on r8a7790 and CPUFreq support
for the Lager board. Please note, that patch 4/4 is an RFC as explained
inline.

Developed on top of -next of 09.09.2013 with my recent shmobile patches,
including "ARM: shmobile: lager: disable MMCIF Command Completion Signal,
add CLK_CTRL2" and my two earlier patch series from today:

[PATCH 0/2] regulator: da9210: support Device Tree initialisation
[PATCH 0/5] i2c: rcar: Device Tree support and clock improvements

If these patches are used without da9210 DT support, the driver won't
initialise correctly, otherwise applying these patches without the above
dependencies will compile and shouldn't do any harm.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (4):
  pinctrl: sh-pfc: r8a7790: add pin definitions for the I2C3 interface
  ARM: shmobile: r8a7790: add I2C support in Device Tree mode
  ARM: shmobile: r8a7790: add CPUFreq clock support
  ARM: shmobile: lager: add CPUFreq support

 arch/arm/boot/dts/r8a7790-lager-reference.dts  |   32 +++++
 arch/arm/boot/dts/r8a7790.dtsi                 |   36 ++++++
 arch/arm/mach-shmobile/Kconfig                 |    2 +
 arch/arm/mach-shmobile/board-lager-reference.c |    4 +-
 arch/arm/mach-shmobile/clock-r8a7790.c         |  160 ++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c           |   28 ++++
 6 files changed, 261 insertions(+), 1 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
