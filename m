From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Mar 2011 16:35:37 +0000
Subject: [GIT PULL] sh updates for 2.6.39-rc1, part 2.
Message-Id: <20110324163537.GA3320@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-latest

Which contains:

David Engraf (1):
      sh: Fix ptrace hw_breakpoint handling

Nobuhiro Iwamatsu (1):
      sh: Fix build alloc_thread_info_node function

Paul Mundt (4):
      sh: wire up sys_syncfs.
      sh: Conver to asm-generic/sizes.h.
      sh: pmb: Use struct syscore_ops instead of sysdevs
      sh: Re-enable GENERIC_HARDIRQS_NO_DEPRECATED.

Phil Edworthy (1):
      sh: Fix ptrace fpu state initialisation

Rafael J. Wysocki (1):
      sh: Use struct syscore_ops instead of sysdevs

 arch/sh/Kconfig                  |    3 +-
 arch/sh/boards/board-edosk7760.c |    2 +-
 arch/sh/include/asm/sizes.h      |   63 +-------------------------
 arch/sh/include/asm/unistd_32.h  |    3 +-
 arch/sh/include/asm/unistd_64.h  |    3 +-
 arch/sh/kernel/process.c         |    4 +-
 arch/sh/kernel/ptrace_32.c       |    8 +++
 arch/sh/kernel/ptrace_64.c       |    6 ++
 arch/sh/kernel/syscalls_32.S     |    1 +
 arch/sh/kernel/syscalls_64.S     |    1 +
 arch/sh/mm/pmb.c                 |   43 ++++++------------
 drivers/sh/clk/core.c            |   68 +++++++--------------------
 drivers/sh/intc/core.c           |   95 +++++++++++++++++++-------------------
 drivers/sh/intc/internals.h      |    1 -
 14 files changed, 104 insertions(+), 197 deletions(-)
