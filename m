From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 21 Oct 2009 00:47:49 +0000
Subject: [GIT PULL] sh updates for 2.6.32-rc6
Message-Id: <20091021004749.GA17730@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.32

Which contains:

Magnus Damm (1):
      sh: disabled cache handling fix.

Paul Mundt (1):
      sh: Kill off stray HAVE_FTRACE_SYSCALLS reference.

Thomas Gleixner (1):
      sh: Remove BKL from landisk gio.

Valentin Sitdikov (1):
      sh: Fix up single page flushing to use PAGE_SIZE.

 arch/sh/Kconfig                   |    1 -
 arch/sh/boards/mach-landisk/gio.c |   10 ++++------
 arch/sh/mm/cache-sh4.c            |   22 ++++++++++------------
 arch/sh/mm/cache.c                |   10 ++++++++++
 4 files changed, 24 insertions(+), 19 deletions(-)
