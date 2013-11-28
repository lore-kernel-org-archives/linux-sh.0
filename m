From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 15:20:02 +0000
Subject: [PATCH 0/2] sh-pfc: Fix pin bias setup
Message-Id: <1385652004-7117-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These two patches fix typos in the pin bias setup code for r8a7740 and sh7372
that resulted in the incorrect register being written when configuring pull-ups
and pull-downs.

Laurent Pinchart (2):
  sh-pfc: r8a7740: Fix pin bias setup
  sh-pfc: sh7372: Fix pin bias setup

 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

