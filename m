From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 19 May 2008 10:47:11 +0000
Subject: [GIT PULL] sh updates for 2.6.26-rc3
Message-Id: <20080519104711.GA11875@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Harvey Harrison (1):
      sh: use the common ascii hex helpers

Hideo Saito (2):
      sh: Fix up optimized SH-4 memcpy on big endian.
      sh: Fix up thread info pointer in syscall_badsys resume path.

Paul Mundt (4):
      sh: display boot params by default on entry.
      sh: disable initrd defaults in .empty_zero_page.
      sh: Make is_valid_bugaddr() more intelligent on nommu.
      sh: Fix up restorer in debug_trap exception return path.

Yoshihiro Shimoda (1):
      sh: fix sh7785 master clock value

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 arch/sh/kernel/entry-common.S          |   12 ++++++------
 arch/sh/kernel/head_32.S               |    4 ++--
 arch/sh/kernel/kgdb_stub.c             |   11 +++++------
 arch/sh/kernel/setup.c                 |   11 +++++++++++
 arch/sh/kernel/traps.c                 |   10 +++++++++-
 arch/sh/lib/memcpy-sh4.S               |   22 +++++++++++-----------
 drivers/serial/sh-sci.c                |    8 ++++----
 include/asm-sh/kgdb.h                  |   14 --------------
 9 files changed, 49 insertions(+), 45 deletions(-)
