From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Apr 2011 18:42:41 +0000
Subject: [GIT PULL] sh fixes for 2.6.39-rc3
Message-Id: <20110407184241.GF8052@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Alexandre Courbot (1):
      serial: sh-sci: prevent setup of uninitialized serial console

Nobuhiro Iwamatsu (3):
      sh: sh-sci: Fix double initialization by serial_console_setup
      sh: landisk: Remove mv_nr_irqs
      sh: landisk: Remove whitespace

Paul Mundt (1):
      sh: select ARCH_NO_SYSDEV_OPS.

Yoshihiro Shimoda (2):
      dma: shdma: add checking the DMAOR_AE in sh_dmae_err
      sh: fix build error in board-sh7757lcr.c

 arch/sh/Kconfig                     |    1 +
 arch/sh/boards/board-sh7757lcr.c    |    2 +-
 arch/sh/boards/mach-landisk/setup.c |    5 ++---
 drivers/dma/shdma.c                 |    7 ++++++-
 drivers/tty/serial/sh-sci.c         |   25 ++++++++++++-------------
 5 files changed, 22 insertions(+), 18 deletions(-)
