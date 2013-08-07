From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 07 Aug 2013 12:02:21 +0000
Subject: [PATCH 0/2] R8A7790 PFC DU support
Message-Id: <1375876943-11824-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Those two patches add pin groups and functions for the Display Unit in the
R8A7790 SoC. They're based on the latest pinctrl/for-next branch and can be
found in my git tree at

	git://linuxtv.org/pinchartl/fbdev.git pinmux/next/r8a7790

Laurent Pinchart (2):
  sh-pfc: r8a7790: Rename DU1_DOTCLKIN to DU_DOTCLKIN1
  sh-pfc: r8a7790: Add DU pin groups and functions

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 142 ++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

