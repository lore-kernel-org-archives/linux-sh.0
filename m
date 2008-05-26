From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 May 2008 10:09:16 +0000
Subject: [GIT PULL] sh updates for 2.6.26-rc4
Message-Id: <20080526100916.GA18102@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.26.git

Which contains:

Magnus Damm (5):
      sh: fix USBF resource for sh7722
      sh: fix VPU interrupt vector for sh7723
      sh: add probe support for new sh7723 cut
      sh: use sm501 8250 mfd support on r2d boards
      sh: update Migo-R defconfig

Paul Mundt (1):
      sh: Drop broken URAM support on SH7723.

 arch/sh/Kconfig                           |    1 -
 arch/sh/boards/renesas/rts7751r2d/setup.c |   39 +----
 arch/sh/configs/migor_defconfig           |  294 +++++++++++++++++++++++------
 arch/sh/kernel/cpu/sh4/probe.c            |    1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c    |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c    |    8 +-
 6 files changed, 241 insertions(+), 104 deletions(-)
