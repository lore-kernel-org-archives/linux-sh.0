From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 14 Apr 2011 06:01:30 +0000
Subject: [PATCH 0/5] ptrace low level unification
Message-Id: <1302760895-13459-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>

This is a series of low level ptrace unification steps to make it easier
for common code (like KGDB) to poke at register state.  This also avoids
having to duplicate higher level operations for most ports which don't
have special needs for accessing things.

Mike Frysinger (5):
  asm-generic/ptrace.h: start a common low level ptrace helper
  Blackfin: convert to asm-generic ptrace.h
  x86: convert to asm-generic ptrace.h
  sh: convert to asm-generic ptrace.h
  kgdbts: unify/generalize gdb breakpoint adjustment

 arch/blackfin/include/asm/kgdb.h   |    1 +
 arch/blackfin/include/asm/ptrace.h |    5 +-
 arch/sh/include/asm/kgdb.h         |    1 +
 arch/sh/include/asm/ptrace.h       |    6 ++-
 arch/x86/include/asm/kgdb.h        |    1 +
 arch/x86/include/asm/ptrace.h      |   18 ++------
 drivers/misc/kgdbts.c              |   29 +++++---------
 include/asm-generic/ptrace.h       |   74 ++++++++++++++++++++++++++++++++++++
 8 files changed, 99 insertions(+), 36 deletions(-)
 create mode 100644 include/asm-generic/ptrace.h

-- 
1.7.5.rc1

