From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 14:55:11 +0000
Subject: [PATCH 0/9] ARM: shmobile: MMCIF and SDHI interfaces for AP6EVM and lager
Message-Id: <1368802520-16378-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds MMCIF and SDHI interfaces to APE6EVM and (partially)
lager shmobile boards. Patches, analogous to the last 3 patches in this
series for the lager board should follow soon. It can also be noted, that
in this version always-on regulators are used to supply power to all MMC/SD
interfaces on APE6EVM. In the future proper support for supplying on-board
regulators should be implemented.

Patches depend on earlier pinctrl patches from Laurent, they have to wait,
until the latest or an updated version of his patches is applied.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (9):
  pinctrl: r8a7790: add pinmux data for MMCIF and SDHI interfaces
  pinctrl: r8a73a4: add pinmux data for MMCIF and SDHI interfaces
  ARM: shmobile: r8a73a4: add clock definitions and aliases for MMCIF
    and SDHI
  ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF
    and SDHI
  ARM: shmobile: APE6EVM: add DT pinctrl definitions for a serial
    interface
  ARM: shmobile: lager: add DT pinctrl definitions for a serial
    interface
  ARM: shmobile: APE6EVM: add MMCIF and SDHI DT nodes
  ARM: shmobile: APE6EVM: switch to using platform_add_devices()
  ARM: shmobile: APE6EVM: add MMCIF and SDHI devices

 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   56 ++++++
 arch/arm/boot/dts/r8a73a4.dtsi         |   45 +++++
 arch/arm/boot/dts/r8a7790-lager.dts    |   10 +
 arch/arm/mach-shmobile/board-ape6evm.c |  147 +++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a73a4.c |   22 ++-
 arch/arm/mach-shmobile/clock-r8a7790.c |   26 ++-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c   |  200 ++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c   |  294 ++++++++++++++++++++++++++++++++
 8 files changed, 783 insertions(+), 17 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
