From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Apr 2013 05:32:44 +0000
Subject: [RFC][PATCH 0/4] ARM: shmobile: r8a7778: pinctrl support
Message-Id: <877gkcb75z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Simon, Magnus

These patches are r8a7778 pinctrl support
But, my belief is 60%.
So, I added [RFC] on this series

>> Laurent

Could you please check patch ?

>> Simon

#2 patch tidyup code position only, no dependency.
These are based on renesas-next-20130405v2 tags
and Laurent's this patch

Subject: [PATCH v2 1/3] gpio-rcar: Add RCAR_GP_PIN macro
Date:	Mon,  8 Apr 2013 12:05:30 +0200

#1 patch is big size.
Please let me know if you can't get #1 patch (SH-ML size limit ?)

Kuninori Morimoto (4):
      1) sh-pfc: Add r8a7778 pinmux support
      2) ARM: shmobile: r8a7778: fixup Ether setup code position
      3) ARM: shmobile: r8a7778: Register PFC drivce
      4) ARM: shmobile: bockw: add pinctrl support

 arch/arm/mach-shmobile/board-bockw.c          |   13 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   41 +-
 drivers/pinctrl/sh-pfc/Kconfig                |    5 +
 drivers/pinctrl/sh-pfc/Makefile               |    1 +
 drivers/pinctrl/sh-pfc/core.c                 |    3 +
 drivers/pinctrl/sh-pfc/core.h                 |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c          | 2359 +++++++++++++++++++++++++
 8 files changed, 2410 insertions(+), 14 deletions(-)


Best regards
---
Kuninori Morimoto
