From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 22 Jan 2014 10:21:26 +0000
Subject: [GIT PULL] Renesas pinctrl patch
Message-Id: <5411991.NWHfO7Sty2@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

The following changes since commit 8385af02bad1724a720f6ba4c1ec590d4f082229:

  pinctrl: sirf: add pin group for USP0 with only RX or TX frame sync 
(2014-01-08 10:51:10 +0100)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pfc

for you to fetch changes up to 18bb6ecc1c2faca550f76c3d2b704d6231b06c66:

  pinctrl: sh-pfc: r8a7791: Add QSPI pin groups (2014-01-12 22:39:10 +0100)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      pinctrl: sh-pfc: r8a7791: Add QSPI pin groups

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 63 +++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

-- 
Regards,

Laurent Pinchart

