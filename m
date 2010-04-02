From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 02 Apr 2010 07:44:31 +0000
Subject: [GIT PULL] sh updates for 2.6.34-rc4
Message-Id: <20100402074431.GC14056@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.34

Which contains:

Andrea Gelmini (1):
      USB gadget r8a66597-udc.c: duplicated include

Andrew Stubbs (1):
      sh: Fix FDPIC binary loader

Julia Lawall (1):
      arch/sh/kernel: Use set_cpus_allowed_ptr

Matt Fleming (2):
      sh: update the TLB replacement counter for entry wiring.
      sh: Enable the mmu in start_secondary()

Paul Mundt (2):
      sh: export return_address() symbol.
      sh: Fix up the SH-3 build for recent TLB changes.

Yusuke Goda (1):
      sh: Update ecovec_defconfig

 arch/sh/configs/ecovec24_defconfig        |  236 +++++++++++++++++++++++------
 arch/sh/include/asm/elf.h                 |    6 +-
 arch/sh/include/cpu-sh4/cpu/mmu_context.h |    2 +
 arch/sh/kernel/cpufreq.c                  |    4 +-
 arch/sh/kernel/return_address.c           |    3 +
 arch/sh/kernel/smp.c                      |    1 +
 arch/sh/mm/tlb-pteaex.c                   |   28 ++++
 arch/sh/mm/tlb-sh3.c                      |   19 +++
 arch/sh/mm/tlb-sh4.c                      |   28 ++++
 arch/sh/mm/tlb-urb.c                      |   22 ++-
 arch/sh/mm/tlbflush_32.c                  |   28 ----
 drivers/usb/gadget/r8a66597-udc.c         |    1 -
 12 files changed, 294 insertions(+), 84 deletions(-)
