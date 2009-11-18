From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Nov 2009 01:57:15 +0000
Subject: [GIT PULL] sh updates for 2.6.32-rc8
Message-Id: <20091118015715.GA8751@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.32

Which contains:

Kuninori Morimoto (1):
      uio: pm_runtime_disable is needed if failed

Thomas Gleixner (1):
      sh: Fixup last users of irq_chip->typename

 arch/sh/kernel/cpu/irq/imask.c    |    2 +-
 arch/sh/kernel/cpu/irq/intc-sh5.c |    2 +-
 drivers/uio/uio_pdrv_genirq.c     |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
