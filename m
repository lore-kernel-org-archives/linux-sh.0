From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 06:38:35 +0000
Subject: [PATCH 0/2] ARM: shmobile: Use DT for GIC
Message-Id: <87iozo8umw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

1) - 2) patches replace C base .init_irq to DT base .init_irq
on armadillo800eva/marzen, because

 - armadillo800eva/marzen boards are using DT_MACHINE_START()
 - r8a7740/r8a7779 dtsi already has GIC settings

3) - 4) pathces move intc/gic code to setup.c
and remove intc-r8axxx.c

Kuninori Morimoto (4):
      1) ARM: shmobile: armadillo800eva: Use DT for GIC
      2) ARM: shmobile: marzen: Use DT for GIC
      3) ARM: shmobile: r8a7740: move r8a7740_init_irq_of() to setup
      4) ARM: shmobile: r8a7779: move r8a7779_init_irq_xxx() to setup

 arch/arm/mach-shmobile/Makefile                |    4 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 arch/arm/mach-shmobile/board-marzen.c          |    3 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |    1 -
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |    1 -
 arch/arm/mach-shmobile/intc-r8a7740.c          |   68 -------------
 arch/arm/mach-shmobile/intc-r8a7779.c          |  130 ------------------------
 arch/arm/mach-shmobile/setup-r8a7740.c         |   32 ++++++
 arch/arm/mach-shmobile/setup-r8a7779.c         |   80 +++++++++++++++
 9 files changed, 116 insertions(+), 205 deletions(-)

Best regards
---
Kuninori Morimoto
