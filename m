From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Jan 2013 18:17:31 +0000
Subject: [PATCH 00/22] SH pinctrl and pinmux implementation
Message-Id: <1357237073-15600-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here's a patch set that implements pinctrl and pinmux support for the SuperH
and SH Mobile pin controllers (PFC). The patches are based on my previous PFC
patch series ("[PATCH v4 00/81] SH pin control and GPIO rework") and are
available from my git tree at

	git://linuxtv.org/pinchartl/fbdev.git pinmux-pinctrl

The series start with miscellaneous cleanup and rework patches that slowly get
the code in shape. Patches 12/22 and 13/22 then rework the GPIO code to split
real GPIOs and function GPIOS in two gpio_chip instances. Patches 14/22 and
15/22 are two more miscellaneous cleanups to prepare for patch 16/22 that
implements real pinctrl and pinmux support.

This pinctrl and pinmux implementation simply replaces the existing once. This
should be safe as I've verified that the pinctrl and pinmux APIs are not used
by any SuperH or SH Mobile board code or driver.

The remaining patches then define LCD controller pin groups and functions for
the sh73a0 and r8a7740 SoCs and port the kzm9g and armadillo800eva boards to
the pinmux API to set the initial pinmux configuration.

I ran into an issue when trying to port the bonito board (the only other
r8a7740 board in mainline) to the pinmux API. My board patches use system pin
control hogging to apply the initial pinmux configuration. This mechanism
requires registering the pinctrl mappings before registering the pinctrl
device, as the default states are selected when the pinctrl device is
registered. However, the mappings vary depending on board configuration read
through GPIOs, and the GPIOs are implemented by the pinctrl driver. One
possible solution would be to apply updates to the selected state as mappings
are registered, but that looks pretty complex at first sight. Other ideas (or,
better, patches :-)) are welcome.

Last but not least, a DT patch series will follow soon.

Laurent Pinchart (22):
  sh-pfc: Drop the sh_pfc_pinctrl spinlock
  sh-pfc: Don't take the sh_pfc spinlock in sh_pfc_map_gpios()
  sh-pfc: Use GPIO_FN instead of PINMUX_GPIO where possible
  sh-pfc: Use _GPIO_PORT instead of PINMUX_GPIO where possible
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
  sh-pfc: Expose real groups and functions in pinctrl/pinmux operations
  sh-pfc: sh73a0: Add LCD and LCD2 pin groups and functions
  sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and functions
  ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
  ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0
  sh-pfc: sh73a0: Remove LCD and LCD2 function GPIOS
  ARM: shmobile: sh73a0: Remove LCDC and LCDC2 function GPIOs

 arch/arm/mach-shmobile/board-armadillo800eva.c |   38 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |   35 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |  112 ++--
 drivers/pinctrl/sh-pfc/core.c                  |   71 ++-
 drivers/pinctrl/sh-pfc/core.h                  |    6 +-
 drivers/pinctrl/sh-pfc/gpio.c                  |  198 ++++--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  359 ++++++++-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           |   17 +-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c            |  678 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-sh7264.c            |  694 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-sh7269.c            |  898 +++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-sh7372.c            |   82 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            |  409 +++++++---
 drivers/pinctrl/sh-pfc/pfc-sh7720.c            |  559 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7722.c            |  770 +++++++++---------
 drivers/pinctrl/sh-pfc/pfc-sh7723.c            |  974 +++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-sh7724.c            |  990 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c            |   16 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c            | 1020 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7785.c            |  568 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7786.c            |  408 +++++-----
 drivers/pinctrl/sh-pfc/pfc-shx3.c              |  264 +++---
 drivers/pinctrl/sh-pfc/pinctrl.c               |  184 ++---
 drivers/pinctrl/sh-pfc/sh_pfc.h                |   75 ++-
 24 files changed, 4970 insertions(+), 4455 deletions(-)

-- 
Regards,

Laurent Pinchart
