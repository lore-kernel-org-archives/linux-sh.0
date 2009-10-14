From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 14 Oct 2009 09:06:31 +0000
Subject: [GIT PULL] sh updates for 2.6.32-rc5
Message-Id: <20091014090630.GA29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.32

Which contains:

Paul Mundt (8):
      sh: update die() output.
      sh: force dcache flush if dcache_dirty bit set.
      sh: ftrace: Fix up syscall tracepoint support.
      sh: Use boot_cpu_data for FPU tests in sigcontext paths.
      sh: Tidy up SMP cpuinfo.
      sh: Populate initial secondary CPU info from boot_cpu_data.
      sh: Optimize the setup_rt_frame() I-cache flush.
      sh: Fix a TRACE_IRQS_OFF typo.

 arch/sh/kernel/entry-common.S |    2 +-
 arch/sh/kernel/ftrace.c       |   37 +++++++++++++++++++++++++++----------
 arch/sh/kernel/setup.c        |    2 ++
 arch/sh/kernel/signal_32.c    |    9 ++++-----
 arch/sh/kernel/smp.c          |    2 ++
 arch/sh/kernel/traps_32.c     |    7 ++++---
 arch/sh/mm/cache.c            |    2 +-
 7 files changed, 41 insertions(+), 20 deletions(-)
