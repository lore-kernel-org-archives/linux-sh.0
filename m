From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Dec 2008 15:12:35 +0000
Subject: [PATCH 00/05] sh: timer rewrite V4
Message-Id: <20081210151235.32515.26334.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH Timer Rewrite V4:

[PATCH 01/05] clocksource: add read2() callback and warning
[PATCH 02/05] clocksource: add enable() and disable() callbacks
[PATCH 03/05] sh: timer base code, early timer support
[PATCH 04/05] sh: CMT platform driver using early timer
[PATCH 05/05] sh: enable CMT on sh7723/sh7722/sh7366/sh7343

This patchset contains the following:
 - Clocksource changes - updated read2() patch, same old enable()/disable() 
 - Add sh_timer - early timer code for SuperH
 - Add sh_cmt - platform driver for CMT using sh_timer, now without timer_inc
 - Add CMT platform data for SuperH Mobile processors

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Built on top of the arch_gettimeoffset patches.

 arch/sh/Kconfig                        |   24 -
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   39 +
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   39 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   39 +
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   39 +
 arch/sh/kernel/time_32.c               |   27 -
 drivers/clocksource/Makefile           |    2 
 drivers/clocksource/sh_cmt.c           |  702 ++++++++++++++++++++++++++++++++
 drivers/clocksource/sh_timer.c         |   72 +++
 include/linux/clocksource.h            |   35 +
 include/linux/sh_timer.h               |   26 +
 kernel/time/clocksource.c              |    6 
 kernel/time/jiffies.c                  |    4 
 kernel/time/timekeeping.c              |   12 
 14 files changed, 1046 insertions(+), 20 deletions(-)
