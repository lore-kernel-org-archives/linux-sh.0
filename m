From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:01:59 +0000
Subject: [PATCH v2 00/77] SH pin control and GPIO rework with OF support
Message-Id: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi everybody,

Here's the second version of the SH pin control and GPIO rework patches. I've
added OF support for PFC instantiation and GPIO mappings that was missing from
v1. PINCTRL bindings are still missing and will come soon.

The first version of this patch set is available at
https://lkml.org/lkml/2012/11/20/823. I haven't applied the ack's I've received
on patches that have been extensively reworked in v2. Sorry for the
inconvenience. All comments received on v1 should have been addressed.

The GPIO DT bindings have been tested on an SH73A0 platform (KZM-A9-GT) with
the on-board GPIO LEDs. Please see patch 71/77 for a question regarding those
bindings.

The patches are still based on top of v3.7-rc6. You can get them from my git
tree at
 
	git://linuxtv.org/pinchartl/fbdev.git pinmux

The code has been compile-tested on all modified platforms except SH7264 and
SH7269, and runtime tested on SH7372 (Mackerel), SH73A0 (KZM-A9-GT) and
R8A7740 (Armadillo) so far. I will runtime test it on R8A7779 (Marzen).

The SH7264 and SH7269 platforms have no gpiolib support so the PFC code can't
be compiled for them. As the currently implemented arch-level pinmux support
also depends on generic GPIO, we're moving from a situation where the code
isn't used to a different situation where the code isn't used. I don't
consider that as a regression.

Sorry for the numerous checkpatch warnings, patches that move code around or
rename files don't modify the content to make review easier, and thus carry
warnings from the existing code.

Changes since v1:

- Split SoC changes in one patch per SoC to make backporting easier
- Dropped SH7267 and SH7277 changes as support for those SoCs will be removed
  from the kernel
- Removed the sh_pfc_register() function on ARM
- Added OF support for PFC instantiation and GPIO bindings
- Added PFC DT nodes for the Mackerel and KZM9G boards
- Added GPIO LEDs DT nodes for the KZM9G board

Laurent Pinchart (76):
  sh-pfc: Split platform data from the sh_pfc structure
  sh-pfc: Move private definitions and declarations to private header
  sh-pfc: Merge PFC core and pinctrl
  sh-pfc: Merge PFC core and gpio
  sh-pfc: Move platform device and driver to the core
  sh-pfc: Let the compiler decide whether to inline functions
  sh-pfc: Remove check for impossible error condition
  sh-pfc: Sort headers alphabetically
  sh-pfc: Split platform device and platform driver registration
  sh-pfc: Support passing resources through platform device
  ARM: shmobile: Select PINCTRL
  ARM: shmobile: r8a7740: Register PFC platform device
  ARM: shmobile: r8a7779: Register PFC platform device
  ARM: shmobile: sh7372: Register PFC platform device
  ARM: shmobile: sh73a0: Register PFC platform device
  ARM: shmobile: r8a7740: Add pin control resources
  ARM: shmobile: sh7372: Add pin control resources
  ARM: shmobile: sh73a0: Add pin control resources
  sh: Add PFC platform device registration helper function
  sh: sh7203: Register PFC platform device
  sh: sh7264: Register PFC platform device
  sh: sh7269: Register PFC platform device
  sh: sh7720: Register PFC platform device
  sh: sh7722: Register PFC platform device
  sh: sh7723: Register PFC platform device
  sh: sh7724: Register PFC platform device
  sh: sh7734: Register PFC platform device
  sh: sh7757: Register PFC platform device
  sh: sh7785: Register PFC platform device
  sh: sh7786: Register PFC platform device
  sh: shx3: Register PFC platform device
  sh-pfc: Remove platform device registration
  sh-pfc: Remove unused resource and num_resources platform data fields
  sh-pfc: Move driver from drivers/sh/ to drivers/pinctrl/
  sh-pfc: Support pinmux info in driver data instead of platform data
  sh-pfc: Add r8a7740 pinmux support
  sh-pfc: Add r8a7779 pinmux support
  sh-pfc: Add sh7372 pinmux support
  sh-pfc: Add sh73a0 pinmux support
  ARM: shmobile: r8a7740: Use driver-provided pinmux info
  ARM: shmobile: r8a7779: Use driver-provided pinmux info
  ARM: shmobile: sh7372: Use driver-provided pinmux info
  ARM: shmobile: sh73a0: Use driver-provided pinmux info
  sh-pfc: Add sh7203 pinmux support
  sh-pfc: Add sh7264 pinmux support
  sh-pfc: Add sh7269 pinmux support
  sh-pfc: Add sh7720 pinmux support
  sh-pfc: Add sh7722 pinmux support
  sh-pfc: Add sh7723 pinmux support
  sh-pfc: Add sh7724 pinmux support
  sh-pfc: Add sh7734 pinmux support
  sh-pfc: Add sh7757 pinmux support
  sh-pfc: Add sh7785 pinmux support
  sh-pfc: Add sh7786 pinmux support
  sh-pfc: Add shx3 pinmux support
  sh: sh7203: pinmux: Use driver-provided pinmux info
  sh: sh7264: pinmux: Use driver-provided pinmux info
  sh: sh7269: pinmux: Use driver-provided pinmux info
  sh: sh7720: pinmux: Use driver-provided pinmux info
  sh: sh7722: pinmux: Use driver-provided pinmux info
  sh: sh7723: pinmux: Use driver-provided pinmux info
  sh: sh7724: pinmux: Use driver-provided pinmux info
  sh: sh7734: pinmux: Use driver-provided pinmux info
  sh: sh7757: pinmux: Use driver-provided pinmux info
  sh: sh7785: pinmux: Use driver-provided pinmux info
  sh: sh7786: pinmux: Use driver-provided pinmux info
  sh: shx3: pinmux: Use driver-provided pinmux info
  sh: Remove unused sh_pfc_register_info() function
  sh-pfc: Remove pinmux_info definition
  sh-pfc: Move sh_pfc.h from include/linux/ to driver directory
  sh-pfc: Add OF support
  ARM: shmobile: r8a7740: Add pin control device in device tree
  ARM: shmobile: armadillo: Populate platform devices from device tree
  ARM: shmobile: kzm9g: Add pin control device in device tree
  ARM: shmobile: kzm9g: Populate platform devices from device tree
  ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree

Nobuhiro Iwamatsu (1):
  ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   43 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |    6 +
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   18 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |   32 +
 arch/arm/mach-shmobile/Makefile                    |    5 -
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |    3 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |   26 +
 arch/arm/mach-shmobile/setup-r8a7779.c             |   25 +
 arch/arm/mach-shmobile/setup-sh7372.c              |   26 +
 arch/arm/mach-shmobile/setup-sh73a0.c              |   25 +
 arch/sh/Kconfig                                    |   12 +
 arch/sh/include/asm/gpio.h                         |    2 +-
 arch/sh/include/cpu-common/cpu/pfc.h               |   26 +
 arch/sh/kernel/cpu/Makefile                        |    2 +-
 arch/sh/kernel/cpu/pfc.c                           |   33 +
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c            | 1582 +-----------
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c            | 2121 +---------------
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c            | 2823 +-------------------
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c             | 1226 +---------
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c            | 1778 +------------
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c            | 1893 +-------------
 arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c            | 2210 +---------------
 arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c            | 2470 +-----------------
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c            | 2267 +----------------
 arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c            | 1294 +---------
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c            |  822 +------
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c              |  573 +----
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |  116 +
 drivers/pinctrl/sh-pfc/Makefile                    |   21 +
 drivers/{sh/pfc => pinctrl/sh-pfc}/core.c          |  294 ++-
 drivers/pinctrl/sh-pfc/core.h                      |   72 +
 drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c          |  111 +-
 .../pinctrl/sh-pfc}/pfc-r8a7740.c                  |   11 +-
 .../pinctrl/sh-pfc}/pfc-r8a7779.c                  |   29 +-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c                | 1592 +++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7264.c                | 2131 +++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7269.c                | 2834 ++++++++++++++++++++
 .../pinctrl/sh-pfc}/pfc-sh7372.c                   |   11 +-
 .../pinctrl/sh-pfc}/pfc-sh73a0.c                   |   11 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c                | 1236 +++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7722.c                | 1779 ++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7723.c                | 1903 +++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7724.c                | 2225 +++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7734.c                | 2475 +++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7757.c                | 2282 ++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7785.c                | 1304 +++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7786.c                |  837 ++++++
 drivers/pinctrl/sh-pfc/pfc-shx3.c                  |  582 ++++
 drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c       |  149 +-
 {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h |   43 +-
 drivers/sh/Kconfig                                 |    1 -
 drivers/sh/Makefile                                |    1 -
 drivers/sh/pfc/Kconfig                             |   26 -
 drivers/sh/pfc/Makefile                            |    3 -
 59 files changed, 22007 insertions(+), 21424 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
 create mode 100644 arch/sh/include/cpu-common/cpu/pfc.h
 create mode 100644 arch/sh/kernel/cpu/pfc.c
 create mode 100644 drivers/pinctrl/sh-pfc/Kconfig
 create mode 100644 drivers/pinctrl/sh-pfc/Makefile
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/core.c (62%)
 create mode 100644 drivers/pinctrl/sh-pfc/core.h
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c (59%)
 rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-r8a7740.c (99%)
 rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-r8a7779.c (99%)
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7203.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7264.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7269.c
 rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-sh7372.c (99%)
 rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-sh73a0.c (99%)
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7720.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7722.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7723.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7724.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7734.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7757.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7785.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7786.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-shx3.c
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c (76%)
 rename {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h (83%)
 delete mode 100644 drivers/sh/pfc/Kconfig
 delete mode 100644 drivers/sh/pfc/Makefile

-- 
Regards,

Laurent Pinchart

