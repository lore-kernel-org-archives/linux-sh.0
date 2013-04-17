From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Apr 2013 05:12:21 +0000
Subject: [PATCH 0/6] ARM: shmobile: r8a7778/bockw: add SDHI0 support
Message-Id: <87haj5eo5p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

These patches add SDHI support on Bock-W board.

Please check #5 patch which is directly accessing to
PFC register.
Because (I guess) current pinctrl driver doesn't support
pull-up/down.

#1	: for sh-pfc
#2 - #3 : for r8a7778 soc
#4 - #5 : for bockw board
#6      : for board defconfig

Kuninori Morimoto (6):
      1) sh-pfc: r8a7778: add SDHI support
      2) ARM: shmobile: r8a7778: add SDHI clock support
      3) ARM: shmobile: r8a7778: Register SDHI device
      4) ARM: shmobile: bockw: define FPGA address and rename iomem variable
      5) ARM: shmobile: bockw: add SDHI0 support
      6) ARM: shmobile: bockw: enable SDHI on defconfig

 arch/arm/configs/bockw_defconfig              |    2 +
 arch/arm/mach-shmobile/board-bockw.c          |   42 +++++++++++--
 arch/arm/mach-shmobile/clock-r8a7778.c        |    7 +++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   24 ++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c          |   79 +++++++++++++++++++++++++
 6 files changed, 150 insertions(+), 6 deletions(-)
