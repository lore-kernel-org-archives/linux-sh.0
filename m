From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 08:57:08 +0000
Subject: [GIT PULL] sh fixes for 3.0-rc2
Message-Id: <20110602085708.GA26101@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Guennadi Liakhovetski (4):
      sh: switch ap325rxa to dynamically manage the platform camera
      sh: add MMCIF runtime PM support on ecovec
      sh: mark DMA slave ID 0 as invalid
      dmaengine: shdma: fix a regression: initialise DMA channels for memcpy

Nobuhiro Iwamatsu (1):
      sh: asm/tlb.h needs linux/swap.h

Paul Mundt (8):
      sh: arch/sh/kernel/process_32.c needs linux/prefetch.h.
      sh: Update shmin to reflect PIO dependency.
      sh64: asm/pgtable.h needs asm/mmu.h
      sh64: Move from P1SEG to CAC_ADDR for consistent sync.
      sh: Fix up asm-generic/ptrace.h fallout.
      Revert "clocksource: sh_tmu: Runtime PM support"
      Revert "clocksource: sh_cmt: Runtime PM support"
      dmaengine: shdma: Fix up fallout from runtime PM changes.

 arch/sh/Kconfig                      |    2 +-
 arch/sh/boards/mach-ap325rxa/setup.c |   32 +++++++++++++-------------------
 arch/sh/boards/mach-ecovec24/setup.c |    3 +++
 arch/sh/include/asm/pgtable.h        |    1 +
 arch/sh/include/asm/ptrace.h         |    6 ++++--
 arch/sh/include/asm/tlb.h            |    1 +
 arch/sh/include/cpu-sh4/cpu/sh7722.h |    1 +
 arch/sh/include/cpu-sh4/cpu/sh7724.h |    1 +
 arch/sh/include/cpu-sh4/cpu/sh7757.h |    1 +
 arch/sh/kernel/process_32.c          |    1 +
 arch/sh/mm/consistent.c              |    2 +-
 drivers/clocksource/sh_cmt.c         |   12 ++----------
 drivers/clocksource/sh_tmu.c         |   12 ++----------
 drivers/dma/shdma.c                  |    9 +++++++--
 14 files changed, 39 insertions(+), 45 deletions(-)
