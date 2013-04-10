From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Apr 2013 09:29:37 +0000
Subject: [PATCH 0/4 v2] ARM: shmobile: r8a7778: pinctrl support
Message-Id: <87hajeka2q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Simon, Magnus

These patches are v2 of r8a7778 pinctrl support
I removed [RFC] from Subject

These are based on

renesas-next-20130405v2
 + simon/defconfig-bockw
 + simon/soc-r8a7778
 + simon/boards-bockw

and Laurent's this patch

Subject: [PATCH v2 1/3] gpio-rcar: Add RCAR_GP_PIN macro
Date:	Mon,  8 Apr 2013 12:05:30 +0200

Kuninori Morimoto (3):
      sh-pfc: Add r8a7778 pinmux support
      ARM: shmobile: r8a7778: Register PFC device
      ARM: shmobile: bockw: add pinctrl support

 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/board-bockw.c          |   13 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   13 +
 drivers/pinctrl/sh-pfc/Kconfig                |    5 +
 drivers/pinctrl/sh-pfc/Makefile               |    1 +
 drivers/pinctrl/sh-pfc/core.c                 |    3 +
 drivers/pinctrl/sh-pfc/core.h                 |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c          | 2369 +++++++++++++++++++++++++
 9 files changed, 2407 insertions(+)


Best regards
---
Kuninori Morimoto
