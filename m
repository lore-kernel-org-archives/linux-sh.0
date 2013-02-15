From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 15 Feb 2013 13:48:35 +0000
Subject: [PATCH 0/2] shmobile: kzm9g: correct smsc regulator registration
Message-Id: <1360936117-21765-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Correct registration of regulators for the SMSC device on the kzm9g
and update the defconfig accordingly.

Simon Horman (2):
  ARM: shmobile: kzm9g: correct smsc regulator registration
  ARM: mach-shmobile: kzm9g: do not enable REGULATOR_DUMMY in defconfig

 arch/arm/configs/kzm9g_defconfig     |    1 -
 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

