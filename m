From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 07 Jul 2009 20:46:01 +0000
Subject: [GIT PULL] sh updates for 2.6.31-rc3
Message-Id: <20090707204600.GA24726@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.31

Which contains:

Magnus Damm (3):
      sh-sci: update receive error handling for muxed irqs
      usb: allow sh7724 to enable on-chip r8a66597
      sh: add r8a66597 usb0 host to the se7724 board

Paul Mundt (4):
      sh: define PERF_COUNTER_INDEX_OFFSET.
      video: sh_mobile_lcdcfb: Convert to framebuffer_alloc().
      video: hitfb: Convert to framebuffer_alloc().
      video: hitfb: Move over to dev_pm_ops.

SUGIOKA Toshinobu (1):
      serial: sh-sci: fix sci interrupt handler

 arch/sh/boards/mach-se/7724/setup.c |   38 ++++++++++++++++++++
 arch/sh/include/asm/perf_counter.h  |    2 +
 drivers/serial/sh-sci.c             |   11 +++---
 drivers/usb/host/Kconfig            |    4 +-
 drivers/video/hitfb.c               |   66 +++++++++++++++++++++++-----------
 drivers/video/sh_mobile_lcdcfb.c    |   40 +++++++++++++--------
 6 files changed, 116 insertions(+), 45 deletions(-)
