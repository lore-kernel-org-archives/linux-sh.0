From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 11:05:35 +0000
Subject: [PATCH 0/6] ARM: shmobile: r8a73a4: detailed clock topology support
Message-Id: <87bo9x5h1h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

These patches adds detailed r8a73a4 clock topology support.
These patches are tested on APE6EVM board.

Kuninori Morimoto (6):
      clk: sh: add sh_clk_reparent_register()
      ARM: shmobile: r8a73a4: add main clock
      ARM: shmobile: r8a73a4: add pll clocks
      ARM: shmobile: r8a73a4: add div4 clocks
      ARM: shmobile: r8a73a4: add div6 clocks
      ARM: shmobile: ape6evm: MP clock parent become EXTAL2

 arch/arm/mach-shmobile/board-ape6evm.c |   15 ++
 arch/arm/mach-shmobile/clock-r8a73a4.c |  384 ++++++++++++++++++++++++++++++--
 drivers/sh/clk/cpg.c                   |   15 +-
 include/linux/sh_clk.h                 |    1 +
 4 files changed, 396 insertions(+), 19 deletions(-)
