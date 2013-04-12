From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Apr 2013 05:34:23 +0000
Subject: Re: [PATCH 0/3 v3] ARM: shmobile: r8a7778: pinctrl support
Message-Id: <877gk8pb1f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Simon, Magnus

These patches are v3 of r8a7778 pinctrl support

These are based on renesas-next-20130411v2

Main change is [1/3]
I added Laurent's Acked-by on [2/3] [3/3]

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
