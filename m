From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:03 +0000
Subject: [PATCH 00/35] Fully migrate sh7372 to pinctrl
Message-Id: <1366671758-8954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set migrates the r8a7740 platforms to pinctrl, function by function,
and then removes function GPIO support completely.

The patches are based on tags/renesas-next-20130422. They have been tested on
Mackerel only as I don't have an ap4evb board.

Laurent Pinchart (35):
  sh-pfc: sh7372: Add BSC pin groups and functions
  sh-pfc: sh7372: Add CEU pin groups and functions
  sh-pfc: sh7372: Add FLCTL pin groups and functions
  sh-pfc: sh7372: Add FSI pin groups and functions
  sh-pfc: sh7372: Add HDMI pin groups and functions
  sh-pfc: sh7372: Add INTC pin groups and functions
  sh-pfc: sh7372: Add KEYSC pin groups and functions
  sh-pfc: sh7372: Add LCDC pin groups and functions
  sh-pfc: sh7372: Add SCIF pin groups and functions
  sh-pfc: sh7372: Add USB pin groups and functions
  ARM: shmobile: mackerel: Register pinctrl mapping for the ADXL34X
  ARM: shmobile: mackerel: Register pinctrl mapping for CEU
  ARM: shmobile: mackerel: Register pinctrl mapping for FLCTL
  ARM: shmobile: mackerel: Register pinctrl mapping for FSI
  ARM: shmobile: mackerel: Register pinctrl mapping for HDMI
  ARM: shmobile: mackerel: Register pinctrl mapping for LCD
  ARM: shmobile: mackerel: Register pinctrl mapping for SCIF
  ARM: shmobile: mackerel: Register IRQ pinctrl mapping for SDHI0
  ARM: shmobile: mackerel: Register pinctrl mapping for SMSC911x
  ARM: shmobile: mackerel: Register pinctrl mapping for ST1232
  ARM: shmobile: mackerel: Register pinctrl mapping for TCA6416
  ARM: shmobile: mackerel: Register pinctrl mapping for USBHS
  ARM: shmobile: ap4evb: Register pinctrl mapping for CEU
  ARM: shmobile: ap4evb: Register pinctrl mapping for FSI
  ARM: shmobile: ap4evb: Register pinctrl mapping for HDMI
  ARM: shmobile: ap4evb: Register pinctrl mapping for KEYSC
  ARM: shmobile: ap4evb: Register pinctrl mapping for LCD
  ARM: shmobile: ap4evb: Register pinctrl mapping for SCIF
  ARM: shmobile: ap4evb: Register pinctrl mapping for SMSC911x
  ARM: shmobile: ap4evb: Simplify tsc2007 pen state read function
  ARM: shmobile: ap4evb: Register pinctrl mapping for TSC2007
  ARM: shmobile: ap4evb: Register pinctrl mapping for USBHS
  sh-pfc: sh7372: Replace GPIO_PORTx enum with GPIO port numbers
  sh-pfc: sh7372: Remove function GPIOs
  ARM: shmobile: sh7372: Remove all GPIOs

 arch/arm/mach-shmobile/board-ap4evb.c        |  132 ++-
 arch/arm/mach-shmobile/board-mackerel.c      |  171 ++--
 arch/arm/mach-shmobile/include/mach/sh7372.h |  391 --------
 drivers/pinctrl/sh-pfc/pfc-sh7372.c          | 1313 ++++++++++++++++++++------
 4 files changed, 1158 insertions(+), 849 deletions(-)

-- 
Regards,

Laurent Pinchart

