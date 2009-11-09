From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Nov 2009 01:57:42 +0000
Subject: [GIT PULL] sh updates for 2.6.32-rc7
Message-Id: <20091109015742.GB22932@linux-sh.org>
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
      serial: sh-sci: disable callback typo fix

Matt Fleming (1):
      sh: Account for cache aliases in flush_icache_range()

Paul Mundt (1):
      sh: unwinder: Fix up invalid PC refetch in dwarf unwinder.

Thomas Gleixner (1):
      sh: Replace old style lock initializer

 arch/sh/include/asm/rwsem.h |    2 +-
 arch/sh/kernel/dwarf.c      |    2 +-
 arch/sh/mm/cache-sh4.c      |    5 ++++-
 drivers/serial/sh-sci.c     |    2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)
