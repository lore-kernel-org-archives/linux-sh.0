From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 31 Oct 2012 03:05:59 +0000
Subject: [PATCH 0/3] sh/ARM: shmobile: add sh_clk_fsidiv_register()
Message-Id: <87ip9rmjcb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Simon

These patches add sh_clk_fsidiv_register() for FSI-DIV clock control.
This is 1st step of FSI-DT support.
My plan is...

 1st : sh/ARM: add FSI-DIV clock control functions
 2nd : FSI driver supports audio clock calculation method
 3rd : sh/ARM: remove old style .set_rate callback from platform
 4th : FSI support DT
 5th : platform use DT for FSI

Kuninori Morimoto (3):
      sh: clkfwk: add sh_clk_fsidiv_register()
      ARM: shmobile: sh7372: sh7372_fsidivX_clk become non-global
      ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks

 arch/arm/mach-shmobile/board-ap4evb.c        |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c      |    2 +-
 arch/arm/mach-shmobile/clock-sh7372.c        |   92 +++-----------------------
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 -
 drivers/sh/clk/cpg.c                         |   86 ++++++++++++++++++++++++
 include/linux/sh_clk.h                       |    9 +++
 6 files changed, 107 insertions(+), 86 deletions(-)


Best regards
---
Kuninori Morimoto
