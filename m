From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Feb 2010 05:30:21 +0000
Subject: [GIT PULL] sh updates for 2.6.33-rc9
Message-Id: <20100215053021.GE18636@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This simply hooks up TIF_SINGLESTEP around the hardware single-step
enable/disable in addition to punting the step state down to
tracehook_report_syscall_exit()/tracehook_signal_handler() in order to
get the ptrace_notify() logic right, as reported by Mike Frysinger.

With any luck, this should it for 2.6.33.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33

Which contains:

Paul Mundt (1):
      sh64: fix tracing of signals.

 arch/sh/kernel/ptrace_64.c |   11 +++++++++--
 arch/sh/kernel/signal_64.c |    4 +++-
 2 files changed, 12 insertions(+), 3 deletions(-)
