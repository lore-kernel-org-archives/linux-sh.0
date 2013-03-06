From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 13:46:39 +0000
Subject: [PATCH v2 00/39] PFC pinctrl functions for sh7372, sh73a0, r8a7740 and r8a7779
Message-Id: <1362577638-15493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set defines pinctrl groups and functions for the SCIF, I2C, FSI,
LCD(C), SDHI and MMCIF devices on sh7372, sh73a0, r8a7740 and r8a7779 (not all
combinations are currently defined though, work is still needed to implement
all functions).

Patches 01/39 to 09/39 define the groups and functions, patches 10/30 to 22/39
replace function GPIOs by proper pinctrl mappings in board files, patches 23/39
to 30/39 remove the corresponding function GPIOs from the PFC driver and
patches 31/39 to 39/39 remove them from platform headers.

The patches are based on top of "[PATCH v3 00/29] SH pinctrl and pinmux
implementation" and are available from my git tree at

	git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pfc-funcs

Guennadi Liakhovetski (3):
  sh-pfc: sh7372: Add SDHCI and MMCIF pin groups and functions
  sh-pfc: sh73a0: Add SDHI and MMCIF pin groups and functions
  sh-pfc: r8a7740: Add SDHI and MMCIF pin groups and functions

Laurent Pinchart (36):
  sh-pfc: sh73a0: Add LCD and LCD2 pin groups and functions
  sh-pfc: sh73a0: Add SCIFA and SCIFB pin groups and functions
  sh-pfc: sh73a0: Add I2C2 and I2C3 pin groups and functions
  sh-pfc: sh73a0: Add FSI pin groups and functions
  sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and functions
  sh-pfc: r8a7779: Add DU pin groups and functions
  ARM: shmobile: ag5evm: Register pinctrl mappings for SCIF
  ARM: shmobile: ag5evm: Register pinctrl mappings for I2C
  ARM: shmobile: ag5evm: Register pinctrl mappings for FSI
  ARM: shmobile: ap4evb: Register pinctrl mappings for SDHI and MMCIF
  ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0
  ARM: shmobile: armadillo800eva: Register pinctrl mappings for SDHI and
    MMCIF
  ARM: shmobile: bonito: Register pinctrl mappings for LCDC0
  ARM: shmobile: kota2: Register pinctrl mappings for SCIF
  ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
  ARM: shmobile: kzm9g: Register pinctrl mappings for SCIF
  ARM: shmobile: kzm9g: Register pinctrl mappings for I2C
  ARM: shmobile: kzm9g: Register pinctrl mappings for FSI
  ARM: shmobile: mackerel: Register pinctrl mappings for SDHI and MMCIF
  sh-pfc: sh7372: Remove SDHI and MMCIF function GPIOS
  sh-pfc: sh73a0: Remove LCD and LCD2 function GPIOS
  sh-pfc: sh73a0: Remove SCIFA and SCIFB function GPIOS
  sh-pfc: sh73a0: Remove I2C function GPIOS
  sh-pfc: sh73a0: Remove FSI function GPIOS
  sh-pfc: r8a7740: Remove LCD0 and LCD1 function GPIOS
  sh-pfc: r8a7740: Remove SDHI and MMCIF function GPIOS
  sh-pfc: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
  ARM: shmobile: sh7372: Remove SDHI and MMCIF function GPIOs
  ARM: shmobile: sh73a0: Remove LCDC and LCDC2 function GPIOs
  ARM: shmobile: sh73a0: Remove SCIFA and SCIFB function GPIOs
  ARM: shmobile: sh73a0: Remove I2C function GPIOs
  ARM: shmobile: sh73a0: Remove FSI function GPIOs
  ARM: shmobile: r8a7740: Remove LCD0 and LCD1 function GPIOs
  ARM: shmobile: r8a7740: Remove SDHI and MMCIF function GPIOs
  ARM: shmobile: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
  ARM: shmobile: r8a7779: Remove DU function GPIOs

 arch/arm/mach-shmobile/board-ag5evm.c          |   41 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |   52 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |   97 +-
 arch/arm/mach-shmobile/board-bonito.c          |   43 +-
 arch/arm/mach-shmobile/board-kota2.c           |   42 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |   68 +-
 arch/arm/mach-shmobile/board-mackerel.c        |   64 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |   74 --
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |   90 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h   |   29 -
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |  237 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  595 +++++++++--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           |  291 +++++-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c            |  230 ++++-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            | 1289 ++++++++++++++++++++----
 15 files changed, 2380 insertions(+), 862 deletions(-)

-- 
Regards,

Laurent Pinchart

