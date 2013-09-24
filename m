From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Sep 2013 10:34:03 +0000
Subject: [GIT PULL FOR v3.13] SH PFC pin definitions for I2C and SRU/SSI
Message-Id: <1527335.Z2uP9kBimX@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

Here are two patches that add pin definitions to the sh-pfc driver. If you 
believe they can go to v3.12 please feel free to include them in your next 
fixes pull request. Otherwise please pull them in your for-next branch.

The following changes since commit cfa8b3f54e00b2300a2562c00d4d0cac48379ddb:

  Merge branch 'devel' into for-next (2013-09-23 11:26:59 +0200)

are available in the git repository at:


  git://linuxtv.org/pinchartl/fbdev.git pinmux/next

for you to fetch changes up to 70702bfc13c4f96f2f05d4ce2eb110cd1735fef5:

  sh-pfc: r8a7790: Add I2C pin groups and functions (2013-09-24 12:23:42 
+0200)

----------------------------------------------------------------
Kuninori Morimoto (1):
      sh-pfc: r8a7778: Add SRU/SSI pin support

Ulrich Hecht (1):
      sh-pfc: r8a7790: Add I2C pin groups and functions

 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 125 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  82 ++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

-- 
Regards,

Laurent Pinchart

