From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 10:32:23 +0000
Subject: [PATCH 00/10] sh: timer rewrite V3
Message-Id: <20081201103223.26620.35882.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH Timer Rewrite V3:

[PATCH 01/10] sh: timer base code, early timer support
[PATCH 02/10] clockevent: let set_mode() setup delta information
[PATCH 03/10] clockevent: add clockevent_unregister()
[PATCH 04/10] timer_inc: timer helper code, clockevent only
[PATCH 05/10] irq: allow free_irq() after setup_irq()
[PATCH 06/10] sh: CMT platform driver using timer_inc
[PATCH 07/10] sh: enable CMT on sh7723/sh7722/sh7366/sh7343
[PATCH 08/10] clocksource: add read2() callback
[PATCH 09/10] clocksource: add enable() and disable() callbacks
[PATCH 10/10] timer_inc: add clocksource support

This patchset changes the following
 - Clockevent changes - set_mode() fix and unregister support
 - Clocksource changes - add read2(), enable() and disable() callbacks
 - Irq code modification - allow free_irq() on setup_irq() interrupts
 - Add timer_inc - hardware independent clocksource and clockevent code
 - Add sh_timer - early timer code for SuperH
 - Add sh_cmt - platform driver for CMT using timer_inc and sh_timer
 - Add CMT platform data for SuperH Mobile processors

All patches apply to the latest sh-2.6 git tree, but the more generic
clocksource/clockevent specific bits also applies to linux-2.6-tip.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |   23 +
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   39 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   39 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   39 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   39 ++
 arch/sh/kernel/time_32.c               |   33 +-
 drivers/clocksource/Makefile           |    2 
 drivers/clocksource/sh_cmt.c           |  366 ++++++++++++++++++++++++++
 drivers/clocksource/sh_timer.c         |   72 +++++
 drivers/clocksource/timer_inc.c        |  449 +++++++++++++++++++++++++++++++-
 include/linux/clockchips.h             |    2 
 include/linux/clocksource.h            |   35 ++
 include/linux/interrupt.h              |    2 
 include/linux/sh_timer.h               |   26 +
 include/linux/timer_inc.h              |   47 +++
 kernel/irq/manage.c                    |    4 
 kernel/time/clockevents.c              |   42 ++
 kernel/time/tick-common.c              |   27 +
 kernel/time/timekeeping.c              |   12 
 19 files changed, 1259 insertions(+), 39 deletions(-)
