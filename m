From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:16:21 +0000
Subject: [PATCH 0/4] sh73a0: Expose the PFC-controller SDHI power gate as a regulator
Message-Id: <1366672585-9098-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

The sh73a0 has an internal power gate on the VCCQ power supply for the SDHI0
device that is controlled (for some strange reason) by a bit in a PFC
register.

This patch set exposes the power gate as a regulator. As the only currently
supported board (kzm9g) has the VCCQ_MC0 pins directly connected to an always
on 3.3V supply, the code assumes that the external VCCQ power supply can't be
controlled. This could be fixed later by setting the regulator supply name.

As this series turns the power off when not needed it might bring additional
power saving, but this hasn't been measured. If the patches are considered too
complex a simpler approach would be to turn the power gate on when the SDHI
function is selected.

The patches are based on tags/renesas-next-20130422. They have been tested on
kzm9g.

Laurent Pinchart (4):
  sh-pfc: Add support for SoC-specific initialization
  sh-pfc: sh73a0: Add VCCQ MC0 regulator
  ARM: shmobile: kzm9g: Remove the VCCQ MC0 function GPIO
  ARM: shmobile: kzm9g-reference: Remove the VCCQ MC0 function GPIO

 arch/arm/mach-shmobile/board-kzm9g-reference.c |   1 -
 arch/arm/mach-shmobile/board-kzm9g.c           |   3 -
 drivers/pinctrl/sh-pfc/Kconfig                 |   1 +
 drivers/pinctrl/sh-pfc/core.c                  |  16 ++-
 drivers/pinctrl/sh-pfc/core.h                  |   1 +
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            | 134 +++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/sh_pfc.h                |   2 +
 7 files changed, 153 insertions(+), 5 deletions(-)

-- 
Regards,

Laurent Pinchart

