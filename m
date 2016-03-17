From: Rich Felker <dalias@libc.org>
Date: Thu, 17 Mar 2016 22:04:53 +0000
Subject: [GIT PULL] arch/sh updates for 4.6
Message-Id: <20160317220453.GA889@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317180253.GA24679@brightrain.aerifal.cx>
In-Reply-To: <20160317180253.GA24679@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Yoshinori Sato <ysato@users.sourceforge.jp>

Linus,

Please pull these arch/sh changes for 4.6. They include minor
cleanups, a fix for a crash that likely affects all sh models with
MMU, and introduction of a framework for boards described by device
tree, which sets the stage for future J2 support.

Using git.libc.org for the sh tree is only temporary until we get one
setup on kernel.org, which is pending getting signatures on my key. I
hope to resolve that at ELC next month. Let me know if there's
anything you'd like me to do in the mean time to establish some
alternate basis of trust for these commits; hopefully it's less of an
issue being that they're not touching anything but a previously
unmaintained arch.

Rich



--

The following changes since commit b562e44f507e863c6792946e4e1b1449fbbac85d:

  Linux 4.5 (2016-03-13 21:28:54 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh sh-for-4.6

for you to fetch changes up to b15d53d009558d14c4f394a6d1fa2039c7f45c43:

  sched/preempt, sh: kmap_coherent relies on disabled preemption (2016-03-17 19:46:14 +0000)

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
      sh: New gcc support

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
