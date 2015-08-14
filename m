From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 14 Aug 2015 13:51:01 +0000
Subject: [PATCH 0/7] Bock-W legacy excision
Message-Id: <1439560268-4935-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This eliminates the last shmobile legacy platform, Bock-W, and with it a
number of other things that have thus become obsolete.

CU
Uli


Ulrich Hecht (7):
  ARM: shmobile: bockw: remove legacy board file and config
  ARM: shmobile: r8a7778: remove obsolete setup code
  ARM: shmobile: Kconfig: remove obsolete option ARCH_R8A7778
  ARM: shmobile: r8a7778: remove legacy clock implementation
  ARM: shmobile: remove ARCH_SHMOBILE_LEGACY option
  ARM: shmobile: bockw: remove legacy defconfig
  MAINTAINERS: remove references to dropped marzen and bockw defconfigs

 MAINTAINERS                            |   2 -
 arch/arm/Kconfig                       |  26 +-
 arch/arm/Kconfig.debug                 |   3 +-
 arch/arm/configs/bockw_defconfig       | 133 ------
 arch/arm/mach-shmobile/Kconfig         |  40 --
 arch/arm/mach-shmobile/Makefile        |  11 -
 arch/arm/mach-shmobile/Makefile.boot   |  11 -
 arch/arm/mach-shmobile/board-bockw.c   | 737 ---------------------------------
 arch/arm/mach-shmobile/clock-r8a7778.c | 342 ---------------
 arch/arm/mach-shmobile/clock.c         |  47 ---
 arch/arm/mach-shmobile/clock.h         |  42 --
 arch/arm/mach-shmobile/r8a7778.h       |  77 ----
 arch/arm/mach-shmobile/setup-r8a7778.c | 560 +------------------------
 13 files changed, 3 insertions(+), 2028 deletions(-)
 delete mode 100644 arch/arm/configs/bockw_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-bockw.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7778.c
 delete mode 100644 arch/arm/mach-shmobile/clock.c
 delete mode 100644 arch/arm/mach-shmobile/clock.h
 delete mode 100644 arch/arm/mach-shmobile/r8a7778.h

-- 
2.4.6

