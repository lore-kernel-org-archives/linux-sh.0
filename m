From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Aug 2009 01:16:09 +0000
Subject: [GIT PULL] sh updates for 2.6.31-rc7
Message-Id: <20090818011609.GB4402@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This fixes up a couple of suspend bugs (primarily impacting the SH7724
CPU and its associated solution engine board). While technically not
regressions, and a bit bigger than I would care for at this point, these
changes are necessary for fixing up crash on resume for SH7724, spurious
wakeups for CMT clocksource/clockevent users, and suspend crashes in the
fb driver for platforms using deferred I/O.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.31

Which contains:

Magnus Damm (4):
      sh: skip disabled LCDC channels
      sh: CMT suspend/resume
      sh: use in-soc KEYSC on se7724
      sh: sh7724 ddr self-refresh changes

 arch/sh/boards/mach-se/7724/setup.c |    9 ++--
 arch/sh/kernel/cpu/shmobile/sleep.S |   70 ++++++++++++++++++++++++++++++++++-
 drivers/clocksource/sh_cmt.c        |   28 ++++++++++++++
 drivers/video/sh_mobile_lcdcfb.c    |    5 ++
 4 files changed, 106 insertions(+), 6 deletions(-)
