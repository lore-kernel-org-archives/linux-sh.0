From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:05 +0000
Subject: [PATCH v4 00/88] PFC pinctrl functions for sh7372, sh73a0, r8a7740 and r8a7779
Message-Id: <1363215633-4264-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

The fourth version of the functions patch set defines pinctrl groups and
functions for even more devices on sh7372, sh73a0, r8a7740 and r8a7779.

Patches 01/88 to 21/88 define the groups and functions, patches 22/88 to 49/88
replace function GPIOs by proper pinctrl mappings in board files, patches 50/88
to 68/88 remove the corresponding function GPIOs from the PFC driver and
patches 69/88 to 88/88 remove them from platform headers.

The major difference compared to v3, beside adding more groups and functions,
is the bias pinconf support implementation for sh73a0 (02/88). I would
appreciate if that patch could be carefully reviewed.

The patches are based on top of "[PATCH 00/25] sh-pfc: pinconf implementation"
and are available from my git tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/functions

With this patch set the AG5 EVM, Kota2 and Marzen boards are fully ported from
function GPIOs to the pinctrl API, and only one last function GPIO need to be
removed for the KZM9G board. The next step will be to follow the same path for
all other boards. Volunteers are welcome.

I consider this set as v3.10 material. As with the previous PFC patch sets
there are dependencies between board code changes and sh-pfc changes, so it
would be easier to merge everything through the ARM tree.

Simon, could you please replace the PFC patches in your tree with my pinmux/3.9
pinctrl, pinconf and functions branches ? I'm sorry for the inconvienence
caused by the rebase. I plan to now build incrementally on top of the functions
branch.

Guennadi Liakhovetski (3):
  sh-pfc: sh7372: Add SDHCI and MMCIF pin groups and functions
  sh-pfc: sh73a0: Add SDHI and MMCIF pin groups and functions
  sh-pfc: r8a7740: Add SDHI and MMCIF pin groups and functions

Laurent Pinchart (85):
  sh-pfc: sh73a0: Add bias (pull-up/down) pinconf support
  sh-pfc: sh73a0: Add LCD and LCD2 pin groups and functions
  sh-pfc: sh73a0: Add SCIFA and SCIFB pin groups and functions
  sh-pfc: sh73a0: Add I2C2 and I2C3 pin groups and functions
  sh-pfc: sh73a0: Add FSI pin groups and functions
  sh-pfc: sh73a0: Add KEYSC pin groups and functions
  sh-pfc: sh73a0: Add BSC pin groups and functions
  sh-pfc: sh73a0: Add USB pin groups and functions
  sh-pfc: sh73a0: Add IrDA pin groups and functions
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
  ARM: shmobile: ag5evm: Register pinctrl mappings for SDHI and MMCIF
  ARM: shmobile: ag5evm: Register pinctrl mappings for KEYSC
  ARM: shmobile: ag5evm: Register pinctrl mappings for IrDA
  ARM: shmobile: ap4evb: Register pinctrl mappings for SDHI and MMCIF
  ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0
  ARM: shmobile: armadillo800eva: Register pinctrl mappings for SDHI and
    MMCIF
  ARM: shmobile: bonito: Register pinctrl mappings for LCDC0
  ARM: shmobile: kota2: Register pinctrl mappings for SCIF
  ARM: shmobile: kota2: Register pinctrl mappings for SDHI and MMCIF
  ARM: shmobile: kota2: Register pinctrl mappings for KEYSC
  ARM: shmobile: kota2: Register pinctrl mappings for BSC
  ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
  ARM: shmobile: kzm9g: Register pinctrl mappings for SCIF
  ARM: shmobile: kzm9g: Register pinctrl mappings for I2C
  ARM: shmobile: kzm9g: Register pinctrl mappings for FSI
  ARM: shmobile: kzm9g: Register pinctrl mappings for SDHI and MMCIF
  ARM: shmobile: kzm9g: Register pinctrl mappings for BSC
  ARM: shmobile: kzm9g: Register pinctrl mappings for USB
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
  sh-pfc: sh73a0: Remove pull-up function GPIOS
  sh-pfc: sh73a0: Remove KEYSC function GPIOS
  sh-pfc: sh73a0: Remove BSC function GPIOS
  sh-pfc: sh73a0: Remove USB function GPIOS
  sh-pfc: sh73a0: Remove IrDA function GPIOS
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
  ARM: shmobile: sh73a0: Remove pull-up function GPIOS
  ARM: shmobile: sh73a0: Remove KEYSC function GPIOs
  ARM: shmobile: sh73a0: Remove BSC function GPIOs
  ARM: shmobile: sh73a0: Remove USB function GPIOs
  ARM: shmobile: sh73a0: Remove IrDA function GPIOs
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

 arch/arm/mach-shmobile/board-ag5evm.c          |  146 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |   55 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |  100 +-
 arch/arm/mach-shmobile/board-bonito.c          |   44 +-
 arch/arm/mach-shmobile/board-kota2.c           |  166 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |  138 +-
 arch/arm/mach-shmobile/board-mackerel.c        |   68 +-
 arch/arm/mach-shmobile/board-marzen.c          |   75 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |   74 -
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |  324 ++-
 arch/arm/mach-shmobile/include/mach/sh7372.h   |   29 -
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |  363 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  596 +++++-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           | 1589 +++++++++++++--
 drivers/pinctrl/sh-pfc/pfc-sh7372.c            |  231 ++-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            | 2545 +++++++++++++++++-------
 16 files changed, 4646 insertions(+), 1897 deletions(-)

-- 
Regards,

Laurent Pinchart

