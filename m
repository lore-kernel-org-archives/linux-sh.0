From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 23 Feb 2012 05:32:23 +0000
Subject: [PATCH 00/05] ARM: mach-shmobile: Resending 3.3-rc patches
Message-Id: <20120223053223.2040.38757.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: Resending 3.3-rc patches

[PATCH 01/05] ARM: mach-shmobile: r8a7779 PFC IPSR4 fix
[PATCH 02/05] ARM: mach-shmobile: sh73a0 PSTR 32-bit access fix
[PATCH 03/05] ARM: mach-shmobile: sh73a0 PINT IRQ base fix
[PATCH 04/05] ARM: mach-shmobile: sh73a0 IRQ sparse alloc fix
[PATCH 05/05] ARM: mach-shmobile: IRQ driven GPIO key support for Kota2

The above patches were submitted for inclusion in 3.3-rc last month,
but since I cannot find them in Linus tree I'm now resending.

The first 4 patches are crystal clear fixes, but the last one is perhaps
not as obvious as 3.3-rc material. The patch is however limited to simple
platform data for a single device on a particular board, and with the
patch applied it is possible to test patches 3 and 4.

Rafael, can you please pick up?

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c         |    3 +--
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    6 +++---
 arch/arm/mach-shmobile/intc-sh73a0.c         |    2 ++
 arch/arm/mach-shmobile/pfc-r8a7779.c         |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c          |    2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)
