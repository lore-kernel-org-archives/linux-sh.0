From: Rich Felker <dalias@libc.org>
Date: Mon, 27 Jul 2020 22:09:24 +0000
Subject: [GIT PULL] arch/sh additional critical fixes 5.8
Message-Id: <20200727220922.GP6949@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Linus,

I have some last-minute fixes I hope you can still pull in for 5.8.
One is for a boot regression (mmu code broken) and the other fixes a
long-standing broken syscall number bounds check.

Rich



The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.8-part2

for you to fetch changes up to 04a8a3d0a73f51c7c2da84f494db7ec1df230e69:

  sh: Fix validation of system call number (2020-07-27 16:12:49 -0400)

----------------------------------------------------------------
Fixes for major regression and longstanding bounds-checking error.

----------------------------------------------------------------
Michael Karcher (1):
      sh: Fix validation of system call number

Peter Zijlstra (1):
      sh/tlb: Fix PGTABLE_LEVELS > 2

 arch/sh/include/asm/pgalloc.h | 10 +---------
 arch/sh/kernel/entry-common.S |  6 +++---
 2 files changed, 4 insertions(+), 12 deletions(-)
