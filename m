From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 13 May 2013 08:53:50 +0000
Subject: [PATCH 0/3] ARM: mach-shmobile: lager: support GPIO switche
Message-Id: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This short series adds support for accessing the 4 pins of SW2 as
gpio keys 1 - 4.

As the gpio-keys driver requires IRQ_TYPE_EDGE_BOTH support for this
has been added to the R-Car GPIO driver.

Simon Horman (3):
  gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH
  ARM: shmobile: r8a7790: Configure R-Car GPIO for IRQ_TYPE_EDGE_BOTH
  ARM: mach-shmobile: lager: support GPIO switches

 arch/arm/mach-shmobile/board-lager.c    | 22 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c  |  1 +
 drivers/gpio/gpio-rcar.c                | 27 ++++++++++++++++++++++-----
 include/linux/platform_data/gpio-rcar.h |  1 +
 4 files changed, 46 insertions(+), 5 deletions(-)

-- 
1.8.2.1

