From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Oct 2012 02:55:53 +0000
Subject: [PATCH 0/4] ARM: shmobile: r8a7779/marzen I2C/HSPI support
Message-Id: <874nm1wwco.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are I2C/HSPI driver support on r8a7779/marzen.
These are depend on latest linus/master branch

Kuninori Morimoto (4):
      ARM: shmobile: r8a7779: add HSPI clock support
      ARM: shmobile: r8a7779: add I2C clock support
      ARM: shmobile: r8a7779: add I2C driver support
      ARM: shmobile: marzen: add HSPI support

 arch/arm/configs/marzen_defconfig      |    4 ++
 arch/arm/mach-shmobile/board-marzen.c  |   25 +++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c |   16 ++++++-
 arch/arm/mach-shmobile/setup-r8a7779.c |   77 ++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 1 deletion(-)

Best regards
---
Kuninori Morimoto
