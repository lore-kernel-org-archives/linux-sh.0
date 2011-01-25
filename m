From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 09:52:00 +0000
Subject: [GIT PULL] sh updates for 2.6.38-rc3
Message-Id: <20110125095200.GA18488@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Aurelien Jarno (1):
      sh: Fix sh build failure when CONFIG_SFC=m

Guennadi Liakhovetski (1):
      sh: fix MSIOF0 SPI on ecovec: it conflicts with VOU

Magnus Damm (1):
      sh: update INTC to clear IRQ sense valid flag

Nobuhiro Iwamatsu (1):
      sh: Fix build of sh7750 base boards

Paul Mundt (2):
      sh: Fix up breakage from asm-generic/pgtable.h changes.
      sh: support XZ-compressed kernel.

 arch/sh/Kconfig                       |    1 +
 arch/sh/Makefile                      |    3 ++-
 arch/sh/boards/mach-ecovec24/setup.c  |    2 ++
 arch/sh/boot/Makefile                 |   11 +++++++++--
 arch/sh/boot/compressed/Makefile      |    4 +++-
 arch/sh/boot/compressed/misc.c        |    4 ++++
 arch/sh/include/asm/pgtable.h         |    1 +
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |    6 +++---
 arch/sh/kernel/topology.c             |    1 +
 drivers/sh/intc/chip.c                |    6 ++++--
 10 files changed, 30 insertions(+), 9 deletions(-)
