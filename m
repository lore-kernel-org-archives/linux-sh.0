From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 31 Mar 2008 07:20:09 +0000
Subject: [GIT PULL] sh updates for 2.6.25-rc8
Message-Id: <20080331072009.GC16398@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.25.git

Which contains:

Adrian Bunk (1):
      remove include/asm-sh/floppy.h

Paul Mundt (2):
      sh: Fix occasional FPU register corruption under preempt.
      sh: Fix TIF_USEDFPU clearing under FPU emulation.

Yoshihiro Shimoda (1):
      sh: Fix up uImage compression type

 arch/sh/Kconfig               |    3 -
 arch/sh/boot/Makefile         |    2 +-
 arch/sh/kernel/cpu/sh2a/fpu.c |    1 +
 arch/sh/kernel/cpu/sh4/fpu.c  |    1 +
 arch/sh/kernel/cpu/sh5/fpu.c  |    1 +
 arch/sh/kernel/dump_task.c    |    1 +
 arch/sh/kernel/process_32.c   |    1 +
 arch/sh/kernel/signal_32.c    |    1 +
 include/asm-sh/floppy.h       |  268 -----------------------------------------
 include/asm-sh/fpu.h          |   39 ++++---
 include/asm-sh/processor.h    |    1 -
 include/asm-sh/processor_32.h |    1 +
 include/asm-sh/processor_64.h |    1 +
 13 files changed, 33 insertions(+), 288 deletions(-)
 delete mode 100644 include/asm-sh/floppy.h
