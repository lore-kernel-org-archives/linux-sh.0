From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 Nov 2013 01:45:32 +0000
Subject: [PATCH 0/2] Miscallaneous sh-pfc fixes
Message-Id: <1385430334-12141-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here are two small sh-pfc fixes, based on top of the current pinctrl for-next
branch. The patches are self-explanatory and don't depend on each other.

Laurent Pinchart (2):
  sh-pfc: Share common PORTCR macro definition
  sh-pfc: Fix PINMUX_GPIO macro

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 11 -----------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 11 -----------
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  | 11 -----------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 10 ----------
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  5 ++---
 5 files changed, 2 insertions(+), 46 deletions(-)

-- 
Regards,

Laurent Pinchart

