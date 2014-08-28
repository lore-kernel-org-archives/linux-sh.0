From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Aug 2014 03:34:43 +0000
Subject: [PATCH 00/05] ARM: shmobile: r8a7740 and Armadillo cleanup
Message-Id: <20140828033443.18867.55162.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7740 and Armadillo cleanup

[PATCH 01/05] ARM: shmobile: armadillo800eva: Sync DTS
[PATCH 02/05] ARM: shmobile: armadillo800eva: Build DTS for multiplatform
[PATCH 03/05] ARM: shmobile: r8a7740: Add restart callback
[PATCH 04/05] ARM: shmobile: armadillo800eva reference: Remove C board code
[PATCH 05/05] ARM: shmobile: armadillo800eva reference: Remove DTS

This patch series cleans up the Armadillo board support by removing
the DT reference implementation. To not lose functionality the reset
handling code is moved from (incorrect) board specific location to
the r8a7740 SoC code.

With this patch series applied the "DT Reference" case is now replaced
by r8a7740 Multiplatform using the same DTS/DTB as the r8a7740 legacy
case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20140827-v3.17-rc2

 arch/arm/boot/dts/Makefile                               |    2 
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts  |  300 --------------
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts            |  276 ++++++++++++
 arch/arm/mach-shmobile/Kconfig                           |   15 
 arch/arm/mach-shmobile/Makefile                          |    1 
 arch/arm/mach-shmobile/Makefile.boot                     |    1 
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |  199 ---------
 arch/arm/mach-shmobile/setup-r8a7740.c                   |    8 
 8 files changed, 284 insertions(+), 518 deletions(-)
