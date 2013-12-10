From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Dec 2013 15:25:15 +0000
Subject: [GIT PULL FOR v3.14] pinctrl sh-pfc patches
Message-Id: <7350665.cppfL7BT7r@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

The following changes since commit 18334c8e18b2cea1c5c1ad4103ea1bf359a21775:

  pinctrl: make the MSM SoC driver depend on OF (2013-12-10 10:03:47 +0100)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pfc

for you to fetch changes up to 2ef3967ef5b7e37af5b87beae67cdb24a318f324:

  sh-pfc: r8a7791: Fix msiof groups to follow GROUP (2013-12-10 16:22:55 
+0100)

----------------------------------------------------------------
Kuninori Morimoto (2):
      sh-pfc: r8a7790: Add SSI pin support
      sh-pfc: r8a7790: Add Audio pin support

Laurent Pinchart (1):
      sh-pfc: Share common PORTCR macro definition

Takashi Yoshii (1):
      sh-pfc: r8a7791: Fix msiof groups to follow GROUP

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  11 --
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  11 --
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 307 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  21 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |  11 --
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  10 --
 drivers/pinctrl/sh-pfc/sh_pfc.h      |   3 +-
 7 files changed, 323 insertions(+), 51 deletions(-)

-- 
Regards,

Laurent Pinchart

