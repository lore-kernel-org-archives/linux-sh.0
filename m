From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 03 Dec 2010 07:50:07 +0000
Subject: [GIT PULL] sh updates for 2.6.37-rc5
Message-Id: <20101203075006.GA1560@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This contains some fixups for the SH7724 FSI utilization and fixes up the
clock refcounting problems, as per the R-Mobile changes, as well as a
fix for lazy dcache writeback that follows an identical ARM change.

It's been an uphill battle for the PG_dcache_dirty case, and the current
tree is unreliable for some combintions of root on MMC, CF, and USB for a
number of configurations. Newer parts are D-cache coherent so this hasn't
really been much of a problem except for on older configurations, which
unfortunately people have started hitting and reporting.

This will result in potentially more aggressive flushing than we
specifically need at the moment, but it does fix up all of the
outstanding bugs reported. It should be possible to back off of the
flush_kernel_dcache_page() implementation with this in place, but that's
left as a .38 exercise where we have more time to test the configurations
with reported problems.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Guennadi Liakhovetski (1):
      dma: shdma: add a MODULE_ALIAS() to allow module autoloading

Kuninori Morimoto (1):
      sh: Add div6_reparent_clks to clock framework for FSI

Nobuhiro Iwamatsu (2):
      sh: se/7724: Update clock framework of FSI clock to non-legacy
      sh: se/7724: Remove FSI/B of GPIO init code

Paul Mundt (1):
      sh: Assume new page cache pages have dirty dcache lines.

Vasiliy Kulikov (1):
      sh: boards: mach-se: use IS_ERR() instead of NULL check

 arch/sh/boards/mach-ecovec24/setup.c   |   34 +++--------------------
 arch/sh/boards/mach-se/7724/setup.c    |   47 +++++---------------------------
 arch/sh/include/asm/cacheflush.h       |    2 +-
 arch/sh/include/cpu-sh4/cpu/sh7724.h   |    3 ++
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   44 ++++++++++++++++++++++++++---
 arch/sh/mm/cache-sh4.c                 |    4 +-
 arch/sh/mm/cache-sh7705.c              |    2 +-
 arch/sh/mm/cache.c                     |   14 +++++-----
 arch/sh/mm/kmap.c                      |    2 +-
 drivers/dma/shdma.c                    |    1 +
 10 files changed, 66 insertions(+), 87 deletions(-)
