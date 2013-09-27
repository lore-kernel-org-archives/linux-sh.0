From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 27 Sep 2013 00:10:55 +0000
Subject: [GIT PULL v2 FOR v3.13] SH PFC pin definitions for I2C and SRU/SSI
Message-Id: <5568164.3mozjzet5g@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

If you haven't merged my previous pull request yet, here's an update with a 
third patch that adds support for the I2C3 controller's pins on R8A7790.

As before, if you believe the patches can go to v3.12 in the -rc phase please 
feel free to include them in your next fixes pull request, otherwise please 
pull them in your for-next branch.

The following changes since commit cfa8b3f54e00b2300a2562c00d4d0cac48379ddb:

  Merge branch 'devel' into for-next (2013-09-23 11:26:59 +0200)

are available in the git repository at:


  git://linuxtv.org/pinchartl/fbdev.git pinmux/next

for you to fetch changes up to f6aaaac9995084e496d4ff800d092a8c0cb12641:

  sh-pfc: r8a7790: add pin definitions for the I2C3 interface (2013-09-27 
02:03:52 +0200)

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      sh-pfc: r8a7790: add pin definitions for the I2C3 interface

Kuninori Morimoto (1):
      sh-pfc: r8a7778: Add SRU/SSI pin support

Ulrich Hecht (1):
      sh-pfc: r8a7790: Add I2C pin groups and functions

 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 125 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 110 +++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+)

-- 
Regards,

Laurent Pinchart

