From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Mar 2013 18:35:39 +0000
Subject: [PATCH 00/23] Further SH PFC cleanup
Message-Id: <1362940562-8570-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Is there better ways to spend a Sunday than working on further SH PFC
cleanups (hint: there definitely is) ? For your enjoyment here are 23 more
patches that prepare the PFC driver for the big GPIO/PFC split.

The first 11 patches add pin control resources to the SH platforms. They don't
depend on any of the previous unmerged PFC patch series but are required for
the rest of this series. Paul, are you fine with merging them through the ARM
tree ? I don't think there's any risk of merge conflicts.

The rest of the series is really miscellaneous cleanups. Worth to be noted are
the constification of the PFC SoC data and the removal of the unused and badly
implemented pinconf support.

The patches are based on my previous "[PATCH v3 00/64] PFC pinctrl functions
for sh7372, sh73a0, r8a7740 and r8a7779" series and are available at

	git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pfc-cleanup

Laurent Pinchart (23):
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
  sh-pfc: Remove pinconf support
  sh-pfc: Merge sh_pfc_reconfig_pin() into sh_pfc_gpio_set_direction()
  sh-pfc: Clean up pin configuration type handling
  sh-pfc: Convert message printing from pr_* to dev_*

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
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c   |  17 ++-
 drivers/pinctrl/sh-pfc/core.c           | 228 ++++++--------------------------
 drivers/pinctrl/sh-pfc/core.h           |  49 ++++---
 drivers/pinctrl/sh-pfc/gpio.c           | 222 ++++++++++++++++++++++++-------
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
 drivers/pinctrl/sh-pfc/pinctrl.c        | 202 +++++++++-------------------
 drivers/pinctrl/sh-pfc/sh_pfc.h         |  35 ++---
 32 files changed, 533 insertions(+), 521 deletions(-)

-- 
Regards,

Laurent Pinchart

