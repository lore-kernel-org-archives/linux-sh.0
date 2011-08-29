From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 08:20:14 +0000
Subject: [GIT PULL] rmobile updates for 3.1-rc5
Message-Id: <20110829082014.GA17767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Nothing particularly noteworthy here, mostly random fixes, stubbing in
some clock definitions, and wiring up some platform data.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-3.x.git rmobile-fixes-for-linus

Which contains:

Jesper Juhl (1):
      ARM: static should be at beginning of declaration

Kuninori Morimoto (4):
      ARM: mach-shmobile: sh7372: Add USB-DMAC support
      ARM: mach-shmobile: mackerel: Add USB-DMA ID
      ARM: mach-shmobile: clock-sh73a0: tidyup CKSCR main clock selecter
      ARM: mach-shmobile: clock-sh7372: fixup USB-DMAC1 settings

Magnus Damm (4):
      ARM: mach-shmobile: Use CMT2 for timer on sh7372
      ARM: mach-shmobile: Remove 3DG/SGX from sh7372 INTCS
      ARM: mach-shmobile: sh7372 MSIOF clock support
      ARM: mach-shmobile: sh7372 CMT3 and CMT4 clock support

Simon Horman (2):
      ARM: mach-shmobile: ag5evm: SDHI requires waiting for idle
      mmc: sdhi, mmcif: zboot: Correct clock disable logic

 arch/arm/boot/compressed/mmcif-sh7372.c      |    2 +-
 arch/arm/boot/compressed/sdhi-sh7372.c       |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c        |    3 +-
 arch/arm/mach-shmobile/board-mackerel.c      |    4 +
 arch/arm/mach-shmobile/clock-sh7372.c        |   29 ++++-
 arch/arm/mach-shmobile/clock-sh73a0.c        |    2 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h |    4 +
 arch/arm/mach-shmobile/intc-sh7372.c         |    7 +-
 arch/arm/mach-shmobile/setup-sh7372.c        |  176 +++++++++++++++++++++++---
 9 files changed, 199 insertions(+), 30 deletions(-)
