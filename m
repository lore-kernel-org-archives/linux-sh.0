From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Jan 2009 09:55:21 +0000
Subject: [PATCH 00/05] sh: timer patches
Message-Id: <20090122095521.31653.35942.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: timer patches

[PATCH 01/05] sh: rework clocksource and sched_clock
[PATCH 02/05] sh: tmu disable support
[PATCH 03/05] sh: fix no sys_timer case
[PATCH 04/05] sh: CMT platform driver V6
[PATCH 05/05] sh: CMT platform data for sh7723/sh7722/sh7366/sh7343

These patches are my latest iteration of SuperH timer changes.

Patch 1-3 are quite obvious and have no special dependencies.

The CMT driver patch implements a simplified CMT driver. The
clocksource and early platform driver dependencies have been
removed temporarily to make it possible to merge the driver
without waiting for bits in -mm.

The CMT platform data patch depends on the serial port patches.

And on top of all this I have some early platform driver patches.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    8 
 arch/sh/include/asm/timer.h            |    4 
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   34 +
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   34 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   34 +
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   34 +
 arch/sh/kernel/time_32.c               |   72 +--
 arch/sh/kernel/timers/timer-tmu.c      |   20 -
 drivers/clocksource/Makefile           |    1 
 drivers/clocksource/sh_cmt.c           |  615 ++++++++++++++++++++++++++++++++
 include/linux/sh_cmt.h                 |   13 
 11 files changed, 812 insertions(+), 57 deletions(-)
