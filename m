From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Apr 2009 09:20:30 +0000
Subject: [GIT PULL] sh updates for 2.6.30-rc2
Message-Id: <20090414092029.GB30402@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Francesco VIRLINZI (1):
      sh: intc: Added resume from hibernation support to the intc

Kuninori Morimoto (4):
      sh: urquell: Add board comment
      sh: urquell: Fix up address mapping in board comments.
      sh: ap325: use edge control for ov772x camera
      sh: sh7786: modify usb setup timeout judgment bug.

Paul Mundt (7):
      sh: wire up sys_preadv/sys_pwritev() syscalls.
      sh: Provide cpumask_of_pcibus() to fix NUMA build.
      sh: Add support for DMA API debugging.
      sh: Plug in support for ARCH=sh64 using sh SRCARCH.
      MAINTAINERS: Update sh architecture file patterns.
      sh: Pre-allocate a reasonable number of DMA debug entries.
      sh: Add in PCI bus for DMA API debugging.

Yoshihiro Shimoda (1):
      sh: sh7785lcr: fix PCI address map for 32-bit mode

 MAINTAINERS                            |    2 +
 Makefile                               |    7 +++++-
 arch/sh/Kconfig                        |   18 ++++++++++++++-
 arch/sh/boards/board-ap325rxa.c        |    1 +
 arch/sh/boards/board-urquell.c         |   30 ++++++++++++++++++++++++++
 arch/sh/drivers/pci/ops-sh7785lcr.c    |    5 ++++
 arch/sh/drivers/pci/pci-sh7780.h       |    2 +
 arch/sh/drivers/pci/pci.c              |    3 ++
 arch/sh/include/asm/dma-mapping.h      |   36 +++++++++++++++++++++++++++----
 arch/sh/include/asm/scatterlist.h      |   11 +++++----
 arch/sh/include/asm/topology.h         |    7 ++++-
 arch/sh/include/asm/unistd_32.h        |    4 ++-
 arch/sh/include/asm/unistd_64.h        |    4 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   14 ++++++------
 arch/sh/kernel/syscalls_32.S           |    2 +
 arch/sh/kernel/syscalls_64.S           |    2 +
 arch/sh/mm/consistent.c                |   31 +++++++++++++++++++++------
 drivers/sh/intc.c                      |   35 +++++++++++++++++++++++++++---
 18 files changed, 179 insertions(+), 35 deletions(-)
