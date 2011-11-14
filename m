From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Nov 2011 08:15:56 +0000
Subject: [GIT PULL] sh fixes for 3.2-rc2
Message-Id: <20111114081555.GN29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

There is mostly odd fixes and the addition of a couple helpers that
some stuff aimed at the next merge window wants. There's the shuffling
over of the runtime PM platform stub that was in use by the ARM
SH/R-Mobile code and using it generically for the rest of the SH
platforms, too (this fixes up some regressions with the runtime PM code
on SH platforms that tie their MSTP bits in to the clock framework but
don't otherwise have their own private runtime PM implementations).

Please pull from:

        git://github.com/pmundt/linux-sh.git sh-fixes-for-linus

Which contains:

Kuninori Morimoto (2):
      sh: clkfwk: add clk_rate_mult_range_round()
      mailmap: Fix up some renesas attributions

Nobuhiro Iwamatsu (1):
      sh: Fix cached/uncaced address calculation in 29bit mode

Paul Mundt (4):
      sh: Wire up process_vm syscalls.
      drivers: sh: Generalize runtime PM platform stub.
      drivers: sh: Kill off dead pathname for runtime PM stub.
      sh: clkfwk: Kill off remaining debugfs cruft.

Phil Edworthy (1):
      serial: sh-sci: Fix up SH-2A SCIF support.

 .mailmap                                           |    2 +
 arch/arm/mach-shmobile/Makefile                    |    2 +-
 arch/sh/include/asm/page.h                         |    5 +
 arch/sh/include/asm/unistd_32.h                    |    4 +-
 arch/sh/include/asm/unistd_64.h                    |    4 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |   16 ++-
 arch/sh/kernel/syscalls_32.S                       |    2 +
 arch/sh/kernel/syscalls_64.S                       |    2 +
 drivers/sh/Makefile                                |    8 ++
 drivers/sh/clk/core.c                              |  107 ++++----------------
 .../arm/mach-shmobile => drivers/sh}/pm_runtime.c  |    4 +-
 drivers/tty/serial/sh-sci.c                        |   19 ++++
 include/linux/serial_sci.h                         |    1 +
 include/linux/sh_clk.h                             |    4 +-
 14 files changed, 82 insertions(+), 98 deletions(-)
 rename {arch/arm/mach-shmobile => drivers/sh}/pm_runtime.c (94%)
