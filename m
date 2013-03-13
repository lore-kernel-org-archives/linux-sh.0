From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:39:19 +0000
Subject: [PATCH 00/25] sh-pfc: pinconf implementation
Message-Id: <1363214384-3870-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here's a patch set that implements pinconf support for the sh-pfc driver.

The set is based on the "[PATCH 00/23] Further SH PFC cleanup" set that I've
previously posted. Changes since that set are

- fix return value check in sh_pfc_register_pinctrl() (12/25)
- provide a real pinconf implementation instead of removing it (21/25)
- return an error if a pin doesn't support the requested direction (25/25)

As I'm not too familiar with the pinconf API I'd appreciate if 21/25 could be
carefully reviewed.

As before, the first 11 patches add pin control resources to the SH platforms.
They don't depend on any of the previous unmerged PFC patch series but are
required for the rest of this series. Paul, are you fine with merging them
through the ARM tree ? I don't think there's any risk of merge conflicts.

The patches are based on my pinmux/3.9/pinctrl branch and are available at

        git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pinconf

I've rebased the pinmux/3.9/pinctrl branch on top of the pinctrl merge in
Simon's tree.

Laurent Pinchart (24):
  sh: sh7203: Add pin control resources
  sh: sh7264: Add pin control resources
  sh: sh7269: Add pin control resources
  sh: sh7720: Add pin control resources
  sh: sh7722: Add pin control resources
  sh: sh7723: Add pin control resources
  sh: sh7724: Add pin control resources
  sh: sh7757: Add pin control resources
  sh: sh7785: Add pin control resources
  sh: sh7786: Add pin control resources
  sh: shx3: Add pin control resources
  sh-pfc: Move GPIO registers access functions to gpio.c
  sh-pfc: Don't map data registers individually
  sh-pfc: Drop unused support for 1:1 physical to virtual memory
    mappings
  sh-pfc: Don't modify pinmux_data_reg SoC data
  sh-pfc: Don't modify sh_pfc_pin SoC data
  sh-pfc: Remove configuration dry-run and free
  sh-pfc: Constify all SoC data
  sh-pfc: Use proper error codes
  sh-pfc: Implement generic pinconf support
  sh-pfc: Merge sh_pfc_reconfig_pin() into sh_pfc_gpio_set_direction()
  sh-pfc: Clean up pin configuration type handling
  sh-pfc: Convert message printing from pr_* to dev_*
  sh-pfc: Return an error if a pin doesn't support the requested
    direction

Wei Yongjun (1):
  sh-pfc: Fix return value check in sh_pfc_register_pinctrl()

 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c |  13 +-
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c |  13 +-
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c |  11 +-
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c  |  14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c |  14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c |  14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c |  13 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |  13 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c |  14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |  14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c   |  17 +-
 drivers/pinctrl/sh-pfc/Kconfig          |   1 +
 drivers/pinctrl/sh-pfc/core.c           | 228 +++++--------------------
 drivers/pinctrl/sh-pfc/core.h           |  49 +++---
 drivers/pinctrl/sh-pfc/gpio.c           | 222 +++++++++++++++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c    |  12 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c    |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c     |  12 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c     |  14 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7722.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-sh7786.c     |  10 +-
 drivers/pinctrl/sh-pfc/pfc-shx3.c       |  10 +-
 drivers/pinctrl/sh-pfc/pinctrl.c        | 285 +++++++++++++++++++-------------
 drivers/pinctrl/sh-pfc/sh_pfc.h         |  49 +++---
 33 files changed, 654 insertions(+), 498 deletions(-)

-- 
Regards,

Laurent Pinchart

