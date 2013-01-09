From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Jan 2013 02:36:38 +0000
Subject: Re: [PATCH v2 00/29] SH pinctrl and pinmux implementation
Message-Id: <20130109023637.GA28023@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357692769-1432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357692769-1432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 09, 2013 at 01:52:20AM +0100, Laurent Pinchart wrote:
> Hello,
> 
> Here's the second version of the SuperH and SH Mobile pin controllers (PFC)
> pinctrl and pinmux support patches. The patches are based on my previous PFC
> patch series ("[PATCH v4 00/81] SH pin control and GPIO rework") and are
> available from my git tree at
> 
>         git://linuxtv.org/pinchartl/fbdev.git pinmux-pinctrl
> 
> The series depends on three patches from Linus Walleij that implement default
> pinmux configuration in the device core. This solves the bonito board issue
> mentioned in v1. Those patches are included in this set for convenience.

Is "ARM: shmobile: bonito: Register pinctrl mappings for LCDC0"
the only patch in the series that depends on Linus's patches?

> As the two dependencies will go to mainline through separate trees we will
> need coordination to push this set. It would probably be easier if it went
> through the mach-shmobile tree, in which case Linus' patches should go in
> early during the merge window. Linus, would that be fine with you ? Are your
> three patches included in this series ready for mainline ? If so, can you
> provide a stable branch that you will push ?

The first patch "pinctrl: fix comment mistak" seems to be
in Linus's tree, post-3.8-rc2.

> The series start with miscellaneous cleanup and rework patches that slowly get
> the code in shape. Patches 15/29 and 16/29 then rework the GPIO code to split
> real GPIOs and function GPIOS in two gpio_chip instances. Patches 17/22 and
> 18/22 are two more miscellaneous cleanups to prepare for patch 19/22 that
> implements real pinctrl and pinmux support.
> 
> This pinctrl and pinmux implementation simply replaces the existing one. This
> should be safe as I've verified that the pinctrl and pinmux APIs are not used
> by any SuperH or SH Mobile board code or driver.
> 
> The remaining patches then define LCD controller pin groups and functions for
> the sh73a0 and r8a7740 SoCs and port the kzm9g, armadillo800eva and bonito
> boards to the pinmux API to set the initial pinmux configuration.
> 
> Patch 22/29 is a bug fix that could go in independently of the whole set.
> 
> Changes since v1:
> 
> - Port the bonito board to the pinmux API
> - Set the pins gpio_chip dev field correctly
> 
> Laurent Pinchart (26):
>   sh-pfc: Drop the sh_pfc_pinctrl spinlock
>   sh-pfc: Don't take the sh_pfc spinlock in sh_pfc_map_gpios()
>   sh-pfc: Use GPIO_FN instead of PINMUX_GPIO where possible
>   sh-pfc: Use _GPIO_PORT instead of PINMUX_GPIO where possible
>   sh-pfc: Replace first_gpio and last_gpio with nr_gpios
>   sh-pfc: Replace SoC info data and mark ranges with a number of pins
>   sh-pfc: Remove unused sh_pfc_soc_info reserved_id field
>   sh-pfc: Initialize pinmux_gpio flags statically
>   sh-pfc: Make struct pinmux_gpio enum_id field const
>   sh-pfc: Shrink the pinctrl GPIO range to include real GPIOs only
>   sh-pfc: Don't needlessly check GPIO type in sh_gpio_free()
>   sh-pfc: Split pins and functions definition tables
>   sh-pfc: Split pins and functions into separate gpio_chip instances
>   sh-pfc: Rename struct pinmux_pin to struct sh_pfc_pin
>   sh-pfc: Look up IRQ table entries by GPIO number
>   sh-pfc: Expose real groups and functions in pinctrl/pinmux operations
>   sh-pfc: sh73a0: Add LCD and LCD2 pin groups and functions
>   sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and functions
>   ARM: shmobile: kzm9g: Use of_machine_is_compatible()
>   ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
>   sh-pfc: sh73a0: Remove LCD and LCD2 function GPIOS
>   ARM: shmobile: sh73a0: Remove LCDC and LCDC2 function GPIOs
>   ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0
>   ARM: shmobile: bonito: Register pinctrl mappings for LCDC0
>   sh-pfc: r8a7740: Remove LCD0 and LCD1 function GPIOS
>   ARM: shmobile: r8a7740: Remove LCD0 and LCD1 function GPIOs
> 
> Linus Walleij (3):
>   pinctrl: fix comment mistake
>   pinctrl: skip deferral of hogs
>   drivers/pinctrl: grab default handles from device core
> 
>  Documentation/pinctrl.txt                      |   24 +-
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   41 +-
>  arch/arm/mach-shmobile/board-bonito.c          |   43 +-
>  arch/arm/mach-shmobile/board-kzm9g.c           |   39 +-
>  arch/arm/mach-shmobile/include/mach/r8a7740.h  |   39 -
>  arch/arm/mach-shmobile/include/mach/sh73a0.h   |  112 ++--
>  drivers/base/Makefile                          |    1 +
>  drivers/base/dd.c                              |    7 +
>  drivers/base/pinctrl.c                         |   81 ++
>  drivers/pinctrl/core.c                         |   40 +-
>  drivers/pinctrl/sh-pfc/core.c                  |   71 ++-
>  drivers/pinctrl/sh-pfc/core.h                  |    6 +-
>  drivers/pinctrl/sh-pfc/gpio.c                  |  198 ++++--
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  396 ++++++++--
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c           |   17 +-
>  drivers/pinctrl/sh-pfc/pfc-sh7203.c            |  678 ++++++++--------
>  drivers/pinctrl/sh-pfc/pfc-sh7264.c            |  694 ++++++++--------
>  drivers/pinctrl/sh-pfc/pfc-sh7269.c            |  898 +++++++++++-----------
>  drivers/pinctrl/sh-pfc/pfc-sh7372.c            |   82 +-
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c            |  409 +++++++---
>  drivers/pinctrl/sh-pfc/pfc-sh7720.c            |  559 +++++++-------
>  drivers/pinctrl/sh-pfc/pfc-sh7722.c            |  770 +++++++++---------
>  drivers/pinctrl/sh-pfc/pfc-sh7723.c            |  974 +++++++++++-----------
>  drivers/pinctrl/sh-pfc/pfc-sh7724.c            |  990 ++++++++++++------------
>  drivers/pinctrl/sh-pfc/pfc-sh7734.c            |   16 +-
>  drivers/pinctrl/sh-pfc/pfc-sh7757.c            | 1020 ++++++++++++------------
>  drivers/pinctrl/sh-pfc/pfc-sh7785.c            |  568 +++++++-------
>  drivers/pinctrl/sh-pfc/pfc-sh7786.c            |  408 +++++-----
>  drivers/pinctrl/sh-pfc/pfc-shx3.c              |  264 +++---
>  drivers/pinctrl/sh-pfc/pinctrl.c               |  184 ++---
>  drivers/pinctrl/sh-pfc/sh_pfc.h                |   75 ++-
>  include/linux/device.h                         |    7 +
>  include/linux/pinctrl/devinfo.h                |   45 +
>  33 files changed, 5185 insertions(+), 4571 deletions(-)
>  create mode 100644 drivers/base/pinctrl.c
>  create mode 100644 include/linux/pinctrl/devinfo.h
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
