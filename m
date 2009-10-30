From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:23:31 +0000
Subject: [PATCH 00/09] sh:  sh: SuperH Mobile Sleep Mode Rewrite Part 2/2
Message-Id: <20091030042331.11783.88942.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: SuperH Mobile Sleep Mode Rewrite Part 2/2

[PATCH 01/09] sh: Move ap325rxa board code into separate directory
[PATCH 02/09] sh: Add ap325rxa specific memory pre/post sleep code
[PATCH 03/09] sh: Add Ecovec24 specific memory pre/post sleep code
[PATCH 04/09] sh: Rework SuperH Mobile sleep mode code
[PATCH 05/09] sh: Keep track of allowed sleep modes
[PATCH 06/09] sh: Add MMU and Cache handling sleep mode code
[PATCH 07/09] sh: Use RSMEM for sleep code on sh7724
[PATCH 08/09] sh: Add R-standby sleep mode support
[PATCH 09/09] sh: Add KFR2R09 specific memory pre/post R-standby code

These patches implement the second part of the sleep mode rewrite
for SuperH Mobile. This part includes the latest R-standby support.

This and the previous patch set have been tested with CONFIG_SUSPEND
on Migo-R, AP325RXA, MS7724SE, KFR2R09 and Ecovec24.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/Makefile                      |    1 
 arch/sh/boards/Makefile               |    1 
 arch/sh/boards/board-ap325rxa.c       |  610 --------------------------------
 arch/sh/boards/mach-ap325rxa/Makefile |    4 
 arch/sh/boards/mach-ap325rxa/sdram.S  |   69 +++
 arch/sh/boards/mach-ap325rxa/setup.c  |  623 +++++++++++++++++++++++++++++++++
 arch/sh/boards/mach-ecovec24/Makefile |    1 
 arch/sh/boards/mach-ecovec24/sdram.S  |   52 ++
 arch/sh/boards/mach-ecovec24/setup.c  |   14 
 arch/sh/boards/mach-kfr2r09/sdram.S   |   28 +
 arch/sh/boards/mach-kfr2r09/setup.c   |    3 
 arch/sh/include/asm/suspend.h         |   50 ++
 arch/sh/kernel/asm-offsets.c          |   23 +
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   42 +-
 arch/sh/kernel/cpu/shmobile/pm.c      |  101 ++++-
 arch/sh/kernel/cpu/shmobile/sleep.S   |  348 ++++++++++--------
 16 files changed, 1163 insertions(+), 807 deletions(-)
