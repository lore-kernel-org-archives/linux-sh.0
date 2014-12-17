From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 09:42:04 +0000
Subject: [PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
Message-Id: <20141217094204.7039.45337.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit

[PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
[PATCH v2 02/05] ARM: shmobile: sh73a0: Introduce generic setup callback
[PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
[PATCH v2 04/05] ARM: shmobile: kzm9g: Sync with DT reference
[PATCH v2 05/05] ARM: shmobile: kzm9g: Build DTS for Multiplatform

This patch series enables sh73a0 Multiplatform support. At this point
the KZM9G board code written in C is left as-is, but future updates will
make sure to get rid of DT reference DTS and C board code.

To make it work you need the sh73a0 CCF v7 series and the DIV6 v7
series from Ulrich Hecht.

Patch 1-3 should be possible to merge without any special dependencies.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20141217-v3.18

 arch/arm/boot/dts/Makefile            |    3 
 arch/arm/boot/dts/sh73a0-kzm9g.dts    |  342 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/Kconfig        |    5 
 arch/arm/mach-shmobile/Makefile       |    4 
 arch/arm/mach-shmobile/Makefile.boot  |    2 
 arch/arm/mach-shmobile/setup-sh73a0.c |   21 +-
 arch/arm/mach-shmobile/smp-sh73a0.c   |    2 
 7 files changed, 369 insertions(+), 10 deletions(-)
