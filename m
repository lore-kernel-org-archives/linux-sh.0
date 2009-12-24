From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Dec 2009 06:19:57 +0000
Subject: [GIT PULL] sh updates for 2.6.33-rc2
Message-Id: <20091224061957.GG28878@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33

Which contains:

Guennadi Liakhovetski (1):
      sh: dmaengine support for sh7724.

Kuninori Morimoto (1):
      sh: mach-ecovec24: setup.c detailed correction

Magnus Damm (1):
      serial: sh-sci: earlyprintk zero uartclk fix

Markus Pietrek (1):
      sh: Ensure all PG_dcache_dirty pages are written back.

Nobuhiro Iwamatsu (1):
      sh: dmaengine support for SH7785

Paul Mundt (4):
      sh: Fix up MAX_DMA_CHANNELS definition when DMA is disabled.
      sh: Restore bl bit toggling in idle loop.
      sh: Only use bl bit toggling for sleeping idle.
      serial: sh-sci: Convert tremaining ctrl_xxx I/O routines to __raw_xxx.

 arch/sh/boards/mach-ecovec24/setup.c   |    4 +-
 arch/sh/include/asm/dma.h              |    6 +-
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |    8 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   15 ++++
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   14 ++++
 arch/sh/kernel/idle.c                  |    2 +
 arch/sh/mm/cache.c                     |    8 +--
 drivers/serial/sh-sci.c                |   20 ++++--
 drivers/serial/sh-sci.h                |  118 ++++++++++++++++----------------
 9 files changed, 117 insertions(+), 78 deletions(-)
