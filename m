From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 20 Aug 2010 11:45:05 +0000
Subject: [GIT PULL] genesis updates for 2.6.36-rc2
Message-Id: <20100820114505.GB30659@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100804075806.GE15098@linux-sh.org>
In-Reply-To: <20100804075806.GE15098@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The only noteworthy thing here are the runtime PM bits, which were
blocked on the driver core tree merge.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Arnd Hannemann (2):
      ARM: mach-shmobile: AP4EVB: use gpio-leds for leds.
      ARM: mach-shmobile: ap4evb: fix write protect for SDHI1

Guennadi Liakhovetski (2):
      ARM: mach-shmobile: add clock definitions for CEU and CSI2
      ARM: mach-shmobile: do not enable the PLLC2 clock on init

Kuninori Morimoto (1):
      ARM: mach-shmobile: ap4evb: modify FSI2 ID

Magnus Damm (2):
      ARM: mach-shmobile: Runtime PM V3
      ARM: mach-shmobile: Clock framework comment fix

Paul Mundt (1):
      ARM: mach-shmobile: Fix up gpio-leds pdata definition.

 arch/arm/mach-shmobile/Makefile       |    2 +-
 arch/arm/mach-shmobile/board-ap4evb.c |   56 ++++++++---
 arch/arm/mach-shmobile/clock-sh7372.c |    9 +-
 arch/arm/mach-shmobile/clock.c        |    4 +-
 arch/arm/mach-shmobile/pm_runtime.c   |  169 +++++++++++++++++++++++++++++++++
 5 files changed, 220 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/pm_runtime.c
