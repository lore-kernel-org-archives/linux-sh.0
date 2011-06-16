From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Jun 2011 06:53:42 +0000
Subject: [GIT PULL] rmobile fixes for 3.0-rc4
Message-Id: <20110616065338.GA17860@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-3.x.git rmobile-fixes-for-linus

Which contains:

Kuninori Morimoto (1):
      ARM: mach-shmobile: mackerel: tidyup usbhs driver settings

Magnus Damm (3):
      ARM: mach-shmobile: AG5EVM SDHI1 platform data update
      ARM: mach-shmobile: Mackerel USB platform data update
      ARM: mach-shmobile: sh73a0 gic_arch_extn.irq_set_wake() fix

Paul Mundt (1):
      ARM: mach-shmobile: Correct SCIF port types for SH7367.

 arch/arm/mach-shmobile/board-ag5evm.c   |    4 +-
 arch/arm/mach-shmobile/board-mackerel.c |  208 ++++++++++++++++++++++---------
 arch/arm/mach-shmobile/intc-sh73a0.c    |    6 +
 arch/arm/mach-shmobile/setup-sh7367.c   |   14 +-
 4 files changed, 161 insertions(+), 71 deletions(-)
