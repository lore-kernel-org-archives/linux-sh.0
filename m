From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 14:15:25 +0000
Subject: [PATCH 00/02] ARM: shmobile: sh73a0 Core Shutdown CPUIdle prototype
Message-Id: <20130914141525.19348.8099.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: sh73a0 Core Shutdown CPUIdle prototype

[PATCH 01/02] ARM: shmobile: Extend SCU CPU notifier to handle CPUIdle
[PATCH 02/02] cpuidle: Renesas SCU Core Shutdown CPUIdle driver

This series implements a CPUIdle prototype for SCU based SoCs from
Renesas that support the Core Shutdown mode. The code is currently
running on sh73a0 in SMP mode. Caches are currently not managed,
so to test this you will have to disable cache in the kernel 
configuration. The first patch extends the SCU CPU notifier to
install a resume vector for CPUIdle, and the second patch adds
a CPUIdle driver.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20130906, depends on 
 [PATCH 00/05] ARM: shmobile: Use CPU notifiers for SCU boot vector code

 arch/arm/mach-shmobile/platsmp-scu.c  |   21 +++++++++-
 drivers/cpuidle/Kconfig               |    6 +++
 drivers/cpuidle/Makefile              |    1 
 drivers/cpuidle/cpuidle-renesas-scu.c |   66 +++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 3 deletions(-)
