From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 14:21:14 +0000
Subject: [PATCH 00/02] SH-Mobile ARM clock framework V2
Message-Id: <20100512142114.28459.16246.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH-Mobile ARM clock framework V2

[PATCH 01/02] ARM: mach-shmobile: Use shared clock framework
[PATCH 02/02] ARM: mach-shmobile: sh7372 clock framework support V2

These patches add SH-Mobile ARM clock framework support for sh7372
using the clock framework in drivers/sh that is shared with SH.

sh7377 and sh7367 clock framework tables will be posted in the not
so distant future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the genesis-2.6 git tree + UIO. Also needs the
 shared clock framework code from SH in place.

 arch/arm/mach-shmobile/Kconfig               |    4 
 arch/arm/mach-shmobile/Makefile              |    4 
 arch/arm/mach-shmobile/board-ap4evb.c        |   16 -
 arch/arm/mach-shmobile/clock-sh7367.c        |   36 --
 arch/arm/mach-shmobile/clock-sh7372.c        |  387 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock.c               |   44 ++
 arch/arm/mach-shmobile/include/mach/common.h |    3 
 arch/arm/mach-shmobile/setup-sh7372.c        |    8 
 drivers/sh/Makefile                          |    2 
 9 files changed, 456 insertions(+), 48 deletions(-)
