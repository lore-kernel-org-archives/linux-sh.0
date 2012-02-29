From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:16:05 +0000
Subject: [PATCH 00/17] sh and mach-shmobile struct sh_clk_ops rename
Message-Id: <20120229131605.29154.8330.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh and mach-shmobile struct sh_clk_ops rename

[PATCH 01/17] sh: introduce sh_clk_ops in parallel with clk_ops
[PATCH 02/17] sh: convert cpg code to sh_clk_ops
[PATCH 03/17] ARM: mach-shmobile: sh7367 sh_clk_ops rename
[PATCH 04/17] ARM: mach-shmobile: sh7377 sh_clk_ops rename
[PATCH 05/17] ARM: mach-shmobile: sh7372 sh_clk_ops rename
[PATCH 06/17] ARM: mach-shmobile: sh73a0 sh_clk_ops rename
[PATCH 07/17] ARM: mach-shmobile: r8a7740 sh_clk_ops rename
[PATCH 08/17] ARM: mach-shmobile: r8a7779 sh_clk_ops rename
[PATCH 09/17] sh: sh header sh_clk_ops rename
[PATCH 10/17] sh: sh2 sh_clk_ops rename
[PATCH 11/17] sh: sh2a sh_clk_ops rename
[PATCH 12/17] sh: sh3 sh_clk_ops rename
[PATCH 13/17] sh: sh4 sh_clk_ops rename
[PATCH 14/17] sh: sh4a sh_clk_ops rename
[PATCH 15/17] sh: sh5 sh_clk_ops rename
[PATCH 16/17] sh: board sh_clk_ops rename
[PATCH 17/17] sh: remove clk_ops

This patch series renames struct clk_ops to struct sh_clk_ops across
arch/sh, arch/arm/mach-shmobile and drivers/sh. The reason for this
is to avoid name space collision with the common struct clk patches.

Merge order wise across the different trees, [PATCH 01/17] needs to be
first and [PATCH 17/17] last. In between any order is ok.

All SoCs with ARM, sh2, sh3, sh4 and sh4a are known to compile.
sh2a and sh5 are not compiled but survive basic grep testing.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7740.c |    6 +++---
 arch/arm/mach-shmobile/clock-r8a7779.c |    2 +-
 arch/arm/mach-shmobile/clock-sh7367.c  |    6 +++---
 arch/arm/mach-shmobile/clock-sh7372.c  |    8 ++++----
 arch/arm/mach-shmobile/clock-sh7377.c  |    6 +++---
 arch/arm/mach-shmobile/clock-sh73a0.c  |   12 ++++++------
 arch/sh/boards/mach-highlander/setup.c |    2 +-
 arch/sh/boards/mach-sdk7786/setup.c    |    2 +-
 arch/sh/include/asm/clock.h            |    2 +-
 arch/sh/kernel/cpu/sh2/clock-sh7619.c  |   12 ++++++------
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c |   12 ++++++------
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c |   12 ++++++------
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh3.c     |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7705.c  |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7706.c  |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7709.c  |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7710.c  |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7712.c  |   10 +++++-----
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    6 +++---
 arch/sh/kernel/cpu/sh4/clock-sh4.c     |   12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c |   14 +++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c |   12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c |   14 +++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    2 +-
 arch/sh/kernel/cpu/sh5/clock-sh5.c     |   12 ++++++------
 drivers/sh/clk/cpg.c                   |   16 ++++++++--------
 include/linux/sh_clk.h                 |    7 ++++---
 36 files changed, 144 insertions(+), 143 deletions(-)
