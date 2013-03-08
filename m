From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:20 +0000
Subject: [PATCH v3 00/64] PFC pinctrl functions for sh7372, sh73a0, r8a7740 and r8a7779
Message-Id: <1362740544-19164-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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

Patches 01/64 to 16/64 define the groups and functions, patches 17/30 to 35/64
replace function GPIOs by proper pinctrl mappings in board files, patches 36/64
to 49/64 remove the corresponding function GPIOs from the PFC driver and
patches 50/64 to 64/64 remove them from platform headers.

The patches are based on top of "[PATCH v4 00/29] SH pinctrl and pinmux
implementation" and are available from my git tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pfc-funcs

With this patch set the Marzen board is fully ported from function GPIOs to the
pinctrl API. The next step will be to follow the same path for all other
boards. Any volunteer ? :-)

I consider this set as ready to be queued for v3.10. As with the previous PFC
patch sets there are dependencies between board code changes and sh-pfc 
changes, so it would be easier to merge everything through the ARM tree.

Guennadi Liakhovetski (3):
  sh-pfc: sh7372: Add SDHCI and MMCIF pin groups and functions
  sh-pfc: sh73a0: Add SDHI and MMCIF pin groups and functions
  sh-pfc: r8a7740: Add SDHI and MMCIF pin groups and functions

Laurent Pinchart (61):
  sh-pfc: sh73a0: Add LCD and LCD2 pin groups and functions
  sh-pfc: sh73a0: Add SCIFA and SCIFB pin groups and functions
  sh-pfc: sh73a0: Add I2C2 and I2C3 pin groups and functions
  sh-pfc: sh73a0: Add FSI pin groups and functions
  sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and functions
  sh-pfc: r8a7779: Add DU pin groups and functions
  sh-pfc: r8a7779: Add SDHI and MMCIF pin groups and functions
  sh-pfc: r8a7779: Add SCIF pin groups and functions
  sh-pfc: r8a7779: Add HSPI pin groups and functions
  sh-pfc: r8a7779: Add USB0 and USB1 PENC pinmux support
  sh-pfc: r8a7779: Add USB pin groups and functions
  sh-pfc: r8a7779: Add LBSC pin groups and functions
  sh-pfc: r8a7779: Add INTC pin groups and functions
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
  ARM: shmobile: marzen: Register pinctrl mappings for SDHI and MMCIF
  ARM: shmobile: marzen: Register pinctrl mappings for SCIF
  ARM: shmobile: marzen: Register pinctrl mappings for HSPI
  ARM: shmobile: marzen: Register pinctrl mappings for USB
  ARM: shmobile: marzen: Register pinctrl mappings for LBSC
  ARM: shmobile: marzen: Register pinctrl mappings for INTC
  sh-pfc: sh7372: Remove SDHI and MMCIF function GPIOS
  sh-pfc: sh73a0: Remove LCD and LCD2 function GPIOS
  sh-pfc: sh73a0: Remove SCIFA and SCIFB function GPIOS
  sh-pfc: sh73a0: Remove I2C function GPIOS
  sh-pfc: sh73a0: Remove FSI function GPIOS
  sh-pfc: r8a7740: Remove LCD0 and LCD1 function GPIOS
  sh-pfc: r8a7740: Remove SDHI and MMCIF function GPIOS
  sh-pfc: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
  sh-pfc: r8a7779: Remove SDHI and MMCIF function GPIOS
  sh-pfc: r8a7779: Remove SCIF function GPIOS
  sh-pfc: r8a7779: Remove HSPI function GPIOS
  sh-pfc: r8a7779: Remove USB function GPIOS
  sh-pfc: r8a7779: Remove LBSC function GPIOS
  sh-pfc: r8a7779: Remove INTC function GPIOS
  ARM: shmobile: sh7372: Remove SDHI and MMCIF function GPIOs
  ARM: shmobile: sh73a0: Remove LCDC and LCDC2 function GPIOs
  ARM: shmobile: sh73a0: Remove SCIFA and SCIFB function GPIOs
  ARM: shmobile: sh73a0: Remove I2C function GPIOs
  ARM: shmobile: sh73a0: Remove FSI function GPIOs
  ARM: shmobile: r8a7740: Remove LCD0 and LCD1 function GPIOs
  ARM: shmobile: r8a7740: Remove SDHI and MMCIF function GPIOs
  ARM: shmobile: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
  ARM: shmobile: r8a7779: Remove DU function GPIOs
  ARM: shmobile: r8a7779: Remove SDHI and MMCIF function GPIOs
  ARM: shmobile: r8a7779: Remove SCIF function GPIOs
  ARM: shmobile: r8a7779: Remove HSPI function GPIOs
  ARM: shmobile: r8a7779: Remove USB function GPIOs
  ARM: shmobile: r8a7779: Remove LBSC function GPIOs
  ARM: shmobile: r8a7779: Remove INTC function GPIOs

 arch/arm/mach-shmobile/board-ag5evm.c          |   41 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |   52 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |   97 +-
 arch/arm/mach-shmobile/board-bonito.c          |   43 +-
 arch/arm/mach-shmobile/board-kota2.c           |   42 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |   68 +-
 arch/arm/mach-shmobile/board-mackerel.c        |   64 +-
 arch/arm/mach-shmobile/board-marzen.c          |   67 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |   74 --
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |  324 +++--
 arch/arm/mach-shmobile/include/mach/sh7372.h   |   29 -
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |  237 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  595 +++++++--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           | 1611 +++++++++++++++++++++---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c            |  230 +++-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            | 1289 ++++++++++++++++---
 16 files changed, 3719 insertions(+), 1144 deletions(-)

-- 
Regards,

Laurent Pinchart

