From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Nov 2011 08:15:56 +0000
Subject: [GIT PULL] rmobile fixes for 3.2-rc2
Message-Id: <20111114081556.GA13597@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Nothing terribly exciting here, either. In addition to build fixes for
the recent cpuidle changes, the bulk of it is simply shuffling some code
around for an upcoming board/CPU combination, and tidying up the in-tree
variants in the process.

Please pull from:

	git://github.com/pmundt/linux-sh.git rmobile-fixes-for-linus

Which contains:

Kuninori Morimoto (7):
      ARM: mach-shmobile: sh73a0: add MMC data pin pull-up
      ARM: mach-shmobile: kota2: add comment out separator
      ARM: mach-shmobile: clock-sh7372: remove un-necessary index
      ARM: mach-shmobile: ap4evb: remove white space from end of line
      ARM: mach-shmobile: move helper macro PORT_DATA_xx to sh_pfc.h
      ARM: mach-shmobile: move helper macro PORT_xx to sh_pfc.h
      ARM: mach-shmobile: move helper macro PORTCR to sh_pfc.h

Magnus Damm (1):
      ARM: mach-shmobile: cpuidle single/global and last_state fixes

 arch/arm/mach-shmobile/board-ag5evm.c        |   16 +-
 arch/arm/mach-shmobile/board-ap4evb.c        |    2 +-
 arch/arm/mach-shmobile/board-kota2.c         |    7 +
 arch/arm/mach-shmobile/clock-sh7372.c        |    8 +-
 arch/arm/mach-shmobile/cpuidle.c             |   52 +++---
 arch/arm/mach-shmobile/include/mach/common.h |    4 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    8 +
 arch/arm/mach-shmobile/pfc-sh7367.c          |  122 +++----------
 arch/arm/mach-shmobile/pfc-sh7372.c          |  262 ++++++++++++--------------
 arch/arm/mach-shmobile/pfc-sh7377.c          |  159 ++++------------
 arch/arm/mach-shmobile/pfc-sh73a0.c          |  193 ++++++++-----------
 arch/arm/mach-shmobile/pm-sh7372.c           |   14 +-
 include/linux/sh_pfc.h                       |   76 ++++++++
 13 files changed, 400 insertions(+), 523 deletions(-)
