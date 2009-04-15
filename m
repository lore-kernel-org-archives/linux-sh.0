From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 10:49:56 +0000
Subject: [PATCH 00/05] Remaining earlytimer / Early Platform patches
Message-Id: <20090415104956.29940.86548.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remaining earlytimer / Early Platform patches:

[PATCH 01/05] clocksource: sh_cmt earlytimer support
[PATCH 02/05] sh: arch earlytimer support
[PATCH 03/05] sh: Add plat_early_device_setup()
[PATCH 04/05] sh: Early Platform Data for SuperH Mobile
[PATCH 05/05] sh: Let SH_TIMER_CMT select GENERIC_TIME

This patchset contains all the outstanding earlytimer-specific patches
for the SuperH architecture. earlytimer is implemented using sh_cmt as
Early Platform Driver together with Early Platform Data for SuperH Mobile.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Needs driver-core.current/driver-core-early-platform-driver.patch from Greg
 Tested on a sh7722 Migo-R board with 2.6.30-rc2.

 arch/sh/Kconfig                        |    1 +
 arch/sh/include/asm/device.h           |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   10 ++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   10 ++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   10 ++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   10 ++++++++++
 arch/sh/kernel/setup.c                 |    7 +++++++
 arch/sh/kernel/time_32.c               |    9 +++++++++
 drivers/clocksource/sh_cmt.c           |   18 ++++++++++++++++--
 9 files changed, 75 insertions(+), 2 deletions(-)
