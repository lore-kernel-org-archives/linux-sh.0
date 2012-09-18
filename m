From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Sep 2012 08:11:08 +0000
Subject: [GIT PULL] sh fixes for 3.6-rc7
Message-Id: <20120918081106.GR13568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 6dab7ede9390d4d937cb89feca932e4fd575d2da:

  Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm (2012-08-18 16:20:05 -0700)

are available in the git repository at:


  git://github.com/pmundt/linux-sh tags/sh-for-linus

for you to fetch changes up to 5e071e2b4b82599f07cce5e1d2d272feb462950c:

  sh: Fix up TIF_NOTIFY_RESUME sans TIF_SIGPENDING handling. (2012-09-18 17:04:37 +0900)

----------------------------------------------------------------
SuperH fixes for 3.6-rc7

----------------------------------------------------------------
Al Viro (1):
      sh: Fix up TIF_NOTIFY_RESUME sans TIF_SIGPENDING handling.

Laurent Pinchart (1):
      sh: pfc: Release spinlock in sh_pfc_gpio_request_enable() error path

Paul Mundt (1):
      sh: intc: Fix up multi-evt irq association.

 arch/sh/kernel/cpu/sh5/entry.S | 2 +-
 arch/sh/kernel/entry-common.S  | 2 +-
 drivers/sh/intc/core.c         | 2 +-
 drivers/sh/pfc/pinctrl.c       | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)
