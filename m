From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 08 Apr 2013 10:05:29 +0000
Subject: [PATCH v2 0/3] sh-pfc: r8a7779: Improve readability with a new macro
Message-Id: <1365415532-24544-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This is the second version of the r8a7779 PFC readability improvement patches
that use a macro to convert from the documentation pin number space to the
linear pinctrl space.

Note that patch 1/3 has already been posted as part of the "r8a7790 PFC pinctrl
and GPIO improvements" patch series. Depending on the merge order one of them
should be dropped.

Simon, is there a chance you could queue this to your pinmux branch for v3.10 ?

Changes from v1:

- Rename the macro to RCAR_GP_PIN
- Define the macro in a single header file

Laurent Pinchart (3):
  gpio-rcar: Add RCAR_GP_PIN macro
  sh-pfc: r8a7779: Replace hardcoded pin numbers with RCAR_GP_PIN macro
  ARM: shmobile: marzen: Use RCAR_GP_PIN macro

 arch/arm/mach-shmobile/board-marzen.c   |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c    | 294 ++++++++++++++++++--------------
 include/linux/platform_data/gpio-rcar.h |   2 +
 3 files changed, 170 insertions(+), 133 deletions(-)

-- 
Regards,

Laurent Pinchart

