From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Oct 2014 07:46:47 +0000
Subject: [PATCH 00/03] ARM: shmobile: Board removal festivities
Message-Id: <20141029074647.405.25250.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Board removal festivities

[PATCH 01/03] ARM: shmobile: lager-reference: DTS-only board support
[PATCH 02/03] ARM: shmobile: lager: Remove legacy board support
[PATCH 03/03] ARM: shmobile: mackerel: Remove legacy board support

Rework Lager to be supported by DTS only and phase out the old
Mackerel board support code. SoC code is not touched due to merge
dependencies, so r8a7790 and sh7372 legacy SoC code is still around.

Simon, do you want me to remove legacy SoC code as well, or shall we wait?

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20141028-v3.18-rc2
 
 arch/arm/mach-shmobile/Kconfig                        |   21 
 arch/arm/mach-shmobile/Makefile                       |    3 
 arch/arm/mach-shmobile/Makefile.boot                  |    2 
 arch/arm/mach-shmobile/board-lager-reference.c        |   39 
 arch/arm/mach-shmobile/board-lager.c                  |  885 ---------
 arch/arm/mach-shmobile/board-mackerel.c               | 1522 -----------------
 arch/arm/mach-shmobile/include/mach/head-mackerel.txt |   93 -
 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h    |   38 
 arch/arm/mach-shmobile/include/mach/mmc.h             |    5 
 arch/arm/mach-shmobile/include/mach/zboot.h           |    5 
 10 files changed, 1 insertion(+), 2612 deletions(-)
