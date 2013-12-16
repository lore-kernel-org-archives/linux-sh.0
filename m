From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Dec 2013 19:25:13 +0000
Subject: [PATCH 0/4] pinctrl: sh-pfc: Constify const data
Message-Id: <1387221917-15437-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set makes sure that const data is stored in .rodata. The first
patch and part of the second patch seem to require gcc 4.8 to have an effect,
as gcc 4.7.3 stores the compound literals in .data in this case.

Simon, should I split patch 4/4 or is it fine as-is ?

Laurent Pinchart (4):
  pinctrl: sh-pfc: Constify enum_ids and var_field_width compound
    literals
  pinctrl: sh-pfc: Constify IRQ GPIOs arrays
  pinctrl: sh-pfc: sh: Constify pins and cfg_regs arrays
  pinctrl: sh-pfc: ARM: Constify pins and cfg_regs arrays

 drivers/pinctrl/sh-pfc/gpio.c        |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  4 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  4 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  |  2 +-
 drivers/pinctrl/sh-pfc/pfc-shx3.c    |  2 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 13 +++++++------
 22 files changed, 31 insertions(+), 30 deletions(-)

-- 
Regards,

Laurent Pinchart

