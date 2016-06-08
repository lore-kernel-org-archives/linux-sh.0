From: Rich Felker <dalias@libc.org>
Date: Wed, 08 Jun 2016 21:34:57 +0000
Subject: [GIT PULL] arch/sh updates for 4.7
Message-Id: <20160608213456.GA1643@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Linus,

Here are arch/sh changes for 4.7. I realize and apologize that these
are rather late coming. That's due to a mix of a (probably misguided)
attempt to get the baseline J-Core support changes in and unexpected
personal circumstances.

If you can merge these still I'd appreciate it (they don't affect
anything outside arch/sh) but if not I can hold them until next time.

Rich


--

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/sh-for-4.7

for you to fetch changes up to 21233d635e161daa5d46d6d13c85320725f40e47:

  sh: fix build regression with CONFIG_OF && !CONFIG_OF_FLATTREE (2016-06-08 00:35:30 +0000)

----------------------------------------------------------------
These changes include fixes for some nommu-specific bugs and for minor
bugs introduced in 4.6, cleanup, builtin DTB support, and resolution
of a longstanding sigcontext ABI mismatch issue.

----------------------------------------------------------------
Pan Xinhui (1):
      sh: cmpxchg: fix a bit shift bug in big_endian os

Paul Gortmaker (4):
      sh: make time.c explicitly non-modular
      sh: make mm/asids-debugfs explicitly non-modular
      sh: make board-secureedge5410 explicitly non-modular
      sh: make heartbeat driver explicitly non-modular

Rich Felker (6):
      sh: add support for linking a builtin device tree blob in the kernel
      sh: make sigcontext definition consistent across fpu/nofpu models
      sh: disable aliased page logic on NOMMU models
      sh: fix futex/robust_list on nommu models
      sh: allow clocksource drivers to register sched_clock backends
      sh: fix build regression with CONFIG_OF && !CONFIG_OF_FLATTREE

 arch/sh/Kconfig                       | 22 ++++++++++++++++++++++
 arch/sh/Makefile                      |  2 ++
 arch/sh/boards/board-secureedge5410.c |  3 +--
 arch/sh/boards/of-generic.c           | 15 ++++++++++++---
 arch/sh/boot/dts/Makefile             |  3 +++
 arch/sh/drivers/heartbeat.c           | 32 +++-----------------------------
 arch/sh/include/asm/cmpxchg-xchg.h    |  2 +-
 arch/sh/include/uapi/asm/sigcontext.h |  3 ---
 arch/sh/kernel/cpu/init.c             |  4 ++++
 arch/sh/kernel/head_32.S              |  6 +++---
 arch/sh/kernel/setup.c                |  6 +++++-
 arch/sh/kernel/time.c                 |  3 +--
 arch/sh/mm/asids-debugfs.c            |  5 +----
 arch/sh/mm/cache.c                    |  4 ++++
 14 files changed, 62 insertions(+), 48 deletions(-)
 create mode 100644 arch/sh/boot/dts/Makefile
