From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:41 +0000
Subject: [PATCH 00/37] Fully migrate r8a7740 to pinctrl
Message-Id: <1366671618-8796-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set migrates the r8a7740 platforms to pinctrl, function by function,
and then removes function GPIO support completely.

The patches have been tested on Armadillo only as I don't have a Bonito board.

Laurent Pinchart (37):
  sh-pfc: r8a7740: Add SCIF pin groups and functions
  sh-pfc: r8a7740: Declare missing INTC function
  sh-pfc: r8a7740: Add BSC pin groups and functions
  sh-pfc: r8a7740: Add GETHER pin groups and functions
  sh-pfc: r8a7740: Add CEU pin groups and functions
  sh-pfc: r8a7740: Add FSI pin groups and functions
  sh-pfc: r8a7740: Add HDMI pin groups and functions
  sh-pfc: r8a7740: Hardcode the LCDC0 output
  ARM: shmobile: armadillo800eva: Register pinctrl mapping for INTC
  ARM: shmobile: armadillo800eva: Register pinctrl mapping for GETHER
  ARM: shmobile: armadillo800eva: Register pinctrl mapping for CEU0
  ARM: shmobile: armadillo800eva: Register pinctrl mapping for FSI
  ARM: shmobile: armadillo800eva: Register pinctrl mapping for HDMI
  ARM: shmobile: armadillo800eva: Don't configure LCDC routing manually
  ARM: shmobile: armadillo800eva: Replace GPIO_PORTx with GPIO port
    numbers
  ARM: shmobile: bonito: Remove empty core devices array
  ARM: shmobile: bonito: Register pinctrl mapping for SCIF
  ARM: shmobile: bonito: Register pinctrl mapping for INTC
  ARM: shmobile: bonito: Register pinctrl mapping for BSC
  ARM: shmobile: bonito: Don't configure LCDC routing manually
  sh-pfc: r8a7740: Remove SCIF function GPIOS
  sh-pfc: r8a7740: Remove INTC function GPIOS
  sh-pfc: r8a7740: Remove BSC function GPIOS
  sh-pfc: r8a7740: Remove GETHER function GPIOS
  sh-pfc: r8a7740: Remove CEU function GPIOS
  sh-pfc: r8a7740: Remove FSI function GPIOS
  sh-pfc: r8a7740: Remove HDMI function GPIOS
  ARM: shmobile: r8a7740: Remove SCIF function GPIOs
  ARM: shmobile: r8a7740: Remove INTC function GPIOs
  ARM: shmobile: r8a7740: Remove BSC function GPIOs
  ARM: shmobile: r8a7740: Remove GETHER function GPIOs
  ARM: shmobile: r8a7740: Remove CEU function GPIOs
  ARM: shmobile: r8a7740: Remove FSI function GPIOs
  ARM: shmobile: r8a7740: Remove HDMI function GPIOs
  sh-pfc: r8a7740: Remove function GPIOs
  sh-pfc: r8a7740: Replace GPIO_PORTx enum with GPIO port numbers
  ARM: shmobile: r8a7740: Remove all GPIOs

 arch/arm/mach-shmobile/board-armadillo800eva.c |  108 +-
 arch/arm/mach-shmobile/board-bonito.c          |   47 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |  488 ---------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           | 1322 ++++++++++++++++--------
 4 files changed, 952 insertions(+), 1013 deletions(-)

-- 
Regards,

Laurent Pinchart

