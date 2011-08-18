From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:43:59 +0000
Subject: [PATCH 00/07] ARM: mach-shmobile: Initial Kota2 board support
Message-Id: <20110818054359.23410.4526.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: Initial Kota2 board support

[PATCH 01/07] ARM: mach-shmobile: Kota2 SCIFA2 and SMSC911X support
[PATCH 02/07] ARM: mach-shmobile: Kota2 KEYSC support
[PATCH 03/07] ARM: mach-shmobile: Kota2 GPIO Keys support
[PATCH 04/07] ARM: mach-shmobile: Kota2 GPIO LEDs support
[PATCH 05/07] ARM: mach-shmobile: Kota2 MMCIF support
[PATCH 06/07] ARM: mach-shmobile: Kota2 SCIFA4 and SCIFB support
[PATCH 07/07] ARM: mach-shmobile: Kota2 SDHI0 and SDHI1 support

These patches add initial Kota2 board support to mach-shmobile.

With these patches applied the Kota2 board has support for:
SCIFA2, SMSC911X, KEYSC, GPIO-Keys, GPIO-LEDs, MMCIF, SCIFA4,
SCIFB, SDHI0 and SDHI1.

Remaining device support includes LCDC, FSI and I2C.

On top of this support for Runtime PM and DMA Engine will be added.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the Kota2 mach-type entry to build together with
 [PATCH] ARM: mach-shmobile: sh73a0 PFC pull-up support for SDHI0+2

 arch/arm/mach-shmobile/Kconfig       |    7 
 arch/arm/mach-shmobile/Makefile      |    1 
 arch/arm/mach-shmobile/board-kota2.c |  447 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp.c     |   10 
 4 files changed, 461 insertions(+), 4 deletions(-)
  
