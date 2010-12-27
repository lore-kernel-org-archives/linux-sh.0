From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Dec 2010 14:20:48 +0000
Subject: [GIT PULL] sh updates for 2.6.37-rc8
Message-Id: <20101227142048.GA6555@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Paul Mundt (4):
      sh: Fix up SH4-202 clkfwk build.
      sh: mach-se: Fix up SE7206 build.
      sh: Fix up SH7201 clkfwk build.
      sh: intc: Initialize radix tree gfp mask explicitly.

 arch/sh/boards/mach-se/7206/irq.c      |    2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c |    2 +-
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    3 +--
 drivers/sh/intc/core.c                 |    1 +
 4 files changed, 4 insertions(+), 4 deletions(-)
