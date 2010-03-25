From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Mar 2010 07:07:42 +0000
Subject: [PATCH 00/06] Share clock framework code between SH and SH-Mobile ARM
Message-Id: <20100325070742.24148.57892.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Share clock framework code between SH and SH-Mobile ARM

[PATCH 01/06] ARM: mach-shmobile: Makefile update for old clock code
[PATCH 02/06] sh: move sh asm/clock.h contents to linux/sh_clk.h
[PATCH 03/06] sh: move sh clock.c contents to drivers/sh/clk.c
[PATCH 04/06] sh: move sh clock-cpg.c contents to drivers/sh/clk-cpg.c
[PATCH 05/06] ARM: mach-shmobile: SH-Mobile ARM specific clock code
[PATCH 06/06] ARM: mach-shmobile: initial sh7372 clock framework

These patches moves the SH clock framework to drivers/sh so it can
be shared between SH and SH-Mobile ARM. On top of this initial clock
framework support is added for the sh7372 processor.

I expect to have to rework some and rebase most of these patches,
let me know if you have any ideas on how to share the code in a
better way.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig               |    5 
 arch/arm/mach-shmobile/Makefile              |   16 
 arch/arm/mach-shmobile/board-ap4evb.c        |   16 
 arch/arm/mach-shmobile/clock-sh7372.c        |  297 +++++++++++
 arch/arm/mach-shmobile/clock.c               |   33 +
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/setup-sh7372.c        |    2 
 arch/sh/include/asm/clock.h                  |  167 ------
 arch/sh/kernel/cpu/Makefile                  |    2 
 arch/sh/kernel/cpu/clock-cpg.c               |  291 -----------
 arch/sh/kernel/cpu/clock.c                   |  629 -------------------------
 drivers/sh/Makefile                          |    3 
 drivers/sh/clk-cpg.c                         |  294 +++++++++++
 drivers/sh/clk.c                             |  650 ++++++++++++++++++++++++++
 include/linux/sh_clk.h                       |  172 ++++++
 15 files changed, 1484 insertions(+), 1094 deletions(-)
