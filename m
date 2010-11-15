From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Nov 2010 06:25:15 +0000
Subject: [GIT PULL] rmobile fixes for 2.6.37-rc2, part 2.
Message-Id: <20101115062515.GA24925@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

More trivial bits..

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-fixes-for-linus

Which contains:

Kuninori Morimoto (1):
      ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate

Paul Mundt (1):
      MAINTAINERS: update the ARM SH-Mobile git tree entry.

Tony SIM (1):
      ARM: mach-shmobile: intc-sh7372: fix interrupt number

Yusuke Goda (1):
      ARM: mach-shmobile: ap4evb: Mark NOR boot loader partitions read-only.

 MAINTAINERS                           |    2 +-
 arch/arm/mach-shmobile/board-ap4evb.c |    6 ++++++
 arch/arm/mach-shmobile/intc-sh7372.c  |    2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)
