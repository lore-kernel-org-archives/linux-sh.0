From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Jun 2011 07:11:00 +0000
Subject: [GIT PULL] sh fixes for 3.0-rc6
Message-Id: <20110630071059.GA24169@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-3.x.git sh-fixes-for-linus

Which contains:

Paul Mundt (2):
      sh: Fix up unmet dependency warnings with USB EHCI/OHCI selects.
      sh: use printk_ratelimited instead of printk_ratelimit

Yoshihiro Shimoda (5):
      sh: fix compile error using sh7757lcr_defconfig
      sh: add platform_device of EHCI/OHCI to setup-sh7757
      sh: add to select the new configuration for USB EHCI/OHCI
      sh: fix the INTC vector for IRQ and IRL in setup-sh7757
      sh: fix the value of sh_dmae_slave_config in setup-sh7757

 arch/sh/Kconfig                        |    5 ++
 arch/sh/configs/sh7757lcr_defconfig    |    8 +--
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  106 +++++++++++++++++++++++--------
 arch/sh/kernel/irq.c                   |    6 +-
 arch/sh/mm/alignment.c                 |    9 ++-
 5 files changed, 94 insertions(+), 40 deletions(-)
