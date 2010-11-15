From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Nov 2010 06:25:12 +0000
Subject: [GIT PULL] sh updates for 2.6.37-rc2, part 2.
Message-Id: <20101115062512.GD8489@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Nothing too interesting here, all trivial changes.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Axel Lin (1):
      rtc: rtc-sh - fix a memory leak

Paul Mundt (4):
      sh: intc: Fix up initializers for gcc 4.5.
      sh: clkfwk: fix up compiler warnings.
      MAINTAINERS: update the sh git tree entry.
      sh: intc: Fix up build failure introduced by radix tree changes.

 MAINTAINERS             |    2 +-
 drivers/rtc/rtc-sh.c    |    4 ++--
 drivers/sh/clk/core.c   |    4 ++--
 drivers/sh/intc/virq.c  |    2 +-
 include/linux/sh_intc.h |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
