From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 Mar 2013 02:20:13 +0000
Subject: [PATCH 0/2] PFC compilation fixes for v3.10
Message-Id: <1364264415-6020-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here are two fixes for compilation warning and error introduced in the PFC
patches scheduled for v3.10.

Simon, could you please pick these two patches and push them upstream ?

Laurent Pinchart (2):
  sh-pfc: Fix compiler warning when BUG()
  sh: sh7269: Fix compilation by adding missing includes

 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c | 2 ++
 drivers/pinctrl/sh-pfc/core.c           | 1 +
 2 files changed, 3 insertions(+)

-- 
Regards,

Laurent Pinchart

