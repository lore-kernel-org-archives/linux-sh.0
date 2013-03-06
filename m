From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 12:52:21 +0000
Subject: [PATCH v3 00/29] SH pinctrl and pinmux implementation
Message-Id: <1362574370-17889-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here's the third version of the SuperH and SH Mobile pin controllers (PFC)
pinctrl and pinmux support patches. The patches have been rebased on top of
v3.9-rc1 and are available from my git tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pinctrl

As previously, the series start with miscellaneous cleanup and rework patches
that slowly get the code in shape. Patches 15/29 and 16/29 then rework the GPIO
code to split real GPIOs and function GPIOS in two gpio_chip instances. Patches
17/29 to 22/29 are more miscellaneous cleanups to prepare for patch 23/29 that
adds support for sparse GPIO numbering (this was the major issue with v2).
Patch 29/29 implements real pinctrl and pinmux support.

Patch 01/29 is a pinctrl core improvement that should go separately through
the pinctrl tree. Linus, would you like to pick it up now ?

This pinctrl and pinmux implementation simply replaces the existing one. This
should be safe as I've verified that the pinctrl and pinmux APIs are not used
by any SuperH or SH Mobile board code or driver.

Changes since v2:

- Rebased on v3.9-rc1
- Constify fields in the pinctrl core
- Support sparse GPIO numbers
- Drop LCD(C) pin groups and functions (moved to another patch set)

Changes since v1:

- Port the bonito board to the pinmux API
- Set the pins gpio_chip dev field correctly

Guennadi Liakhovetski (2):
  sh-pfc: Fix a typo and simplify a definition on sh73a0
  ARM: shmobile: sh73a0: Support sparse GPIO numbers

Laurent Pinchart (27):
  pinctrl: Declare operation structures as const
  sh-pfc: Declare operation structures as const
  sh-pfc: Don't define the per-device pinctrl struct instances as global
  sh-pfc: Drop the sh_pfc_pinctrl spinlock
  sh-pfc: Don't take the sh_pfc spinlock in sh_pfc_map_gpios()
  sh-pfc: Use GPIO_FN instead of PINMUX_GPIO where possible
  sh-pfc: Replace first_gpio and last_gpio with nr_gpios
  sh-pfc: Replace SoC info data and mark ranges with a number of pins
  sh-pfc: Remove unused sh_pfc_soc_info reserved_id field
  sh-pfc: Initialize pinmux_gpio flags statically
  sh-pfc: Make struct pinmux_gpio enum_id field const
  sh-pfc: Shrink the pinctrl GPIO range to include real GPIOs only
  sh-pfc: Don't needlessly check GPIO type in sh_gpio_free()
  sh-pfc: Split pins and functions definition tables
  sh-pfc: Split pins and functions into separate gpio_chip instances
  sh-pfc: Rename struct pinmux_pin to struct sh_pfc_pin
  sh-pfc: Look up IRQ table entries by GPIO number
  sh-pfc: Share the PORT_10_REV, PORT_32 and PORT_32_REV definitions
  sh-pfc: Use pinmux identifiers in the pin muxing API
  sh-pfc: Simplify the sh_pfc_gpio_is_pin() logic
  sh-pfc: Add function to retrieve a pin instance from its pin number
  sh-pfc: Add support for sparse pin numbers
  ARM: shmobile: ap4-evb: Replace GPIO_PORTx enum with GPIO port numbers
  ARM: shmobile: armadillo: Replace GPIO_PORTx enum with GPIO port
    numbers
  ARM: shmobile: bonito: Replace GPIO_PORTx enum with GPIO port numbers
  ARM: shmobile: mackerel: Replace GPIO_PORTx enum with GPIO port
    numbers
  sh-pfc: Expose real groups and functions in pinctrl/pinmux operations

 arch/arm/mach-shmobile/board-ag5evm.c          |  26 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |  36 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |  58 +--
 arch/arm/mach-shmobile/board-bonito.c          |   6 +-
 arch/arm/mach-shmobile/board-kota2.c           |  42 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |  14 +-
 arch/arm/mach-shmobile/board-mackerel.c        |  34 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |   2 +-
 drivers/pinctrl/devicetree.c                   |   4 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c          |   6 +-
 drivers/pinctrl/pinconf.c                      |   2 +-
 drivers/pinctrl/pinctrl-at91.c                 |   6 +-
 drivers/pinctrl/pinctrl-bcm2835.c              |   6 +-
 drivers/pinctrl/pinctrl-exynos5440.c           |   6 +-
 drivers/pinctrl/pinctrl-falcon.c               |   2 +-
 drivers/pinctrl/pinctrl-imx.c                  |   6 +-
 drivers/pinctrl/pinctrl-lantiq.c               |   4 +-
 drivers/pinctrl/pinctrl-mxs.c                  |   6 +-
 drivers/pinctrl/pinctrl-nomadik.c              |   6 +-
 drivers/pinctrl/pinctrl-pxa3xx.c               |   4 +-
 drivers/pinctrl/pinctrl-samsung.c              |   6 +-
 drivers/pinctrl/pinctrl-single.c               |   6 +-
 drivers/pinctrl/pinctrl-sirf.c                 |   4 +-
 drivers/pinctrl/pinctrl-tegra.c                |   6 +-
 drivers/pinctrl/pinctrl-u300.c                 |   6 +-
 drivers/pinctrl/pinctrl-xway.c                 |   2 +-
 drivers/pinctrl/sh-pfc/core.c                  |  71 +--
 drivers/pinctrl/sh-pfc/core.h                  |  15 +-
 drivers/pinctrl/sh-pfc/gpio.c                  | 210 +++++---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  84 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           |  51 +-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c            | 480 +++++++++----------
 drivers/pinctrl/sh-pfc/pfc-sh7264.c            | 452 +++++++++---------
 drivers/pinctrl/sh-pfc/pfc-sh7269.c            | 616 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7372.c            |  82 ++--
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            |  97 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7720.c            | 325 ++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7722.c            | 472 +++++++++---------
 drivers/pinctrl/sh-pfc/pfc-sh7723.c            | 634 +++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7724.c            | 630 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c            |  47 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c            | 612 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7785.c            | 346 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7786.c            | 288 +++++------
 drivers/pinctrl/sh-pfc/pfc-shx3.c              | 140 +++---
 drivers/pinctrl/sh-pfc/pinctrl.c               | 289 +++++------
 drivers/pinctrl/sh-pfc/sh_pfc.h                |  94 +++-
 drivers/pinctrl/spear/pinctrl-spear.c          |   4 +-
 include/linux/pinctrl/pinctrl.h                |   6 +-
 49 files changed, 3229 insertions(+), 3122 deletions(-)

-- 
Regards,

Laurent Pinchart

