From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 09 Jun 2015 07:14:38 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7740: move I2C errata handling into the driver
Message-Id: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

This series moves the errata handling from the setup function into the driver.
It has been tested that this changeset does not cause a regression on the
armadillo board we had access to. Unfortunately, this board did not need the
workaround at all, only some revisions of the r8a7740 are affected.

After a short discussion with Simon, we agreed this should go via I2C.

Wolfram Sang (2):
  i2c: sh_mobile: add errata workaround
  ARM: shmobile: r8a7740: remove I2C errata handling

 arch/arm/mach-shmobile/setup-r8a7740.c | 55 ----------------------------------
 drivers/i2c/busses/i2c-sh_mobile.c     | 40 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 55 deletions(-)

-- 
2.1.4

