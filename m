From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Feb 2008 08:35:21 +0000
Subject: [GIT PULL] sh updates for 2.6.25-rc4
Message-Id: <20080227083521.GA405@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Adrian McMenamin (2):
      maple: remove unused variable
      maple: fix device detection

Hideo Saito (1):
      sh: Fix up HAS_SR_RB typo in entry-macros.

Julia Lawall (1):
      arch/sh/drivers/dma/dma-sh.c: Correct use of ! and &

Magnus Damm (1):
      sh: revert dreamcast pci change

Paul Mundt (3):
      sh: Rename SH-3 CCR3 reg to avoid synclink_cs clash.
      sh: SH5-103 needs to select CPU_SH5.
      serial: Move asm-sh/sci.h to linux/serial_sci.h.

Rafael Ignacio Zurita (1):
      sh: fix rtc_resources setup for sh770x

Roel Kluin (1):
      sh: heartbeat: ioremap is expected to succeed

Tobias Klauser (1):
      sh: Storage class should be before const qualifier

 arch/sh/Kconfig                              |    1 +
 arch/sh/drivers/dma/dma-sh.c                 |    2 +-
 arch/sh/drivers/heartbeat.c                  |    2 +-
 arch/sh/drivers/pci/ops-dreamcast.c          |   44 +++++++++---------
 arch/sh/kernel/cpu/sh2/setup-sh7619.c        |    2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c       |    4 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c       |    2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c       |    2 +-
 arch/sh/kernel/cpu/sh3/probe.c               |    4 +-
 arch/sh/kernel/cpu/sh3/setup-sh7705.c        |    2 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c        |    8 ++--
 arch/sh/kernel/cpu/sh3/setup-sh7710.c        |    2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c        |    2 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c       |    2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c        |    2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c        |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c       |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c         |    2 +-
 drivers/serial/sh-sci.c                      |    2 +-
 drivers/sh/maple/maple.c                     |   66 +++++++++++++++++---------
 include/asm-sh/cpu-sh3/cache.h               |    2 +-
 include/asm-sh/entry-macros.S                |    4 +-
 include/linux/maple.h                        |    1 -
 include/{asm-sh/sci.h => linux/serial_sci.h} |   10 ++--
 30 files changed, 101 insertions(+), 83 deletions(-)
 rename include/{asm-sh/sci.h => linux/serial_sci.h} (73%)
