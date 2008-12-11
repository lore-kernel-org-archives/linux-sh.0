From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Dec 2008 12:52:42 +0000
Subject: [PATCH 00/03] sh: timer rewrite V5
Message-Id: <20081211125242.19369.8194.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH Timer Rewrite V5:

[PATCH 01/03] sh: CONFIG_SH_TIMER support
[PATCH 02/03] sh: CMT early platform driver
[PATCH 03/03] sh: enable CMT on sh7723/sh7722/sh7366/sh7343

This patchset is another iteration which simply disconnects the clocksource
patches and makes use of early platform drivers. The early platform driver
patch and read(), enable/disable() and arch_gettimeoffset clocksource
patches can be found on lkml.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |   24 -
 arch/sh/include/asm/timer.h            |    4 
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   40 +
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   40 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   40 +
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   40 +
 arch/sh/kernel/time_32.c               |   41 +
 drivers/clocksource/Makefile           |    1 
 drivers/clocksource/sh_cmt.c           |  702 ++++++++++++++++++++++++++++++++
 include/linux/sh_cmt.h                 |   13 
 10 files changed, 931 insertions(+), 14 deletions(-)
