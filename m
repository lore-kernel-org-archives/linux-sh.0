From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 09 Mar 2012 20:55:04 +0000
Subject: [GIT PULL] Renesas SoC updates for v3.4
Message-Id: <201203092155.04731.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Paul Mundt <lethal@linux-sh.org>

Hi,

Please pull Renesas SoC updates for v3.4 since commit
ce8fea7aa4ad9e3b40999a08622ef27c77159659:

    mmap: EINVAL not ENOMEM when rejecting VM_GROWS

with top-most commit f57fd2100e8273af3a9d2ff67714903d2dfd1eef

    ARM: mach-shmobile: default to no earlytimer

from the git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc

They include:

* The rename of shmobile struct clk_ops to struct sh_clk_ops to avoid
  possible future name space collision with common struct clk code.

  This also affects drivers that are shared with the sh architecture,
  so the branch containing this part of the material, clk_ops-rename,
  will be merged into the Paul Mundt's sh tree if necessary.

* Introduction of L2 Cache support for r8a7779.

* Conversion of the mach-shmobile subarch to properly use a per-SoC
  map_io and separate init_early callback for early serial console
  support on platforms where that is possible.

Magnus Damm is the author of all the changes.


 arch/arm/mach-shmobile/board-ag5evm.c        |   39 +---------------
 arch/arm/mach-shmobile/board-ap4evb.c        |   44 +++----------------
 arch/arm/mach-shmobile/board-bonito.c        |   44 +++++-------------
 arch/arm/mach-shmobile/board-g3evm.c         |   38 +--------------
 arch/arm/mach-shmobile/board-g4evm.c         |   38 +--------------
 arch/arm/mach-shmobile/board-kota2.c         |   38 +--------------
 arch/arm/mach-shmobile/board-mackerel.c      |   44 +++----------------
 arch/arm/mach-shmobile/board-marzen.c        |   62 +------------------------
 arch/arm/mach-shmobile/clock-r8a7740.c       |    8 ++--
 arch/arm/mach-shmobile/clock-r8a7779.c       |    4 +-
 arch/arm/mach-shmobile/clock-sh7367.c        |    8 ++--
 arch/arm/mach-shmobile/clock-sh7372.c        |   10 ++--
 arch/arm/mach-shmobile/clock-sh7377.c        |    8 ++--
 arch/arm/mach-shmobile/clock-sh73a0.c        |   14 +++---
 arch/arm/mach-shmobile/clock.c               |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h |    9 +++-
 arch/arm/mach-shmobile/setup-r8a7740.c       |   45 +++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c       |   54 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7367.c        |   32 +++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c        |   32 +++++++++++++
 arch/arm/mach-shmobile/setup-sh7377.c        |   32 +++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c        |   32 +++++++++++++
 arch/arm/mach-shmobile/timer.c               |    6 ++-
 arch/sh/boards/mach-highlander/setup.c       |    2 +-
 arch/sh/boards/mach-sdk7786/setup.c          |    2 +-
 arch/sh/include/asm/clock.h                  |    2 +-
 arch/sh/kernel/cpu/sh2/clock-sh7619.c        |   12 +++---
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c       |   12 +++---
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c       |   12 +++---
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c       |   12 +++---
 arch/sh/kernel/cpu/sh3/clock-sh3.c           |   12 +++---
 arch/sh/kernel/cpu/sh3/clock-sh7705.c        |   12 +++---
 arch/sh/kernel/cpu/sh3/clock-sh7706.c        |   12 +++---
 arch/sh/kernel/cpu/sh3/clock-sh7709.c        |   12 +++---
 arch/sh/kernel/cpu/sh3/clock-sh7710.c        |   12 +++---
 arch/sh/kernel/cpu/sh3/clock-sh7712.c        |   10 ++--
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c       |    6 +-
 arch/sh/kernel/cpu/sh4/clock-sh4.c           |   12 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c       |    4 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c       |    4 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c       |    4 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c       |    4 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c       |    6 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c       |   14 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c       |   12 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c       |   14 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c         |    2 +-
 arch/sh/kernel/cpu/sh5/clock-sh5.c           |   12 +++---
 drivers/sh/clk/cpg.c                         |   16 +++---
 include/linux/sh_clk.h                       |    5 +-
 53 files changed, 429 insertions(+), 459 deletions(-)

---------------

Magnus Damm (35):
      sh: introduce sh_clk_ops in parallel with clk_ops
      sh: convert cpg code to sh_clk_ops
      ARM: mach-shmobile: sh7367 sh_clk_ops rename
      ARM: mach-shmobile: sh7377 sh_clk_ops rename
      ARM: mach-shmobile: sh7372 sh_clk_ops rename
      ARM: mach-shmobile: sh73a0 sh_clk_ops rename
      ARM: mach-shmobile: r8a7740 sh_clk_ops rename
      ARM: mach-shmobile: r8a7779 sh_clk_ops rename
      sh: sh header sh_clk_ops rename
      sh: sh2 sh_clk_ops rename
      sh: sh2a sh_clk_ops rename
      sh: sh3 sh_clk_ops rename
      sh: sh4 sh_clk_ops rename
      sh: sh4a sh_clk_ops rename
      sh: sh5 sh_clk_ops rename
      sh: board sh_clk_ops rename
      sh: remove clk_ops
      ARM: mach-shmobile: sh7367 map_io and init_early update
      ARM: mach-shmobile: sh7377 map_io and init_early update
      ARM: mach-shmobile: sh7372 map_io and init_early update
      ARM: mach-shmobile: sh73a0 map_io and init_early update
      ARM: mach-shmobile: r8a7740 map_io and init_early update
      ARM: mach-shmobile: r8a7779 map_io and init_early update
      ARM: mach-shmobile: r8a7779 L2 cache support
      ARM: mach-shmobile: rename clk_init() to shmobile_clk_init()
      ARM: mach-shmobile: Move sh7372 Mackerel external clk setup
      ARM: mach-shmobile: Move sh7372 AP4EVB external clk setup
      ARM: mach-shmobile: add shmobile_earlytimer_init()
      ARM: mach-shmobile: sh7367 and G3EVM timer rework
      ARM: mach-shmobile: sh7377 and G4EVM timer rework
      ARM: mach-shmobile: sh7372, AP4EVB and Mackerel timer rework
      ARM: mach-shmobile: sh73a0, AG5EVM and Kota2 timer rework
      ARM: mach-shmobile: r8a7740 and Bonito timer rework
      ARM: mach-shmobile: r8a7779 and Marzen timer rework
      ARM: mach-shmobile: default to no earlytimer

