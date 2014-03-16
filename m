From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Mar 2014 21:35:20 +0000
Subject: [PATCH 00/06] ARM: shmobile: r8a7790 Core Standby CPUIdle prototype
Message-Id: <20140316213520.15598.85886.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7790 Core Standby CPUIdle prototype

[PATCH 01/06] ARM: shmobile: Allow non-SMP reset hook usage
[PATCH 02/06] ARM: shmobile: Install CPUIdle reset vector
[PATCH 03/06] ARM: shmobile: Setup reset vector for non-SMP r8a7790
[PATCH 04/06] ARM: shmobile: Also build APMU code for non-SMP r8a7790
[PATCH 05/06] ARM: shmobile: r8a7790 Core Standby CPUIdle prototype
[PATCH 06/06] ARM: shmobile: Install clocksource for r8a7790 tickless

These prototype patches add CPUIdle handling to the r8a7790 SoC. Most of
the patches focus on allowing CPUIdle operation both in CONFIG_SMP=n and
CONFIG_SMP=y. In the latter case "maxcpus=n" can also be passed on the
kernel command line. The code in [PATCH 05/06] should probably be located
under drivers/cpuidle instead of under arch/arm/mach-shmobile.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc6-20140313v3

 arch/arm/mach-shmobile/Makefile              |    6 +
 arch/arm/mach-shmobile/cpuidle.c             |   27 +++++++
 arch/arm/mach-shmobile/headsmp.S             |   15 +++-
 arch/arm/mach-shmobile/include/mach/common.h |    2 
 arch/arm/mach-shmobile/platsmp-apmu.c        |   42 ++++++++++-
 arch/arm/mach-shmobile/pm-r8a7790.c          |   93 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7790.c       |    2 
 arch/arm/mach-shmobile/smp-r8a7790.c         |   30 --------
 8 files changed, 173 insertions(+), 44 deletions(-)
