From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 20:51:33 +0000
Subject: [PATCH 00/16] SCIF, I2C and FSI pinctrl functions for sh73a0
Message-Id: <1357851109-22103-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set defines pinctrl groups and functions for the SCIF, I2C and FSI
devices on sh73a0. Patches 04/16 to 10/16 replace function GPIOs by proper
pinctrl mappings for those devices, and patches 11/16 to 16/16 remove the
corresponding function GPIOs.

As subtle bugs can easily crawl in the PFC groups and functions I'd appreciate
if someone had time to carefully review patches 01/16 to 03/16.

The patches are based on top of "[PATCH v2 00/29] SH pinctrl and pinmux
implementation". I will rebase my next version of the pinctrl DT patches on
top of them.

Laurent Pinchart (16):
  sh-pfc: sh73a0: Add SCIFA and SCIFB pin groups and functions
  sh-pfc: sh73a0: Add I2C2 and I2C3 pin groups and functions
  sh-pfc: sh73a0: Add FSI pin groups and functions
  ARM: shmobile: ag5evm: Register pinctrl mappings for SCIF
  ARM: shmobile: ag5evm: Register pinctrl mappings for I2C
  ARM: shmobile: ag5evm: Register pinctrl mappings for FSI
  ARM: shmobile: kota2: Register pinctrl mappings for SCIF
  ARM: shmobile: kzm9g: Register pinctrl mappings for SCIF
  ARM: shmobile: kzm9g: Register pinctrl mappings for I2C
  ARM: shmobile: kzm9g: Register pinctrl mappings for FSI
  sh-pfc: sh73a0: Remove SCIFA and SCIFB function GPIOS
  sh-pfc: sh73a0: Remove I2C function GPIOS
  sh-pfc: sh73a0: Remove FSI function GPIOS
  ARM: shmobile: sh73a0: Remove SCIFA and SCIFB function GPIOs
  ARM: shmobile: sh73a0: Remove I2C function GPIOs
  ARM: shmobile: sh73a0: Remove FSI function GPIOs

 arch/arm/mach-shmobile/board-ag5evm.c        |   41 +-
 arch/arm/mach-shmobile/board-kota2.c         |   42 +-
 arch/arm/mach-shmobile/board-kzm9g.c         |   31 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h |  133 ++---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c          |  766 ++++++++++++++++++++++----
 5 files changed, 770 insertions(+), 243 deletions(-)

-- 
Regards,

Laurent Pinchart

