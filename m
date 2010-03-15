From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Mar 2010 03:35:34 +0000
Subject: [GIT PULL] sh updates for 2.6.34-rc2
Message-Id: <20100315033534.GA14501@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Huang Weiyi (1):
      serial: sh-sci: remove duplicated #include

Paul Mundt (4):
      sh: Support CPU affinity masks for INTC controllers.
      sh: Fix up uncached offset for legacy 29-bit mode.
      sh: Fix up NUMA build for 29-bit.
      sh: Export uncached helper symbols.

Peter Huewe (1):
      serial: sh-sci: Fix build failure for non-sh architectures.

 arch/sh/include/asm/mmu.h  |    7 +++++++
 arch/sh/mm/uncached.c      |    9 +++++++++
 drivers/serial/sh-sci.c    |    1 -
 drivers/sh/intc.c          |   31 ++++++++++++++++++++++++++++++-
 include/linux/serial_sci.h |    4 ++++
 5 files changed, 50 insertions(+), 2 deletions(-)
