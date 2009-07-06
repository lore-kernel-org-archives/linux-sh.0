From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 06 Jul 2009 10:32:40 +0000
Subject: [PATCH 0/3] SH ftrace fixes
Message-Id: <cover.1246875978.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul,

the following ftrace patches are available at,

    git://github.com/mfleming/linux-2.6.git sh/ftrace

I've included them here to make them easier to review. In particular,
you might want to look over "sh: Add ftrace syscall tracing support"
to make sure that you're OK with the HI and LO bits.

Matt Fleming (3):
  sh: Fix the value of MCOUNT_INSN_OFFSET
  sh: Define HAVE_FUNCTION_TRACE_MCOUNT_TEST
  sh: Add ftrace syscall tracing support

 arch/sh/Kconfig                   |    2 +
 arch/sh/include/asm/ftrace.h      |    8 +++-
 arch/sh/include/asm/syscall_32.h  |    1 +
 arch/sh/include/asm/thread_info.h |   21 ++++++++---
 arch/sh/kernel/Makefile_32        |    1 +
 arch/sh/kernel/entry-common.S     |   14 ++++++--
 arch/sh/kernel/ftrace.c           |   66 +++++++++++++++++++++++++++++++++++++
 arch/sh/kernel/ptrace_32.c        |    8 ++++
 arch/sh/lib/mcount.S              |   17 +++++++++-
 9 files changed, 126 insertions(+), 12 deletions(-)

