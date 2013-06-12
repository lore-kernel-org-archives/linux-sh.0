From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Jun 2013 02:09:59 +0000
Subject: [PATCH 0/3 v4] ARM: shmobile: r8a7778/bockw: add I2C/HSPI/MMC support
Message-Id: <87d2rs6pvv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> 1) - 2) are not SH patch but needed
> 3) - 5) are pfc patches
> 6) - 8) are r8a7778 patches
> 9) - b) are bockw patches
> c) - e) are defconfig patches
> f) - h) are tidyup cleanup patches

These patches are part of 9) - b) v4 I2C/HSPI/MMC support for BockW.
These patches are based on renesas-next-20130611v2 tag

Kuninori Morimoto (3):
      ARM: shmobile: bockw: add I2C device support
      ARM: shmobile: bockw: add SPI FLASH support
      ARM: shmobile: bockw: add MMCIF support

 arch/arm/mach-shmobile/board-bockw.c |   80 +++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)
