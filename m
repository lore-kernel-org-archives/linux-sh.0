From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Aug 2013 08:50:49 +0000
Subject: Re: [PATCH 0/5 v2] ARM: shmobile: bockw: add Sound support
Message-Id: <87haecvns0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Laurent

These are v2 of R-Car sound support on Bock-W board.

It enables PIO transfer only at this point, because
 1) PIO settings is the most easy basic settings
 2) HPB-DMAC is still not enabled on r8a7778

R-Car sound driver is already supporting DMA transfer on ASoC (= Mark's) branch.
So, it is easy to support DMA transfer if r8a7778 has HPB-DMAC support.

To enable R-Car sound on Bock-W board, ASoC branch mergeing is required

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: for-next

These patches are based on renesas-devel-20130823

Kuninori Morimoto (5):
      sh-pfc: r8a7778: add SRU/SSI pin support
      ARM: shmobile: r8a7778: add SSI/SRU clock support
      ARM: shmobile: bockw: enable global use of FPGA
      ARM: shmobile: bockw: add R-Car sound support (PIO)
      ARM: shmobile: bockw defconfig: add Sound support

 arch/arm/configs/bockw_defconfig       |    4 +
 arch/arm/mach-shmobile/Kconfig         |    2 +
 arch/arm/mach-shmobile/board-bockw.c   |  289 +++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7778.c |   43 ++++-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c   |  125 ++++++++++++++
 5 files changed, 453 insertions(+), 10 deletions(-)

Best regards
---
Kuninori Morimoto
