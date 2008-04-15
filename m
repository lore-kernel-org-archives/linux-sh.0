From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Apr 2008 17:23:33 +0000
Subject: [GIT PULL] sh updates for 2.6.25
Message-Id: <20080415172333.GA29489@linux-sh.org>
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
      sh64: add missing #include <asm/fpu.h>'s

Andrew Morton (2):
      sh: arch/sh/kernel/traps_32.c needs asm/fpu.h
      sh: export empty_zero_page

Manuel Lauss (1):
      sh: fix compressed kernel build

 arch/sh/boot/compressed/head_32.S |    1 -
 arch/sh/boot/compressed/head_64.S |    1 -
 arch/sh/kernel/process_64.c       |    1 +
 arch/sh/kernel/ptrace_64.c        |    1 +
 arch/sh/kernel/sh_ksyms_32.c      |    1 +
 arch/sh/kernel/sh_ksyms_64.c      |    1 +
 arch/sh/kernel/signal_64.c        |    1 +
 arch/sh/kernel/traps_32.c         |    1 +
 arch/sh/kernel/traps_64.c         |    1 +
 9 files changed, 7 insertions(+), 2 deletions(-)
