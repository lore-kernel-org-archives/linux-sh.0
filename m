From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 21 Mar 2008 03:41:24 +0000
Subject: [GIT PULL] sh updates for 2.6.25-rc7
Message-Id: <20080321034124.GB16295@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.25.git

Which contains:

Franck Bui-Huu (1):
      sh: Use relative paths for mach/cpu symlinks.

Kieran Bingham (1):
      sh: Fix up the address error exception handler for SH-2.

Paul Mundt (3):
      sh: Fix up the timer IRQ definition for SH7203.
      sh: Fix uImage build error.
      sh: Fix more user header breakage from sh64 integration.

Robert P. J. Day (1):
      SH: Use newer, non-deprecated __SPIN_LOCK_UNLOCKED macro.

Yutaro Ebihara (1):
      serial: sh-sci: Fix fifo stall on SH7760/SH7780/SH7785 SCIF.

 arch/sh/Kconfig                |    1 +
 arch/sh/Makefile               |    8 ++++++--
 arch/sh/boot/Makefile          |    4 ++--
 arch/sh/kernel/cpu/sh2/entry.S |    1 -
 arch/sh/kernel/smp.c           |    2 +-
 drivers/serial/sh-sci.c        |    4 ++--
 include/asm-sh/byteorder.h     |   15 +++++++--------
 include/asm-sh/posix_types.h   |    6 ++++++
 8 files changed, 25 insertions(+), 16 deletions(-)
