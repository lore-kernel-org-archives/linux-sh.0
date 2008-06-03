From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 03 Jun 2008 11:32:49 +0000
Subject: [GIT PULL] sh updates for 2.6.26-rc5
Message-Id: <20080603113249.GA15541@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.26.git

Which contains:

Adrian Bunk (1):
      sh/kernel/cpu/irq/intc-sh5.c build fix

Harvey Harrison (1):
      sh: module.c use kernel unaligned helpers

Paul Mundt (4):
      sh: fix miscompilation of ip_fast_csum with gcc >= 4.3
      sh: Disable 4KSTACKS on nommu.
      sh: Update SE7206 defconfig.
      sh: Add defconfig for RSK7203.

 arch/sh/Kconfig.debug             |    2 +-
 arch/sh/configs/rsk7203_defconfig |  841 +++++++++++++++++++++++++++++++++++++
 arch/sh/configs/se7206_defconfig  |  475 ++++++++++++++-------
 arch/sh/kernel/cpu/irq/intc-sh5.c |    1 +
 arch/sh/kernel/module.c           |   39 +--
 include/asm-sh/checksum_32.h      |    2 +-
 6 files changed, 1164 insertions(+), 196 deletions(-)
 create mode 100644 arch/sh/configs/rsk7203_defconfig
