From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Apr 2011 18:42:51 +0000
Subject: [GIT PULL] rmobile fixes for 2.6.39-rc3
Message-Id: <20110407184251.GA29901@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-fixes-for-linus

Which contains:

Guennadi Liakhovetski (1):
      ARM: arch-shmobile: only run HDMI init on respective boards

Kuninori Morimoto (1):
      ARM: arch-shmobile: only run FSI init on respective boards

Simon Horman (1):
      ARM: mach-shmobile: Correctly check for CONFIG_MACH_MACKEREL

 arch/arm/mach-shmobile/board-ap4evb.c       |   19 +++++++------------
 arch/arm/mach-shmobile/board-mackerel.c     |   10 ++++------
 arch/arm/mach-shmobile/include/mach/mmc.h   |    2 +-
 arch/arm/mach-shmobile/include/mach/zboot.h |    2 +-
 4 files changed, 13 insertions(+), 20 deletions(-)
