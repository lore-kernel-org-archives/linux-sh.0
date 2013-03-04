From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 04 Mar 2013 07:17:54 +0000
Subject: [PATCH 0/5] ARM: shmobile: Add R-Car M1A Bock-W support
Message-Id: <87y5e3pra9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are R-Car M1A chip and Bock-W board support

Bock-W board needs ${LINUX}/arch/arm/tools/mach-types

bockw                  MACH_BOCKW              BOCKW                   3386

ARM Web site already has Bock-W, mach-types will be updated
if upstream kernel has it.

This series doesn't support DT yet.
I'm working for it, but still doesn't work.
I will send my current DT support work for R-Car M1,
it is very helpful for me if you give feedback.

These patches are based on simon/next branch

Kuninori Morimoto (5):
      ARM: shmobile: add R8A7778 setup support
      ARM: shmobile: add R8A7778 clock support
      ARM: shmobile: add R8A7778 intc support
      ARM: shmobile: add r8a7778 GPIO/PFC support
      ARM: shmobile: add R-Car M1A Bock-W platform support

 arch/arm/configs/bockw_defconfig              |   95 +
 arch/arm/mach-shmobile/Kconfig                |   12 +
 arch/arm/mach-shmobile/Makefile               |    2 +
 arch/arm/mach-shmobile/board-bockw.c          |  126 ++
 arch/arm/mach-shmobile/clock-r8a7778.c        |  109 ++
 arch/arm/mach-shmobile/include/mach/common.h  |    8 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  292 +++
 arch/arm/mach-shmobile/intc-r8a7778.c         |   64 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |  309 +++
 drivers/pinctrl/sh-pfc/Makefile               |    1 +
 drivers/pinctrl/sh-pfc/core.h                 |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c          | 2503 +++++++++++++++++++++++++
 12 files changed, 3522 insertions(+)


Best regards
---
Kuninori Morimoto
