From: Rich Felker <dalias@libc.org>
Date: Fri, 05 Aug 2016 22:42:19 +0000
Subject: [GIT PULL] arch/sh updates for 4.8
Message-Id: <20160805224219.GA13141@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Linus,

Please pull these changes for arch/sh. They're based off a commit in
your current tree to resolve conflicts with 726328d92a
(locking/spinlock, arch: Update and fix spin_unlock_wait()
implementations). The J-Core arch support is included here but to be
usable it needs drivers that are waiting on approval/inclusion from
their subsystem maintainers.

Rich




--

The following changes since commit 7f155c702677d057d03b192ce652311de5434697:

  Merge tag 'nfs-for-4.8-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2016-07-30 16:33:25 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/sh-for-4.8

for you to fetch changes up to e61c10e468a42512f5fad74c00b62af5cc19f65f:

  sh: add device tree source for J2 FPGA on Mimas v2 board (2016-08-05 03:38:26 +0000)

----------------------------------------------------------------
These changes improve device tree support (including builtin DTB), add
support for the J-Core J2 processor, an open source synthesizable
reimplementation of the SH-2 ISA, resolve a longstanding sigcontext
ABI mismatch issue, and fix various bugs including nommu-specific
issues and minor regressions introduced in 4.6.

----------------------------------------------------------------
Markus Elfring (1):
      sh: Delete unnecessary checks before the function call "mempool_destroy"

Pan Xinhui (1):
      sh: cmpxchg: fix a bit shift bug in big_endian os

Paul Gortmaker (4):
      sh: make time.c explicitly non-modular
      sh: make mm/asids-debugfs explicitly non-modular
      sh: make board-secureedge5410 explicitly non-modular
      sh: make heartbeat driver explicitly non-modular

Rich Felker (16):
      sh: add support for linking a builtin device tree blob in the kernel
      sh: make sigcontext definition consistent across fpu/nofpu models
      sh: disable aliased page logic on NOMMU models
      sh: fix futex/robust_list on nommu models
      sh: allow clocksource drivers to register sched_clock backends
      sh: fix build regression with CONFIG_OF && !CONFIG_OF_FLATTREE
      sh: add support for J-Core J2 processor
      sh: add AT_HWCAP flag for J-Core cas.l instruction
      sh: add J2 atomics using the cas.l instruction
      sh: add working futex atomic ops on userspace addresses for smp
      sh: SMP support for SH2 entry.S
      sh: add SMP support for J2
      sh: do not perform IPI-based cache flush except on boards that need it
      sh: use common clock framework with device tree boards
      sh: add defconfig for J-Core J2
      sh: add device tree source for J2 FPGA on Mimas v2 board

Yoshinori Sato (1):
      sh: system call wire up

 arch/sh/Kconfig                         |  34 +++++
 arch/sh/Makefile                        |   3 +
 arch/sh/boards/Kconfig                  |   1 +
 arch/sh/boards/board-secureedge5410.c   |   3 +-
 arch/sh/boards/of-generic.c             |  15 ++-
 arch/sh/boot/dts/Makefile               |   3 +
 arch/sh/boot/dts/j2_mimas_v2.dts        |  96 ++++++++++++++
 arch/sh/configs/j2_defconfig            |  40 ++++++
 arch/sh/drivers/heartbeat.c             |  32 +----
 arch/sh/include/asm/atomic.h            |   8 ++
 arch/sh/include/asm/barrier.h           |   5 +
 arch/sh/include/asm/bitops-cas.h        |  93 +++++++++++++
 arch/sh/include/asm/bitops.h            |   2 +
 arch/sh/include/asm/cmpxchg-cas.h       |  24 ++++
 arch/sh/include/asm/cmpxchg-xchg.h      |   2 +-
 arch/sh/include/asm/cmpxchg.h           |   2 +
 arch/sh/include/asm/futex-cas.h         |  34 +++++
 arch/sh/include/asm/futex-irq.h         |  86 ------------
 arch/sh/include/asm/futex-llsc.h        |  41 ++++++
 arch/sh/include/asm/futex.h             |  97 ++++++++------
 arch/sh/include/asm/processor.h         |   2 +-
 arch/sh/include/asm/spinlock-cas.h      | 117 +++++++++++++++++
 arch/sh/include/asm/spinlock-llsc.h     | 224 ++++++++++++++++++++++++++++++++
 arch/sh/include/asm/spinlock.h          | 222 +------------------------------
 arch/sh/include/uapi/asm/cpu-features.h |   1 +
 arch/sh/include/uapi/asm/sigcontext.h   |   3 -
 arch/sh/include/uapi/asm/unistd_32.h    |  16 ++-
 arch/sh/include/uapi/asm/unistd_64.h    |  16 ++-
 arch/sh/kernel/cpu/clock.c              |   4 +
 arch/sh/kernel/cpu/init.c               |   6 +-
 arch/sh/kernel/cpu/proc.c               |   1 +
 arch/sh/kernel/cpu/sh2/Makefile         |   4 +
 arch/sh/kernel/cpu/sh2/entry.S          |  55 ++++++++
 arch/sh/kernel/cpu/sh2/probe.c          |  39 +++++-
 arch/sh/kernel/cpu/sh2/smp-j2.c         | 139 ++++++++++++++++++++
 arch/sh/kernel/dwarf.c                  |   6 +-
 arch/sh/kernel/head_32.S                |   6 +-
 arch/sh/kernel/setup.c                  |   6 +-
 arch/sh/kernel/syscalls_32.S            |  14 ++
 arch/sh/kernel/syscalls_64.S            |  14 ++
 arch/sh/kernel/time.c                   |   3 +-
 arch/sh/mm/Makefile                     |   3 +-
 arch/sh/mm/asids-debugfs.c              |   5 +-
 arch/sh/mm/cache-j2.c                   |  65 +++++++++
 arch/sh/mm/cache.c                      |  13 +-
 45 files changed, 1206 insertions(+), 399 deletions(-)
 create mode 100644 arch/sh/boot/dts/Makefile
 create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts
 create mode 100644 arch/sh/configs/j2_defconfig
 create mode 100644 arch/sh/include/asm/bitops-cas.h
 create mode 100644 arch/sh/include/asm/cmpxchg-cas.h
 create mode 100644 arch/sh/include/asm/futex-cas.h
 create mode 100644 arch/sh/include/asm/futex-llsc.h
 create mode 100644 arch/sh/include/asm/spinlock-cas.h
 create mode 100644 arch/sh/include/asm/spinlock-llsc.h
 create mode 100644 arch/sh/kernel/cpu/sh2/smp-j2.c
 create mode 100644 arch/sh/mm/cache-j2.c
