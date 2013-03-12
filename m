From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 12 Mar 2013 15:48:26 +0000
Subject: [PATCH v3.1 0/4] More PFC pinctrl functions for sh73a0
Message-Id: <1363103310-16260-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here are more pinctrl pin groups and functions for the sh73a0 KEYSC, BSC, USB
and IrDA devices.

I've inserted the patches right after "sh-pfc: sh73a0: Add SDHI and MMCIF pin
groups and functions" in the "[PATCH v3 00/64] PFC pinctrl functions for
sh7372, sh73a0, r8a7740 and r8a7779" series. The result can be found in my git
tree at

	git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pfc-funcs

Simon, could you please pull the pinmux/3.9/pinctrl and pinmux/3.9/pfc-funcs
branches into your tree ?

I'd like to get the pinmux/3.9/pfc-cleanup branch in v3.10 as well. It
includes arm/sh/* changes that could in my opinion go through the ARM tree to
avoid dependency issues upstream, but I'd like to get a confirmation from Paul
first.

Laurent Pinchart (4):
  sh-pfc: sh73a0: Add KEYSC pin groups and functions
  sh-pfc: sh73a0: Add BSC pin groups and functions
  sh-pfc: sh73a0: Add USB pin groups and functions
  sh-pfc: sh73a0: Add IrDA pin groups and functions

 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 375 ++++++++++++++++++++++++++++++++++++
 1 file changed, 375 insertions(+)

-- 
Regards,

Laurent Pinchart

