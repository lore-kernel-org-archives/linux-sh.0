From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 16 Jul 2015 07:53:42 +0000
Subject: [PATCH 00/03] ARM: shmobile: r8a7779 Marzen legacy removal
Message-Id: <20150716075342.1198.63257.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7779 Marzen legacy removal

[PATCH 01/03] ARM: shmobile: marzen: Remove legacy board code
[PATCH 02/03] ARM: shmobile: r8a7779: Remove legacy SoC code
[PATCH 03/03] ARM: shmobile: Remove marzen_defconfig

This series removes the r8a7779 Marzen legacy code. Board
code for Marzen written in C and r8a7779 SoC code including
old clock framework code and platform devices are removed.

Existing Marzen users need to move over to Multiplatform and
shmobile_defconfig. The DT file r8a7779-marzen.dts file is
the same as for the legacy case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150716-v4.2-rc2
 No special dependencies

 arch/arm/boot/dts/Makefile             |    3 
 arch/arm/configs/marzen_defconfig      |  124 -----
 arch/arm/mach-shmobile/Kconfig         |    7 
 arch/arm/mach-shmobile/Makefile        |    2 
 arch/arm/mach-shmobile/Makefile.boot   |    1 
 arch/arm/mach-shmobile/board-marzen.c  |  347 ----------------
 arch/arm/mach-shmobile/clock-r8a7779.c |  271 ------------
 arch/arm/mach-shmobile/r8a7779.h       |   17 
 arch/arm/mach-shmobile/setup-r8a7779.c |  676 --------------------------------
 arch/arm/mach-shmobile/smp-r8a7779.c   |    9 
 10 files changed, 5 insertions(+), 1452 deletions(-)
