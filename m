From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Jul 2012 03:53:18 +0000
Subject: [PATCH 0/7] ARM: shmobile: r8a7740: PM support
Message-Id: <87pq8ctc5x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael
Cc Magnus, Simon

These are r8a7740 PM support patch set

Kuninori Morimoto (7):
      1 ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
      2 ARM: shmobile: r8a7740: add basic pm domain support
      3 ARM: shmobile: r8a7740: add A3SP pm domain support
      4 ARM: shmobile: r8a7740: add A4LC pm domain support
      5 ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
      6 ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
      7 ARM: shmobile: armadillo800eva: A3SP domain includes USB

 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |   54 ++++++-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |   35 ++++
 arch/arm/mach-shmobile/pfc-r8a7740.c           |    4 +-
 arch/arm/mach-shmobile/pm-r8a7740.c            |  205 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c         |   22 +++
 6 files changed, 311 insertions(+), 10 deletions(-)


These patches include 2 features.
 1) USB Func enables external IRQ mode   : #1/#5
 2) add PM support                       : others

1) feature are required for A3SP PM domain (#7).

Best regards
---
Kuninori Morimoto
