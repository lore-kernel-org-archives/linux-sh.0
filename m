From: Rich Felker <dalias@libc.org>
Date: Thu, 17 Mar 2016 18:02:53 +0000
Subject: [GIT PULL] arch/sh updates for 4.6
Message-Id: <20160317180253.GA24679@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

These are the updates Sato-san and I have for arch/sh in this merge
window. Aside from some small fixes and cleanup they set the stage for
J2 support (by adding framework for boards described by device tree),
which should only minimally touch existing files when it's added.

Could you pull these changes and send them upstream for 4.6, or let me
know if there are problems (like stupid mistakes I made in preparing
the branch) or if I should send the request directly to Linus? Rob
suggested I might go through you this first time since I'm new to
maintainer workflow and the repo (on libc.org) is temporary pending
getting it setup on kernel.org.

Rich


--

The following changes since commit b562e44f507e863c6792946e4e1b1449fbbac85d:

  Linux 4.5 (2016-03-13 21:28:54 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh sh-for-4.6

for you to fetch changes up to aff17e9ddd7128661b24f70a92f13e0379484dc7:

  sched/preempt, sh: kmap_coherent relies on disabled preemption (2016-03-17 17:35:53 +0000)

----------------------------------------------------------------
David Hildenbrand (1):
      sched/preempt, sh: kmap_coherent relies on disabled preemption

Rich Felker (5):
      sh: provide unified syscall trap compatible with all SH models
      sh: make MMU-specific SMP code conditional on CONFIG_MMU
      sh: remove arch-specific localtimer and use generic one
      sh: add device tree support and generic board using device tree
      sh: add SMP method selection to device tree pseudo-board

Stephen Boyd (1):
      sh: Use generic clkdev.h header

Yoshinori Sato (2):
      sh: Disable trace for kernel uncompressing.
      SH: New gcc support

 Documentation/devicetree/booting-without-of.txt |  13 ++
 arch/sh/Kconfig                                 |   1 +
 arch/sh/boards/Kconfig                          |  15 ++
 arch/sh/boards/Makefile                         |   2 +
 arch/sh/boards/of-generic.c                     | 196 ++++++++++++++++++++++++
 arch/sh/boot/compressed/Makefile                |   2 +-
 arch/sh/include/asm/Kbuild                      |   1 +
 arch/sh/include/asm/clkdev.h                    |  33 ----
 arch/sh/include/asm/smp.h                       |  10 ++
 arch/sh/kernel/Makefile                         |   1 -
 arch/sh/kernel/cpu/sh2/entry.S                  |   8 +-
 arch/sh/kernel/cpu/sh2a/entry.S                 |   8 +-
 arch/sh/kernel/entry-common.S                   |  21 ++-
 arch/sh/kernel/head_32.S                        |  13 ++
 arch/sh/kernel/localtimer.c                     |  60 --------
 arch/sh/kernel/setup.c                          |  27 ++++
 arch/sh/kernel/sh_ksyms_32.c                    |   3 +
 arch/sh/kernel/smp.c                            |  24 +--
 arch/sh/lib/ashlsi3.S                           |  35 +++--
 arch/sh/lib/ashrsi3.S                           |  33 ++--
 arch/sh/lib/lshrsi3.S                           |  34 ++--
 arch/sh/mm/kmap.c                               |   2 +
 22 files changed, 397 insertions(+), 145 deletions(-)
 create mode 100644 arch/sh/boards/of-generic.c
 delete mode 100644 arch/sh/include/asm/clkdev.h
 delete mode 100644 arch/sh/kernel/localtimer.c
